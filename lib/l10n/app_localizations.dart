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
