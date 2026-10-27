import 'package:flutter_test/flutter_test.dart';
import 'package:CodaMi/features/app_update/domain/app_update.dart';

void main() {
  test('compares the installed version with the store', () {
    const store = PlatformVersions(latest: '1.10.0', minimum: '1.2.0');
    expect(updateStatus('1.10.0', store), UpdateStatus.upToDate);
    expect(updateStatus('1.11.0', store), UpdateStatus.upToDate);
    expect(updateStatus('1.9.0', store), UpdateStatus.available);
    expect(updateStatus('1.2.0', store), UpdateStatus.available);
    expect(updateStatus('1.1.9', store), UpdateStatus.required);
  });

  test('empty store versions turn the checks off', () {
    expect(
      updateStatus('1.0.0', const PlatformVersions()),
      UpdateStatus.upToDate,
    );
    expect(
      updateStatus('1.0.0', const PlatformVersions(minimum: '1.1.0')),
      UpdateStatus.required,
    );
    expect(
      updateStatus('not-a-version', const PlatformVersions(latest: '2.0.0')),
      UpdateStatus.upToDate,
    );
  });

  test('reads each platform and drops bad values', () {
    final config = AppVersionConfig.fromMap({
      'androidLatest': '1.2.0',
      'androidMinimum': ' 1.1 ',
      'iosLatest': 'v2',
      'iosMinimum': 3,
      'appStoreId': '12ab',
    });
    expect(config.of(StorePlatform.android).latest, '1.2.0');
    expect(config.of(StorePlatform.android).minimum, '1.1');
    expect(config.of(StorePlatform.ios).latest, '');
    expect(config.of(StorePlatform.ios).minimum, '');
    expect(config.appStoreId, '');
    expect(AppVersionConfig.fromMap(null).android.latest, '');
  });

  test('admin form checks', () {
    expect(checkPlatform('', ''), isNull);
    expect(checkPlatform('1.2.0', '1.1.0'), isNull);
    expect(checkPlatform('1.2.0', '1.2.0'), isNull);
    expect(checkPlatform('1.2', ''), isNull);
    expect(checkPlatform('one', ''), VersionFormError.badVersion);
    expect(
      checkPlatform('1.2.0', '1.3.0'),
      VersionFormError.minimumAboveLatest,
    );
  });

  test('store links for each platform', () {
    expect(
      storeUrl(StorePlatform.android, 'com.codami.app', ''),
      'https://play.google.com/store/apps/details?id=com.codami.app',
    );
    expect(
      storeUrl(StorePlatform.ios, 'com.codami.app', '1234567890'),
      'https://apps.apple.com/app/id1234567890',
    );
  });

  test('sheet once per version, banner hidden for a few days', () {
    final now = DateTime(2026, 10, 27);
    const fresh = UpdatePromptState();
    expect(fresh.showSheet('1.1.0'), isTrue);
    expect(fresh.showBanner('1.1.0', now), isTrue);

    final seen = UpdatePromptState(
      sheetShownFor: '1.1.0',
      bannerHiddenFor: '1.1.0',
      bannerHiddenUntil: now.add(bannerSnooze),
    );
    expect(seen.showSheet('1.1.0'), isFalse);
    expect(seen.showSheet('1.2.0'), isTrue);
    expect(seen.showBanner('1.1.0', now), isFalse);
    expect(seen.showBanner('1.2.0', now), isTrue);
    expect(seen.showBanner('1.1.0', now.add(const Duration(days: 4))), isTrue);
  });
}
