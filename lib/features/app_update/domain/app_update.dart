import '../../whats_new/domain/release_note.dart';

enum UpdateStatus { upToDate, available, required }

enum StorePlatform { android, ios }

// The store versions of one platform. Empty means not set.
class PlatformVersions {
  final String latest;
  final String minimum;

  const PlatformVersions({this.latest = '', this.minimum = ''});
}

// `config/appVersion`, edited in Admin → More → App updates.
class AppVersionConfig {
  final PlatformVersions android;
  final PlatformVersions ios;
  final String appStoreId;

  const AppVersionConfig({
    this.android = const PlatformVersions(),
    this.ios = const PlatformVersions(),
    this.appStoreId = '',
  });

  factory AppVersionConfig.fromMap(Map<String, dynamic>? map) {
    String read(String key) {
      final value = map?[key];
      return value is String && isVersion(value.trim()) ? value.trim() : '';
    }

    final id = map?['appStoreId'];
    return AppVersionConfig(
      android: PlatformVersions(
        latest: read('androidLatest'),
        minimum: read('androidMinimum'),
      ),
      ios: PlatformVersions(
        latest: read('iosLatest'),
        minimum: read('iosMinimum'),
      ),
      appStoreId: id is String && appStoreIdPattern.hasMatch(id) ? id : '',
    );
  }

  PlatformVersions of(StorePlatform platform) => switch (platform) {
    StorePlatform.android => android,
    StorePlatform.ios => ios,
  };

  Map<String, dynamic> toMap() => {
    'androidLatest': android.latest,
    'androidMinimum': android.minimum,
    'iosLatest': ios.latest,
    'iosMinimum': ios.minimum,
    'appStoreId': appStoreId,
  };
}

final appStoreIdPattern = RegExp(r'^\d{6,12}$');

UpdateStatus updateStatus(String installed, PlatformVersions store) {
  if (!isVersion(installed)) return UpdateStatus.upToDate;
  if (store.minimum.isNotEmpty &&
      compareVersions(installed, store.minimum) < 0) {
    return UpdateStatus.required;
  }
  if (store.latest.isNotEmpty && compareVersions(installed, store.latest) < 0) {
    return UpdateStatus.available;
  }
  return UpdateStatus.upToDate;
}

// What the admin typed, or the reason it can't be saved.
enum VersionFormError { badVersion, minimumAboveLatest, badAppStoreId }

VersionFormError? checkPlatform(String latest, String minimum) {
  if ((latest.isNotEmpty && !isVersion(latest)) ||
      (minimum.isNotEmpty && !isVersion(minimum))) {
    return VersionFormError.badVersion;
  }
  if (latest.isNotEmpty &&
      minimum.isNotEmpty &&
      compareVersions(minimum, latest) > 0) {
    return VersionFormError.minimumAboveLatest;
  }
  return null;
}

String storeUrl(
  StorePlatform platform,
  String packageName,
  String appStoreId,
) => switch (platform) {
  StorePlatform.android =>
    'https://play.google.com/store/apps/details?id=$packageName',
  StorePlatform.ios => 'https://apps.apple.com/app/id$appStoreId',
};

// The update sheet shows once per store version; the Home banner can be
// hidden for a few days.
class UpdatePromptState {
  final String? sheetShownFor;
  final String? bannerHiddenFor;
  final DateTime? bannerHiddenUntil;

  const UpdatePromptState({
    this.sheetShownFor,
    this.bannerHiddenFor,
    this.bannerHiddenUntil,
  });

  bool showSheet(String latest) => sheetShownFor != latest;

  bool showBanner(String latest, DateTime now) =>
      bannerHiddenFor != latest ||
      bannerHiddenUntil == null ||
      now.isAfter(bannerHiddenUntil!);
}

const bannerSnooze = Duration(days: 3);
