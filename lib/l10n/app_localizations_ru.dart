// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get navHome => 'Home';

  @override
  String get navPets => 'Pets';

  @override
  String get navProfile => 'Profile';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get notSet => 'Not set';

  @override
  String get soon => 'Soon';

  @override
  String comingSoon(String feature) {
    return '$feature is coming soon.';
  }

  @override
  String get profileTitle => 'Profile';

  @override
  String get myPets => 'My pets';

  @override
  String get myReports => 'My reports';

  @override
  String get homeCity => 'Home city';

  @override
  String get notifications => 'Notifications';

  @override
  String get language => 'Language';

  @override
  String get phoneLanguage => 'Phone language';

  @override
  String get phoneLanguageHint => 'Follow your phone\'s settings';

  @override
  String get signOut => 'Sign out';

  @override
  String get signOutTitle => 'Sign out?';

  @override
  String get signOutMessage => 'You can log back in anytime.';

  @override
  String get deleteAccount => 'Delete account';

  @override
  String get deleteAccountTitle => 'Delete your account?';

  @override
  String get deleteAccountMessage =>
      'This permanently deletes your profile, your pets, your reports and their photos. It can\'t be undone.';

  @override
  String get deletingAccount => 'Deleting your account…';

  @override
  String get myReportsSubtitle => 'Keep your reports up to date.';

  @override
  String get statTotal => 'Total';

  @override
  String postedOn(String date) {
    return 'Posted $date';
  }

  @override
  String get reportActive => 'Active';

  @override
  String get reportResolved => 'Resolved';

  @override
  String get myReportsLoadError => 'Couldn\'t load your reports';

  @override
  String get checkConnection => 'Check your connection and try again.';

  @override
  String get noActiveReports => 'No active reports';

  @override
  String get noActiveReportsMessage =>
      'Reports you publish for lost or found pets will show up here.';

  @override
  String get reportAPet => 'Report a pet';

  @override
  String get nothingResolved => 'Nothing resolved yet';

  @override
  String get nothingResolvedMessage =>
      'When you mark a report as found, it moves here.';

  @override
  String get markAsFound => 'Mark as found';

  @override
  String get returnedToOwner => 'Returned to owner';

  @override
  String get backHome => 'Back home';

  @override
  String get reunited => 'Reunited';

  @override
  String get deleteReport => 'Delete report';

  @override
  String resolveLostTitle(String petName) {
    return 'Is $petName back home?';
  }

  @override
  String get resolveFoundTitle => 'Has the owner been found?';

  @override
  String resolveLostMessage(String petName) {
    return 'The report will move to \"Back home\" in the Found tab, so neighbours know $petName is safe.';
  }

  @override
  String get resolveFoundMessage =>
      'The report will move to \"Reunited\" in the Found tab.';

  @override
  String get notYet => 'Not yet';

  @override
  String get yesResolved => 'Yes, resolved';

  @override
  String get reportResolvedSuccess => 'Wonderful news! Report resolved.';

  @override
  String get deleteReportTitle => 'Delete this report?';

  @override
  String deleteOpenReportMessage(String petName) {
    return 'It will disappear from the map and lists. If $petName is safe, mark the report as found instead, so neighbours know.';
  }

  @override
  String get deleteResolvedReportMessage =>
      'It will be removed from the map and the \"Back home\" list.';

  @override
  String get reportDeleted => 'Report deleted.';
}
