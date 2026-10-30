import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('pt'),
    Locale('ru'),
    Locale('zh'),
  ];

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navPets.
  ///
  /// In en, this message translates to:
  /// **'Pets'**
  String get navPets;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// No description provided for @soon.
  ///
  /// In en, this message translates to:
  /// **'Soon'**
  String get soon;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'{feature} is coming soon.'**
  String comingSoon(String feature);

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @myPets.
  ///
  /// In en, this message translates to:
  /// **'My pets'**
  String get myPets;

  /// No description provided for @myReports.
  ///
  /// In en, this message translates to:
  /// **'My reports'**
  String get myReports;

  /// No description provided for @homeCity.
  ///
  /// In en, this message translates to:
  /// **'Home city'**
  String get homeCity;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get chooseLanguage;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @signOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out?'**
  String get signOutTitle;

  /// No description provided for @signOutMessage.
  ///
  /// In en, this message translates to:
  /// **'You can log back in anytime.'**
  String get signOutMessage;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete your account?'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes your profile, your pets, your reports and their photos. It can\'t be undone.'**
  String get deleteAccountMessage;

  /// No description provided for @deletingAccount.
  ///
  /// In en, this message translates to:
  /// **'Deleting your account…'**
  String get deletingAccount;

  /// No description provided for @myReportsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Keep your reports up to date.'**
  String get myReportsSubtitle;

  /// No description provided for @statTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get statTotal;

  /// No description provided for @postedOn.
  ///
  /// In en, this message translates to:
  /// **'Posted {date}'**
  String postedOn(String date);

  /// No description provided for @reportActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get reportActive;

  /// No description provided for @reportResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get reportResolved;

  /// No description provided for @myReportsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load your reports'**
  String get myReportsLoadError;

  /// No description provided for @checkConnection.
  ///
  /// In en, this message translates to:
  /// **'Check your connection and try again.'**
  String get checkConnection;

  /// No description provided for @noActiveReports.
  ///
  /// In en, this message translates to:
  /// **'No active reports'**
  String get noActiveReports;

  /// No description provided for @noActiveReportsMessage.
  ///
  /// In en, this message translates to:
  /// **'Reports you publish for lost or found pets will show up here.'**
  String get noActiveReportsMessage;

  /// No description provided for @reportAPet.
  ///
  /// In en, this message translates to:
  /// **'Report a pet'**
  String get reportAPet;

  /// No description provided for @nothingResolved.
  ///
  /// In en, this message translates to:
  /// **'Nothing resolved yet'**
  String get nothingResolved;

  /// No description provided for @nothingResolvedMessage.
  ///
  /// In en, this message translates to:
  /// **'When you mark a report as found, it moves here.'**
  String get nothingResolvedMessage;

  /// No description provided for @markAsFound.
  ///
  /// In en, this message translates to:
  /// **'Mark as found'**
  String get markAsFound;

  /// No description provided for @returnedToOwner.
  ///
  /// In en, this message translates to:
  /// **'Returned to owner'**
  String get returnedToOwner;

  /// No description provided for @backHome.
  ///
  /// In en, this message translates to:
  /// **'Back home'**
  String get backHome;

  /// No description provided for @reunited.
  ///
  /// In en, this message translates to:
  /// **'Reunited'**
  String get reunited;

  /// No description provided for @deleteReport.
  ///
  /// In en, this message translates to:
  /// **'Delete report'**
  String get deleteReport;

  /// No description provided for @resolveLostTitle.
  ///
  /// In en, this message translates to:
  /// **'Is {petName} back home?'**
  String resolveLostTitle(String petName);

  /// No description provided for @resolveFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Has the owner been found?'**
  String get resolveFoundTitle;

  /// No description provided for @resolveLostMessage.
  ///
  /// In en, this message translates to:
  /// **'The report will move to \"Back home\" in the Found tab, so neighbours know {petName} is safe.'**
  String resolveLostMessage(String petName);

  /// No description provided for @resolveFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'The report will move to \"Reunited\" in the Found tab.'**
  String get resolveFoundMessage;

  /// No description provided for @notYet.
  ///
  /// In en, this message translates to:
  /// **'Not yet'**
  String get notYet;

  /// No description provided for @yesResolved.
  ///
  /// In en, this message translates to:
  /// **'Yes, resolved'**
  String get yesResolved;

  /// No description provided for @reportResolvedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Wonderful news! Report resolved.'**
  String get reportResolvedSuccess;

  /// No description provided for @deleteReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this report?'**
  String get deleteReportTitle;

  /// No description provided for @deleteOpenReportMessage.
  ///
  /// In en, this message translates to:
  /// **'It will disappear from the map and lists. If {petName} is safe, mark the report as found instead, so neighbours know.'**
  String deleteOpenReportMessage(String petName);

  /// No description provided for @deleteResolvedReportMessage.
  ///
  /// In en, this message translates to:
  /// **'It will be removed from the map and the \"Back home\" list.'**
  String get deleteResolvedReportMessage;

  /// No description provided for @reportDeleted.
  ///
  /// In en, this message translates to:
  /// **'Report deleted.'**
  String get reportDeleted;

  /// No description provided for @onboarding1Title.
  ///
  /// In en, this message translates to:
  /// **'Every pet deserves\na '**
  String get onboarding1Title;

  /// No description provided for @onboarding1Highlight.
  ///
  /// In en, this message translates to:
  /// **'way home'**
  String get onboarding1Highlight;

  /// No description provided for @onboarding1Body.
  ///
  /// In en, this message translates to:
  /// **'CodaMi connects neighbours so lost dogs and cats find their way back to the people who love them.'**
  String get onboarding1Body;

  /// No description provided for @onboarding2Title.
  ///
  /// In en, this message translates to:
  /// **'Report a pet\nin '**
  String get onboarding2Title;

  /// No description provided for @onboarding2Highlight.
  ///
  /// In en, this message translates to:
  /// **'seconds'**
  String get onboarding2Highlight;

  /// No description provided for @onboarding2Body.
  ///
  /// In en, this message translates to:
  /// **'Snap a photo, drop the location and publish a lost or found report. Everyone nearby sees it instantly.'**
  String get onboarding2Body;

  /// No description provided for @onboarding3Title.
  ///
  /// In en, this message translates to:
  /// **'See who\'s\n'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Highlight.
  ///
  /// In en, this message translates to:
  /// **'nearby'**
  String get onboarding3Highlight;

  /// No description provided for @onboarding3Body.
  ///
  /// In en, this message translates to:
  /// **'Lost and found pets around you, live on one map, so you always know where to look.'**
  String get onboarding3Body;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @lost.
  ///
  /// In en, this message translates to:
  /// **'Lost'**
  String get lost;

  /// No description provided for @found.
  ///
  /// In en, this message translates to:
  /// **'Found'**
  String get found;

  /// No description provided for @you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// No description provided for @published.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get published;

  /// No description provided for @onboardingSampleBreed.
  ///
  /// In en, this message translates to:
  /// **'Golden Retriever · 3 yrs'**
  String get onboardingSampleBreed;

  /// No description provided for @onboardingSamplePlace.
  ///
  /// In en, this message translates to:
  /// **'Milano · 2h ago'**
  String get onboardingSamplePlace;

  /// No description provided for @validationNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get validationNameRequired;

  /// No description provided for @validationNameTooShort.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 2 characters'**
  String get validationNameTooShort;

  /// No description provided for @validationNameTooLong.
  ///
  /// In en, this message translates to:
  /// **'Name must be under 50 characters'**
  String get validationNameTooLong;

  /// No description provided for @validationNameInvalid.
  ///
  /// In en, this message translates to:
  /// **'Name can only contain letters, spaces, hyphens and apostrophes'**
  String get validationNameInvalid;

  /// No description provided for @validationEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get validationEmailRequired;

  /// No description provided for @validationEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get validationEmailInvalid;

  /// No description provided for @validationPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get validationPasswordRequired;

  /// No description provided for @validationPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long'**
  String get validationPasswordTooShort;

  /// No description provided for @validationConfirmRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get validationConfirmRequired;

  /// No description provided for @validationPasswordsDontMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get validationPasswordsDontMatch;

  /// No description provided for @spamNote.
  ///
  /// In en, this message translates to:
  /// **'Can\'t find the reset email? Check your Spam or Junk folder, it sometimes lands there.'**
  String get spamNote;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @authResetSentTitle.
  ///
  /// In en, this message translates to:
  /// **'Check your inbox'**
  String get authResetSentTitle;

  /// No description provided for @authResetSentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent you a link to reset your password.'**
  String get authResetSentSubtitle;

  /// No description provided for @authLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get authLoginTitle;

  /// No description provided for @authLoginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Log in to keep helping pets find their way home.'**
  String get authLoginSubtitle;

  /// No description provided for @authSignupTitle.
  ///
  /// In en, this message translates to:
  /// **'Join the pack'**
  String get authSignupTitle;

  /// No description provided for @authSignupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create an account and help your neighbourhood.'**
  String get authSignupSubtitle;

  /// No description provided for @authForgotTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get authForgotTitle;

  /// No description provided for @authForgotSubtitle.
  ///
  /// In en, this message translates to:
  /// **'No worries, we\'ll email you a reset link.'**
  String get authForgotSubtitle;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueWithApple;

  /// No description provided for @resetLinkSentTo.
  ///
  /// In en, this message translates to:
  /// **'We sent a reset link to'**
  String get resetLinkSentTo;

  /// No description provided for @backToLogIn.
  ///
  /// In en, this message translates to:
  /// **'Back to Log In'**
  String get backToLogIn;

  /// No description provided for @sendAgain.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t get it? Send again'**
  String get sendAgain;

  /// No description provided for @errorOffline.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline. Check your connection and try again.'**
  String get errorOffline;

  /// No description provided for @errorSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Your session expired. Please sign in again.'**
  String get errorSessionExpired;

  /// No description provided for @deleteAccountFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t delete your account. Please try again.'**
  String get deleteAccountFailed;

  /// No description provided for @authErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get authErrorGeneric;

  /// No description provided for @authErrorDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled.'**
  String get authErrorDisabled;

  /// No description provided for @authErrorWrongCredentials.
  ///
  /// In en, this message translates to:
  /// **'Wrong email or password.'**
  String get authErrorWrongCredentials;

  /// No description provided for @authErrorEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'An account with this email already exists. Try logging in.'**
  String get authErrorEmailInUse;

  /// No description provided for @authErrorTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please wait a moment and try again.'**
  String get authErrorTooManyRequests;

  /// No description provided for @citySearchFailed.
  ///
  /// In en, this message translates to:
  /// **'City search failed. Please try again.'**
  String get citySearchFailed;

  /// No description provided for @placeSearchFailed.
  ///
  /// In en, this message translates to:
  /// **'Place search failed. Please try again.'**
  String get placeSearchFailed;

  /// No description provided for @placeOutsideCity.
  ///
  /// In en, this message translates to:
  /// **'That place is outside your city. Please pick one in your city.'**
  String get placeOutsideCity;

  /// No description provided for @placeNotFound.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find that place. Please pick another one.'**
  String get placeNotFound;

  /// No description provided for @citySearchOffline.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t reach city search. Check your connection and try again.'**
  String get citySearchOffline;

  /// No description provided for @searchCityHint.
  ///
  /// In en, this message translates to:
  /// **'Search your city, e.g. Milano'**
  String get searchCityHint;

  /// No description provided for @noCitiesFound.
  ///
  /// In en, this message translates to:
  /// **'No cities found for \"{query}\".'**
  String noCitiesFound(String query);

  /// No description provided for @homeCityUpdated.
  ///
  /// In en, this message translates to:
  /// **'Home city updated to {city}.'**
  String homeCityUpdated(String city);

  /// No description provided for @saveCityFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save your city. Please try again.'**
  String get saveCityFailed;

  /// No description provided for @citySetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Where are '**
  String get citySetupTitle;

  /// No description provided for @citySetupHighlight.
  ///
  /// In en, this message translates to:
  /// **'you?'**
  String get citySetupHighlight;

  /// No description provided for @cityEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Change your '**
  String get cityEditTitle;

  /// No description provided for @cityEditHighlight.
  ///
  /// In en, this message translates to:
  /// **'city'**
  String get cityEditHighlight;

  /// No description provided for @citySetupBody.
  ///
  /// In en, this message translates to:
  /// **'Pick your city so we can show lost & found pets near you and let you know when a pet goes missing in your area.'**
  String get citySetupBody;

  /// No description provided for @saveCity.
  ///
  /// In en, this message translates to:
  /// **'Save city'**
  String get saveCity;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @notYouSignOut.
  ///
  /// In en, this message translates to:
  /// **'Not you? Sign out'**
  String get notYouSignOut;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hi, {name}!'**
  String greeting(String name);

  /// No description provided for @showPetsWithin.
  ///
  /// In en, this message translates to:
  /// **'Show pets within'**
  String get showPetsWithin;

  /// No description provided for @distanceFrom.
  ///
  /// In en, this message translates to:
  /// **'Distance from {city}'**
  String distanceFrom(String city);

  /// No description provided for @everywhere.
  ///
  /// In en, this message translates to:
  /// **'Everywhere'**
  String get everywhere;

  /// No description provided for @distanceKm.
  ///
  /// In en, this message translates to:
  /// **'{km} km'**
  String distanceKm(int km);

  /// No description provided for @withinKm.
  ///
  /// In en, this message translates to:
  /// **'within {km} km'**
  String withinKm(int km);

  /// No description provided for @areaNotSet.
  ///
  /// In en, this message translates to:
  /// **'Area not set yet'**
  String get areaNotSet;

  /// No description provided for @reportPetSemantics.
  ///
  /// In en, this message translates to:
  /// **'Report a lost or found pet'**
  String get reportPetSemantics;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @locationServicesOff.
  ///
  /// In en, this message translates to:
  /// **'Turn on location services to use your location.'**
  String get locationServicesOff;

  /// No description provided for @locationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Allow location access in Settings to use your location.'**
  String get locationPermissionDenied;

  /// No description provided for @locationFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t get your location. Please try again.'**
  String get locationFailed;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @fullScreen.
  ///
  /// In en, this message translates to:
  /// **'Full screen'**
  String get fullScreen;

  /// No description provided for @loadingPets.
  ///
  /// In en, this message translates to:
  /// **'Loading pets…'**
  String get loadingPets;

  /// No description provided for @mapLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load reports. Check your connection.'**
  String get mapLoadFailed;

  /// No description provided for @mapNoLost.
  ///
  /// In en, this message translates to:
  /// **'No lost pets in this area'**
  String get mapNoLost;

  /// No description provided for @mapNoFound.
  ///
  /// In en, this message translates to:
  /// **'No found pets in this area'**
  String get mapNoFound;

  /// No description provided for @mapNoPets.
  ///
  /// In en, this message translates to:
  /// **'No lost or found pets in this area'**
  String get mapNoPets;

  /// No description provided for @zoomIn.
  ///
  /// In en, this message translates to:
  /// **'Zoom in'**
  String get zoomIn;

  /// No description provided for @zoomOut.
  ///
  /// In en, this message translates to:
  /// **'Zoom out'**
  String get zoomOut;

  /// No description provided for @myLocation.
  ///
  /// In en, this message translates to:
  /// **'My location'**
  String get myLocation;

  /// No description provided for @myCity.
  ///
  /// In en, this message translates to:
  /// **'My city'**
  String get myCity;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @timeJustNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get timeJustNow;

  /// No description provided for @timeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min ago'**
  String timeMinutesAgo(int minutes);

  /// No description provided for @timeHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours} h ago'**
  String timeHoursAgo(int hours);

  /// No description provided for @timeYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get timeYesterday;

  /// No description provided for @timeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String timeDaysAgo(int days);

  /// No description provided for @notifLostTitle.
  ///
  /// In en, this message translates to:
  /// **'Lost pet in {city}'**
  String notifLostTitle(String city);

  /// No description provided for @notifLostBodyNear.
  ///
  /// In en, this message translates to:
  /// **'{pet} was last seen near {street}, {city}. Keep an eye out!'**
  String notifLostBodyNear(String pet, String street, String city);

  /// No description provided for @notifLostBodyIn.
  ///
  /// In en, this message translates to:
  /// **'{pet} was last seen in {city}. Keep an eye out!'**
  String notifLostBodyIn(String pet, String city);

  /// No description provided for @notifFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Pet found in {city}'**
  String notifFoundTitle(String city);

  /// No description provided for @notifFoundBodyNear.
  ///
  /// In en, this message translates to:
  /// **'{pet} was found near {street}, {city}. Do you know the owner?'**
  String notifFoundBodyNear(String pet, String street, String city);

  /// No description provided for @notifFoundBodyIn.
  ///
  /// In en, this message translates to:
  /// **'{pet} was found in {city}. Do you know the owner?'**
  String notifFoundBodyIn(String pet, String city);

  /// No description provided for @notifBackHomeTitle.
  ///
  /// In en, this message translates to:
  /// **'{pet} is back home'**
  String notifBackHomeTitle(String pet);

  /// No description provided for @notifBackHomeBody.
  ///
  /// In en, this message translates to:
  /// **'Good news from {city}: {pet} has been found. Thank you for helping!'**
  String notifBackHomeBody(String pet, String city);

  /// No description provided for @notifReunitedTitle.
  ///
  /// In en, this message translates to:
  /// **'{pet} is reunited'**
  String notifReunitedTitle(String pet);

  /// No description provided for @notifReunitedBody.
  ///
  /// In en, this message translates to:
  /// **'The pet found in {city} is back with its family.'**
  String notifReunitedBody(String city);

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get markAllRead;

  /// No description provided for @notificationsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load notifications'**
  String get notificationsLoadError;

  /// No description provided for @allCaughtUp.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up'**
  String get allCaughtUp;

  /// No description provided for @notificationsEmpty.
  ///
  /// In en, this message translates to:
  /// **'We\'ll let you know when a pet is lost or found in your city.'**
  String get notificationsEmpty;

  /// No description provided for @notificationsNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get notificationsNew;

  /// No description provided for @notificationsEarlier.
  ///
  /// In en, this message translates to:
  /// **'Earlier'**
  String get notificationsEarlier;

  /// No description provided for @reportNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Report not available'**
  String get reportNotAvailable;

  /// No description provided for @reportRemoved.
  ///
  /// In en, this message translates to:
  /// **'This report was removed by its owner.'**
  String get reportRemoved;

  /// No description provided for @reportsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load reports'**
  String get reportsLoadError;

  /// No description provided for @pullToRetry.
  ///
  /// In en, this message translates to:
  /// **'Check your connection and pull down to try again.'**
  String get pullToRetry;

  /// No description provided for @noLostNearby.
  ///
  /// In en, this message translates to:
  /// **'No lost pets nearby'**
  String get noLostNearby;

  /// No description provided for @noLostNearbyMessage.
  ///
  /// In en, this message translates to:
  /// **'Good news! Nobody has reported a lost pet in your area yet.'**
  String get noLostNearbyMessage;

  /// No description provided for @noFoundYet.
  ///
  /// In en, this message translates to:
  /// **'No found pets yet'**
  String get noFoundYet;

  /// No description provided for @noFoundYetMessage.
  ///
  /// In en, this message translates to:
  /// **'Pets found by your neighbours will show up here.'**
  String get noFoundYetMessage;

  /// No description provided for @backHomeSection.
  ///
  /// In en, this message translates to:
  /// **'Back home'**
  String get backHomeSection;

  /// No description provided for @backHomeSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pets that found their way back to their families.'**
  String get backHomeSectionSubtitle;

  /// No description provided for @loadMore.
  ///
  /// In en, this message translates to:
  /// **'Load more'**
  String get loadMore;

  /// No description provided for @speciesDog.
  ///
  /// In en, this message translates to:
  /// **'Dog'**
  String get speciesDog;

  /// No description provided for @speciesCat.
  ///
  /// In en, this message translates to:
  /// **'Cat'**
  String get speciesCat;

  /// No description provided for @speciesOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get speciesOther;

  /// No description provided for @sexMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get sexMale;

  /// No description provided for @sexFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get sexFemale;

  /// No description provided for @sexUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get sexUnknown;

  /// No description provided for @nearPlace.
  ///
  /// In en, this message translates to:
  /// **'Near {street}, {city}'**
  String nearPlace(String street, String city);

  /// No description provided for @callFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t start a call.'**
  String get callFailed;

  /// No description provided for @whatsappFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open WhatsApp.'**
  String get whatsappFailed;

  /// No description provided for @emailFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open your email app.'**
  String get emailFailed;

  /// No description provided for @whatsappMessageLost.
  ///
  /// In en, this message translates to:
  /// **'Hi! I\'m contacting you about the lost pet \"{pet}\" on CodaMi.'**
  String whatsappMessageLost(String pet);

  /// No description provided for @whatsappMessageFound.
  ///
  /// In en, this message translates to:
  /// **'Hi! I\'m contacting you about the found pet \"{pet}\" on CodaMi.'**
  String whatsappMessageFound(String pet);

  /// No description provided for @emailSubjectLost.
  ///
  /// In en, this message translates to:
  /// **'About {pet} (lost pet on CodaMi)'**
  String emailSubjectLost(String pet);

  /// No description provided for @emailSubjectFound.
  ///
  /// In en, this message translates to:
  /// **'About {pet} (found pet on CodaMi)'**
  String emailSubjectFound(String pet);

  /// No description provided for @shareTitleLost.
  ///
  /// In en, this message translates to:
  /// **'LOST PET: {pet}'**
  String shareTitleLost(String pet);

  /// No description provided for @shareTitleFound.
  ///
  /// In en, this message translates to:
  /// **'FOUND PET: {pet}'**
  String shareTitleFound(String pet);

  /// No description provided for @shareFooter.
  ///
  /// In en, this message translates to:
  /// **'Seen this pet? Open CodaMi to get in touch.'**
  String get shareFooter;

  /// No description provided for @lastSeen.
  ///
  /// In en, this message translates to:
  /// **'Last seen'**
  String get lastSeen;

  /// No description provided for @foundAt.
  ///
  /// In en, this message translates to:
  /// **'Found at'**
  String get foundAt;

  /// No description provided for @areaAbout.
  ///
  /// In en, this message translates to:
  /// **'area of about {meters} m'**
  String areaAbout(int meters);

  /// No description provided for @when.
  ///
  /// In en, this message translates to:
  /// **'When'**
  String get when;

  /// No description provided for @postedBy.
  ///
  /// In en, this message translates to:
  /// **'Posted by'**
  String get postedBy;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @contactTitleLost.
  ///
  /// In en, this message translates to:
  /// **'Seen {pet}? Get in touch'**
  String contactTitleLost(String pet);

  /// No description provided for @contactTitleFound.
  ///
  /// In en, this message translates to:
  /// **'Is this your pet? Get in touch'**
  String get contactTitleFound;

  /// No description provided for @noContactShared.
  ///
  /// In en, this message translates to:
  /// **'No contact details were shared.'**
  String get noContactShared;

  /// No description provided for @resolvedThanksLost.
  ///
  /// In en, this message translates to:
  /// **'{pet} is back home. Thank you for using CodaMi!'**
  String resolvedThanksLost(String pet);

  /// No description provided for @resolvedThanksFound.
  ///
  /// In en, this message translates to:
  /// **'This pet is back with its family. Thank you for helping!'**
  String get resolvedThanksFound;

  /// No description provided for @yourContactDetails.
  ///
  /// In en, this message translates to:
  /// **'Your contact details'**
  String get yourContactDetails;

  /// No description provided for @markPetAsFound.
  ///
  /// In en, this message translates to:
  /// **'Mark {pet} as found'**
  String markPetAsFound(String pet);

  /// No description provided for @markReturnedToOwner.
  ///
  /// In en, this message translates to:
  /// **'Mark as returned to owner'**
  String get markReturnedToOwner;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard.'**
  String get copiedToClipboard;

  /// No description provided for @petSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save your pet. Please try again.'**
  String get petSaveFailed;

  /// No description provided for @petDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t delete your pet. Please try again.'**
  String get petDeleteFailed;

  /// No description provided for @errorPermission.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have permission to do that.'**
  String get errorPermission;

  /// No description provided for @storageNotReady.
  ///
  /// In en, this message translates to:
  /// **'Photo storage isn\'t set up yet. Please try again later.'**
  String get storageNotReady;

  /// No description provided for @storageFull.
  ///
  /// In en, this message translates to:
  /// **'Storage is full right now. Please try again later.'**
  String get storageFull;

  /// No description provided for @petAdded.
  ///
  /// In en, this message translates to:
  /// **'{name} was added to your pets.'**
  String petAdded(String name);

  /// No description provided for @petsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load your pets'**
  String get petsLoadError;

  /// No description provided for @noPetsYet.
  ///
  /// In en, this message translates to:
  /// **'No pets yet'**
  String get noPetsYet;

  /// No description provided for @noPetsYetMessage.
  ///
  /// In en, this message translates to:
  /// **'Add your pets now so you can report them in seconds if they ever get lost.'**
  String get noPetsYetMessage;

  /// No description provided for @addFirstPet.
  ///
  /// In en, this message translates to:
  /// **'Add your first pet'**
  String get addFirstPet;

  /// No description provided for @petsHeaderEmpty.
  ///
  /// In en, this message translates to:
  /// **'Keep your pets\' profiles ready, just in case.'**
  String get petsHeaderEmpty;

  /// No description provided for @petsHeaderCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 furry friend, ready if anything happens.} other{{count} furry friends, ready if anything happens.}}'**
  String petsHeaderCount(int count);

  /// No description provided for @addPet.
  ///
  /// In en, this message translates to:
  /// **'Add pet'**
  String get addPet;

  /// No description provided for @petUpdated.
  ///
  /// In en, this message translates to:
  /// **'{name} was updated.'**
  String petUpdated(String name);

  /// No description provided for @removePetTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove {name}?'**
  String removePetTitle(String name);

  /// No description provided for @removePetMessage.
  ///
  /// In en, this message translates to:
  /// **'This deletes the profile and its photos. It can\'t be undone.'**
  String get removePetMessage;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @petRemoved.
  ///
  /// In en, this message translates to:
  /// **'{name} was removed.'**
  String petRemoved(String name);

  /// No description provided for @breed.
  ///
  /// In en, this message translates to:
  /// **'Breed'**
  String get breed;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @sex.
  ///
  /// In en, this message translates to:
  /// **'Sex'**
  String get sex;

  /// No description provided for @petAddedOn.
  ///
  /// In en, this message translates to:
  /// **'Added {date}'**
  String petAddedOn(String date);

  /// No description provided for @distinctiveFeatures.
  ///
  /// In en, this message translates to:
  /// **'Distinctive features'**
  String get distinctiveFeatures;

  /// No description provided for @ifPetGoesMissing.
  ///
  /// In en, this message translates to:
  /// **'If {name} ever goes missing'**
  String ifPetGoesMissing(String name);

  /// No description provided for @ifPetGoesMissingBody.
  ///
  /// In en, this message translates to:
  /// **'Publish a lost report with this profile in seconds, and neighbours nearby will be alerted.'**
  String get ifPetGoesMissingBody;

  /// No description provided for @reportPetAsLost.
  ///
  /// In en, this message translates to:
  /// **'Report {name} as lost'**
  String reportPetAsLost(String name);

  /// No description provided for @colorBlack.
  ///
  /// In en, this message translates to:
  /// **'Black'**
  String get colorBlack;

  /// No description provided for @colorWhite.
  ///
  /// In en, this message translates to:
  /// **'White'**
  String get colorWhite;

  /// No description provided for @colorBrown.
  ///
  /// In en, this message translates to:
  /// **'Brown'**
  String get colorBrown;

  /// No description provided for @colorGolden.
  ///
  /// In en, this message translates to:
  /// **'Golden'**
  String get colorGolden;

  /// No description provided for @colorGrey.
  ///
  /// In en, this message translates to:
  /// **'Grey'**
  String get colorGrey;

  /// No description provided for @colorCream.
  ///
  /// In en, this message translates to:
  /// **'Cream'**
  String get colorCream;

  /// No description provided for @colorGinger.
  ///
  /// In en, this message translates to:
  /// **'Ginger'**
  String get colorGinger;

  /// No description provided for @petPhotoRequired.
  ///
  /// In en, this message translates to:
  /// **'Add at least one photo of your pet.'**
  String get petPhotoRequired;

  /// No description provided for @petSpeciesRequired.
  ///
  /// In en, this message translates to:
  /// **'Choose whether your pet is a dog, cat or other.'**
  String get petSpeciesRequired;

  /// No description provided for @checkHighlightedFields.
  ///
  /// In en, this message translates to:
  /// **'Please check the highlighted fields.'**
  String get checkHighlightedFields;

  /// No description provided for @signInToSave.
  ///
  /// In en, this message translates to:
  /// **'Please sign in again to save.'**
  String get signInToSave;

  /// No description provided for @discardChangesTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard changes?'**
  String get discardChangesTitle;

  /// No description provided for @discardPetChanges.
  ///
  /// In en, this message translates to:
  /// **'Your changes to this pet will be lost.'**
  String get discardPetChanges;

  /// No description provided for @keepEditing.
  ///
  /// In en, this message translates to:
  /// **'Keep editing'**
  String get keepEditing;

  /// No description provided for @discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// No description provided for @editPetTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit {name}'**
  String editPetTitle(String name);

  /// No description provided for @newPet.
  ///
  /// In en, this message translates to:
  /// **'New pet'**
  String get newPet;

  /// No description provided for @whatKindOfPet.
  ///
  /// In en, this message translates to:
  /// **'What kind of pet?'**
  String get whatKindOfPet;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @petNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Luna'**
  String get petNameHint;

  /// No description provided for @petNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your pet\'s name'**
  String get petNameRequired;

  /// No description provided for @petNameTooLong.
  ///
  /// In en, this message translates to:
  /// **'Name must be under 40 characters'**
  String get petNameTooLong;

  /// No description provided for @breedHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Golden Retriever, Mixed'**
  String get breedHint;

  /// No description provided for @colorHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Golden with white chest'**
  String get colorHint;

  /// No description provided for @ageHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 3 years, 8 months'**
  String get ageHint;

  /// No description provided for @featuresHint.
  ///
  /// In en, this message translates to:
  /// **'Collar, microchip, scars, spots… anything that helps someone recognise your pet.'**
  String get featuresHint;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @savePet.
  ///
  /// In en, this message translates to:
  /// **'Save pet'**
  String get savePet;

  /// No description provided for @cameraPermission.
  ///
  /// In en, this message translates to:
  /// **'Please allow camera access in Settings.'**
  String get cameraPermission;

  /// No description provided for @photosPermission.
  ///
  /// In en, this message translates to:
  /// **'Please allow photo access in Settings.'**
  String get photosPermission;

  /// No description provided for @cameraFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the camera.'**
  String get cameraFailed;

  /// No description provided for @galleryFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the gallery.'**
  String get galleryFailed;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @addPetPhotos.
  ///
  /// In en, this message translates to:
  /// **'Add photos of your pet'**
  String get addPetPhotos;

  /// No description provided for @addPetPhotosHint.
  ///
  /// In en, this message translates to:
  /// **'Clear, recent photos help people recognise them'**
  String get addPetPhotosHint;

  /// No description provided for @photoRequired.
  ///
  /// In en, this message translates to:
  /// **'At least one photo is required'**
  String get photoRequired;

  /// No description provided for @tapToMakeCover.
  ///
  /// In en, this message translates to:
  /// **'Tap a photo to make it the cover.'**
  String get tapToMakeCover;

  /// No description provided for @cover.
  ///
  /// In en, this message translates to:
  /// **'Cover'**
  String get cover;

  /// No description provided for @uploadingPhotos.
  ///
  /// In en, this message translates to:
  /// **'Uploading photos… {percent}%'**
  String uploadingPhotos(int percent);

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get saving;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takePhoto;

  /// No description provided for @useCamera.
  ///
  /// In en, this message translates to:
  /// **'Use your camera'**
  String get useCamera;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get chooseFromGallery;

  /// No description provided for @pickExistingPhoto.
  ///
  /// In en, this message translates to:
  /// **'Pick an existing photo'**
  String get pickExistingPhoto;

  /// No description provided for @yourPet.
  ///
  /// In en, this message translates to:
  /// **'your pet'**
  String get yourPet;

  /// No description provided for @unknownDog.
  ///
  /// In en, this message translates to:
  /// **'Unknown dog'**
  String get unknownDog;

  /// No description provided for @unknownCat.
  ///
  /// In en, this message translates to:
  /// **'Unknown cat'**
  String get unknownCat;

  /// No description provided for @unknownPet.
  ///
  /// In en, this message translates to:
  /// **'Unknown pet'**
  String get unknownPet;

  /// No description provided for @errorChooseType.
  ///
  /// In en, this message translates to:
  /// **'Choose whether you lost or found a pet.'**
  String get errorChooseType;

  /// No description provided for @errorPickPet.
  ///
  /// In en, this message translates to:
  /// **'Pick the pet that is missing.'**
  String get errorPickPet;

  /// No description provided for @errorFoundPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add at least one photo of the pet.'**
  String get errorFoundPhoto;

  /// No description provided for @errorFoundSpecies.
  ///
  /// In en, this message translates to:
  /// **'Is it a dog, a cat or other?'**
  String get errorFoundSpecies;

  /// No description provided for @errorChooseCity.
  ///
  /// In en, this message translates to:
  /// **'Choose the city where it happened.'**
  String get errorChooseCity;

  /// No description provided for @errorFutureDate.
  ///
  /// In en, this message translates to:
  /// **'The date can\'t be in the future.'**
  String get errorFutureDate;

  /// No description provided for @errorDescriptionShort.
  ///
  /// In en, this message translates to:
  /// **'Add a short description (at least 10 characters).'**
  String get errorDescriptionShort;

  /// No description provided for @errorContactRequired.
  ///
  /// In en, this message translates to:
  /// **'Add a phone number or email so people can reach you.'**
  String get errorContactRequired;

  /// No description provided for @errorPhoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number.'**
  String get errorPhoneInvalid;

  /// No description provided for @discardReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard this report?'**
  String get discardReportTitle;

  /// No description provided for @discardReportMessage.
  ///
  /// In en, this message translates to:
  /// **'What you\'ve entered so far will be lost.'**
  String get discardReportMessage;

  /// No description provided for @signInToPublish.
  ///
  /// In en, this message translates to:
  /// **'Please sign in again to publish.'**
  String get signInToPublish;

  /// No description provided for @publishedLost.
  ///
  /// In en, this message translates to:
  /// **'{pet} is now on the map. We hope they\'re home soon.'**
  String publishedLost(String pet);

  /// No description provided for @publishedFound.
  ///
  /// In en, this message translates to:
  /// **'Thank you! {pet} is now on the map.'**
  String publishedFound(String pet);

  /// No description provided for @reportLostPetTitle.
  ///
  /// In en, this message translates to:
  /// **'Report a lost pet'**
  String get reportLostPetTitle;

  /// No description provided for @reportFoundPetTitle.
  ///
  /// In en, this message translates to:
  /// **'Report a found pet'**
  String get reportFoundPetTitle;

  /// No description provided for @newReport.
  ///
  /// In en, this message translates to:
  /// **'New report'**
  String get newReport;

  /// No description provided for @stepOf.
  ///
  /// In en, this message translates to:
  /// **'{current} of {total}'**
  String stepOf(int current, int total);

  /// No description provided for @publishReport.
  ///
  /// In en, this message translates to:
  /// **'Publish report'**
  String get publishReport;

  /// No description provided for @stepTypeTitle.
  ///
  /// In en, this message translates to:
  /// **'What happened?'**
  String get stepTypeTitle;

  /// No description provided for @stepTypeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s get the word out to people nearby, fast.'**
  String get stepTypeSubtitle;

  /// No description provided for @stepFoundPetTitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us about the pet'**
  String get stepFoundPetTitle;

  /// No description provided for @stepFoundPetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A clear photo is the fastest way for the owner to recognise them.'**
  String get stepFoundPetSubtitle;

  /// No description provided for @addFoundPhotos.
  ///
  /// In en, this message translates to:
  /// **'Add photos of the pet'**
  String get addFoundPhotos;

  /// No description provided for @addFoundPhotosHint.
  ///
  /// In en, this message translates to:
  /// **'Take one now, or pick from your gallery'**
  String get addFoundPhotosHint;

  /// No description provided for @whatKindOfAnimal.
  ///
  /// In en, this message translates to:
  /// **'What kind of animal?'**
  String get whatKindOfAnimal;

  /// No description provided for @collarName.
  ///
  /// In en, this message translates to:
  /// **'Name on collar or tag'**
  String get collarName;

  /// No description provided for @collarNameHint.
  ///
  /// In en, this message translates to:
  /// **'Leave empty if you don\'t know'**
  String get collarNameHint;

  /// No description provided for @stepLostPetTitle.
  ///
  /// In en, this message translates to:
  /// **'Which pet is missing?'**
  String get stepLostPetTitle;

  /// No description provided for @stepLostPetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ll use their profile and photos so you don\'t have to retype anything.'**
  String get stepLostPetSubtitle;

  /// No description provided for @stepWhereFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Where did you find it?'**
  String get stepWhereFoundTitle;

  /// No description provided for @stepWhereLostTitle.
  ///
  /// In en, this message translates to:
  /// **'Where was {pet} last seen?'**
  String stepWhereLostTitle(String pet);

  /// No description provided for @stepWhereSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the city, then pin the spot on the map. People only see an area of about 100 m, never the exact address.'**
  String get stepWhereSubtitle;

  /// No description provided for @streetOrLandmark.
  ///
  /// In en, this message translates to:
  /// **'Street or landmark'**
  String get streetOrLandmark;

  /// No description provided for @pinExactSpot.
  ///
  /// In en, this message translates to:
  /// **'Pin the exact spot'**
  String get pinExactSpot;

  /// No description provided for @spotHintFound.
  ///
  /// In en, this message translates to:
  /// **'Drag the map so the pin sits where {pet} was found.'**
  String spotHintFound(String pet);

  /// No description provided for @spotHintLost.
  ///
  /// In en, this message translates to:
  /// **'Drag the map so the pin sits where {pet} was last seen.'**
  String spotHintLost(String pet);

  /// No description provided for @spotFarFromCity.
  ///
  /// In en, this message translates to:
  /// **'This spot is {km} km from {city}. Is the city right?'**
  String spotFarFromCity(int km, String city);

  /// No description provided for @spotPinned.
  ///
  /// In en, this message translates to:
  /// **'Pinned. People only see an area of about {meters} m around it, never the exact spot.'**
  String spotPinned(int meters);

  /// No description provided for @timeHourAgo.
  ///
  /// In en, this message translates to:
  /// **'1 hour ago'**
  String get timeHourAgo;

  /// No description provided for @timeThisMorning.
  ///
  /// In en, this message translates to:
  /// **'This morning'**
  String get timeThisMorning;

  /// No description provided for @stepWhenFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'When did you find it?'**
  String get stepWhenFoundTitle;

  /// No description provided for @stepWhenLostTitle.
  ///
  /// In en, this message translates to:
  /// **'When did you last see {pet}?'**
  String stepWhenLostTitle(String pet);

  /// No description provided for @stepWhenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'An approximate time is fine.'**
  String get stepWhenSubtitle;

  /// No description provided for @changeDate.
  ///
  /// In en, this message translates to:
  /// **'Change date'**
  String get changeDate;

  /// No description provided for @changeTime.
  ///
  /// In en, this message translates to:
  /// **'Change time'**
  String get changeTime;

  /// No description provided for @stepDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Anything else we should know?'**
  String get stepDetailsTitle;

  /// No description provided for @stepDetailsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Details help neighbours recognise the pet and reach you quickly.'**
  String get stepDetailsSubtitle;

  /// No description provided for @descriptionHintLost.
  ///
  /// In en, this message translates to:
  /// **'Collar colour, behaviour, how {pet} went missing…'**
  String descriptionHintLost(String pet);

  /// No description provided for @descriptionHintFound.
  ///
  /// In en, this message translates to:
  /// **'Condition, collar, behaviour, where exactly you found it…'**
  String get descriptionHintFound;

  /// No description provided for @howToReachYou.
  ///
  /// In en, this message translates to:
  /// **'How can people reach you?'**
  String get howToReachYou;

  /// No description provided for @contactPrivacyNote.
  ///
  /// In en, this message translates to:
  /// **'Shown only on the report page, never in lists.'**
  String get contactPrivacyNote;

  /// No description provided for @phoneHint.
  ///
  /// In en, this message translates to:
  /// **'Phone, e.g. +39 333 123 4567'**
  String get phoneHint;

  /// No description provided for @reachableOnWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'Reachable on WhatsApp'**
  String get reachableOnWhatsapp;

  /// No description provided for @reachableOnWhatsappHint.
  ///
  /// In en, this message translates to:
  /// **'People can message you on this number'**
  String get reachableOnWhatsappHint;

  /// No description provided for @stepReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Ready to publish?'**
  String get stepReviewTitle;

  /// No description provided for @stepReviewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This is how your report will look to people nearby.'**
  String get stepReviewSubtitle;

  /// No description provided for @iLostMyPet.
  ///
  /// In en, this message translates to:
  /// **'I lost my pet'**
  String get iLostMyPet;

  /// No description provided for @iFoundAPet.
  ///
  /// In en, this message translates to:
  /// **'I found a pet'**
  String get iFoundAPet;

  /// No description provided for @iLostMyPetHint.
  ///
  /// In en, this message translates to:
  /// **'Alert people nearby and get help searching.'**
  String get iLostMyPetHint;

  /// No description provided for @iFoundAPetHint.
  ///
  /// In en, this message translates to:
  /// **'Help a lost pet find its way back home.'**
  String get iFoundAPetHint;

  /// No description provided for @addAPet.
  ///
  /// In en, this message translates to:
  /// **'Add a pet'**
  String get addAPet;

  /// No description provided for @pleaseChooseCity.
  ///
  /// In en, this message translates to:
  /// **'Please choose a city'**
  String get pleaseChooseCity;

  /// No description provided for @noPlacesFound.
  ///
  /// In en, this message translates to:
  /// **'No places found in {city} for \"{query}\".'**
  String noPlacesFound(String city, String query);

  /// No description provided for @searchStreetHint.
  ///
  /// In en, this message translates to:
  /// **'Search in {city}, e.g. Via Dante'**
  String searchStreetHint(String city);

  /// No description provided for @yourCity.
  ///
  /// In en, this message translates to:
  /// **'your city'**
  String get yourCity;

  /// No description provided for @useMyLocation.
  ///
  /// In en, this message translates to:
  /// **'Use my location'**
  String get useMyLocation;

  /// No description provided for @publishFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t publish your report. Please try again.'**
  String get publishFailed;

  /// No description provided for @updateReportFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t update the report. Please try again.'**
  String get updateReportFailed;

  /// No description provided for @deleteReportFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t delete the report. Please try again.'**
  String get deleteReportFailed;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUse;

  /// No description provided for @legalLastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated: {date}'**
  String legalLastUpdated(String date);

  /// No description provided for @deleteAccountPasswordPrompt.
  ///
  /// In en, this message translates to:
  /// **'Enter your password to confirm.'**
  String get deleteAccountPasswordPrompt;

  /// No description provided for @deleteAccountTypeConfirm.
  ///
  /// In en, this message translates to:
  /// **'Type {word} to confirm.'**
  String deleteAccountTypeConfirm(String word);

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong password. Please try again.'**
  String get wrongPassword;

  /// No description provided for @confirmPasswordAgain.
  ///
  /// In en, this message translates to:
  /// **'For your security, please confirm your password again.'**
  String get confirmPasswordAgain;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get contactUs;

  /// No description provided for @legalQuestions.
  ///
  /// In en, this message translates to:
  /// **'Questions about this document or your data?'**
  String get legalQuestions;

  /// No description provided for @languageChangeLater.
  ///
  /// In en, this message translates to:
  /// **'You can change it anytime in your profile.'**
  String get languageChangeLater;

  /// No description provided for @reward.
  ///
  /// In en, this message translates to:
  /// **'Reward'**
  String get reward;

  /// No description provided for @rewardHint.
  ///
  /// In en, this message translates to:
  /// **'Amount in euros'**
  String get rewardHint;

  /// No description provided for @rewardNote.
  ///
  /// In en, this message translates to:
  /// **'The reward is a private arrangement between the owner and the finder. CodaMi does not guarantee or process any payment.'**
  String get rewardNote;

  /// No description provided for @rewardAmount.
  ///
  /// In en, this message translates to:
  /// **'Reward {amount}'**
  String rewardAmount(String amount);

  /// No description provided for @adminPanel.
  ///
  /// In en, this message translates to:
  /// **'Admin panel'**
  String get adminPanel;

  /// No description provided for @roleAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get roleAdmin;

  /// No description provided for @roleSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get roleSupport;

  /// No description provided for @supportStaff.
  ///
  /// In en, this message translates to:
  /// **'Support staff'**
  String get supportStaff;

  /// No description provided for @supportStaffSubtitle.
  ///
  /// In en, this message translates to:
  /// **'People who answer support requests'**
  String get supportStaffSubtitle;

  /// No description provided for @adminUsers.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get adminUsers;

  /// No description provided for @adminListings.
  ///
  /// In en, this message translates to:
  /// **'Listings'**
  String get adminListings;

  /// No description provided for @adminReportedContent.
  ///
  /// In en, this message translates to:
  /// **'Reported content'**
  String get adminReportedContent;

  /// No description provided for @adminTickets.
  ///
  /// In en, this message translates to:
  /// **'Support tickets'**
  String get adminTickets;

  /// No description provided for @adminVideos.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get adminVideos;

  /// No description provided for @addSupportStaff.
  ///
  /// In en, this message translates to:
  /// **'Add support staff'**
  String get addSupportStaff;

  /// No description provided for @addSupportStaffHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the email of an existing CodaMi account.'**
  String get addSupportStaffHint;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'No CodaMi account uses this email.'**
  String get userNotFound;

  /// No description provided for @alreadyStaff.
  ///
  /// In en, this message translates to:
  /// **'This person is already on the team.'**
  String get alreadyStaff;

  /// No description provided for @staffAdded.
  ///
  /// In en, this message translates to:
  /// **'{name} is now on the support team.'**
  String staffAdded(String name);

  /// No description provided for @removeStaffTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove {name}?'**
  String removeStaffTitle(String name);

  /// No description provided for @removeStaffMessage.
  ///
  /// In en, this message translates to:
  /// **'They will no longer have access to the admin panel.'**
  String get removeStaffMessage;

  /// No description provided for @noSupportStaff.
  ///
  /// In en, this message translates to:
  /// **'No support staff yet.'**
  String get noSupportStaff;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @actionFailed.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get actionFailed;

  /// No description provided for @adminDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get adminDashboard;

  /// No description provided for @adminMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get adminMore;

  /// No description provided for @adminReportedShort.
  ///
  /// In en, this message translates to:
  /// **'Reported'**
  String get adminReportedShort;

  /// No description provided for @adminTicketsShort.
  ///
  /// In en, this message translates to:
  /// **'Tickets'**
  String get adminTicketsShort;

  /// No description provided for @adminSectionSoon.
  ///
  /// In en, this message translates to:
  /// **'This section is coming soon.'**
  String get adminSectionSoon;

  /// No description provided for @statUsers.
  ///
  /// In en, this message translates to:
  /// **'Registered users'**
  String get statUsers;

  /// No description provided for @statOpenLost.
  ///
  /// In en, this message translates to:
  /// **'Open lost reports'**
  String get statOpenLost;

  /// No description provided for @statOpenFound.
  ///
  /// In en, this message translates to:
  /// **'Open found reports'**
  String get statOpenFound;

  /// No description provided for @statBackHome.
  ///
  /// In en, this message translates to:
  /// **'Pets back home'**
  String get statBackHome;

  /// No description provided for @flagListing.
  ///
  /// In en, this message translates to:
  /// **'Report listing'**
  String get flagListing;

  /// No description provided for @flagTitle.
  ///
  /// In en, this message translates to:
  /// **'Why are you reporting this listing?'**
  String get flagTitle;

  /// No description provided for @flagHint.
  ///
  /// In en, this message translates to:
  /// **'Our team will review it. The owner won\'t know who reported it.'**
  String get flagHint;

  /// No description provided for @flagReasonSpam.
  ///
  /// In en, this message translates to:
  /// **'Spam or advertising'**
  String get flagReasonSpam;

  /// No description provided for @flagReasonScam.
  ///
  /// In en, this message translates to:
  /// **'Scam or fraud'**
  String get flagReasonScam;

  /// No description provided for @flagReasonInappropriate.
  ///
  /// In en, this message translates to:
  /// **'Inappropriate content'**
  String get flagReasonInappropriate;

  /// No description provided for @flagReasonWrongInfo.
  ///
  /// In en, this message translates to:
  /// **'False or misleading information'**
  String get flagReasonWrongInfo;

  /// No description provided for @flagReasonOther.
  ///
  /// In en, this message translates to:
  /// **'Something else'**
  String get flagReasonOther;

  /// No description provided for @flagNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Add details (optional)'**
  String get flagNoteHint;

  /// No description provided for @flagSubmit.
  ///
  /// In en, this message translates to:
  /// **'Send report'**
  String get flagSubmit;

  /// No description provided for @flagSent.
  ///
  /// In en, this message translates to:
  /// **'Thanks. Our team will review this listing.'**
  String get flagSent;

  /// No description provided for @alreadyFlagged.
  ///
  /// In en, this message translates to:
  /// **'You have already reported this listing.'**
  String get alreadyFlagged;

  /// No description provided for @blockUser.
  ///
  /// In en, this message translates to:
  /// **'Block {name}'**
  String blockUser(String name);

  /// No description provided for @blockUserTitle.
  ///
  /// In en, this message translates to:
  /// **'Block {name}?'**
  String blockUserTitle(String name);

  /// No description provided for @blockUserMessage.
  ///
  /// In en, this message translates to:
  /// **'You won\'t see their listings or get alerts about them. You can unblock them in Profile → Blocked users.'**
  String get blockUserMessage;

  /// No description provided for @block.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get block;

  /// No description provided for @userBlocked.
  ///
  /// In en, this message translates to:
  /// **'{name} is blocked.'**
  String userBlocked(String name);

  /// No description provided for @blockedUsers.
  ///
  /// In en, this message translates to:
  /// **'Blocked users'**
  String get blockedUsers;

  /// No description provided for @noBlockedUsers.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t blocked anyone.'**
  String get noBlockedUsers;

  /// No description provided for @unblock.
  ///
  /// In en, this message translates to:
  /// **'Unblock'**
  String get unblock;

  /// No description provided for @userUnblocked.
  ///
  /// In en, this message translates to:
  /// **'{name} is unblocked.'**
  String userUnblocked(String name);

  /// No description provided for @unknownUser.
  ///
  /// In en, this message translates to:
  /// **'Unknown user'**
  String get unknownUser;

  /// No description provided for @hiddenListing.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get hiddenListing;

  /// No description provided for @hiddenListingNotice.
  ///
  /// In en, this message translates to:
  /// **'This listing was hidden by the CodaMi team and is no longer public.'**
  String get hiddenListingNotice;

  /// No description provided for @moderation.
  ///
  /// In en, this message translates to:
  /// **'Moderation'**
  String get moderation;

  /// No description provided for @noFlagsOnListing.
  ///
  /// In en, this message translates to:
  /// **'No one has reported this listing.'**
  String get noFlagsOnListing;

  /// No description provided for @flagCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Reported once} other{Reported {count} times}}'**
  String flagCount(int count);

  /// No description provided for @dismissFlags.
  ///
  /// In en, this message translates to:
  /// **'Dismiss reports'**
  String get dismissFlags;

  /// No description provided for @flagsDismissed.
  ///
  /// In en, this message translates to:
  /// **'Reports dismissed.'**
  String get flagsDismissed;

  /// No description provided for @hideListing.
  ///
  /// In en, this message translates to:
  /// **'Hide listing'**
  String get hideListing;

  /// No description provided for @restoreListing.
  ///
  /// In en, this message translates to:
  /// **'Restore listing'**
  String get restoreListing;

  /// No description provided for @listingHidden.
  ///
  /// In en, this message translates to:
  /// **'Listing hidden. Only the owner can still see it.'**
  String get listingHidden;

  /// No description provided for @listingRestored.
  ///
  /// In en, this message translates to:
  /// **'Listing restored.'**
  String get listingRestored;

  /// No description provided for @deleteListing.
  ///
  /// In en, this message translates to:
  /// **'Delete listing'**
  String get deleteListing;

  /// No description provided for @deleteListingTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this listing?'**
  String get deleteListingTitle;

  /// No description provided for @deleteListingMessage.
  ///
  /// In en, this message translates to:
  /// **'The listing and its photos are deleted for everyone. This can\'t be undone.'**
  String get deleteListingMessage;

  /// No description provided for @listingDeleted.
  ///
  /// In en, this message translates to:
  /// **'Listing deleted.'**
  String get listingDeleted;

  /// No description provided for @listingUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Listing no longer available'**
  String get listingUnavailable;

  /// No description provided for @noReportedContent.
  ///
  /// In en, this message translates to:
  /// **'Nothing reported'**
  String get noReportedContent;

  /// No description provided for @noReportedContentMessage.
  ///
  /// In en, this message translates to:
  /// **'Listings reported by users will appear here.'**
  String get noReportedContentMessage;

  /// No description provided for @filterOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get filterOpen;

  /// No description provided for @filterResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get filterResolved;

  /// No description provided for @filterHidden.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get filterHidden;

  /// No description provided for @noListings.
  ///
  /// In en, this message translates to:
  /// **'No listings here'**
  String get noListings;

  /// No description provided for @tryAnotherFilter.
  ///
  /// In en, this message translates to:
  /// **'Try another filter.'**
  String get tryAnotherFilter;

  /// No description provided for @adminUsersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View, disable or delete accounts'**
  String get adminUsersSubtitle;

  /// No description provided for @searchByEmail.
  ///
  /// In en, this message translates to:
  /// **'Search by email'**
  String get searchByEmail;

  /// No description provided for @noUsersFound.
  ///
  /// In en, this message translates to:
  /// **'No users found.'**
  String get noUsersFound;

  /// No description provided for @roleUser.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get roleUser;

  /// No description provided for @userDisabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get userDisabled;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since'**
  String get memberSince;

  /// No description provided for @disableAccount.
  ///
  /// In en, this message translates to:
  /// **'Disable account'**
  String get disableAccount;

  /// No description provided for @enableAccount.
  ///
  /// In en, this message translates to:
  /// **'Enable account'**
  String get enableAccount;

  /// No description provided for @disableUserTitle.
  ///
  /// In en, this message translates to:
  /// **'Disable {name}\'s account?'**
  String disableUserTitle(String name);

  /// No description provided for @disableUserMessage.
  ///
  /// In en, this message translates to:
  /// **'They will be signed out and can\'t log in. Their open listings are hidden until the account is enabled again.'**
  String get disableUserMessage;

  /// No description provided for @accountDisabled.
  ///
  /// In en, this message translates to:
  /// **'Account disabled.'**
  String get accountDisabled;

  /// No description provided for @accountEnabled.
  ///
  /// In en, this message translates to:
  /// **'Account enabled.'**
  String get accountEnabled;

  /// No description provided for @deleteUserTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete {name}\'s account?'**
  String deleteUserTitle(String name);

  /// No description provided for @deleteUserMessage.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes their profile, pets, listings and photos. It can\'t be undone.'**
  String get deleteUserMessage;

  /// No description provided for @userDeleted.
  ///
  /// In en, this message translates to:
  /// **'Account deleted.'**
  String get userDeleted;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requiredField;

  /// No description provided for @notificationSettingsIntro.
  ///
  /// In en, this message translates to:
  /// **'Choose which alerts you get and give each one its own sound, so you know what happened before you look.'**
  String get notificationSettingsIntro;

  /// No description provided for @notificationSound.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get notificationSound;

  /// No description provided for @alertLostTitle.
  ///
  /// In en, this message translates to:
  /// **'Lost pets nearby'**
  String get alertLostTitle;

  /// No description provided for @alertLostDescription.
  ///
  /// In en, this message translates to:
  /// **'When a pet goes missing in your city'**
  String get alertLostDescription;

  /// No description provided for @alertFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Found pets nearby'**
  String get alertFoundTitle;

  /// No description provided for @alertFoundDescription.
  ///
  /// In en, this message translates to:
  /// **'When someone finds a pet in your city'**
  String get alertFoundDescription;

  /// No description provided for @alertResolvedTitle.
  ///
  /// In en, this message translates to:
  /// **'Happy endings'**
  String get alertResolvedTitle;

  /// No description provided for @alertResolvedDescription.
  ///
  /// In en, this message translates to:
  /// **'When a lost or found pet is back home'**
  String get alertResolvedDescription;

  /// No description provided for @soundDefault.
  ///
  /// In en, this message translates to:
  /// **'Phone default'**
  String get soundDefault;

  /// No description provided for @soundSilent.
  ///
  /// In en, this message translates to:
  /// **'Silent'**
  String get soundSilent;

  /// No description provided for @soundChime.
  ///
  /// In en, this message translates to:
  /// **'Chime'**
  String get soundChime;

  /// No description provided for @soundBell.
  ///
  /// In en, this message translates to:
  /// **'Bell'**
  String get soundBell;

  /// No description provided for @soundBright.
  ///
  /// In en, this message translates to:
  /// **'Bright'**
  String get soundBright;

  /// No description provided for @soundSoft.
  ///
  /// In en, this message translates to:
  /// **'Soft'**
  String get soundSoft;

  /// No description provided for @soundCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom sound'**
  String get soundCustom;

  /// No description provided for @soundFromPhone.
  ///
  /// In en, this message translates to:
  /// **'Ringtones and tones on your phone'**
  String get soundFromPhone;

  /// No description provided for @soundFromFile.
  ///
  /// In en, this message translates to:
  /// **'Music or audio file'**
  String get soundFromFile;

  /// No description provided for @soundIosNote.
  ///
  /// In en, this message translates to:
  /// **'On iPhone, notification sounds have to come from the app, so choose one of the sounds above.'**
  String get soundIosNote;

  /// No description provided for @soundPickFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t use that sound. Please try another one.'**
  String get soundPickFailed;

  /// No description provided for @videosForYou.
  ///
  /// In en, this message translates to:
  /// **'Videos for you'**
  String get videosForYou;

  /// No description provided for @videosForYourPets.
  ///
  /// In en, this message translates to:
  /// **'Picked for your pets'**
  String get videosForYourPets;

  /// No description provided for @videosGeneral.
  ///
  /// In en, this message translates to:
  /// **'Animal welfare and responsible pet care'**
  String get videosGeneral;

  /// No description provided for @videosShuffle.
  ///
  /// In en, this message translates to:
  /// **'Show other videos'**
  String get videosShuffle;

  /// No description provided for @videoMotivational.
  ///
  /// In en, this message translates to:
  /// **'Motivation'**
  String get videoMotivational;

  /// No description provided for @videoEducational.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get videoEducational;

  /// No description provided for @videoTagGeneral.
  ///
  /// In en, this message translates to:
  /// **'Everyone'**
  String get videoTagGeneral;

  /// No description provided for @videoLoadError.
  ///
  /// In en, this message translates to:
  /// **'This video can\'t be played right now. Please try again later.'**
  String get videoLoadError;

  /// No description provided for @adminVideosSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Upload and manage videos'**
  String get adminVideosSubtitle;

  /// No description provided for @addVideo.
  ///
  /// In en, this message translates to:
  /// **'Add video'**
  String get addVideo;

  /// No description provided for @editVideo.
  ///
  /// In en, this message translates to:
  /// **'Edit video'**
  String get editVideo;

  /// No description provided for @noVideosYet.
  ///
  /// In en, this message translates to:
  /// **'No videos yet. Add the first one with the button below.'**
  String get noVideosYet;

  /// No description provided for @deleteVideoTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this video?'**
  String get deleteVideoTitle;

  /// No description provided for @deleteVideoMessage.
  ///
  /// In en, this message translates to:
  /// **'It will be removed from the app for everyone. This can\'t be undone.'**
  String get deleteVideoMessage;

  /// No description provided for @videoHidden.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get videoHidden;

  /// No description provided for @allLanguages.
  ///
  /// In en, this message translates to:
  /// **'All languages'**
  String get allLanguages;

  /// No description provided for @chooseVideo.
  ///
  /// In en, this message translates to:
  /// **'Choose a video'**
  String get chooseVideo;

  /// No description provided for @chooseVideoHint.
  ///
  /// In en, this message translates to:
  /// **'From your gallery, up to 200 MB. Short videos (under 2 minutes) work best.'**
  String get chooseVideoHint;

  /// No description provided for @videoTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get videoTitle;

  /// No description provided for @videoType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get videoType;

  /// No description provided for @videoAnimals.
  ///
  /// In en, this message translates to:
  /// **'Animals'**
  String get videoAnimals;

  /// No description provided for @videoAnimalsHint.
  ///
  /// In en, this message translates to:
  /// **'Pick the animals this video is about. Choose \"Everyone\" for general videos shown to all users.'**
  String get videoAnimalsHint;

  /// No description provided for @videoVisible.
  ///
  /// In en, this message translates to:
  /// **'Visible in the app'**
  String get videoVisible;

  /// No description provided for @videoVisibleHint.
  ///
  /// In en, this message translates to:
  /// **'Hidden videos are only seen by admins.'**
  String get videoVisibleHint;

  /// No description provided for @videoTooLarge.
  ///
  /// In en, this message translates to:
  /// **'This video is larger than 200 MB. Please choose a shorter one.'**
  String get videoTooLarge;

  /// No description provided for @videoSaved.
  ///
  /// In en, this message translates to:
  /// **'Video saved.'**
  String get videoSaved;

  /// No description provided for @uploadingProgress.
  ///
  /// In en, this message translates to:
  /// **'Uploading… {percent}%'**
  String uploadingProgress(int percent);

  /// No description provided for @navVideos.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get navVideos;

  /// No description provided for @videosEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Videos are on the way'**
  String get videosEmptyTitle;

  /// No description provided for @videosEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Soon you\'ll find short videos here about caring for your animals.'**
  String get videosEmptyMessage;

  /// No description provided for @moreVideos.
  ///
  /// In en, this message translates to:
  /// **'More videos'**
  String get moreVideos;

  /// No description provided for @videoWatched.
  ///
  /// In en, this message translates to:
  /// **'Watched'**
  String get videoWatched;

  /// No description provided for @videoBack10.
  ///
  /// In en, this message translates to:
  /// **'Back 10 seconds'**
  String get videoBack10;

  /// No description provided for @videoForward10.
  ///
  /// In en, this message translates to:
  /// **'Forward 10 seconds'**
  String get videoForward10;

  /// No description provided for @videoFullscreen.
  ///
  /// In en, this message translates to:
  /// **'Full screen'**
  String get videoFullscreen;

  /// No description provided for @videoExitFullscreen.
  ///
  /// In en, this message translates to:
  /// **'Exit full screen'**
  String get videoExitFullscreen;

  /// No description provided for @videoRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get videoRetry;

  /// No description provided for @videoDeleted.
  ///
  /// In en, this message translates to:
  /// **'Video deleted.'**
  String get videoDeleted;

  /// No description provided for @noVideosYetTitle.
  ///
  /// In en, this message translates to:
  /// **'No videos yet'**
  String get noVideosYetTitle;

  /// No description provided for @videoVisibleShort.
  ///
  /// In en, this message translates to:
  /// **'Visible'**
  String get videoVisibleShort;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @videoSectionFile.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get videoSectionFile;

  /// No description provided for @videoSectionDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get videoSectionDetails;

  /// No description provided for @videoSectionAudience.
  ///
  /// In en, this message translates to:
  /// **'Who sees it'**
  String get videoSectionAudience;

  /// No description provided for @videoCover.
  ///
  /// In en, this message translates to:
  /// **'Cover image'**
  String get videoCover;

  /// No description provided for @videoCoverHint.
  ///
  /// In en, this message translates to:
  /// **'Optional. Shown on the video card.'**
  String get videoCoverHint;

  /// No description provided for @videoMotivationalHint.
  ///
  /// In en, this message translates to:
  /// **'Inspiring stories and happy moments'**
  String get videoMotivationalHint;

  /// No description provided for @videoEducationalHint.
  ///
  /// In en, this message translates to:
  /// **'Tips and how-tos for owners'**
  String get videoEducationalHint;

  /// No description provided for @uploadVideo.
  ///
  /// In en, this message translates to:
  /// **'Upload video'**
  String get uploadVideo;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & support'**
  String get helpSupport;

  /// No description provided for @helpSupportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Chat with us or send a request'**
  String get helpSupportSubtitle;

  /// No description provided for @supportIntroTitle.
  ///
  /// In en, this message translates to:
  /// **'How can we help?'**
  String get supportIntroTitle;

  /// No description provided for @supportIntroMessage.
  ///
  /// In en, this message translates to:
  /// **'Our team answers here in the app. You\'ll get a notification when we reply.'**
  String get supportIntroMessage;

  /// No description provided for @supportStartChat.
  ///
  /// In en, this message translates to:
  /// **'Start a live chat'**
  String get supportStartChat;

  /// No description provided for @supportStartChatOnline.
  ///
  /// In en, this message translates to:
  /// **'An operator is online now'**
  String get supportStartChatOnline;

  /// No description provided for @supportChatOffline.
  ///
  /// In en, this message translates to:
  /// **'No operator is online right now. Send a request and we\'ll reply as soon as possible.'**
  String get supportChatOffline;

  /// No description provided for @supportSendRequest.
  ///
  /// In en, this message translates to:
  /// **'Send a request'**
  String get supportSendRequest;

  /// No description provided for @supportSendRequestSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We usually reply within 24 hours'**
  String get supportSendRequestSubtitle;

  /// No description provided for @supportMyRequests.
  ///
  /// In en, this message translates to:
  /// **'My requests'**
  String get supportMyRequests;

  /// No description provided for @supportNoRequests.
  ///
  /// In en, this message translates to:
  /// **'No requests yet'**
  String get supportNoRequests;

  /// No description provided for @supportNoRequestsMessage.
  ///
  /// In en, this message translates to:
  /// **'Your conversations with support will appear here.'**
  String get supportNoRequestsMessage;

  /// No description provided for @supportNewChat.
  ///
  /// In en, this message translates to:
  /// **'New live chat'**
  String get supportNewChat;

  /// No description provided for @supportNewRequest.
  ///
  /// In en, this message translates to:
  /// **'New request'**
  String get supportNewRequest;

  /// No description provided for @supportCategory.
  ///
  /// In en, this message translates to:
  /// **'Topic'**
  String get supportCategory;

  /// No description provided for @categoryAccount.
  ///
  /// In en, this message translates to:
  /// **'Account and login'**
  String get categoryAccount;

  /// No description provided for @categoryListing.
  ///
  /// In en, this message translates to:
  /// **'A lost or found listing'**
  String get categoryListing;

  /// No description provided for @categoryApp.
  ///
  /// In en, this message translates to:
  /// **'Problem with the app'**
  String get categoryApp;

  /// No description provided for @categoryOther.
  ///
  /// In en, this message translates to:
  /// **'Something else'**
  String get categoryOther;

  /// No description provided for @supportSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get supportSubject;

  /// No description provided for @supportSubjectHint.
  ///
  /// In en, this message translates to:
  /// **'In a few words'**
  String get supportSubjectHint;

  /// No description provided for @supportSubjectTooShort.
  ///
  /// In en, this message translates to:
  /// **'Please write at least 3 characters'**
  String get supportSubjectTooShort;

  /// No description provided for @supportMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get supportMessage;

  /// No description provided for @supportMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Tell us what happened'**
  String get supportMessageHint;

  /// No description provided for @supportMessageRequired.
  ///
  /// In en, this message translates to:
  /// **'Please write a message'**
  String get supportMessageRequired;

  /// No description provided for @supportSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get supportSend;

  /// No description provided for @supportTooManyOpen.
  ///
  /// In en, this message translates to:
  /// **'You already have 3 open requests. Please continue in one of them.'**
  String get supportTooManyOpen;

  /// No description provided for @supportTypeMessage.
  ///
  /// In en, this message translates to:
  /// **'Write a message…'**
  String get supportTypeMessage;

  /// No description provided for @supportTeam.
  ///
  /// In en, this message translates to:
  /// **'CodaMi support'**
  String get supportTeam;

  /// No description provided for @supportMarkSolved.
  ///
  /// In en, this message translates to:
  /// **'Mark as solved'**
  String get supportMarkSolved;

  /// No description provided for @supportMarkSolvedConfirm.
  ///
  /// In en, this message translates to:
  /// **'Mark this request as solved? You can write again if you still need help.'**
  String get supportMarkSolvedConfirm;

  /// No description provided for @supportClosedNote.
  ///
  /// In en, this message translates to:
  /// **'This request is closed. Start a new one if you need more help.'**
  String get supportClosedNote;

  /// No description provided for @supportResolvedNote.
  ///
  /// In en, this message translates to:
  /// **'Marked as solved. Writing again reopens it.'**
  String get supportResolvedNote;

  /// No description provided for @supportWaitingNote.
  ///
  /// In en, this message translates to:
  /// **'Thanks! Our team will reply here soon.'**
  String get supportWaitingNote;

  /// No description provided for @kindChat.
  ///
  /// In en, this message translates to:
  /// **'Live chat'**
  String get kindChat;

  /// No description provided for @kindTicket.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get kindTicket;

  /// No description provided for @caseStatusOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get caseStatusOpen;

  /// No description provided for @caseStatusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get caseStatusInProgress;

  /// No description provided for @caseStatusWaitingUser.
  ///
  /// In en, this message translates to:
  /// **'Waiting for response'**
  String get caseStatusWaitingUser;

  /// No description provided for @caseStatusResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get caseStatusResolved;

  /// No description provided for @caseStatusClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get caseStatusClosed;

  /// No description provided for @filterUnanswered.
  ///
  /// In en, this message translates to:
  /// **'Unanswered'**
  String get filterUnanswered;

  /// No description provided for @filterUnassigned.
  ///
  /// In en, this message translates to:
  /// **'Unassigned'**
  String get filterUnassigned;

  /// No description provided for @filterMine.
  ///
  /// In en, this message translates to:
  /// **'Mine'**
  String get filterMine;

  /// No description provided for @filterActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get filterActive;

  /// No description provided for @filterDone.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get filterDone;

  /// No description provided for @supportSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search CM-1042 or email'**
  String get supportSearchHint;

  /// No description provided for @supportNoCases.
  ///
  /// In en, this message translates to:
  /// **'No requests here'**
  String get supportNoCases;

  /// No description provided for @supportNoCasesMessage.
  ///
  /// In en, this message translates to:
  /// **'Nothing is waiting in this list.'**
  String get supportNoCasesMessage;

  /// No description provided for @supportTake.
  ///
  /// In en, this message translates to:
  /// **'Take this case'**
  String get supportTake;

  /// No description provided for @supportTakeToReply.
  ///
  /// In en, this message translates to:
  /// **'Take this case to reply.'**
  String get supportTakeToReply;

  /// No description provided for @supportAlreadyTaken.
  ///
  /// In en, this message translates to:
  /// **'Another operator already took this case.'**
  String get supportAlreadyTaken;

  /// No description provided for @supportUnassigned.
  ///
  /// In en, this message translates to:
  /// **'Not assigned'**
  String get supportUnassigned;

  /// No description provided for @supportReassign.
  ///
  /// In en, this message translates to:
  /// **'Reassign'**
  String get supportReassign;

  /// No description provided for @supportAssignTo.
  ///
  /// In en, this message translates to:
  /// **'Assign to'**
  String get supportAssignTo;

  /// No description provided for @supportBackToQueue.
  ///
  /// In en, this message translates to:
  /// **'Back to the queue'**
  String get supportBackToQueue;

  /// No description provided for @supportChangeStatus.
  ///
  /// In en, this message translates to:
  /// **'Change status'**
  String get supportChangeStatus;

  /// No description provided for @supportChat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get supportChat;

  /// No description provided for @supportTimeline.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get supportTimeline;

  /// No description provided for @supportDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get supportDetails;

  /// No description provided for @supportWaitingFor.
  ///
  /// In en, this message translates to:
  /// **'Waiting {time}'**
  String supportWaitingFor(String time);

  /// No description provided for @supportOverdue.
  ///
  /// In en, this message translates to:
  /// **'Late reply'**
  String get supportOverdue;

  /// No description provided for @supportOpened.
  ///
  /// In en, this message translates to:
  /// **'Opened'**
  String get supportOpened;

  /// No description provided for @supportTakenOver.
  ///
  /// In en, this message translates to:
  /// **'Taken over'**
  String get supportTakenOver;

  /// No description provided for @supportWaitToTake.
  ///
  /// In en, this message translates to:
  /// **'Wait before takeover'**
  String get supportWaitToTake;

  /// No description provided for @supportFirstReply.
  ///
  /// In en, this message translates to:
  /// **'First reply'**
  String get supportFirstReply;

  /// No description provided for @supportAvgReply.
  ///
  /// In en, this message translates to:
  /// **'Average reply time'**
  String get supportAvgReply;

  /// No description provided for @supportHandlingTime.
  ///
  /// In en, this message translates to:
  /// **'Time spent'**
  String get supportHandlingTime;

  /// No description provided for @supportResolvedAt.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get supportResolvedAt;

  /// No description provided for @supportMessagesCount.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get supportMessagesCount;

  /// No description provided for @supportOperator.
  ///
  /// In en, this message translates to:
  /// **'Operator'**
  String get supportOperator;

  /// No description provided for @supportUserLabel.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get supportUserLabel;

  /// No description provided for @eventCreated.
  ///
  /// In en, this message translates to:
  /// **'Opened by {name}'**
  String eventCreated(String name);

  /// No description provided for @eventTaken.
  ///
  /// In en, this message translates to:
  /// **'Taken by {name}'**
  String eventTaken(String name);

  /// No description provided for @eventReassigned.
  ///
  /// In en, this message translates to:
  /// **'Reassigned from {from} to {to}'**
  String eventReassigned(String from, String to);

  /// No description provided for @eventStatus.
  ///
  /// In en, this message translates to:
  /// **'{name} set the status to {status}'**
  String eventStatus(String name, String status);

  /// No description provided for @eventReopened.
  ///
  /// In en, this message translates to:
  /// **'Reopened by the user'**
  String get eventReopened;

  /// No description provided for @eventOverdue.
  ///
  /// In en, this message translates to:
  /// **'No reply within the time limit'**
  String get eventOverdue;

  /// No description provided for @eventAutoClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed automatically'**
  String get eventAutoClosed;

  /// No description provided for @presenceOnline.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get presenceOnline;

  /// No description provided for @presenceAway.
  ///
  /// In en, this message translates to:
  /// **'Away'**
  String get presenceAway;

  /// No description provided for @presenceOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get presenceOffline;

  /// No description provided for @presenceAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available for live chat'**
  String get presenceAvailable;

  /// No description provided for @presenceAvailableSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Users can start a live chat while an operator is online'**
  String get presenceAvailableSubtitle;

  /// No description provided for @supportOperators.
  ///
  /// In en, this message translates to:
  /// **'Operators'**
  String get supportOperators;

  /// No description provided for @supportOperatorsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Activity, cases and reply times'**
  String get supportOperatorsSubtitle;

  /// No description provided for @operatorOpenCases.
  ///
  /// In en, this message translates to:
  /// **'Open cases'**
  String get operatorOpenCases;

  /// No description provided for @operatorTaken.
  ///
  /// In en, this message translates to:
  /// **'Taken'**
  String get operatorTaken;

  /// No description provided for @operatorResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get operatorResolved;

  /// No description provided for @operatorReplies.
  ///
  /// In en, this message translates to:
  /// **'Replies'**
  String get operatorReplies;

  /// No description provided for @operatorAvgHandling.
  ///
  /// In en, this message translates to:
  /// **'Average time per case'**
  String get operatorAvgHandling;

  /// No description provided for @operatorLastActive.
  ///
  /// In en, this message translates to:
  /// **'Last active {time}'**
  String operatorLastActive(String time);

  /// No description provided for @operatorCases.
  ///
  /// In en, this message translates to:
  /// **'Cases'**
  String get operatorCases;

  /// No description provided for @noOperators.
  ///
  /// In en, this message translates to:
  /// **'No support staff yet. Add them in Support staff.'**
  String get noOperators;

  /// No description provided for @statUnassigned.
  ///
  /// In en, this message translates to:
  /// **'Unassigned requests'**
  String get statUnassigned;

  /// No description provided for @statUnanswered.
  ///
  /// In en, this message translates to:
  /// **'Unanswered requests'**
  String get statUnanswered;

  /// No description provided for @statOverdue.
  ///
  /// In en, this message translates to:
  /// **'Late replies'**
  String get statOverdue;

  /// No description provided for @alertSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Support replies'**
  String get alertSupportTitle;

  /// No description provided for @alertSupportDescription.
  ///
  /// In en, this message translates to:
  /// **'When CodaMi support writes to you'**
  String get alertSupportDescription;

  /// No description provided for @durationSeconds.
  ///
  /// In en, this message translates to:
  /// **'{n} s'**
  String durationSeconds(int n);

  /// No description provided for @durationMinutes.
  ///
  /// In en, this message translates to:
  /// **'{n} min'**
  String durationMinutes(int n);

  /// No description provided for @durationHours.
  ///
  /// In en, this message translates to:
  /// **'{h} h {m} min'**
  String durationHours(int h, int m);

  /// No description provided for @durationDays.
  ///
  /// In en, this message translates to:
  /// **'{d} d {h} h'**
  String durationDays(int d, int h);

  /// No description provided for @searchUsersHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name or email'**
  String get searchUsersHint;

  /// No description provided for @searchTooShort.
  ///
  /// In en, this message translates to:
  /// **'Type at least 2 characters'**
  String get searchTooShort;

  /// No description provided for @pickStaffTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a user'**
  String get pickStaffTitle;

  /// No description provided for @pickStaffHint.
  ///
  /// In en, this message translates to:
  /// **'Tap a person to add them to the support team.'**
  String get pickStaffHint;

  /// No description provided for @makeStaffTitle.
  ///
  /// In en, this message translates to:
  /// **'Make {name} support staff?'**
  String makeStaffTitle(String name);

  /// No description provided for @makeStaffMessage.
  ///
  /// In en, this message translates to:
  /// **'They will see the admin side and can answer tickets and live chats. You can remove them at any time.'**
  String get makeStaffMessage;

  /// No description provided for @makeStaff.
  ///
  /// In en, this message translates to:
  /// **'Add to team'**
  String get makeStaff;

  /// No description provided for @supportStaffSwitch.
  ///
  /// In en, this message translates to:
  /// **'Support staff'**
  String get supportStaffSwitch;

  /// No description provided for @supportStaffSwitchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Can answer tickets and live chats'**
  String get supportStaffSwitchSubtitle;

  /// No description provided for @staffRemoved.
  ///
  /// In en, this message translates to:
  /// **'{name} is no longer on the support team.'**
  String staffRemoved(String name);

  /// No description provided for @removeStaffCasesNote.
  ///
  /// In en, this message translates to:
  /// **'Their open cases go back to the queue.'**
  String get removeStaffCasesNote;

  /// No description provided for @pushOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get pushOpen;

  /// No description provided for @chatToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get chatToday;

  /// No description provided for @chatLoadEarlier.
  ///
  /// In en, this message translates to:
  /// **'Load earlier messages'**
  String get chatLoadEarlier;

  /// No description provided for @supportPeople.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get supportPeople;

  /// No description provided for @supportTimes.
  ///
  /// In en, this message translates to:
  /// **'Times'**
  String get supportTimes;

  /// No description provided for @supportRequestInfo.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get supportRequestInfo;

  /// No description provided for @supportType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get supportType;

  /// No description provided for @supportResolve.
  ///
  /// In en, this message translates to:
  /// **'Mark as resolved'**
  String get supportResolve;

  /// No description provided for @ticketsWaiting.
  ///
  /// In en, this message translates to:
  /// **'{count} waiting for a reply'**
  String ticketsWaiting(int count);

  /// No description provided for @ticketsAllClear.
  ///
  /// In en, this message translates to:
  /// **'All caught up'**
  String get ticketsAllClear;

  /// No description provided for @photoReviewHint.
  ///
  /// In en, this message translates to:
  /// **'Photos the AI held back. They stay hidden until you decide.'**
  String get photoReviewHint;

  /// No description provided for @reasonAdult.
  ///
  /// In en, this message translates to:
  /// **'Nudity or sexual content'**
  String get reasonAdult;

  /// No description provided for @reasonRacy.
  ///
  /// In en, this message translates to:
  /// **'Suggestive content'**
  String get reasonRacy;

  /// No description provided for @reasonViolence.
  ///
  /// In en, this message translates to:
  /// **'Violence or blood'**
  String get reasonViolence;

  /// No description provided for @likelihoodPossible.
  ///
  /// In en, this message translates to:
  /// **'Possible'**
  String get likelihoodPossible;

  /// No description provided for @likelihoodLikely.
  ///
  /// In en, this message translates to:
  /// **'Likely'**
  String get likelihoodLikely;

  /// No description provided for @likelihoodVeryLikely.
  ///
  /// In en, this message translates to:
  /// **'Very likely'**
  String get likelihoodVeryLikely;

  /// No description provided for @hiddenByAi.
  ///
  /// In en, this message translates to:
  /// **'Hidden by AI'**
  String get hiddenByAi;

  /// No description provided for @petPhoto.
  ///
  /// In en, this message translates to:
  /// **'Pet photo'**
  String get petPhoto;

  /// No description provided for @listingPhoto.
  ///
  /// In en, this message translates to:
  /// **'Listing photo'**
  String get listingPhoto;

  /// No description provided for @uploadedBy.
  ///
  /// In en, this message translates to:
  /// **'By {name}'**
  String uploadedBy(String name);

  /// No description provided for @tapToView.
  ///
  /// In en, this message translates to:
  /// **'Tap to view'**
  String get tapToView;

  /// No description provided for @approvePhoto.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approvePhoto;

  /// No description provided for @removePhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove this photo?'**
  String get removePhotoTitle;

  /// No description provided for @removePhotoMessage.
  ///
  /// In en, this message translates to:
  /// **'It will be removed from the user\'s pet or listing, and the user will be told why.'**
  String get removePhotoMessage;

  /// No description provided for @photoApproved.
  ///
  /// In en, this message translates to:
  /// **'Photo approved'**
  String get photoApproved;

  /// No description provided for @photoRemovedDone.
  ///
  /// In en, this message translates to:
  /// **'Photo removed'**
  String get photoRemovedDone;

  /// No description provided for @photoUnderReview.
  ///
  /// In en, this message translates to:
  /// **'A photo is being checked by our team and is hidden until then.'**
  String get photoUnderReview;

  /// No description provided for @reportedTabPhotos.
  ///
  /// In en, this message translates to:
  /// **'AI photos'**
  String get reportedTabPhotos;

  /// No description provided for @reportedTabReports.
  ///
  /// In en, this message translates to:
  /// **'User reports'**
  String get reportedTabReports;

  /// No description provided for @noPhotosToReview.
  ///
  /// In en, this message translates to:
  /// **'No photos to review'**
  String get noPhotosToReview;

  /// No description provided for @noPhotosToReviewMessage.
  ///
  /// In en, this message translates to:
  /// **'Photos the AI holds back will appear here.'**
  String get noPhotosToReviewMessage;

  /// No description provided for @aFriend.
  ///
  /// In en, this message translates to:
  /// **'A friend'**
  String get aFriend;

  /// No description provided for @addContact.
  ///
  /// In en, this message translates to:
  /// **'Add contact'**
  String get addContact;

  /// No description provided for @addTestContacts.
  ///
  /// In en, this message translates to:
  /// **'Add test contacts'**
  String get addTestContacts;

  /// No description provided for @adjustPoints.
  ///
  /// In en, this message translates to:
  /// **'Adjust points'**
  String get adjustPoints;

  /// No description provided for @adjustPointsAmount.
  ///
  /// In en, this message translates to:
  /// **'Points to add or remove'**
  String get adjustPointsAmount;

  /// No description provided for @adjustPointsAmountHelp.
  ///
  /// In en, this message translates to:
  /// **'Use a minus sign to remove points, e.g. -20'**
  String get adjustPointsAmountHelp;

  /// No description provided for @adjustPointsInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a number of points and a reason.'**
  String get adjustPointsInvalid;

  /// No description provided for @adjustPointsReason.
  ///
  /// In en, this message translates to:
  /// **'Reason (shown to the user)'**
  String get adjustPointsReason;

  /// No description provided for @adminContactsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Vets, associations and services shown to users'**
  String get adminContactsSubtitle;

  /// No description provided for @adminEmergenciesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reported animal emergencies'**
  String get adminEmergenciesSubtitle;

  /// No description provided for @alertEmergencyDescription.
  ///
  /// In en, this message translates to:
  /// **'Animals that need urgent help near your city'**
  String get alertEmergencyDescription;

  /// No description provided for @alertEmergencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergencies nearby'**
  String get alertEmergencyTitle;

  /// No description provided for @allContacts.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allContacts;

  /// No description provided for @ambassadorLevels.
  ///
  /// In en, this message translates to:
  /// **'Ambassador levels'**
  String get ambassadorLevels;

  /// No description provided for @call112.
  ///
  /// In en, this message translates to:
  /// **'Call 112'**
  String get call112;

  /// No description provided for @claim.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get claim;

  /// No description provided for @claimed.
  ///
  /// In en, this message translates to:
  /// **'Claimed'**
  String get claimed;

  /// No description provided for @codeCopied.
  ///
  /// In en, this message translates to:
  /// **'Code copied'**
  String get codeCopied;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @contactActive.
  ///
  /// In en, this message translates to:
  /// **'Shown to users'**
  String get contactActive;

  /// No description provided for @contactActiveHelp.
  ///
  /// In en, this message translates to:
  /// **'Turn off to hide this contact without deleting it.'**
  String get contactActiveHelp;

  /// No description provided for @contactAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get contactAddress;

  /// No description provided for @contactAreaKm.
  ///
  /// In en, this message translates to:
  /// **'Area covered (km)'**
  String get contactAreaKm;

  /// No description provided for @contactAreaKmHelp.
  ///
  /// In en, this message translates to:
  /// **'How far from its address it can help. Leave empty to use the default from the emergency settings.'**
  String get contactAreaKmHelp;

  /// No description provided for @contactCity.
  ///
  /// In en, this message translates to:
  /// **'Town or city'**
  String get contactCity;

  /// No description provided for @contactHandles.
  ///
  /// In en, this message translates to:
  /// **'Emergencies it handles'**
  String get contactHandles;

  /// No description provided for @contactHandlesHelp.
  ///
  /// In en, this message translates to:
  /// **'Leave all off if it handles every kind.'**
  String get contactHandlesHelp;

  /// No description provided for @contactHoursHint.
  ///
  /// In en, this message translates to:
  /// **'Opening hours, e.g. Mon–Fri 9:00–18:00'**
  String get contactHoursHint;

  /// No description provided for @contactInactive.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get contactInactive;

  /// No description provided for @contactKindAssociation.
  ///
  /// In en, this message translates to:
  /// **'Animal welfare association'**
  String get contactKindAssociation;

  /// No description provided for @contactKindOther.
  ///
  /// In en, this message translates to:
  /// **'Other service'**
  String get contactKindOther;

  /// No description provided for @contactKindPublicService.
  ///
  /// In en, this message translates to:
  /// **'Public veterinary service'**
  String get contactKindPublicService;

  /// No description provided for @contactKindVet.
  ///
  /// In en, this message translates to:
  /// **'Vet'**
  String get contactKindVet;

  /// No description provided for @contactMissingFields.
  ///
  /// In en, this message translates to:
  /// **'Add a name and place the pin on the map.'**
  String get contactMissingFields;

  /// No description provided for @contactName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get contactName;

  /// No description provided for @contactNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Clinica Veterinaria San Francesco'**
  String get contactNameHint;

  /// No description provided for @contactPhones.
  ///
  /// In en, this message translates to:
  /// **'Phone numbers'**
  String get contactPhones;

  /// No description provided for @contactPhonesHint.
  ///
  /// In en, this message translates to:
  /// **'Separate numbers with commas'**
  String get contactPhonesHint;

  /// No description provided for @contactPlace.
  ///
  /// In en, this message translates to:
  /// **'Where it is'**
  String get contactPlace;

  /// No description provided for @contactRecommendedHelp.
  ///
  /// In en, this message translates to:
  /// **'Shown before nearer contacts when an emergency is reported.'**
  String get contactRecommendedHelp;

  /// No description provided for @contactTestHelp.
  ///
  /// In en, this message translates to:
  /// **'Placeholder for testing. Shown with a TEST label, never verified or emailed.'**
  String get contactTestHelp;

  /// No description provided for @contactType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get contactType;

  /// No description provided for @contactVerifiedHelp.
  ///
  /// In en, this message translates to:
  /// **'Only after the organization agreed to be listed and the details were checked.'**
  String get contactVerifiedHelp;

  /// No description provided for @copyCode.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copyCode;

  /// No description provided for @dailyActive.
  ///
  /// In en, this message translates to:
  /// **'Active today'**
  String get dailyActive;

  /// No description provided for @dailyCheckin.
  ///
  /// In en, this message translates to:
  /// **'Daily check-in'**
  String get dailyCheckin;

  /// No description provided for @dailyRewards.
  ///
  /// In en, this message translates to:
  /// **'Daily rewards'**
  String get dailyRewards;

  /// No description provided for @deleteContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this contact?'**
  String get deleteContactTitle;

  /// No description provided for @directions.
  ///
  /// In en, this message translates to:
  /// **'Directions'**
  String get directions;

  /// No description provided for @editContact.
  ///
  /// In en, this message translates to:
  /// **'Edit contact'**
  String get editContact;

  /// No description provided for @emergencies.
  ///
  /// In en, this message translates to:
  /// **'Emergencies'**
  String get emergencies;

  /// No description provided for @emergenciesActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get emergenciesActive;

  /// No description provided for @emergenciesAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get emergenciesAll;

  /// No description provided for @emergenciesNearYou.
  ///
  /// In en, this message translates to:
  /// **'Near you'**
  String get emergenciesNearYou;

  /// No description provided for @emergenciesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Animals that need urgent help'**
  String get emergenciesSubtitle;

  /// No description provided for @emergencyAddPhotos.
  ///
  /// In en, this message translates to:
  /// **'Add a photo'**
  String get emergencyAddPhotos;

  /// No description provided for @emergencyAddPhotosHint.
  ///
  /// In en, this message translates to:
  /// **'Helps others find and recognise the animal'**
  String get emergencyAddPhotosHint;

  /// No description provided for @emergencyAllContacts.
  ///
  /// In en, this message translates to:
  /// **'See all emergency contacts'**
  String get emergencyAllContacts;

  /// No description provided for @emergencyAlreadyReported.
  ///
  /// In en, this message translates to:
  /// **'You already reported this.'**
  String get emergencyAlreadyReported;

  /// No description provided for @emergencyCallReporter.
  ///
  /// In en, this message translates to:
  /// **'Call the person who reported it'**
  String get emergencyCallReporter;

  /// No description provided for @emergencyClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get emergencyClose;

  /// No description provided for @emergencyCloseTitle.
  ///
  /// In en, this message translates to:
  /// **'Close this emergency?'**
  String get emergencyCloseTitle;

  /// No description provided for @emergencyContacts.
  ///
  /// In en, this message translates to:
  /// **'Emergency contacts'**
  String get emergencyContacts;

  /// No description provided for @emergencyDetails.
  ///
  /// In en, this message translates to:
  /// **'What\'s happening?'**
  String get emergencyDetails;

  /// No description provided for @emergencyDetailsHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Dog hit by a car, lying by the road, still breathing'**
  String get emergencyDetailsHint;

  /// No description provided for @emergencyDetailsRequired.
  ///
  /// In en, this message translates to:
  /// **'Describe the situation in a few words.'**
  String get emergencyDetailsRequired;

  /// No description provided for @emergencyDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'CodaMi is not an emergency service. If an animal is in immediate danger, call 112 or a vet first. Don\'t rely only on app notifications.'**
  String get emergencyDisclaimer;

  /// No description provided for @emergencyFalseAlarmTitle.
  ///
  /// In en, this message translates to:
  /// **'Mark as a false alarm?'**
  String get emergencyFalseAlarmTitle;

  /// No description provided for @emergencyFindingContacts.
  ///
  /// In en, this message translates to:
  /// **'Finding contacts near this place…'**
  String get emergencyFindingContacts;

  /// No description provided for @emergencyHelpDone.
  ///
  /// In en, this message translates to:
  /// **'Thank you! The person who reported it was told.'**
  String get emergencyHelpDone;

  /// No description provided for @emergencyHelpMessage.
  ///
  /// In en, this message translates to:
  /// **'The person who reported it will know someone is coming. Only go if it\'s safe for you.'**
  String get emergencyHelpMessage;

  /// No description provided for @emergencyHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you going to help?'**
  String get emergencyHelpTitle;

  /// No description provided for @emergencyImHelping.
  ///
  /// In en, this message translates to:
  /// **'I\'m going to help'**
  String get emergencyImHelping;

  /// No description provided for @emergencyMarkFalseAlarm.
  ///
  /// In en, this message translates to:
  /// **'Mark as false alarm'**
  String get emergencyMarkFalseAlarm;

  /// No description provided for @emergencyMarkResolved.
  ///
  /// In en, this message translates to:
  /// **'Mark as resolved'**
  String get emergencyMarkResolved;

  /// No description provided for @emergencyMissingFields.
  ///
  /// In en, this message translates to:
  /// **'Choose what happened and the animal, describe it and place the pin.'**
  String get emergencyMissingFields;

  /// No description provided for @emergencyNoContacts.
  ///
  /// In en, this message translates to:
  /// **'No contacts listed for this area yet. Call 112 or a vet.'**
  String get emergencyNoContacts;

  /// No description provided for @emergencyPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Shown to people who want to help, so they can call you.'**
  String get emergencyPhoneHint;

  /// No description provided for @emergencyPinHint.
  ///
  /// In en, this message translates to:
  /// **'Move the map to put the pin where the animal is.'**
  String get emergencyPinHint;

  /// No description provided for @emergencyPinned.
  ///
  /// In en, this message translates to:
  /// **'Pin placed'**
  String get emergencyPinned;

  /// No description provided for @emergencyReopen.
  ///
  /// In en, this message translates to:
  /// **'Reopen'**
  String get emergencyReopen;

  /// No description provided for @emergencyReportFalse.
  ///
  /// In en, this message translates to:
  /// **'Report as false'**
  String get emergencyReportFalse;

  /// No description provided for @emergencyReportFalseDone.
  ///
  /// In en, this message translates to:
  /// **'Thanks, our team will check it.'**
  String get emergencyReportFalseDone;

  /// No description provided for @emergencyReportFalseMessage.
  ///
  /// In en, this message translates to:
  /// **'Our team will check this emergency.'**
  String get emergencyReportFalseMessage;

  /// No description provided for @emergencyReportFalseTitle.
  ///
  /// In en, this message translates to:
  /// **'Is this emergency false?'**
  String get emergencyReportFalseTitle;

  /// No description provided for @emergencyResolveTitle.
  ///
  /// In en, this message translates to:
  /// **'Mark as resolved?'**
  String get emergencyResolveTitle;

  /// No description provided for @emergencyResolved.
  ///
  /// In en, this message translates to:
  /// **'Marked as resolved'**
  String get emergencyResolved;

  /// No description provided for @emergencySend.
  ///
  /// In en, this message translates to:
  /// **'Send emergency'**
  String get emergencySend;

  /// No description provided for @emergencySendFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t send the emergency. Check your connection and try again, or call 112.'**
  String get emergencySendFailed;

  /// No description provided for @emergencySending.
  ///
  /// In en, this message translates to:
  /// **'Sending…'**
  String get emergencySending;

  /// No description provided for @emergencySent.
  ///
  /// In en, this message translates to:
  /// **'Emergency sent. People nearby are being alerted. You can also call the contacts below directly.'**
  String get emergencySent;

  /// No description provided for @emergencySettings.
  ///
  /// In en, this message translates to:
  /// **'Emergency settings'**
  String get emergencySettings;

  /// No description provided for @emergencySettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Alert distances and how contacts are ranked'**
  String get emergencySettingsSubtitle;

  /// No description provided for @emergencyStatusClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get emergencyStatusClosed;

  /// No description provided for @emergencyStatusFalseAlarm.
  ///
  /// In en, this message translates to:
  /// **'False alarm'**
  String get emergencyStatusFalseAlarm;

  /// No description provided for @emergencyStatusHelping.
  ///
  /// In en, this message translates to:
  /// **'Help on the way'**
  String get emergencyStatusHelping;

  /// No description provided for @emergencyStatusOpen.
  ///
  /// In en, this message translates to:
  /// **'Needs help'**
  String get emergencyStatusOpen;

  /// No description provided for @emergencyStatusResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get emergencyStatusResolved;

  /// No description provided for @emergencySuggestedContacts.
  ///
  /// In en, this message translates to:
  /// **'Who can help'**
  String get emergencySuggestedContacts;

  /// No description provided for @emergencySuggestedContactsHint.
  ///
  /// In en, this message translates to:
  /// **'Nearest suitable contacts first. Call them directly.'**
  String get emergencySuggestedContactsHint;

  /// No description provided for @emergencyTypeAbandoned.
  ///
  /// In en, this message translates to:
  /// **'Abandoned animal'**
  String get emergencyTypeAbandoned;

  /// No description provided for @emergencyTypeDanger.
  ///
  /// In en, this message translates to:
  /// **'Animal in danger'**
  String get emergencyTypeDanger;

  /// No description provided for @emergencyTypeInjured.
  ///
  /// In en, this message translates to:
  /// **'Injured animal'**
  String get emergencyTypeInjured;

  /// No description provided for @emergencyTypeIntervention.
  ///
  /// In en, this message translates to:
  /// **'Request for intervention'**
  String get emergencyTypeIntervention;

  /// No description provided for @emergencyTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other emergency'**
  String get emergencyTypeOther;

  /// No description provided for @emergencyTypeUrgentFound.
  ///
  /// In en, this message translates to:
  /// **'Found, needs urgent care'**
  String get emergencyTypeUrgentFound;

  /// No description provided for @emergencyUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This emergency is no longer available.'**
  String get emergencyUnavailable;

  /// No description provided for @emergencyWhatHappened.
  ///
  /// In en, this message translates to:
  /// **'What happened?'**
  String get emergencyWhatHappened;

  /// No description provided for @emergencyWhere.
  ///
  /// In en, this message translates to:
  /// **'Where is the animal?'**
  String get emergencyWhere;

  /// No description provided for @emergencyWhereHint.
  ///
  /// In en, this message translates to:
  /// **'The exact place is shared so helpers can find the animal.'**
  String get emergencyWhereHint;

  /// No description provided for @emergencyYouAreHelping.
  ///
  /// In en, this message translates to:
  /// **'You said you\'re going to help. Thank you!'**
  String get emergencyYouAreHelping;

  /// No description provided for @emergencyYourPhone.
  ///
  /// In en, this message translates to:
  /// **'Your phone'**
  String get emergencyYourPhone;

  /// No description provided for @flagBurst.
  ///
  /// In en, this message translates to:
  /// **'Many friends of this user became active on the same day'**
  String get flagBurst;

  /// No description provided for @flagDeviceUsed.
  ///
  /// In en, this message translates to:
  /// **'This phone was already used for another invite'**
  String get flagDeviceUsed;

  /// No description provided for @flagSameDevice.
  ///
  /// In en, this message translates to:
  /// **'Same phone as the person who invited them'**
  String get flagSameDevice;

  /// No description provided for @haveInviteCode.
  ///
  /// In en, this message translates to:
  /// **'Did a friend invite you? Enter their code'**
  String get haveInviteCode;

  /// No description provided for @invitePromptTitle.
  ///
  /// In en, this message translates to:
  /// **'Did a friend invite you?'**
  String get invitePromptTitle;

  /// No description provided for @invitePromptBody.
  ///
  /// In en, this message translates to:
  /// **'Enter their invite code so your friend gets the credit for bringing you to CodaMi.'**
  String get invitePromptBody;

  /// No description provided for @invitePromptLater.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{You can also add it later today in Profile → Invite friends.} other{You can also add it later in Profile → Invite friends, within {days} days of signing up.}}'**
  String invitePromptLater(int days);

  /// No description provided for @inviteCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Invite code'**
  String get inviteCodeLabel;

  /// No description provided for @inviteCodeFromLink.
  ///
  /// In en, this message translates to:
  /// **'Filled in from your invite link. Tap Use to confirm.'**
  String get inviteCodeFromLink;

  /// No description provided for @inviteCodeFormat.
  ///
  /// In en, this message translates to:
  /// **'Invite codes have 6 letters and numbers, like ABC234.'**
  String get inviteCodeFormat;

  /// No description provided for @inviteCodeNotFound.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find this code. Check it with your friend.'**
  String get inviteCodeNotFound;

  /// No description provided for @inviteCodeOwn.
  ///
  /// In en, this message translates to:
  /// **'That\'s your own code. Share it with your friends instead.'**
  String get inviteCodeOwn;

  /// No description provided for @inviteCodeTooLate.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{Invite codes can only be added on the day you sign up.} other{Invite codes can only be added in the first {days} days after signing up.}}'**
  String inviteCodeTooLate(int days);

  /// No description provided for @inviteCodeTooManyTries.
  ///
  /// In en, this message translates to:
  /// **'Too many wrong codes today. Try again tomorrow.'**
  String get inviteCodeTooManyTries;

  /// No description provided for @howInvitesWork.
  ///
  /// In en, this message translates to:
  /// **'How it works'**
  String get howInvitesWork;

  /// No description provided for @inviteApproved.
  ///
  /// In en, this message translates to:
  /// **'Invite approved'**
  String get inviteApproved;

  /// No description provided for @inviteCodeAlreadyUsed.
  ///
  /// In en, this message translates to:
  /// **'You already used an invite code.'**
  String get inviteCodeAlreadyUsed;

  /// No description provided for @inviteCodeInvalid.
  ///
  /// In en, this message translates to:
  /// **'This code isn\'t valid.'**
  String get inviteCodeInvalid;

  /// No description provided for @inviteCodeNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'This code can\'t be used: it\'s your own code, or it\'s too long since you signed up.'**
  String get inviteCodeNotAllowed;

  /// No description provided for @inviteFriends.
  ///
  /// In en, this message translates to:
  /// **'Invite friends'**
  String get inviteFriends;

  /// No description provided for @inviteFriendsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Become a CodaMi ambassador'**
  String get inviteFriendsSubtitle;

  /// No description provided for @inviteIntro.
  ///
  /// In en, this message translates to:
  /// **'Every new CodaMi user is one more pair of eyes for lost pets. Invite your friends and become a CodaMi ambassador.'**
  String get inviteIntro;

  /// No description provided for @inviteRejected.
  ///
  /// In en, this message translates to:
  /// **'Invite rejected'**
  String get inviteRejected;

  /// No description provided for @inviteStatusExpired.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t become active in time'**
  String get inviteStatusExpired;

  /// No description provided for @inviteStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Joined, not active yet'**
  String get inviteStatusPending;

  /// No description provided for @inviteStatusQualified.
  ///
  /// In en, this message translates to:
  /// **'Active – points earned'**
  String get inviteStatusQualified;

  /// No description provided for @inviteStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Not counted'**
  String get inviteStatusRejected;

  /// No description provided for @inviteStatusReview.
  ///
  /// In en, this message translates to:
  /// **'Being checked'**
  String get inviteStatusReview;

  /// No description provided for @inviteStep1.
  ///
  /// In en, this message translates to:
  /// **'Share your code. Your friend enters it in Profile → Invite friends after signing up.'**
  String get inviteStep1;

  /// No description provided for @invitedFriends.
  ///
  /// In en, this message translates to:
  /// **'Invited friends (active)'**
  String get invitedFriends;

  /// No description provided for @invitesToReview.
  ///
  /// In en, this message translates to:
  /// **'Invites to review'**
  String get invitesToReview;

  /// No description provided for @invitesToReviewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Invites held by the anti-fraud checks'**
  String get invitesToReviewSubtitle;

  /// No description provided for @levelAmbassador.
  ///
  /// In en, this message translates to:
  /// **'Ambassador'**
  String get levelAmbassador;

  /// No description provided for @levelBonus.
  ///
  /// In en, this message translates to:
  /// **'Bonus points'**
  String get levelBonus;

  /// No description provided for @settingsActiveFriends.
  ///
  /// In en, this message translates to:
  /// **'Active friends'**
  String get settingsActiveFriends;

  /// No description provided for @levelChampion.
  ///
  /// In en, this message translates to:
  /// **'CodaMi Champion'**
  String get levelChampion;

  /// No description provided for @levelSuperAmbassador.
  ///
  /// In en, this message translates to:
  /// **'Super Ambassador'**
  String get levelSuperAmbassador;

  /// No description provided for @levelSupporter.
  ///
  /// In en, this message translates to:
  /// **'Supporter'**
  String get levelSupporter;

  /// No description provided for @myEmergencies.
  ///
  /// In en, this message translates to:
  /// **'Mine'**
  String get myEmergencies;

  /// No description provided for @myPoints.
  ///
  /// In en, this message translates to:
  /// **'My points'**
  String get myPoints;

  /// No description provided for @noActiveEmergencies.
  ///
  /// In en, this message translates to:
  /// **'No emergencies'**
  String get noActiveEmergencies;

  /// No description provided for @noEmergenciesMessage.
  ///
  /// In en, this message translates to:
  /// **'Emergencies reported near your city appear here.'**
  String get noEmergenciesMessage;

  /// No description provided for @noEmergenciesNearby.
  ///
  /// In en, this message translates to:
  /// **'No emergencies near you'**
  String get noEmergenciesNearby;

  /// No description provided for @noEmergencyContacts.
  ///
  /// In en, this message translates to:
  /// **'No contacts yet'**
  String get noEmergencyContacts;

  /// No description provided for @noEmergencyContactsAdmin.
  ///
  /// In en, this message translates to:
  /// **'Add vets, associations and services, or add test contacts to try the feature.'**
  String get noEmergencyContactsAdmin;

  /// No description provided for @noEmergencyContactsMessage.
  ///
  /// In en, this message translates to:
  /// **'Contacts will be added soon. In an emergency, call 112 or a vet.'**
  String get noEmergencyContactsMessage;

  /// No description provided for @noInvitesToReview.
  ///
  /// In en, this message translates to:
  /// **'Nothing to review'**
  String get noInvitesToReview;

  /// No description provided for @noInvitesToReviewMessage.
  ///
  /// In en, this message translates to:
  /// **'Invites that look suspicious appear here. Nothing is rejected without you.'**
  String get noInvitesToReviewMessage;

  /// No description provided for @noInvitesYet.
  ///
  /// In en, this message translates to:
  /// **'No invites yet. Share your code to start.'**
  String get noInvitesYet;

  /// No description provided for @noLevelYet.
  ///
  /// In en, this message translates to:
  /// **'No level yet'**
  String get noLevelYet;

  /// No description provided for @noMyEmergencies.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t reported any emergencies'**
  String get noMyEmergencies;

  /// No description provided for @noPointsYet.
  ///
  /// In en, this message translates to:
  /// **'No points yet. Claim your daily reward to start.'**
  String get noPointsYet;

  /// No description provided for @open24h.
  ///
  /// In en, this message translates to:
  /// **'Open 24 hours'**
  String get open24h;

  /// No description provided for @openMapFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the map.'**
  String get openMapFailed;

  /// No description provided for @photos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get photos;

  /// No description provided for @pointsAdjusted.
  ///
  /// In en, this message translates to:
  /// **'Adjusted by CodaMi'**
  String get pointsAdjusted;

  /// No description provided for @pointsDailyActive.
  ///
  /// In en, this message translates to:
  /// **'Active today'**
  String get pointsDailyActive;

  /// No description provided for @pointsDailyCheckin.
  ///
  /// In en, this message translates to:
  /// **'Daily check-in'**
  String get pointsDailyCheckin;

  /// No description provided for @pointsFriendJoined.
  ///
  /// In en, this message translates to:
  /// **'A friend became active'**
  String get pointsFriendJoined;

  /// No description provided for @pointsHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get pointsHistory;

  /// No description provided for @pointsLevelBonus.
  ///
  /// In en, this message translates to:
  /// **'New level bonus'**
  String get pointsLevelBonus;

  /// No description provided for @pointsOther.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get pointsOther;

  /// No description provided for @pointsSettings.
  ///
  /// In en, this message translates to:
  /// **'Points and rewards'**
  String get pointsSettings;

  /// No description provided for @pointsSettingsIntro.
  ///
  /// In en, this message translates to:
  /// **'Changes apply straight away. Values out of range are replaced by the defaults.'**
  String get pointsSettingsIntro;

  /// No description provided for @pointsSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Daily rewards, invites and levels'**
  String get pointsSettingsSubtitle;

  /// No description provided for @pointsStreakBonus.
  ///
  /// In en, this message translates to:
  /// **'Streak bonus'**
  String get pointsStreakBonus;

  /// No description provided for @pointsWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome bonus'**
  String get pointsWelcome;

  /// No description provided for @recommendedContact.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get recommendedContact;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @reportEmergency.
  ///
  /// In en, this message translates to:
  /// **'Report an emergency'**
  String get reportEmergency;

  /// No description provided for @searchContacts.
  ///
  /// In en, this message translates to:
  /// **'Search by name or town'**
  String get searchContacts;

  /// No description provided for @settingsActiveMinutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes of use for “Active today”'**
  String get settingsActiveMinutes;

  /// No description provided for @settingsAlertsNearby.
  ///
  /// In en, this message translates to:
  /// **'Alerts to people nearby'**
  String get settingsAlertsNearby;

  /// No description provided for @settingsAutoCloseHours.
  ///
  /// In en, this message translates to:
  /// **'Close after (hours without updates)'**
  String get settingsAutoCloseHours;

  /// No description provided for @settingsAutoCloseHoursHelp.
  ///
  /// In en, this message translates to:
  /// **'Open emergencies close by themselves after this time.'**
  String get settingsAutoCloseHoursHelp;

  /// No description provided for @settingsCodeEntryDays.
  ///
  /// In en, this message translates to:
  /// **'Days after sign-up to enter a code'**
  String get settingsCodeEntryDays;

  /// No description provided for @settingsContactsPriority.
  ///
  /// In en, this message translates to:
  /// **'Contact priority'**
  String get settingsContactsPriority;

  /// No description provided for @settingsDefaultAreaKm.
  ///
  /// In en, this message translates to:
  /// **'Default area covered (km)'**
  String get settingsDefaultAreaKm;

  /// No description provided for @settingsDefaultAreaKmHelp.
  ///
  /// In en, this message translates to:
  /// **'Used for contacts without their own area.'**
  String get settingsDefaultAreaKmHelp;

  /// No description provided for @settingsEmailContacts.
  ///
  /// In en, this message translates to:
  /// **'Email alerts to contacts'**
  String get settingsEmailContacts;

  /// No description provided for @settingsEmailContactsHelp.
  ///
  /// In en, this message translates to:
  /// **'Sends an email to verified contacts. The email service must be set up first.'**
  String get settingsEmailContactsHelp;

  /// No description provided for @settingsMaxPerDay.
  ///
  /// In en, this message translates to:
  /// **'Active friends per day before a check'**
  String get settingsMaxPerDay;

  /// No description provided for @settingsMaxPerDayHelp.
  ///
  /// In en, this message translates to:
  /// **'More than this in 24 hours sends the invite to review.'**
  String get settingsMaxPerDayHelp;

  /// No description provided for @settingsMaxRecipients.
  ///
  /// In en, this message translates to:
  /// **'Maximum people alerted'**
  String get settingsMaxRecipients;

  /// No description provided for @settingsMaxSuggested.
  ///
  /// In en, this message translates to:
  /// **'Contacts suggested'**
  String get settingsMaxSuggested;

  /// No description provided for @settingsMinRecipients.
  ///
  /// In en, this message translates to:
  /// **'People to reach'**
  String get settingsMinRecipients;

  /// No description provided for @settingsMinRecipientsHelp.
  ///
  /// In en, this message translates to:
  /// **'The next circle is used until this many people are reached.'**
  String get settingsMinRecipientsHelp;

  /// No description provided for @settingsQualifyDays.
  ///
  /// In en, this message translates to:
  /// **'Active days needed'**
  String get settingsQualifyDays;

  /// No description provided for @settingsQualifyWithinDays.
  ///
  /// In en, this message translates to:
  /// **'Within (days after sign-up)'**
  String get settingsQualifyWithinDays;

  /// No description provided for @settingsReferralPoints.
  ///
  /// In en, this message translates to:
  /// **'Points for each active friend'**
  String get settingsReferralPoints;

  /// No description provided for @settingsRings.
  ///
  /// In en, this message translates to:
  /// **'Alert circles (km)'**
  String get settingsRings;

  /// No description provided for @settingsRingsHelp.
  ///
  /// In en, this message translates to:
  /// **'Comma separated, smallest first, e.g. 5, 10, 25'**
  String get settingsRingsHelp;

  /// No description provided for @settingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get settingsSaved;

  /// No description provided for @settingsStreakDays.
  ///
  /// In en, this message translates to:
  /// **'Days for a streak bonus'**
  String get settingsStreakDays;

  /// No description provided for @settingsWeight24h.
  ///
  /// In en, this message translates to:
  /// **'Bonus for open 24 hours'**
  String get settingsWeight24h;

  /// No description provided for @settingsWeightHelp.
  ///
  /// In en, this message translates to:
  /// **'Contacts get these bonuses and lose points for each km of distance. The highest score comes first.'**
  String get settingsWeightHelp;

  /// No description provided for @settingsWeightPerKm.
  ///
  /// In en, this message translates to:
  /// **'Penalty per km'**
  String get settingsWeightPerKm;

  /// No description provided for @settingsWeightPerKmHelp.
  ///
  /// In en, this message translates to:
  /// **'With 1, a recommended contact (20) comes before one up to 20 km nearer.'**
  String get settingsWeightPerKmHelp;

  /// No description provided for @settingsWeightRecommended.
  ///
  /// In en, this message translates to:
  /// **'Bonus for recommended'**
  String get settingsWeightRecommended;

  /// No description provided for @settingsWeightVerified.
  ///
  /// In en, this message translates to:
  /// **'Bonus for verified'**
  String get settingsWeightVerified;

  /// No description provided for @settingsWelcomePoints.
  ///
  /// In en, this message translates to:
  /// **'Points for the invited friend'**
  String get settingsWelcomePoints;

  /// No description provided for @settingsWelcomePointsHelp.
  ///
  /// In en, this message translates to:
  /// **'Given when they enter a code. 0 turns it off.'**
  String get settingsWelcomePointsHelp;

  /// No description provided for @shareInvite.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareInvite;

  /// No description provided for @statActiveEmergencies.
  ///
  /// In en, this message translates to:
  /// **'Active emergencies'**
  String get statActiveEmergencies;

  /// No description provided for @testContactBadge.
  ///
  /// In en, this message translates to:
  /// **'TEST – not a real contact'**
  String get testContactBadge;

  /// No description provided for @topLevelReached.
  ///
  /// In en, this message translates to:
  /// **'You reached the top level. Thank you!'**
  String get topLevelReached;

  /// No description provided for @useCode.
  ///
  /// In en, this message translates to:
  /// **'Use'**
  String get useCode;

  /// No description provided for @verifiedContact.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verifiedContact;

  /// No description provided for @viewInvitee.
  ///
  /// In en, this message translates to:
  /// **'Invited user'**
  String get viewInvitee;

  /// No description provided for @viewInviter.
  ///
  /// In en, this message translates to:
  /// **'Inviter'**
  String get viewInviter;

  /// No description provided for @yourInviteCode.
  ///
  /// In en, this message translates to:
  /// **'Your invite code'**
  String get yourInviteCode;

  /// No description provided for @yourInvites.
  ///
  /// In en, this message translates to:
  /// **'Your invites'**
  String get yourInvites;

  /// No description provided for @zeroTurnsOff.
  ///
  /// In en, this message translates to:
  /// **'0 turns it off'**
  String get zeroTurnsOff;

  /// No description provided for @activeProgress.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} minutes today'**
  String activeProgress(int done, int total);

  /// No description provided for @claimedPoints.
  ///
  /// In en, this message translates to:
  /// **'+{points} points!'**
  String claimedPoints(int points);

  /// No description provided for @claimedWithBonus.
  ///
  /// In en, this message translates to:
  /// **'+{points} points and a +{bonus} streak bonus!'**
  String claimedWithBonus(int points, int bonus);

  /// No description provided for @emergenciesNearYouCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 animal emergency near you} other{{count} animal emergencies near you}}'**
  String emergenciesNearYouCount(int count);

  /// No description provided for @emergencyAlertedCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Nobody nearby has alerts on yet} =1{1 person nearby was alerted} other{{count} people nearby were alerted}}'**
  String emergencyAlertedCount(int count);

  /// No description provided for @emergencyFalseReports.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Reported as false once} other{Reported as false {count} times}}'**
  String emergencyFalseReports(int count);

  /// No description provided for @emergencyHelpersCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 person is going to help} other{{count} people are going to help}}'**
  String emergencyHelpersCount(int count);

  /// No description provided for @inviteCodeAccepted.
  ///
  /// In en, this message translates to:
  /// **'Code accepted. {name} invited you – welcome to CodaMi!'**
  String inviteCodeAccepted(String name);

  /// No description provided for @inviteShareText.
  ///
  /// In en, this message translates to:
  /// **'I use CodaMi to help lost pets get back home. Join me with my invite code {code}: {link}'**
  String inviteShareText(String code, String link);

  /// No description provided for @inviteStep2.
  ///
  /// In en, this message translates to:
  /// **'They set their city and use the app on {days} different days within {within} days of signing up.'**
  String inviteStep2(int days, int within);

  /// No description provided for @inviteStep3.
  ///
  /// In en, this message translates to:
  /// **'You get {points} points and move up the ambassador levels.'**
  String inviteStep3(int points);

  /// No description provided for @kmAway.
  ///
  /// In en, this message translates to:
  /// **'{km} km away'**
  String kmAway(String km);

  /// No description provided for @levelFriends.
  ///
  /// In en, this message translates to:
  /// **'{level}: active friends'**
  String levelFriends(String level);

  /// No description provided for @levelRule.
  ///
  /// In en, this message translates to:
  /// **'{level} · {friends}+ friends · +{bonus}'**
  String levelRule(String level, int friends, int bonus);

  /// No description provided for @nextLevelHint.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 more active friend to become {level}} other{{count} more active friends to become {level}}}'**
  String nextLevelHint(int count, String level);

  /// No description provided for @plusPoints.
  ///
  /// In en, this message translates to:
  /// **'+{points} points'**
  String plusPoints(int points);

  /// No description provided for @pointsTotal.
  ///
  /// In en, this message translates to:
  /// **'{points, plural, =1{1 point} other{{points} points}}'**
  String pointsTotal(int points);

  /// No description provided for @streakLine.
  ///
  /// In en, this message translates to:
  /// **'{streak}-day streak · +{bonus} bonus every {days} days'**
  String streakLine(int streak, int days, int bonus);

  /// No description provided for @pointsFeedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback sent'**
  String get pointsFeedback;

  /// No description provided for @whatsNew.
  ///
  /// In en, this message translates to:
  /// **'What\'s new'**
  String get whatsNew;

  /// No description provided for @whatsNewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Changes in each version'**
  String get whatsNewSubtitle;

  /// No description provided for @whatsNewTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s new in CodaMi'**
  String get whatsNewTitle;

  /// No description provided for @whatsNewIntro.
  ///
  /// In en, this message translates to:
  /// **'Here\'s what changed in the latest update.'**
  String get whatsNewIntro;

  /// No description provided for @whatsNewVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String whatsNewVersion(String version);

  /// No description provided for @whatsNewSectionNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get whatsNewSectionNew;

  /// No description provided for @whatsNewSectionImproved.
  ///
  /// In en, this message translates to:
  /// **'Improved'**
  String get whatsNewSectionImproved;

  /// No description provided for @whatsNewSectionFixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed'**
  String get whatsNewSectionFixed;

  /// No description provided for @whatsNewEmpty.
  ///
  /// In en, this message translates to:
  /// **'No update notes yet.'**
  String get whatsNewEmpty;

  /// No description provided for @whatsNewDone.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get whatsNewDone;

  /// No description provided for @feedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'How do you like CodaMi?'**
  String get feedbackTitle;

  /// No description provided for @feedbackBody.
  ///
  /// In en, this message translates to:
  /// **'Your feedback goes straight to the CodaMi team and helps us make the app better.'**
  String get feedbackBody;

  /// No description provided for @feedbackPointsOffer.
  ///
  /// In en, this message translates to:
  /// **'+{points} points for your first feedback'**
  String feedbackPointsOffer(int points);

  /// No description provided for @feedbackStarsHint.
  ///
  /// In en, this message translates to:
  /// **'Tap a star to rate'**
  String get feedbackStarsHint;

  /// No description provided for @feedbackCommentHint.
  ///
  /// In en, this message translates to:
  /// **'What do you like, or what could be better? (optional)'**
  String get feedbackCommentHint;

  /// No description provided for @feedbackSend.
  ///
  /// In en, this message translates to:
  /// **'Send feedback'**
  String get feedbackSend;

  /// No description provided for @feedbackLater.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get feedbackLater;

  /// No description provided for @feedbackThanks.
  ///
  /// In en, this message translates to:
  /// **'Thanks for your feedback!'**
  String get feedbackThanks;

  /// No description provided for @feedbackThanksPoints.
  ///
  /// In en, this message translates to:
  /// **'Thanks for your feedback! +{points} points'**
  String feedbackThanksPoints(int points);

  /// No description provided for @feedbackAlreadyToday.
  ///
  /// In en, this message translates to:
  /// **'You already sent feedback today. You can send more tomorrow.'**
  String get feedbackAlreadyToday;

  /// No description provided for @sendFeedbackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell the team what you think'**
  String get sendFeedbackSubtitle;

  /// No description provided for @rateCodaMi.
  ///
  /// In en, this message translates to:
  /// **'Rate CodaMi'**
  String get rateCodaMi;

  /// No description provided for @rateCodaMiSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Leave a review on Google Play'**
  String get rateCodaMiSubtitle;

  /// No description provided for @adminFeedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get adminFeedback;

  /// No description provided for @adminFeedbackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'What users think of the app'**
  String get adminFeedbackSubtitle;

  /// No description provided for @adminFeedbackEmpty.
  ///
  /// In en, this message translates to:
  /// **'No feedback yet.'**
  String get adminFeedbackEmpty;

  /// No description provided for @feedbackRatingsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 rating} other{{count} ratings}}'**
  String feedbackRatingsCount(int count);

  /// No description provided for @feedbackNoComment.
  ///
  /// In en, this message translates to:
  /// **'No comment'**
  String get feedbackNoComment;

  /// No description provided for @adminWhatsNewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Notes shown to users after each update'**
  String get adminWhatsNewSubtitle;

  /// No description provided for @releaseAdd.
  ///
  /// In en, this message translates to:
  /// **'Add version'**
  String get releaseAdd;

  /// No description provided for @releaseEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit notes'**
  String get releaseEdit;

  /// No description provided for @releaseVersion.
  ///
  /// In en, this message translates to:
  /// **'Version number'**
  String get releaseVersion;

  /// No description provided for @releaseVersionHelp.
  ///
  /// In en, this message translates to:
  /// **'Like 1.1.0. It must match the version name of the app in the store.'**
  String get releaseVersionHelp;

  /// No description provided for @releaseVersionInvalid.
  ///
  /// In en, this message translates to:
  /// **'Use numbers and dots, like 1.1.0.'**
  String get releaseVersionInvalid;

  /// No description provided for @releaseVersionExists.
  ///
  /// In en, this message translates to:
  /// **'This version already has notes.'**
  String get releaseVersionExists;

  /// No description provided for @releasePublishedHelp.
  ///
  /// In en, this message translates to:
  /// **'Users only see published notes.'**
  String get releasePublishedHelp;

  /// No description provided for @releaseDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get releaseDraft;

  /// No description provided for @releaseLinesHelp.
  ///
  /// In en, this message translates to:
  /// **'One change per line.'**
  String get releaseLinesHelp;

  /// No description provided for @releaseLanguageHelp.
  ///
  /// In en, this message translates to:
  /// **'Languages left empty show the English notes.'**
  String get releaseLanguageHelp;

  /// No description provided for @releaseEnglishRequired.
  ///
  /// In en, this message translates to:
  /// **'Write the English notes first: other languages fall back to them.'**
  String get releaseEnglishRequired;

  /// No description provided for @releaseDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete these notes?'**
  String get releaseDeleteTitle;

  /// No description provided for @releaseDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'The notes for version {version} will be removed for everyone.'**
  String releaseDeleteBody(String version);

  /// No description provided for @releaseNone.
  ///
  /// In en, this message translates to:
  /// **'No versions yet. Add the notes for your next update.'**
  String get releaseNone;

  /// No description provided for @releaseThisApp.
  ///
  /// In en, this message translates to:
  /// **'This app: version {version}'**
  String releaseThisApp(String version);

  /// No description provided for @feedbackAndReviews.
  ///
  /// In en, this message translates to:
  /// **'Feedback and reviews'**
  String get feedbackAndReviews;

  /// No description provided for @settingsFeedbackPoints.
  ///
  /// In en, this message translates to:
  /// **'Points for the first feedback'**
  String get settingsFeedbackPoints;

  /// No description provided for @settingsFeedbackAfterDays.
  ///
  /// In en, this message translates to:
  /// **'Days after sign-up before asking for feedback'**
  String get settingsFeedbackAfterDays;

  /// No description provided for @settingsReviewActiveDays.
  ///
  /// In en, this message translates to:
  /// **'Days of use before asking'**
  String get settingsReviewActiveDays;

  /// No description provided for @settingsReviewAfterDays.
  ///
  /// In en, this message translates to:
  /// **'Days after sign-up before the store rating window'**
  String get settingsReviewAfterDays;

  /// No description provided for @settingsReviewEveryDays.
  ///
  /// In en, this message translates to:
  /// **'Days between store rating requests'**
  String get settingsReviewEveryDays;

  /// No description provided for @settingsReviewHelp.
  ///
  /// In en, this message translates to:
  /// **'The store rating window never gives points: Google Play and the App Store don\'t allow it.'**
  String get settingsReviewHelp;

  /// No description provided for @petitions.
  ///
  /// In en, this message translates to:
  /// **'Petitions'**
  String get petitions;

  /// No description provided for @petition.
  ///
  /// In en, this message translates to:
  /// **'Petition'**
  String get petition;

  /// No description provided for @petitionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Animal welfare campaigns picked by our team'**
  String get petitionsSubtitle;

  /// No description provided for @adminPetitionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add, review and publish animal welfare petitions'**
  String get adminPetitionsSubtitle;

  /// No description provided for @petitionsBanner.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 animal welfare petition to sign} other{{count} animal welfare petitions to sign}}'**
  String petitionsBanner(int count);

  /// No description provided for @petitionsIntro.
  ///
  /// In en, this message translates to:
  /// **'The CodaMi team checks every petition before it appears here. You read and sign it on the original site.'**
  String get petitionsIntro;

  /// No description provided for @petitionsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No petitions yet. The team will add animal welfare campaigns here.'**
  String get petitionsEmpty;

  /// No description provided for @petitionAdminEmpty.
  ///
  /// In en, this message translates to:
  /// **'No petitions here. Tap Add petition to add one from Change.org, Care2, Avaaz or a trusted organization.'**
  String get petitionAdminEmpty;

  /// No description provided for @petitionView.
  ///
  /// In en, this message translates to:
  /// **'View petition'**
  String get petitionView;

  /// No description provided for @petitionSignOnSite.
  ///
  /// In en, this message translates to:
  /// **'Read and sign on the original site'**
  String get petitionSignOnSite;

  /// No description provided for @petitionOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the petition page.'**
  String get petitionOpenFailed;

  /// No description provided for @petitionIssue.
  ///
  /// In en, this message translates to:
  /// **'The issue'**
  String get petitionIssue;

  /// No description provided for @petitionAction.
  ///
  /// In en, this message translates to:
  /// **'What the petition asks for'**
  String get petitionAction;

  /// No description provided for @petitionWhy.
  ///
  /// In en, this message translates to:
  /// **'Why it matters for animals'**
  String get petitionWhy;

  /// No description provided for @petitionWhere.
  ///
  /// In en, this message translates to:
  /// **'Original petition'**
  String get petitionWhere;

  /// No description provided for @petitionStartedOn.
  ///
  /// In en, this message translates to:
  /// **'Started {date}'**
  String petitionStartedOn(String date);

  /// No description provided for @petitionDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'This petition is hosted by an external site. CodaMi does not collect signatures and is not responsible for the content of the original page.'**
  String get petitionDisclaimer;

  /// No description provided for @petitionEndedNote.
  ///
  /// In en, this message translates to:
  /// **'This campaign has ended. You can still read the original page.'**
  String get petitionEndedNote;

  /// No description provided for @petitionUnavailableNote.
  ///
  /// In en, this message translates to:
  /// **'The original petition is no longer available.'**
  String get petitionUnavailableNote;

  /// No description provided for @petitionTopicPets.
  ///
  /// In en, this message translates to:
  /// **'Pets'**
  String get petitionTopicPets;

  /// No description provided for @petitionTopicWildlife.
  ///
  /// In en, this message translates to:
  /// **'Wildlife'**
  String get petitionTopicWildlife;

  /// No description provided for @petitionTopicFarm.
  ///
  /// In en, this message translates to:
  /// **'Farm animals'**
  String get petitionTopicFarm;

  /// No description provided for @petitionTopicTesting.
  ///
  /// In en, this message translates to:
  /// **'Animal testing'**
  String get petitionTopicTesting;

  /// No description provided for @petitionTopicEntertainment.
  ///
  /// In en, this message translates to:
  /// **'Circuses and zoos'**
  String get petitionTopicEntertainment;

  /// No description provided for @petitionTopicMarine.
  ///
  /// In en, this message translates to:
  /// **'Marine life'**
  String get petitionTopicMarine;

  /// No description provided for @petitionTopicOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get petitionTopicOther;

  /// No description provided for @petitionStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get petitionStatusActive;

  /// No description provided for @petitionStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get petitionStatusCompleted;

  /// No description provided for @petitionStatusClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get petitionStatusClosed;

  /// No description provided for @petitionStatusUnavailable.
  ///
  /// In en, this message translates to:
  /// **'No longer available'**
  String get petitionStatusUnavailable;

  /// No description provided for @petitionReviewPending.
  ///
  /// In en, this message translates to:
  /// **'To review'**
  String get petitionReviewPending;

  /// No description provided for @petitionReviewApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get petitionReviewApproved;

  /// No description provided for @petitionReviewRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get petitionReviewRejected;

  /// No description provided for @petitionAdd.
  ///
  /// In en, this message translates to:
  /// **'Add petition'**
  String get petitionAdd;

  /// No description provided for @petitionEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit petition'**
  String get petitionEdit;

  /// No description provided for @petitionSectionSource.
  ///
  /// In en, this message translates to:
  /// **'Original petition'**
  String get petitionSectionSource;

  /// No description provided for @petitionUrl.
  ///
  /// In en, this message translates to:
  /// **'Petition link'**
  String get petitionUrl;

  /// No description provided for @petitionUrlInvalid.
  ///
  /// In en, this message translates to:
  /// **'Paste the full link, starting with https://'**
  String get petitionUrlInvalid;

  /// No description provided for @petitionTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get petitionTitle;

  /// No description provided for @petitionSource.
  ///
  /// In en, this message translates to:
  /// **'Platform or organization'**
  String get petitionSource;

  /// No description provided for @petitionCountry.
  ///
  /// In en, this message translates to:
  /// **'Country or area'**
  String get petitionCountry;

  /// No description provided for @petitionCountryHelp.
  ///
  /// In en, this message translates to:
  /// **'Leave empty for international campaigns.'**
  String get petitionCountryHelp;

  /// No description provided for @petitionStartedOnPick.
  ///
  /// In en, this message translates to:
  /// **'Petition start date (optional)'**
  String get petitionStartedOnPick;

  /// No description provided for @petitionTopic.
  ///
  /// In en, this message translates to:
  /// **'Topic'**
  String get petitionTopic;

  /// No description provided for @petitionSectionText.
  ///
  /// In en, this message translates to:
  /// **'Our description'**
  String get petitionSectionText;

  /// No description provided for @petitionOwnWordsHelp.
  ///
  /// In en, this message translates to:
  /// **'Write in your own words. Don\'t copy text from the original page.'**
  String get petitionOwnWordsHelp;

  /// No description provided for @petitionSummary.
  ///
  /// In en, this message translates to:
  /// **'Short summary'**
  String get petitionSummary;

  /// No description provided for @petitionImage.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get petitionImage;

  /// No description provided for @petitionImageAdd.
  ///
  /// In en, this message translates to:
  /// **'Add image'**
  String get petitionImageAdd;

  /// No description provided for @petitionImageChange.
  ///
  /// In en, this message translates to:
  /// **'Change image'**
  String get petitionImageChange;

  /// No description provided for @petitionImageHelp.
  ///
  /// In en, this message translates to:
  /// **'Optional. Without an image, the card shows the topic icon.'**
  String get petitionImageHelp;

  /// No description provided for @petitionImagePermission.
  ///
  /// In en, this message translates to:
  /// **'We have permission to use this image'**
  String get petitionImagePermission;

  /// No description provided for @petitionImagePermissionNeeded.
  ///
  /// In en, this message translates to:
  /// **'Confirm you have permission to use the image, or remove it.'**
  String get petitionImagePermissionNeeded;

  /// No description provided for @petitionImageTooBig.
  ///
  /// In en, this message translates to:
  /// **'The image is too large. Choose one under 5 MB.'**
  String get petitionImageTooBig;

  /// No description provided for @petitionChecks.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get petitionChecks;

  /// No description provided for @petitionChecksHelp.
  ///
  /// In en, this message translates to:
  /// **'All four are needed to approve or publish.'**
  String get petitionChecksHelp;

  /// No description provided for @petitionCheckExists.
  ///
  /// In en, this message translates to:
  /// **'The original page exists and opens'**
  String get petitionCheckExists;

  /// No description provided for @petitionCheckGenuine.
  ///
  /// In en, this message translates to:
  /// **'It is about a genuine animal welfare issue'**
  String get petitionCheckGenuine;

  /// No description provided for @petitionCheckGoal.
  ///
  /// In en, this message translates to:
  /// **'It has a clear goal'**
  String get petitionCheckGoal;

  /// No description provided for @petitionCheckHonest.
  ///
  /// In en, this message translates to:
  /// **'No misleading or fraudulent claims'**
  String get petitionCheckHonest;

  /// No description provided for @petitionChecksNeeded.
  ///
  /// In en, this message translates to:
  /// **'Tick all verification checks before approving or publishing.'**
  String get petitionChecksNeeded;

  /// No description provided for @petitionReview.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get petitionReview;

  /// No description provided for @petitionReviewHelp.
  ///
  /// In en, this message translates to:
  /// **'Only published petitions are shown to users.'**
  String get petitionReviewHelp;

  /// No description provided for @petitionRejectReason.
  ///
  /// In en, this message translates to:
  /// **'Reason (only seen by admins)'**
  String get petitionRejectReason;

  /// No description provided for @petitionStatus.
  ///
  /// In en, this message translates to:
  /// **'Petition status'**
  String get petitionStatus;

  /// No description provided for @petitionStatusHelp.
  ///
  /// In en, this message translates to:
  /// **'Update it when the campaign ends or the page is removed.'**
  String get petitionStatusHelp;

  /// No description provided for @petitionFixFields.
  ///
  /// In en, this message translates to:
  /// **'Fill in the fields marked in red.'**
  String get petitionFixFields;

  /// No description provided for @petitionDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this petition?'**
  String get petitionDeleteTitle;

  /// No description provided for @petitionDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'It will be removed from the app for everyone.'**
  String get petitionDeleteBody;

  /// No description provided for @petitionAddedOn.
  ///
  /// In en, this message translates to:
  /// **'Added {date}'**
  String petitionAddedOn(String date);

  /// No description provided for @petitionPublishedOn.
  ///
  /// In en, this message translates to:
  /// **'Published {date}'**
  String petitionPublishedOn(String date);

  /// No description provided for @petitionUpdatedOn.
  ///
  /// In en, this message translates to:
  /// **'Updated {date}'**
  String petitionUpdatedOn(String date);

  /// No description provided for @appUpdates.
  ///
  /// In en, this message translates to:
  /// **'App updates'**
  String get appUpdates;

  /// No description provided for @adminAppUpdatesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Store versions and required updates'**
  String get adminAppUpdatesSubtitle;

  /// No description provided for @appUpdatesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Versions in the stores'**
  String get appUpdatesSubtitle;

  /// No description provided for @appUpdatesIntro.
  ///
  /// In en, this message translates to:
  /// **'Users on an older version see an update message with the What\'s new notes of the latest version. Below the minimum version, the app can\'t be used until it\'s updated. No new build is needed to change these.'**
  String get appUpdatesIntro;

  /// No description provided for @appUpdatesThisPhone.
  ///
  /// In en, this message translates to:
  /// **'This phone has version {version}'**
  String appUpdatesThisPhone(String version);

  /// No description provided for @appUpdatesAndroid.
  ///
  /// In en, this message translates to:
  /// **'Android (Google Play)'**
  String get appUpdatesAndroid;

  /// No description provided for @appUpdatesIos.
  ///
  /// In en, this message translates to:
  /// **'iPhone (App Store)'**
  String get appUpdatesIos;

  /// No description provided for @appUpdatesLatest.
  ///
  /// In en, this message translates to:
  /// **'Latest version in the store'**
  String get appUpdatesLatest;

  /// No description provided for @appUpdatesLatestHelp.
  ///
  /// In en, this message translates to:
  /// **'Set it once the update is live in the store. Leave empty to show no update message.'**
  String get appUpdatesLatestHelp;

  /// No description provided for @appUpdatesMinimum.
  ///
  /// In en, this message translates to:
  /// **'Minimum version'**
  String get appUpdatesMinimum;

  /// No description provided for @appUpdatesMinimumHelp.
  ///
  /// In en, this message translates to:
  /// **'Older versions must update before using the app. Leave empty for none.'**
  String get appUpdatesMinimumHelp;

  /// No description provided for @appUpdatesStoreId.
  ///
  /// In en, this message translates to:
  /// **'App Store ID'**
  String get appUpdatesStoreId;

  /// No description provided for @appUpdatesStoreIdHelp.
  ///
  /// In en, this message translates to:
  /// **'The number in the App Store link (apps.apple.com/app/id…). Needed for the Update button on iPhone.'**
  String get appUpdatesStoreIdHelp;

  /// No description provided for @appUpdatesNotesPublished.
  ///
  /// In en, this message translates to:
  /// **'The notes for {version} are published and shown with the update'**
  String appUpdatesNotesPublished(String version);

  /// No description provided for @appUpdatesNotesDraft.
  ///
  /// In en, this message translates to:
  /// **'The notes for {version} are saved but not published'**
  String appUpdatesNotesDraft(String version);

  /// No description provided for @appUpdatesNotesMissing.
  ///
  /// In en, this message translates to:
  /// **'No What\'s new notes for {version} yet'**
  String appUpdatesNotesMissing(String version);

  /// No description provided for @appUpdatesBadVersion.
  ///
  /// In en, this message translates to:
  /// **'Use a version like 1.2.0'**
  String get appUpdatesBadVersion;

  /// No description provided for @appUpdatesMinimumAbove.
  ///
  /// In en, this message translates to:
  /// **'The minimum can\'t be higher than the latest version'**
  String get appUpdatesMinimumAbove;

  /// No description provided for @appUpdatesBadStoreId.
  ///
  /// In en, this message translates to:
  /// **'The App Store ID has only digits'**
  String get appUpdatesBadStoreId;

  /// No description provided for @appUpdatesRequireTitle.
  ///
  /// In en, this message translates to:
  /// **'Require the update?'**
  String get appUpdatesRequireTitle;

  /// No description provided for @appUpdatesRequireBody.
  ///
  /// In en, this message translates to:
  /// **'Everyone below version {version} will have to update before they can use the app.'**
  String appUpdatesRequireBody(String version);

  /// No description provided for @appUpdatesRequireConfirm.
  ///
  /// In en, this message translates to:
  /// **'Require'**
  String get appUpdatesRequireConfirm;

  /// No description provided for @updateAvailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Update available'**
  String get updateAvailableTitle;

  /// No description provided for @updateAvailableBody.
  ///
  /// In en, this message translates to:
  /// **'Version {latest} of CodaMi is ready. You have {installed}.'**
  String updateAvailableBody(String latest, String installed);

  /// No description provided for @updateNow.
  ///
  /// In en, this message translates to:
  /// **'Update now'**
  String get updateNow;

  /// No description provided for @updateLater.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get updateLater;

  /// No description provided for @updateRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Update required'**
  String get updateRequiredTitle;

  /// No description provided for @updateRequiredBody.
  ///
  /// In en, this message translates to:
  /// **'This version of CodaMi is no longer supported. Update to version {version} to keep using the app.'**
  String updateRequiredBody(String version);

  /// No description provided for @updateBanner.
  ///
  /// In en, this message translates to:
  /// **'Version {version} is available'**
  String updateBanner(String version);

  /// No description provided for @updateStoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the store. Please update CodaMi from the store app.'**
  String get updateStoreFailed;

  /// No description provided for @rateCodaMiSubtitleIos.
  ///
  /// In en, this message translates to:
  /// **'Leave a review on the App Store'**
  String get rateCodaMiSubtitleIos;

  /// No description provided for @updateContinueAsAdmin.
  ///
  /// In en, this message translates to:
  /// **'Continue as admin'**
  String get updateContinueAsAdmin;

  /// No description provided for @navShop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get navShop;

  /// No description provided for @shop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shop;

  /// No description provided for @adminShopSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Products, brands, suppliers and the on/off switch'**
  String get adminShopSubtitle;

  /// No description provided for @shopSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Products for your pets'**
  String get shopSubtitle;

  /// No description provided for @shopSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search products'**
  String get shopSearchHint;

  /// No description provided for @shopEmpty.
  ///
  /// In en, this message translates to:
  /// **'Products are coming soon. Check back later!'**
  String get shopEmpty;

  /// No description provided for @shopNoResults.
  ///
  /// In en, this message translates to:
  /// **'No products match.'**
  String get shopNoResults;

  /// No description provided for @shopInStock.
  ///
  /// In en, this message translates to:
  /// **'In stock'**
  String get shopInStock;

  /// No description provided for @shopLowStock.
  ///
  /// In en, this message translates to:
  /// **'Only a few left'**
  String get shopLowStock;

  /// No description provided for @shopOutOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of stock'**
  String get shopOutOfStock;

  /// No description provided for @shopComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get shopComingSoon;

  /// No description provided for @shopModelOwnStock.
  ///
  /// In en, this message translates to:
  /// **'Our stock'**
  String get shopModelOwnStock;

  /// No description provided for @shopModelBrand.
  ///
  /// In en, this message translates to:
  /// **'Brand partner'**
  String get shopModelBrand;

  /// No description provided for @shopModelDropship.
  ///
  /// In en, this message translates to:
  /// **'Dropshipping'**
  String get shopModelDropship;

  /// No description provided for @shopModelAffiliate.
  ///
  /// In en, this message translates to:
  /// **'Affiliate link'**
  String get shopModelAffiliate;

  /// No description provided for @shopModelOwnStockHelp.
  ///
  /// In en, this message translates to:
  /// **'CodaMi holds the stock and ships it.'**
  String get shopModelOwnStockHelp;

  /// No description provided for @shopModelBrandHelp.
  ///
  /// In en, this message translates to:
  /// **'The brand sells through CodaMi and ships the order.'**
  String get shopModelBrandHelp;

  /// No description provided for @shopModelDropshipHelp.
  ///
  /// In en, this message translates to:
  /// **'A supplier ships the order straight to the customer.'**
  String get shopModelDropshipHelp;

  /// No description provided for @shopModelAffiliateHelp.
  ///
  /// In en, this message translates to:
  /// **'Bought on the partner\'s site through our link; CodaMi earns a commission.'**
  String get shopModelAffiliateHelp;

  /// No description provided for @shopBuyOn.
  ///
  /// In en, this message translates to:
  /// **'Buy on {partner}'**
  String shopBuyOn(String partner);

  /// No description provided for @shopAffiliateNote.
  ///
  /// In en, this message translates to:
  /// **'Sold and shipped by {partner}. CodaMi may earn a commission on this purchase.'**
  String shopAffiliateNote(String partner);

  /// No description provided for @shopPriceOnPartner.
  ///
  /// In en, this message translates to:
  /// **'Price on {partner}'**
  String shopPriceOnPartner(String partner);

  /// No description provided for @shopAddToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get shopAddToCart;

  /// No description provided for @shopCheckoutSoon.
  ///
  /// In en, this message translates to:
  /// **'Buying in the app is coming soon.'**
  String get shopCheckoutSoon;

  /// No description provided for @shopAllAnimals.
  ///
  /// In en, this message translates to:
  /// **'For all animals'**
  String get shopAllAnimals;

  /// No description provided for @shopDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get shopDescription;

  /// No description provided for @shopOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the link.'**
  String get shopOpenFailed;

  /// No description provided for @shopPreviewOff.
  ///
  /// In en, this message translates to:
  /// **'Preview: the shop is off, users can\'t see it.'**
  String get shopPreviewOff;

  /// No description provided for @shopAdminIntro.
  ///
  /// In en, this message translates to:
  /// **'Manage the CodaMi Shop. Users only see it while it\'s on.'**
  String get shopAdminIntro;

  /// No description provided for @shopOpenSwitch.
  ///
  /// In en, this message translates to:
  /// **'Shop open to users'**
  String get shopOpenSwitch;

  /// No description provided for @shopOnHelp.
  ///
  /// In en, this message translates to:
  /// **'On: everyone sees the Shop tab.'**
  String get shopOnHelp;

  /// No description provided for @shopOffHelp.
  ///
  /// In en, this message translates to:
  /// **'Off: users don\'t see the shop. Admins can still prepare it.'**
  String get shopOffHelp;

  /// No description provided for @shopTurnOnTitle.
  ///
  /// In en, this message translates to:
  /// **'Open the shop?'**
  String get shopTurnOnTitle;

  /// No description provided for @shopTurnOnBody.
  ///
  /// In en, this message translates to:
  /// **'Every user will see the Shop tab and the active products straight away.'**
  String get shopTurnOnBody;

  /// No description provided for @shopTurnOffTitle.
  ///
  /// In en, this message translates to:
  /// **'Close the shop?'**
  String get shopTurnOffTitle;

  /// No description provided for @shopTurnOffBody.
  ///
  /// In en, this message translates to:
  /// **'The Shop tab disappears for every user straight away. Products and settings are kept.'**
  String get shopTurnOffBody;

  /// No description provided for @shopTurnOn.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get shopTurnOn;

  /// No description provided for @shopTurnOff.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get shopTurnOff;

  /// No description provided for @shopSalesModels.
  ///
  /// In en, this message translates to:
  /// **'Sales models'**
  String get shopSalesModels;

  /// No description provided for @shopSalesModelsHelp.
  ///
  /// In en, this message translates to:
  /// **'Turning a model off hides all its products from users.'**
  String get shopSalesModelsHelp;

  /// No description provided for @shopCatalog.
  ///
  /// In en, this message translates to:
  /// **'Catalogue'**
  String get shopCatalog;

  /// No description provided for @shopProducts.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get shopProducts;

  /// No description provided for @shopCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get shopCategories;

  /// No description provided for @shopBrands.
  ///
  /// In en, this message translates to:
  /// **'Brands'**
  String get shopBrands;

  /// No description provided for @shopSuppliers.
  ///
  /// In en, this message translates to:
  /// **'Suppliers'**
  String get shopSuppliers;

  /// No description provided for @shopPreview.
  ///
  /// In en, this message translates to:
  /// **'Preview the shop'**
  String get shopPreview;

  /// No description provided for @shopPreviewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'See the shop as users will'**
  String get shopPreviewSubtitle;

  /// No description provided for @shopProductsCount.
  ///
  /// In en, this message translates to:
  /// **'{active} active · {total} in total'**
  String shopProductsCount(int active, int total);

  /// No description provided for @shopAddProduct.
  ///
  /// In en, this message translates to:
  /// **'Add product'**
  String get shopAddProduct;

  /// No description provided for @shopEditProduct.
  ///
  /// In en, this message translates to:
  /// **'Edit product'**
  String get shopEditProduct;

  /// No description provided for @shopProductsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No products yet. Add the first one.'**
  String get shopProductsEmpty;

  /// No description provided for @shopActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get shopActive;

  /// No description provided for @shopHidden.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get shopHidden;

  /// No description provided for @shopNeedCategory.
  ///
  /// In en, this message translates to:
  /// **'Add a category first (Shop → Categories).'**
  String get shopNeedCategory;

  /// No description provided for @shopPhotos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get shopPhotos;

  /// No description provided for @shopPhotosHelp.
  ///
  /// In en, this message translates to:
  /// **'Up to 6 photos. The first one is the cover; hold and drag to reorder.'**
  String get shopPhotosHelp;

  /// No description provided for @shopAddPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add photo'**
  String get shopAddPhoto;

  /// No description provided for @shopImageTooBig.
  ///
  /// In en, this message translates to:
  /// **'Images must be smaller than 5 MB.'**
  String get shopImageTooBig;

  /// No description provided for @shopDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get shopDetails;

  /// No description provided for @shopName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get shopName;

  /// No description provided for @shopCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get shopCategory;

  /// No description provided for @shopPickCategory.
  ///
  /// In en, this message translates to:
  /// **'Choose a category'**
  String get shopPickCategory;

  /// No description provided for @shopAnimals.
  ///
  /// In en, this message translates to:
  /// **'Animals'**
  String get shopAnimals;

  /// No description provided for @shopAnimalsHelp.
  ///
  /// In en, this message translates to:
  /// **'None selected means for every animal. Users see products for their own pets first.'**
  String get shopAnimalsHelp;

  /// No description provided for @shopSalesModel.
  ///
  /// In en, this message translates to:
  /// **'Sales model'**
  String get shopSalesModel;

  /// No description provided for @shopPartnerName.
  ///
  /// In en, this message translates to:
  /// **'Partner shop'**
  String get shopPartnerName;

  /// No description provided for @shopAffiliateUrl.
  ///
  /// In en, this message translates to:
  /// **'Affiliate link'**
  String get shopAffiliateUrl;

  /// No description provided for @shopBrand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get shopBrand;

  /// No description provided for @shopNoBrand.
  ///
  /// In en, this message translates to:
  /// **'No brand'**
  String get shopNoBrand;

  /// No description provided for @shopSupplier.
  ///
  /// In en, this message translates to:
  /// **'Supplier'**
  String get shopSupplier;

  /// No description provided for @shopNoSupplier.
  ///
  /// In en, this message translates to:
  /// **'No supplier'**
  String get shopNoSupplier;

  /// No description provided for @shopPriceSection.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get shopPriceSection;

  /// No description provided for @shopPrice.
  ///
  /// In en, this message translates to:
  /// **'Price (€)'**
  String get shopPrice;

  /// No description provided for @shopPriceAffiliateHelp.
  ///
  /// In en, this message translates to:
  /// **'Optional: prices change on the partner\'s site.'**
  String get shopPriceAffiliateHelp;

  /// No description provided for @shopPriceInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a price, for example 12.90'**
  String get shopPriceInvalid;

  /// No description provided for @shopCompareAt.
  ///
  /// In en, this message translates to:
  /// **'Price before discount (€)'**
  String get shopCompareAt;

  /// No description provided for @shopCompareAtHelp.
  ///
  /// In en, this message translates to:
  /// **'Optional. Shown crossed out next to the price.'**
  String get shopCompareAtHelp;

  /// No description provided for @shopCompareAtInvalid.
  ///
  /// In en, this message translates to:
  /// **'Must be higher than the price.'**
  String get shopCompareAtInvalid;

  /// No description provided for @shopAvailability.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get shopAvailability;

  /// No description provided for @shopVisible.
  ///
  /// In en, this message translates to:
  /// **'Visible to users'**
  String get shopVisible;

  /// No description provided for @shopVisibleHelp.
  ///
  /// In en, this message translates to:
  /// **'Hidden products are only seen by admins.'**
  String get shopVisibleHelp;

  /// No description provided for @shopCategoryVisibleHelp.
  ///
  /// In en, this message translates to:
  /// **'When hidden, the category and all its products are hidden from users.'**
  String get shopCategoryVisibleHelp;

  /// No description provided for @shopBrandVisibleHelp.
  ///
  /// In en, this message translates to:
  /// **'When hidden, all of the brand\'s products are hidden from users.'**
  String get shopBrandVisibleHelp;

  /// No description provided for @shopSupplierActiveHelp.
  ///
  /// In en, this message translates to:
  /// **'When off, all of this supplier\'s products are hidden from users.'**
  String get shopSupplierActiveHelp;

  /// No description provided for @shopDeleteProductTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this product?'**
  String get shopDeleteProductTitle;

  /// No description provided for @shopDeleteProductBody.
  ///
  /// In en, this message translates to:
  /// **'It is removed from the shop with its photos. This can\'t be undone.'**
  String get shopDeleteProductBody;

  /// No description provided for @shopDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete {name}?'**
  String shopDeleteTitle(String name);

  /// No description provided for @shopDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'This can\'t be undone.'**
  String get shopDeleteBody;

  /// No description provided for @shopInUse.
  ///
  /// In en, this message translates to:
  /// **'Still used by products or sub-categories, so it can\'t be deleted. Hide it instead.'**
  String get shopInUse;

  /// No description provided for @shopFixFields.
  ///
  /// In en, this message translates to:
  /// **'Check the fields marked in red.'**
  String get shopFixFields;

  /// No description provided for @shopLinkInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a full link starting with https://'**
  String get shopLinkInvalid;

  /// No description provided for @shopAddCategory.
  ///
  /// In en, this message translates to:
  /// **'Add category'**
  String get shopAddCategory;

  /// No description provided for @shopEditCategory.
  ///
  /// In en, this message translates to:
  /// **'Edit category'**
  String get shopEditCategory;

  /// No description provided for @shopAddStarting.
  ///
  /// In en, this message translates to:
  /// **'Add the starting categories'**
  String get shopAddStarting;

  /// No description provided for @shopStartingHelp.
  ///
  /// In en, this message translates to:
  /// **'Start with food, accessories, care, toys, beds, carriers, tech and other. You can rename, hide or remove them later.'**
  String get shopStartingHelp;

  /// No description provided for @shopParent.
  ///
  /// In en, this message translates to:
  /// **'Inside category'**
  String get shopParent;

  /// No description provided for @shopNoParent.
  ///
  /// In en, this message translates to:
  /// **'None (main category)'**
  String get shopNoParent;

  /// No description provided for @shopIcon.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get shopIcon;

  /// No description provided for @shopOrder.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get shopOrder;

  /// No description provided for @shopOrderHelp.
  ///
  /// In en, this message translates to:
  /// **'Lower numbers come first.'**
  String get shopOrderHelp;

  /// No description provided for @shopCatFood.
  ///
  /// In en, this message translates to:
  /// **'Pet food'**
  String get shopCatFood;

  /// No description provided for @shopCatAccessories.
  ///
  /// In en, this message translates to:
  /// **'Accessories'**
  String get shopCatAccessories;

  /// No description provided for @shopCatCare.
  ///
  /// In en, this message translates to:
  /// **'Pet care'**
  String get shopCatCare;

  /// No description provided for @shopCatToys.
  ///
  /// In en, this message translates to:
  /// **'Toys'**
  String get shopCatToys;

  /// No description provided for @shopCatBeds.
  ///
  /// In en, this message translates to:
  /// **'Beds'**
  String get shopCatBeds;

  /// No description provided for @shopCatCarriers.
  ///
  /// In en, this message translates to:
  /// **'Carriers'**
  String get shopCatCarriers;

  /// No description provided for @shopCatTech.
  ///
  /// In en, this message translates to:
  /// **'Pet tech'**
  String get shopCatTech;

  /// No description provided for @shopCatOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get shopCatOther;

  /// No description provided for @shopAddBrand.
  ///
  /// In en, this message translates to:
  /// **'Add brand'**
  String get shopAddBrand;

  /// No description provided for @shopEditBrand.
  ///
  /// In en, this message translates to:
  /// **'Edit brand'**
  String get shopEditBrand;

  /// No description provided for @shopBrandsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No brands yet. Brands are optional; add them when you have partners.'**
  String get shopBrandsEmpty;

  /// No description provided for @shopWebsite.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get shopWebsite;

  /// No description provided for @shopLogo.
  ///
  /// In en, this message translates to:
  /// **'Logo'**
  String get shopLogo;

  /// No description provided for @shopAddLogo.
  ///
  /// In en, this message translates to:
  /// **'Choose logo'**
  String get shopAddLogo;

  /// No description provided for @shopAddSupplier.
  ///
  /// In en, this message translates to:
  /// **'Add supplier'**
  String get shopAddSupplier;

  /// No description provided for @shopEditSupplier.
  ///
  /// In en, this message translates to:
  /// **'Edit supplier'**
  String get shopEditSupplier;

  /// No description provided for @shopSuppliersEmpty.
  ///
  /// In en, this message translates to:
  /// **'No suppliers yet.'**
  String get shopSuppliersEmpty;

  /// No description provided for @shopSuppliersHelp.
  ///
  /// In en, this message translates to:
  /// **'Only admins see suppliers and their details. Turning a supplier off hides its products.'**
  String get shopSuppliersHelp;

  /// No description provided for @shopContactName.
  ///
  /// In en, this message translates to:
  /// **'Contact person'**
  String get shopContactName;

  /// No description provided for @shopEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get shopEmail;

  /// No description provided for @shopEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get shopEmailInvalid;

  /// No description provided for @shopPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get shopPhone;

  /// No description provided for @shopOrderMethod.
  ///
  /// In en, this message translates to:
  /// **'How orders reach them'**
  String get shopOrderMethod;

  /// No description provided for @shopOrderManual.
  ///
  /// In en, this message translates to:
  /// **'By hand'**
  String get shopOrderManual;

  /// No description provided for @shopOrderManualHelp.
  ///
  /// In en, this message translates to:
  /// **'The team forwards each order to the supplier.'**
  String get shopOrderManualHelp;

  /// No description provided for @shopOrderEmail.
  ///
  /// In en, this message translates to:
  /// **'Automatic email'**
  String get shopOrderEmail;

  /// No description provided for @shopOrderEmailHelp.
  ///
  /// In en, this message translates to:
  /// **'Each paid order is emailed to the supplier (starts with checkout).'**
  String get shopOrderEmailHelp;

  /// No description provided for @shopNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes (admins only)'**
  String get shopNotes;

  /// No description provided for @shopForYourPets.
  ///
  /// In en, this message translates to:
  /// **'For your pets'**
  String get shopForYourPets;

  /// No description provided for @shopOnSale.
  ///
  /// In en, this message translates to:
  /// **'On sale'**
  String get shopOnSale;

  /// No description provided for @shopAllProducts.
  ///
  /// In en, this message translates to:
  /// **'All products'**
  String get shopAllProducts;

  /// No description provided for @shopResults.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get shopResults;

  /// No description provided for @shopProductCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 product} other{{count} products}}'**
  String shopProductCount(int count);

  /// No description provided for @shopYouSave.
  ///
  /// In en, this message translates to:
  /// **'You save {amount}'**
  String shopYouSave(String amount);

  /// No description provided for @shopCart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get shopCart;

  /// No description provided for @shopCartClear.
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get shopCartClear;

  /// No description provided for @shopCartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty. Add products from the shop.'**
  String get shopCartEmpty;

  /// No description provided for @shopCartUnavailable.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 product is no longer available} other{{count} products are no longer available}}'**
  String shopCartUnavailable(int count);

  /// No description provided for @shopCheckout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get shopCheckout;

  /// No description provided for @shopPaymentSoon.
  ///
  /// In en, this message translates to:
  /// **'Payment in the app is coming soon.'**
  String get shopPaymentSoon;

  /// No description provided for @shopViewCart.
  ///
  /// In en, this message translates to:
  /// **'View cart'**
  String get shopViewCart;

  /// No description provided for @shopShipping.
  ///
  /// In en, this message translates to:
  /// **'Shipping'**
  String get shopShipping;

  /// No description provided for @shopShipTo.
  ///
  /// In en, this message translates to:
  /// **'Ship to'**
  String get shopShipTo;

  /// No description provided for @shopShippingNotSet.
  ///
  /// In en, this message translates to:
  /// **'Shipping options will be shown here soon.'**
  String get shopShippingNotSet;

  /// No description provided for @shopFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get shopFree;

  /// No description provided for @shopFreeAbove.
  ///
  /// In en, this message translates to:
  /// **'Free above {amount}'**
  String shopFreeAbove(String amount);

  /// No description provided for @shopFreeShippingGap.
  ///
  /// In en, this message translates to:
  /// **'Add {amount} more for free shipping'**
  String shopFreeShippingGap(String amount);

  /// No description provided for @shopSummary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get shopSummary;

  /// No description provided for @shopSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get shopSubtotal;

  /// No description provided for @shopTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get shopTotal;

  /// No description provided for @shopVatIncluded.
  ///
  /// In en, this message translates to:
  /// **'VAT included'**
  String get shopVatIncluded;

  /// No description provided for @shopSponsored.
  ///
  /// In en, this message translates to:
  /// **'Sponsored'**
  String get shopSponsored;

  /// No description provided for @shopSponsoredSection.
  ///
  /// In en, this message translates to:
  /// **'Sponsored'**
  String get shopSponsoredSection;

  /// No description provided for @shopSponsoredHelp.
  ///
  /// In en, this message translates to:
  /// **'Show first in the shop and its category, with a \"Sponsored\" label.'**
  String get shopSponsoredHelp;

  /// No description provided for @shopSponsorFrom.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get shopSponsorFrom;

  /// No description provided for @shopSponsorUntil.
  ///
  /// In en, this message translates to:
  /// **'Until'**
  String get shopSponsorUntil;

  /// No description provided for @shopSponsorDatesHelp.
  ///
  /// In en, this message translates to:
  /// **'Leave empty to start now and run until switched off.'**
  String get shopSponsorDatesHelp;

  /// No description provided for @shopSponsorDatesInvalid.
  ///
  /// In en, this message translates to:
  /// **'The end date is before the start date.'**
  String get shopSponsorDatesInvalid;

  /// No description provided for @shopNoDate.
  ///
  /// In en, this message translates to:
  /// **'No date'**
  String get shopNoDate;

  /// No description provided for @shopCost.
  ///
  /// In en, this message translates to:
  /// **'Cost price (€, admins only)'**
  String get shopCost;

  /// No description provided for @shopCostHelp.
  ///
  /// In en, this message translates to:
  /// **'What CodaMi pays the supplier or brand. Users never see it.'**
  String get shopCostHelp;

  /// No description provided for @shopMargin.
  ///
  /// In en, this message translates to:
  /// **'Margin: {amount} ({percent}%)'**
  String shopMargin(String amount, int percent);

  /// No description provided for @shopAffiliateClicks.
  ///
  /// In en, this message translates to:
  /// **'Affiliate clicks'**
  String get shopAffiliateClicks;

  /// No description provided for @shopClicksCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 click on \"Buy\"} other{{count} clicks on \"Buy\"}}'**
  String shopClicksCount(int count);

  /// No description provided for @shopLast30Days.
  ///
  /// In en, this message translates to:
  /// **'Last 30 days · tap to refresh'**
  String get shopLast30Days;

  /// No description provided for @shopShippingIntro.
  ///
  /// In en, this message translates to:
  /// **'Where you ship, how and for how much. Prices include VAT. Saved for every user at once.'**
  String get shopShippingIntro;

  /// No description provided for @shopShippingStarting.
  ///
  /// In en, this message translates to:
  /// **'Add the starting setup'**
  String get shopShippingStarting;

  /// No description provided for @shopZones.
  ///
  /// In en, this message translates to:
  /// **'Zones'**
  String get shopZones;

  /// No description provided for @shopZonesHelp.
  ///
  /// In en, this message translates to:
  /// **'Areas you ship to. Switch one off to stop shipping there.'**
  String get shopZonesHelp;

  /// No description provided for @shopZoneName.
  ///
  /// In en, this message translates to:
  /// **'Zone name'**
  String get shopZoneName;

  /// No description provided for @shopAddZone.
  ///
  /// In en, this message translates to:
  /// **'Add zone'**
  String get shopAddZone;

  /// No description provided for @shopZoneItaly.
  ///
  /// In en, this message translates to:
  /// **'Italy'**
  String get shopZoneItaly;

  /// No description provided for @shopZoneIslands.
  ///
  /// In en, this message translates to:
  /// **'Sicily and Sardinia'**
  String get shopZoneIslands;

  /// No description provided for @shopZoneEurope.
  ///
  /// In en, this message translates to:
  /// **'European Union'**
  String get shopZoneEurope;

  /// No description provided for @shopMethod.
  ///
  /// In en, this message translates to:
  /// **'Shipping method'**
  String get shopMethod;

  /// No description provided for @shopAddMethod.
  ///
  /// In en, this message translates to:
  /// **'Add shipping method'**
  String get shopAddMethod;

  /// No description provided for @shopMethodActive.
  ///
  /// In en, this message translates to:
  /// **'Offered to users'**
  String get shopMethodActive;

  /// No description provided for @shopMethodStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get shopMethodStandard;

  /// No description provided for @shopMethodExpress.
  ///
  /// In en, this message translates to:
  /// **'Express'**
  String get shopMethodExpress;

  /// No description provided for @shopMethodStandardTime.
  ///
  /// In en, this message translates to:
  /// **'3–5 working days'**
  String get shopMethodStandardTime;

  /// No description provided for @shopMethodExpressTime.
  ///
  /// In en, this message translates to:
  /// **'1–2 working days'**
  String get shopMethodExpressTime;

  /// No description provided for @shopDeliveryTime.
  ///
  /// In en, this message translates to:
  /// **'Delivery time shown to users'**
  String get shopDeliveryTime;

  /// No description provided for @shopPricePerZone.
  ///
  /// In en, this message translates to:
  /// **'Price per zone'**
  String get shopPricePerZone;

  /// No description provided for @shopPricePerZoneHelp.
  ///
  /// In en, this message translates to:
  /// **'Leave empty where this method isn\'t offered. 0 means free.'**
  String get shopPricePerZoneHelp;

  /// No description provided for @shopFreeAboveLabel.
  ///
  /// In en, this message translates to:
  /// **'Free shipping above (€)'**
  String get shopFreeAboveLabel;

  /// No description provided for @shopFreeAboveHelp.
  ///
  /// In en, this message translates to:
  /// **'Optional. Leave empty to always charge shipping.'**
  String get shopFreeAboveHelp;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'it',
    'pt',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
