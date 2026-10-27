import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../l10n/locale_provider.dart';
import '../../whats_new/data/release_notes_repository.dart';
import '../../whats_new/domain/release_note.dart';
import '../../whats_new/presentation/providers/whats_new_provider.dart';
import '../domain/app_update.dart';

class AppUpdateRepository {
  final FirebaseFirestore _db;

  AppUpdateRepository({FirebaseFirestore? db})
    : _db = db ?? FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>> get _doc =>
      _db.collection('config').doc('appVersion');

  Stream<AppVersionConfig> watch() =>
      _doc.snapshots().map((d) => AppVersionConfig.fromMap(d.data()));

  Future<void> save(AppVersionConfig config) =>
      _doc.set({...config.toMap(), 'updatedAt': FieldValue.serverTimestamp()});
}

final appUpdateRepositoryProvider = Provider((ref) => AppUpdateRepository());

// Null on platforms without a store build (web, desktop).
final storePlatformProvider = Provider<StorePlatform?>((ref) {
  if (kIsWeb) return null;
  return switch (defaultTargetPlatform) {
    TargetPlatform.android => StorePlatform.android,
    TargetPlatform.iOS => StorePlatform.ios,
    _ => null,
  };
});

// Listened to for the whole session, so a release shows up without a restart.
final appVersionConfigProvider = StreamProvider<AppVersionConfig>(
  (ref) => ref.watch(appUpdateRepositoryProvider).watch(),
);

class AppUpdateInfo {
  final UpdateStatus status;
  final String installed;
  final String latest;

  const AppUpdateInfo(this.status, {this.installed = '', this.latest = ''});

  bool get outdated => status != UpdateStatus.upToDate;
}

final appUpdateProvider = Provider<AppUpdateInfo>((ref) {
  const none = AppUpdateInfo(UpdateStatus.upToDate);
  final platform = ref.watch(storePlatformProvider);
  final installed = ref.watch(appVersionProvider).value;
  final config = ref.watch(appVersionConfigProvider).value;
  if (platform == null || installed == null || config == null) return none;
  final store = config.of(platform);
  return AppUpdateInfo(
    updateStatus(installed, store),
    installed: installed,
    latest: store.latest.isEmpty ? store.minimum : store.latest,
  );
});

// The published notes of the store version, shown with the update.
final latestNotesProvider = FutureProvider<ReleaseNote?>((ref) async {
  final latest = ref.watch(appUpdateProvider.select((u) => u.latest));
  if (latest.isEmpty) return null;
  final note = await ref.read(releaseNotesRepositoryProvider).find(latest);
  return note != null && note.published ? note : null;
});

// Opens CodaMi's page in Google Play or the App Store. False when it can't.
final openStoreProvider = Provider<Future<bool> Function()>(
  (ref) => () async {
    final platform = ref.read(storePlatformProvider);
    if (platform == null) return false;
    final appStoreId =
        ref.read(appVersionConfigProvider).value?.appStoreId ?? '';
    if (platform == StorePlatform.ios && appStoreId.isEmpty) return false;
    try {
      final info = await PackageInfo.fromPlatform();
      final uri = Uri.parse(storeUrl(platform, info.packageName, appStoreId));
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Store not opened: $e');
      return false;
    }
  },
);

class UpdatePromptStore {
  static const _sheetKey = 'update_sheet_shown';
  static const _hiddenKey = 'update_banner_hidden';
  static const _untilKey = 'update_banner_hidden_until';

  final SharedPreferences _prefs;

  UpdatePromptStore(this._prefs);

  UpdatePromptState read() {
    final until = _prefs.getInt(_untilKey);
    return UpdatePromptState(
      sheetShownFor: _prefs.getString(_sheetKey),
      bannerHiddenFor: _prefs.getString(_hiddenKey),
      bannerHiddenUntil: until == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(until),
    );
  }

  Future<void> sheetShown(String version) =>
      _prefs.setString(_sheetKey, version);

  Future<void> hideBanner(String version, DateTime until) async {
    await _prefs.setString(_hiddenKey, version);
    await _prefs.setInt(_untilKey, until.millisecondsSinceEpoch);
  }
}

class UpdatePromptNotifier extends Notifier<UpdatePromptState> {
  late final UpdatePromptStore _store = UpdatePromptStore(
    ref.read(sharedPreferencesProvider),
  );

  @override
  UpdatePromptState build() => _store.read();

  Future<void> sheetShown(String version) async {
    await _store.sheetShown(version);
    state = _store.read();
  }

  Future<void> hideBanner(String version) async {
    await _store.hideBanner(version, DateTime.now().add(bannerSnooze));
    state = _store.read();
  }
}

final updatePromptProvider =
    NotifierProvider<UpdatePromptNotifier, UpdatePromptState>(
      UpdatePromptNotifier.new,
    );
