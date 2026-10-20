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
