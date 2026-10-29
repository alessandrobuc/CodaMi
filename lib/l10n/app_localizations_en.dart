// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

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
  String get chooseLanguage => 'Choose your language';

  @override
  String get language => 'Language';

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

  @override
  String get onboarding1Title => 'Every pet deserves\na ';

  @override
  String get onboarding1Highlight => 'way home';

  @override
  String get onboarding1Body =>
      'CodaMi connects neighbours so lost dogs and cats find their way back to the people who love them.';

  @override
  String get onboarding2Title => 'Report a pet\nin ';

  @override
  String get onboarding2Highlight => 'seconds';

  @override
  String get onboarding2Body =>
      'Snap a photo, drop the location and publish a lost or found report. Everyone nearby sees it instantly.';

  @override
  String get onboarding3Title => 'See who\'s\n';

  @override
  String get onboarding3Highlight => 'nearby';

  @override
  String get onboarding3Body =>
      'Lost and found pets around you, live on one map, so you always know where to look.';

  @override
  String get skip => 'Skip';

  @override
  String get getStarted => 'Get Started';

  @override
  String get lost => 'Lost';

  @override
  String get found => 'Found';

  @override
  String get you => 'You';

  @override
  String get published => 'Published';

  @override
  String get onboardingSampleBreed => 'Golden Retriever · 3 yrs';

  @override
  String get onboardingSamplePlace => 'Milano · 2h ago';

  @override
  String get validationNameRequired => 'Please enter your name';

  @override
  String get validationNameTooShort => 'Name must be at least 2 characters';

  @override
  String get validationNameTooLong => 'Name must be under 50 characters';

  @override
  String get validationNameInvalid =>
      'Name can only contain letters, spaces, hyphens and apostrophes';

  @override
  String get validationEmailRequired => 'Please enter your email';

  @override
  String get validationEmailInvalid => 'Please enter a valid email address';

  @override
  String get validationPasswordRequired => 'Please enter your password';

  @override
  String get validationPasswordTooShort =>
      'Password must be at least 8 characters long';

  @override
  String get validationConfirmRequired => 'Please confirm your password';

  @override
  String get validationPasswordsDontMatch => 'Passwords do not match';

  @override
  String get spamNote =>
      'Can\'t find the reset email? Check your Spam or Junk folder, it sometimes lands there.';

  @override
  String get logIn => 'Log In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get authResetSentTitle => 'Check your inbox';

  @override
  String get authResetSentSubtitle =>
      'We\'ve sent you a link to reset your password.';

  @override
  String get authLoginTitle => 'Welcome back!';

  @override
  String get authLoginSubtitle =>
      'Log in to keep helping pets find their way home.';

  @override
  String get authSignupTitle => 'Join the pack';

  @override
  String get authSignupSubtitle =>
      'Create an account and help your neighbourhood.';

  @override
  String get authForgotTitle => 'Forgot password?';

  @override
  String get authForgotSubtitle => 'No worries, we\'ll email you a reset link.';

  @override
  String get fullName => 'Full Name';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get createAccount => 'Create Account';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get or => 'or';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String get resetLinkSentTo => 'We sent a reset link to';

  @override
  String get backToLogIn => 'Back to Log In';

  @override
  String get sendAgain => 'Didn\'t get it? Send again';

  @override
  String get errorOffline =>
      'You\'re offline. Check your connection and try again.';

  @override
  String get errorSessionExpired =>
      'Your session expired. Please sign in again.';

  @override
  String get deleteAccountFailed =>
      'Couldn\'t delete your account. Please try again.';

  @override
  String get authErrorGeneric => 'Something went wrong. Please try again.';

  @override
  String get authErrorDisabled => 'This account has been disabled.';

  @override
  String get authErrorWrongCredentials => 'Wrong email or password.';

  @override
  String get authErrorEmailInUse =>
      'An account with this email already exists. Try logging in.';

  @override
  String get authErrorTooManyRequests =>
      'Too many attempts. Please wait a moment and try again.';

  @override
  String get citySearchFailed => 'City search failed. Please try again.';

  @override
  String get placeSearchFailed => 'Place search failed. Please try again.';

  @override
  String get placeOutsideCity =>
      'That place is outside your city. Please pick one in your city.';

  @override
  String get placeNotFound =>
      'We couldn\'t find that place. Please pick another one.';

  @override
  String get citySearchOffline =>
      'Couldn\'t reach city search. Check your connection and try again.';

  @override
  String get searchCityHint => 'Search your city, e.g. Milano';

  @override
  String noCitiesFound(String query) {
    return 'No cities found for \"$query\".';
  }

  @override
  String homeCityUpdated(String city) {
    return 'Home city updated to $city.';
  }

  @override
  String get saveCityFailed => 'Couldn\'t save your city. Please try again.';

  @override
  String get citySetupTitle => 'Where are ';

  @override
  String get citySetupHighlight => 'you?';

  @override
  String get cityEditTitle => 'Change your ';

  @override
  String get cityEditHighlight => 'city';

  @override
  String get citySetupBody =>
      'Pick your city so we can show lost & found pets near you and let you know when a pet goes missing in your area.';

  @override
  String get saveCity => 'Save city';

  @override
  String get continueLabel => 'Continue';

  @override
  String get notYouSignOut => 'Not you? Sign out';

  @override
  String greeting(String name) {
    return 'Hi, $name!';
  }

  @override
  String get showPetsWithin => 'Show pets within';

  @override
  String distanceFrom(String city) {
    return 'Distance from $city';
  }

  @override
  String get everywhere => 'Everywhere';

  @override
  String distanceKm(int km) {
    return '$km km';
  }

  @override
  String withinKm(int km) {
    return 'within $km km';
  }

  @override
  String get areaNotSet => 'Area not set yet';

  @override
  String get reportPetSemantics => 'Report a lost or found pet';

  @override
  String get map => 'Map';

  @override
  String get locationServicesOff =>
      'Turn on location services to use your location.';

  @override
  String get locationPermissionDenied =>
      'Allow location access in Settings to use your location.';

  @override
  String get locationFailed => 'Couldn\'t get your location. Please try again.';

  @override
  String get back => 'Back';

  @override
  String get fullScreen => 'Full screen';

  @override
  String get loadingPets => 'Loading pets…';

  @override
  String get mapLoadFailed => 'Couldn\'t load reports. Check your connection.';

  @override
  String get mapNoLost => 'No lost pets in this area';

  @override
  String get mapNoFound => 'No found pets in this area';

  @override
  String get mapNoPets => 'No lost or found pets in this area';

  @override
  String get zoomIn => 'Zoom in';

  @override
  String get zoomOut => 'Zoom out';

  @override
  String get myLocation => 'My location';

  @override
  String get myCity => 'My city';

  @override
  String get all => 'All';

  @override
  String get timeJustNow => 'Just now';

  @override
  String timeMinutesAgo(int minutes) {
    return '$minutes min ago';
  }

  @override
  String timeHoursAgo(int hours) {
    return '$hours h ago';
  }

  @override
  String get timeYesterday => 'Yesterday';

  @override
  String timeDaysAgo(int days) {
    return '$days days ago';
  }

  @override
  String notifLostTitle(String city) {
    return 'Lost pet in $city';
  }

  @override
  String notifLostBodyNear(String pet, String street, String city) {
    return '$pet was last seen near $street, $city. Keep an eye out!';
  }

  @override
  String notifLostBodyIn(String pet, String city) {
    return '$pet was last seen in $city. Keep an eye out!';
  }

  @override
  String notifFoundTitle(String city) {
    return 'Pet found in $city';
  }

  @override
  String notifFoundBodyNear(String pet, String street, String city) {
    return '$pet was found near $street, $city. Do you know the owner?';
  }

  @override
  String notifFoundBodyIn(String pet, String city) {
    return '$pet was found in $city. Do you know the owner?';
  }

  @override
  String notifBackHomeTitle(String pet) {
    return '$pet is back home';
  }

  @override
  String notifBackHomeBody(String pet, String city) {
    return 'Good news from $city: $pet has been found. Thank you for helping!';
  }

  @override
  String notifReunitedTitle(String pet) {
    return '$pet is reunited';
  }

  @override
  String notifReunitedBody(String city) {
    return 'The pet found in $city is back with its family.';
  }

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get markAllRead => 'Mark all read';

  @override
  String get notificationsLoadError => 'Couldn\'t load notifications';

  @override
  String get allCaughtUp => 'You\'re all caught up';

  @override
  String get notificationsEmpty =>
      'We\'ll let you know when a pet is lost or found in your city.';

  @override
  String get notificationsNew => 'New';

  @override
  String get notificationsEarlier => 'Earlier';

  @override
  String get reportNotAvailable => 'Report not available';

  @override
  String get reportRemoved => 'This report was removed by its owner.';

  @override
  String get reportsLoadError => 'Couldn\'t load reports';

  @override
  String get pullToRetry => 'Check your connection and pull down to try again.';

  @override
  String get noLostNearby => 'No lost pets nearby';

  @override
  String get noLostNearbyMessage =>
      'Good news! Nobody has reported a lost pet in your area yet.';

  @override
  String get noFoundYet => 'No found pets yet';

  @override
  String get noFoundYetMessage =>
      'Pets found by your neighbours will show up here.';

  @override
  String get backHomeSection => 'Back home';

  @override
  String get backHomeSectionSubtitle =>
      'Pets that found their way back to their families.';

  @override
  String get loadMore => 'Load more';

  @override
  String get speciesDog => 'Dog';

  @override
  String get speciesCat => 'Cat';

  @override
  String get speciesOther => 'Other';

  @override
  String get sexMale => 'Male';

  @override
  String get sexFemale => 'Female';

  @override
  String get sexUnknown => 'Unknown';

  @override
  String nearPlace(String street, String city) {
    return 'Near $street, $city';
  }

  @override
  String get callFailed => 'Couldn\'t start a call.';

  @override
  String get whatsappFailed => 'Couldn\'t open WhatsApp.';

  @override
  String get emailFailed => 'Couldn\'t open your email app.';

  @override
  String whatsappMessageLost(String pet) {
    return 'Hi! I\'m contacting you about the lost pet \"$pet\" on CodaMi.';
  }

  @override
  String whatsappMessageFound(String pet) {
    return 'Hi! I\'m contacting you about the found pet \"$pet\" on CodaMi.';
  }

  @override
  String emailSubjectLost(String pet) {
    return 'About $pet (lost pet on CodaMi)';
  }

  @override
  String emailSubjectFound(String pet) {
    return 'About $pet (found pet on CodaMi)';
  }

  @override
  String shareTitleLost(String pet) {
    return 'LOST PET: $pet';
  }

  @override
  String shareTitleFound(String pet) {
    return 'FOUND PET: $pet';
  }

  @override
  String get shareFooter => 'Seen this pet? Open CodaMi to get in touch.';

  @override
  String get lastSeen => 'Last seen';

  @override
  String get foundAt => 'Found at';

  @override
  String areaAbout(int meters) {
    return 'area of about $meters m';
  }

  @override
  String get when => 'When';

  @override
  String get postedBy => 'Posted by';

  @override
  String get description => 'Description';

  @override
  String get call => 'Call';

  @override
  String contactTitleLost(String pet) {
    return 'Seen $pet? Get in touch';
  }

  @override
  String get contactTitleFound => 'Is this your pet? Get in touch';

  @override
  String get noContactShared => 'No contact details were shared.';

  @override
  String resolvedThanksLost(String pet) {
    return '$pet is back home. Thank you for using CodaMi!';
  }

  @override
  String get resolvedThanksFound =>
      'This pet is back with its family. Thank you for helping!';

  @override
  String get yourContactDetails => 'Your contact details';

  @override
  String markPetAsFound(String pet) {
    return 'Mark $pet as found';
  }

  @override
  String get markReturnedToOwner => 'Mark as returned to owner';

  @override
  String get copiedToClipboard => 'Copied to clipboard.';

  @override
  String get petSaveFailed => 'Couldn\'t save your pet. Please try again.';

  @override
  String get petDeleteFailed => 'Couldn\'t delete your pet. Please try again.';

  @override
  String get errorPermission => 'You don\'t have permission to do that.';

  @override
  String get storageNotReady =>
      'Photo storage isn\'t set up yet. Please try again later.';

  @override
  String get storageFull =>
      'Storage is full right now. Please try again later.';

  @override
  String petAdded(String name) {
    return '$name was added to your pets.';
  }

  @override
  String get petsLoadError => 'Couldn\'t load your pets';

  @override
  String get noPetsYet => 'No pets yet';

  @override
  String get noPetsYetMessage =>
      'Add your pets now so you can report them in seconds if they ever get lost.';

  @override
  String get addFirstPet => 'Add your first pet';

  @override
  String get petsHeaderEmpty =>
      'Keep your pets\' profiles ready, just in case.';

  @override
  String petsHeaderCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count furry friends, ready if anything happens.',
      one: '1 furry friend, ready if anything happens.',
    );
    return '$_temp0';
  }

  @override
  String get addPet => 'Add pet';

  @override
  String petUpdated(String name) {
    return '$name was updated.';
  }

  @override
  String removePetTitle(String name) {
    return 'Remove $name?';
  }

  @override
  String get removePetMessage =>
      'This deletes the profile and its photos. It can\'t be undone.';

  @override
  String get remove => 'Remove';

  @override
  String petRemoved(String name) {
    return '$name was removed.';
  }

  @override
  String get breed => 'Breed';

  @override
  String get color => 'Color';

  @override
  String get age => 'Age';

  @override
  String get sex => 'Sex';

  @override
  String petAddedOn(String date) {
    return 'Added $date';
  }

  @override
  String get distinctiveFeatures => 'Distinctive features';

  @override
  String ifPetGoesMissing(String name) {
    return 'If $name ever goes missing';
  }

  @override
  String get ifPetGoesMissingBody =>
      'Publish a lost report with this profile in seconds, and neighbours nearby will be alerted.';

  @override
  String reportPetAsLost(String name) {
    return 'Report $name as lost';
  }

  @override
  String get colorBlack => 'Black';

  @override
  String get colorWhite => 'White';

  @override
  String get colorBrown => 'Brown';

  @override
  String get colorGolden => 'Golden';

  @override
  String get colorGrey => 'Grey';

  @override
  String get colorCream => 'Cream';

  @override
  String get colorGinger => 'Ginger';

  @override
  String get petPhotoRequired => 'Add at least one photo of your pet.';

  @override
  String get petSpeciesRequired =>
      'Choose whether your pet is a dog, cat or other.';

  @override
  String get checkHighlightedFields => 'Please check the highlighted fields.';

  @override
  String get signInToSave => 'Please sign in again to save.';

  @override
  String get discardChangesTitle => 'Discard changes?';

  @override
  String get discardPetChanges => 'Your changes to this pet will be lost.';

  @override
  String get keepEditing => 'Keep editing';

  @override
  String get discard => 'Discard';

  @override
  String editPetTitle(String name) {
    return 'Edit $name';
  }

  @override
  String get newPet => 'New pet';

  @override
  String get whatKindOfPet => 'What kind of pet?';

  @override
  String get name => 'Name';

  @override
  String get petNameHint => 'e.g. Luna';

  @override
  String get petNameRequired => 'Please enter your pet\'s name';

  @override
  String get petNameTooLong => 'Name must be under 40 characters';

  @override
  String get breedHint => 'e.g. Golden Retriever, Mixed';

  @override
  String get colorHint => 'e.g. Golden with white chest';

  @override
  String get ageHint => 'e.g. 3 years, 8 months';

  @override
  String get featuresHint =>
      'Collar, microchip, scars, spots… anything that helps someone recognise your pet.';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get savePet => 'Save pet';

  @override
  String get cameraPermission => 'Please allow camera access in Settings.';

  @override
  String get photosPermission => 'Please allow photo access in Settings.';

  @override
  String get cameraFailed => 'Couldn\'t open the camera.';

  @override
  String get galleryFailed => 'Couldn\'t open the gallery.';

  @override
  String get optional => 'Optional';

  @override
  String get addPetPhotos => 'Add photos of your pet';

  @override
  String get addPetPhotosHint =>
      'Clear, recent photos help people recognise them';

  @override
  String get photoRequired => 'At least one photo is required';

  @override
  String get tapToMakeCover => 'Tap a photo to make it the cover.';

  @override
  String get cover => 'Cover';

  @override
  String uploadingPhotos(int percent) {
    return 'Uploading photos… $percent%';
  }

  @override
  String get saving => 'Saving…';

  @override
  String get takePhoto => 'Take a photo';

  @override
  String get useCamera => 'Use your camera';

  @override
  String get chooseFromGallery => 'Choose from gallery';

  @override
  String get pickExistingPhoto => 'Pick an existing photo';

  @override
  String get yourPet => 'your pet';

  @override
  String get unknownDog => 'Unknown dog';

  @override
  String get unknownCat => 'Unknown cat';

  @override
  String get unknownPet => 'Unknown pet';

  @override
  String get errorChooseType => 'Choose whether you lost or found a pet.';

  @override
  String get errorPickPet => 'Pick the pet that is missing.';

  @override
  String get errorFoundPhoto => 'Add at least one photo of the pet.';

  @override
  String get errorFoundSpecies => 'Is it a dog, a cat or other?';

  @override
  String get errorChooseCity => 'Choose the city where it happened.';

  @override
  String get errorFutureDate => 'The date can\'t be in the future.';

  @override
  String get errorDescriptionShort =>
      'Add a short description (at least 10 characters).';

  @override
  String get errorContactRequired =>
      'Add a phone number or email so people can reach you.';

  @override
  String get errorPhoneInvalid => 'Please enter a valid phone number.';

  @override
  String get discardReportTitle => 'Discard this report?';

  @override
  String get discardReportMessage =>
      'What you\'ve entered so far will be lost.';

  @override
  String get signInToPublish => 'Please sign in again to publish.';

  @override
  String publishedLost(String pet) {
    return '$pet is now on the map. We hope they\'re home soon.';
  }

  @override
  String publishedFound(String pet) {
    return 'Thank you! $pet is now on the map.';
  }

  @override
  String get reportLostPetTitle => 'Report a lost pet';

  @override
  String get reportFoundPetTitle => 'Report a found pet';

  @override
  String get newReport => 'New report';

  @override
  String stepOf(int current, int total) {
    return '$current of $total';
  }

  @override
  String get publishReport => 'Publish report';

  @override
  String get stepTypeTitle => 'What happened?';

  @override
  String get stepTypeSubtitle =>
      'Let\'s get the word out to people nearby, fast.';

  @override
  String get stepFoundPetTitle => 'Tell us about the pet';

  @override
  String get stepFoundPetSubtitle =>
      'A clear photo is the fastest way for the owner to recognise them.';

  @override
  String get addFoundPhotos => 'Add photos of the pet';

  @override
  String get addFoundPhotosHint => 'Take one now, or pick from your gallery';

  @override
  String get whatKindOfAnimal => 'What kind of animal?';

  @override
  String get collarName => 'Name on collar or tag';

  @override
  String get collarNameHint => 'Leave empty if you don\'t know';

  @override
  String get stepLostPetTitle => 'Which pet is missing?';

  @override
  String get stepLostPetSubtitle =>
      'We\'ll use their profile and photos so you don\'t have to retype anything.';

  @override
  String get stepWhereFoundTitle => 'Where did you find it?';

  @override
  String stepWhereLostTitle(String pet) {
    return 'Where was $pet last seen?';
  }

  @override
  String get stepWhereSubtitle =>
      'Choose the city, then pin the spot on the map. People only see an area of about 100 m, never the exact address.';

  @override
  String get streetOrLandmark => 'Street or landmark';

  @override
  String get pinExactSpot => 'Pin the exact spot';

  @override
  String spotHintFound(String pet) {
    return 'Drag the map so the pin sits where $pet was found.';
  }

  @override
  String spotHintLost(String pet) {
    return 'Drag the map so the pin sits where $pet was last seen.';
  }

  @override
  String spotFarFromCity(int km, String city) {
    return 'This spot is $km km from $city. Is the city right?';
  }

  @override
  String spotPinned(int meters) {
    return 'Pinned. People only see an area of about $meters m around it, never the exact spot.';
  }

  @override
  String get timeHourAgo => '1 hour ago';

  @override
  String get timeThisMorning => 'This morning';

  @override
  String get stepWhenFoundTitle => 'When did you find it?';

  @override
  String stepWhenLostTitle(String pet) {
    return 'When did you last see $pet?';
  }

  @override
  String get stepWhenSubtitle => 'An approximate time is fine.';

  @override
  String get changeDate => 'Change date';

  @override
  String get changeTime => 'Change time';

  @override
  String get stepDetailsTitle => 'Anything else we should know?';

  @override
  String get stepDetailsSubtitle =>
      'Details help neighbours recognise the pet and reach you quickly.';

  @override
  String descriptionHintLost(String pet) {
    return 'Collar colour, behaviour, how $pet went missing…';
  }

  @override
  String get descriptionHintFound =>
      'Condition, collar, behaviour, where exactly you found it…';

  @override
  String get howToReachYou => 'How can people reach you?';

  @override
  String get contactPrivacyNote =>
      'Shown only on the report page, never in lists.';

  @override
  String get phoneHint => 'Phone, e.g. +39 333 123 4567';

  @override
  String get reachableOnWhatsapp => 'Reachable on WhatsApp';

  @override
  String get reachableOnWhatsappHint => 'People can message you on this number';

  @override
  String get stepReviewTitle => 'Ready to publish?';

  @override
  String get stepReviewSubtitle =>
      'This is how your report will look to people nearby.';

  @override
  String get iLostMyPet => 'I lost my pet';

  @override
  String get iFoundAPet => 'I found a pet';

  @override
  String get iLostMyPetHint => 'Alert people nearby and get help searching.';

  @override
  String get iFoundAPetHint => 'Help a lost pet find its way back home.';

  @override
  String get addAPet => 'Add a pet';

  @override
  String get pleaseChooseCity => 'Please choose a city';

  @override
  String noPlacesFound(String city, String query) {
    return 'No places found in $city for \"$query\".';
  }

  @override
  String searchStreetHint(String city) {
    return 'Search in $city, e.g. Via Dante';
  }

  @override
  String get yourCity => 'your city';

  @override
  String get useMyLocation => 'Use my location';

  @override
  String get publishFailed =>
      'Couldn\'t publish your report. Please try again.';

  @override
  String get updateReportFailed =>
      'Couldn\'t update the report. Please try again.';

  @override
  String get deleteReportFailed =>
      'Couldn\'t delete the report. Please try again.';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfUse => 'Terms of Use';

  @override
  String legalLastUpdated(String date) {
    return 'Last updated: $date';
  }

  @override
  String get deleteAccountPasswordPrompt => 'Enter your password to confirm.';

  @override
  String deleteAccountTypeConfirm(String word) {
    return 'Type $word to confirm.';
  }

  @override
  String get wrongPassword => 'Wrong password. Please try again.';

  @override
  String get confirmPasswordAgain =>
      'For your security, please confirm your password again.';

  @override
  String get contactUs => 'Contact us';

  @override
  String get legalQuestions => 'Questions about this document or your data?';

  @override
  String get languageChangeLater =>
      'You can change it anytime in your profile.';

  @override
  String get reward => 'Reward';

  @override
  String get rewardHint => 'Amount in euros';

  @override
  String get rewardNote =>
      'The reward is a private arrangement between the owner and the finder. CodaMi does not guarantee or process any payment.';

  @override
  String rewardAmount(String amount) {
    return 'Reward $amount';
  }

  @override
  String get adminPanel => 'Admin panel';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleSupport => 'Support';

  @override
  String get supportStaff => 'Support staff';

  @override
  String get supportStaffSubtitle => 'People who answer support requests';

  @override
  String get adminUsers => 'Users';

  @override
  String get adminListings => 'Listings';

  @override
  String get adminReportedContent => 'Reported content';

  @override
  String get adminTickets => 'Support tickets';

  @override
  String get adminVideos => 'Videos';

  @override
  String get addSupportStaff => 'Add support staff';

  @override
  String get addSupportStaffHint =>
      'Enter the email of an existing CodaMi account.';

  @override
  String get userNotFound => 'No CodaMi account uses this email.';

  @override
  String get alreadyStaff => 'This person is already on the team.';

  @override
  String staffAdded(String name) {
    return '$name is now on the support team.';
  }

  @override
  String removeStaffTitle(String name) {
    return 'Remove $name?';
  }

  @override
  String get removeStaffMessage =>
      'They will no longer have access to the admin panel.';

  @override
  String get noSupportStaff => 'No support staff yet.';

  @override
  String get add => 'Add';

  @override
  String get actionFailed => 'Something went wrong. Please try again.';

  @override
  String get adminDashboard => 'Dashboard';

  @override
  String get adminMore => 'More';

  @override
  String get adminReportedShort => 'Reported';

  @override
  String get adminTicketsShort => 'Tickets';

  @override
  String get adminSectionSoon => 'This section is coming soon.';

  @override
  String get statUsers => 'Registered users';

  @override
  String get statOpenLost => 'Open lost reports';

  @override
  String get statOpenFound => 'Open found reports';

  @override
  String get statBackHome => 'Pets back home';

  @override
  String get flagListing => 'Report listing';

  @override
  String get flagTitle => 'Why are you reporting this listing?';

  @override
  String get flagHint =>
      'Our team will review it. The owner won\'t know who reported it.';

  @override
  String get flagReasonSpam => 'Spam or advertising';

  @override
  String get flagReasonScam => 'Scam or fraud';

  @override
  String get flagReasonInappropriate => 'Inappropriate content';

  @override
  String get flagReasonWrongInfo => 'False or misleading information';

  @override
  String get flagReasonOther => 'Something else';

  @override
  String get flagNoteHint => 'Add details (optional)';

  @override
  String get flagSubmit => 'Send report';

  @override
  String get flagSent => 'Thanks. Our team will review this listing.';

  @override
  String get alreadyFlagged => 'You have already reported this listing.';

  @override
  String blockUser(String name) {
    return 'Block $name';
  }

  @override
  String blockUserTitle(String name) {
    return 'Block $name?';
  }

  @override
  String get blockUserMessage =>
      'You won\'t see their listings or get alerts about them. You can unblock them in Profile → Blocked users.';

  @override
  String get block => 'Block';

  @override
  String userBlocked(String name) {
    return '$name is blocked.';
  }

  @override
  String get blockedUsers => 'Blocked users';

  @override
  String get noBlockedUsers => 'You haven\'t blocked anyone.';

  @override
  String get unblock => 'Unblock';

  @override
  String userUnblocked(String name) {
    return '$name is unblocked.';
  }

  @override
  String get unknownUser => 'Unknown user';

  @override
  String get hiddenListing => 'Hidden';

  @override
  String get hiddenListingNotice =>
      'This listing was hidden by the CodaMi team and is no longer public.';

  @override
  String get moderation => 'Moderation';

  @override
  String get noFlagsOnListing => 'No one has reported this listing.';

  @override
  String flagCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Reported $count times',
      one: 'Reported once',
    );
    return '$_temp0';
  }

  @override
  String get dismissFlags => 'Dismiss reports';

  @override
  String get flagsDismissed => 'Reports dismissed.';

  @override
  String get hideListing => 'Hide listing';

  @override
  String get restoreListing => 'Restore listing';

  @override
  String get listingHidden =>
      'Listing hidden. Only the owner can still see it.';

  @override
  String get listingRestored => 'Listing restored.';

  @override
  String get deleteListing => 'Delete listing';

  @override
  String get deleteListingTitle => 'Delete this listing?';

  @override
  String get deleteListingMessage =>
      'The listing and its photos are deleted for everyone. This can\'t be undone.';

  @override
  String get listingDeleted => 'Listing deleted.';

  @override
  String get listingUnavailable => 'Listing no longer available';

  @override
  String get noReportedContent => 'Nothing reported';

  @override
  String get noReportedContentMessage =>
      'Listings reported by users will appear here.';

  @override
  String get filterOpen => 'Open';

  @override
  String get filterResolved => 'Resolved';

  @override
  String get filterHidden => 'Hidden';

  @override
  String get noListings => 'No listings here';

  @override
  String get tryAnotherFilter => 'Try another filter.';

  @override
  String get adminUsersSubtitle => 'View, disable or delete accounts';

  @override
  String get searchByEmail => 'Search by email';

  @override
  String get noUsersFound => 'No users found.';

  @override
  String get roleUser => 'User';

  @override
  String get userDisabled => 'Disabled';

  @override
  String get phone => 'Phone';

  @override
  String get memberSince => 'Member since';

  @override
  String get disableAccount => 'Disable account';

  @override
  String get enableAccount => 'Enable account';

  @override
  String disableUserTitle(String name) {
    return 'Disable $name\'s account?';
  }

  @override
  String get disableUserMessage =>
      'They will be signed out and can\'t log in. Their open listings are hidden until the account is enabled again.';

  @override
  String get accountDisabled => 'Account disabled.';

  @override
  String get accountEnabled => 'Account enabled.';

  @override
  String deleteUserTitle(String name) {
    return 'Delete $name\'s account?';
  }

  @override
  String get deleteUserMessage =>
      'This permanently deletes their profile, pets, listings and photos. It can\'t be undone.';

  @override
  String get userDeleted => 'Account deleted.';

  @override
  String get save => 'Save';

  @override
  String get requiredField => 'Required';

  @override
  String get notificationSettingsIntro =>
      'Choose which alerts you get and give each one its own sound, so you know what happened before you look.';

  @override
  String get notificationSound => 'Sound';

  @override
  String get alertLostTitle => 'Lost pets nearby';

  @override
  String get alertLostDescription => 'When a pet goes missing in your city';

  @override
  String get alertFoundTitle => 'Found pets nearby';

  @override
  String get alertFoundDescription => 'When someone finds a pet in your city';

  @override
  String get alertResolvedTitle => 'Happy endings';

  @override
  String get alertResolvedDescription =>
      'When a lost or found pet is back home';

  @override
  String get soundDefault => 'Phone default';

  @override
  String get soundSilent => 'Silent';

  @override
  String get soundChime => 'Chime';

  @override
  String get soundBell => 'Bell';

  @override
  String get soundBright => 'Bright';

  @override
  String get soundSoft => 'Soft';

  @override
  String get soundCustom => 'Custom sound';

  @override
  String get soundFromPhone => 'Ringtones and tones on your phone';

  @override
  String get soundFromFile => 'Music or audio file';

  @override
  String get soundIosNote =>
      'On iPhone, notification sounds have to come from the app, so choose one of the sounds above.';

  @override
  String get soundPickFailed =>
      'Couldn\'t use that sound. Please try another one.';

  @override
  String get videosForYou => 'Videos for you';

  @override
  String get videosForYourPets => 'Picked for your pets';

  @override
  String get videosGeneral => 'Animal welfare and responsible pet care';

  @override
  String get videosShuffle => 'Show other videos';

  @override
  String get videoMotivational => 'Motivation';

  @override
  String get videoEducational => 'Learn';

  @override
  String get videoTagGeneral => 'Everyone';

  @override
  String get videoLoadError =>
      'This video can\'t be played right now. Please try again later.';

  @override
  String get adminVideosSubtitle => 'Upload and manage videos';

  @override
  String get addVideo => 'Add video';

  @override
  String get editVideo => 'Edit video';

  @override
  String get noVideosYet =>
      'No videos yet. Add the first one with the button below.';

  @override
  String get deleteVideoTitle => 'Delete this video?';

  @override
  String get deleteVideoMessage =>
      'It will be removed from the app for everyone. This can\'t be undone.';

  @override
  String get videoHidden => 'Hidden';

  @override
  String get allLanguages => 'All languages';

  @override
  String get chooseVideo => 'Choose a video';

  @override
  String get chooseVideoHint =>
      'From your gallery, up to 200 MB. Short videos (under 2 minutes) work best.';

  @override
  String get videoTitle => 'Title';

  @override
  String get videoType => 'Type';

  @override
  String get videoAnimals => 'Animals';

  @override
  String get videoAnimalsHint =>
      'Pick the animals this video is about. Choose \"Everyone\" for general videos shown to all users.';

  @override
  String get videoVisible => 'Visible in the app';

  @override
  String get videoVisibleHint => 'Hidden videos are only seen by admins.';

  @override
  String get videoTooLarge =>
      'This video is larger than 200 MB. Please choose a shorter one.';

  @override
  String get videoSaved => 'Video saved.';

  @override
  String uploadingProgress(int percent) {
    return 'Uploading… $percent%';
  }

  @override
  String get navVideos => 'Videos';

  @override
  String get videosEmptyTitle => 'Videos are on the way';

  @override
  String get videosEmptyMessage =>
      'Soon you\'ll find short videos here about caring for your animals.';

  @override
  String get moreVideos => 'More videos';

  @override
  String get videoWatched => 'Watched';

  @override
  String get videoBack10 => 'Back 10 seconds';

  @override
  String get videoForward10 => 'Forward 10 seconds';

  @override
  String get videoFullscreen => 'Full screen';

  @override
  String get videoExitFullscreen => 'Exit full screen';

  @override
  String get videoRetry => 'Try again';

  @override
  String get videoDeleted => 'Video deleted.';

  @override
  String get noVideosYetTitle => 'No videos yet';

  @override
  String get videoVisibleShort => 'Visible';

  @override
  String get play => 'Play';

  @override
  String get edit => 'Edit';

  @override
  String get change => 'Change';

  @override
  String get videoSectionFile => 'Video';

  @override
  String get videoSectionDetails => 'Details';

  @override
  String get videoSectionAudience => 'Who sees it';

  @override
  String get videoCover => 'Cover image';

  @override
  String get videoCoverHint => 'Optional. Shown on the video card.';

  @override
  String get videoMotivationalHint => 'Inspiring stories and happy moments';

  @override
  String get videoEducationalHint => 'Tips and how-tos for owners';

  @override
  String get uploadVideo => 'Upload video';

  @override
  String get helpSupport => 'Help & support';

  @override
  String get helpSupportSubtitle => 'Chat with us or send a request';

  @override
  String get supportIntroTitle => 'How can we help?';

  @override
  String get supportIntroMessage =>
      'Our team answers here in the app. You\'ll get a notification when we reply.';

  @override
  String get supportStartChat => 'Start a live chat';

  @override
  String get supportStartChatOnline => 'An operator is online now';

  @override
  String get supportChatOffline =>
      'No operator is online right now. Send a request and we\'ll reply as soon as possible.';

  @override
  String get supportSendRequest => 'Send a request';

  @override
  String get supportSendRequestSubtitle => 'We usually reply within 24 hours';

  @override
  String get supportMyRequests => 'My requests';

  @override
  String get supportNoRequests => 'No requests yet';

  @override
  String get supportNoRequestsMessage =>
      'Your conversations with support will appear here.';

  @override
  String get supportNewChat => 'New live chat';

  @override
  String get supportNewRequest => 'New request';

  @override
  String get supportCategory => 'Topic';

  @override
  String get categoryAccount => 'Account and login';

  @override
  String get categoryListing => 'A lost or found listing';

  @override
  String get categoryApp => 'Problem with the app';

  @override
  String get categoryOther => 'Something else';

  @override
  String get supportSubject => 'Subject';

  @override
  String get supportSubjectHint => 'In a few words';

  @override
  String get supportSubjectTooShort => 'Please write at least 3 characters';

  @override
  String get supportMessage => 'Message';

  @override
  String get supportMessageHint => 'Tell us what happened';

  @override
  String get supportMessageRequired => 'Please write a message';

  @override
  String get supportSend => 'Send';

  @override
  String get supportTooManyOpen =>
      'You already have 3 open requests. Please continue in one of them.';

  @override
  String get supportTypeMessage => 'Write a message…';

  @override
  String get supportTeam => 'CodaMi support';

  @override
  String get supportMarkSolved => 'Mark as solved';

  @override
  String get supportMarkSolvedConfirm =>
      'Mark this request as solved? You can write again if you still need help.';

  @override
  String get supportClosedNote =>
      'This request is closed. Start a new one if you need more help.';

  @override
  String get supportResolvedNote =>
      'Marked as solved. Writing again reopens it.';

  @override
  String get supportWaitingNote => 'Thanks! Our team will reply here soon.';

  @override
  String get kindChat => 'Live chat';

  @override
  String get kindTicket => 'Request';

  @override
  String get caseStatusOpen => 'Open';

  @override
  String get caseStatusInProgress => 'In progress';

  @override
  String get caseStatusWaitingUser => 'Waiting for response';

  @override
  String get caseStatusResolved => 'Resolved';

  @override
  String get caseStatusClosed => 'Closed';

  @override
  String get filterUnanswered => 'Unanswered';

  @override
  String get filterUnassigned => 'Unassigned';

  @override
  String get filterMine => 'Mine';

  @override
  String get filterActive => 'Active';

  @override
  String get filterDone => 'Finished';

  @override
  String get supportSearchHint => 'Search CM-1042 or email';

  @override
  String get supportNoCases => 'No requests here';

  @override
  String get supportNoCasesMessage => 'Nothing is waiting in this list.';

  @override
  String get supportTake => 'Take this case';

  @override
  String get supportTakeToReply => 'Take this case to reply.';

  @override
  String get supportAlreadyTaken => 'Another operator already took this case.';

  @override
  String get supportUnassigned => 'Not assigned';

  @override
  String get supportReassign => 'Reassign';

  @override
  String get supportAssignTo => 'Assign to';

  @override
  String get supportBackToQueue => 'Back to the queue';

  @override
  String get supportChangeStatus => 'Change status';

  @override
  String get supportChat => 'Chat';

  @override
  String get supportTimeline => 'Timeline';

  @override
  String get supportDetails => 'Details';

  @override
  String supportWaitingFor(String time) {
    return 'Waiting $time';
  }

  @override
  String get supportOverdue => 'Late reply';

  @override
  String get supportOpened => 'Opened';

  @override
  String get supportTakenOver => 'Taken over';

  @override
  String get supportWaitToTake => 'Wait before takeover';

  @override
  String get supportFirstReply => 'First reply';

  @override
  String get supportAvgReply => 'Average reply time';

  @override
  String get supportHandlingTime => 'Time spent';

  @override
  String get supportResolvedAt => 'Resolved';

  @override
  String get supportMessagesCount => 'Messages';

  @override
  String get supportOperator => 'Operator';

  @override
  String get supportUserLabel => 'User';

  @override
  String eventCreated(String name) {
    return 'Opened by $name';
  }

  @override
  String eventTaken(String name) {
    return 'Taken by $name';
  }

  @override
  String eventReassigned(String from, String to) {
    return 'Reassigned from $from to $to';
  }

  @override
  String eventStatus(String name, String status) {
    return '$name set the status to $status';
  }

  @override
  String get eventReopened => 'Reopened by the user';

  @override
  String get eventOverdue => 'No reply within the time limit';

  @override
  String get eventAutoClosed => 'Closed automatically';

  @override
  String get presenceOnline => 'Online';

  @override
  String get presenceAway => 'Away';

  @override
  String get presenceOffline => 'Offline';

  @override
  String get presenceAvailable => 'Available for live chat';

  @override
  String get presenceAvailableSubtitle =>
      'Users can start a live chat while an operator is online';

  @override
  String get supportOperators => 'Operators';

  @override
  String get supportOperatorsSubtitle => 'Activity, cases and reply times';

  @override
  String get operatorOpenCases => 'Open cases';

  @override
  String get operatorTaken => 'Taken';

  @override
  String get operatorResolved => 'Resolved';

  @override
  String get operatorReplies => 'Replies';

  @override
  String get operatorAvgHandling => 'Average time per case';

  @override
  String operatorLastActive(String time) {
    return 'Last active $time';
  }

  @override
  String get operatorCases => 'Cases';

  @override
  String get noOperators => 'No support staff yet. Add them in Support staff.';

  @override
  String get statUnassigned => 'Unassigned requests';

  @override
  String get statUnanswered => 'Unanswered requests';

  @override
  String get statOverdue => 'Late replies';

  @override
  String get alertSupportTitle => 'Support replies';

  @override
  String get alertSupportDescription => 'When CodaMi support writes to you';

  @override
  String durationSeconds(int n) {
    return '$n s';
  }

  @override
  String durationMinutes(int n) {
    return '$n min';
  }

  @override
  String durationHours(int h, int m) {
    return '$h h $m min';
  }

  @override
  String durationDays(int d, int h) {
    return '$d d $h h';
  }

  @override
  String get searchUsersHint => 'Search by name or email';

  @override
  String get searchTooShort => 'Type at least 2 characters';

  @override
  String get pickStaffTitle => 'Choose a user';

  @override
  String get pickStaffHint => 'Tap a person to add them to the support team.';

  @override
  String makeStaffTitle(String name) {
    return 'Make $name support staff?';
  }

  @override
  String get makeStaffMessage =>
      'They will see the admin side and can answer tickets and live chats. You can remove them at any time.';

  @override
  String get makeStaff => 'Add to team';

  @override
  String get supportStaffSwitch => 'Support staff';

  @override
  String get supportStaffSwitchSubtitle => 'Can answer tickets and live chats';

  @override
  String staffRemoved(String name) {
    return '$name is no longer on the support team.';
  }

  @override
  String get removeStaffCasesNote => 'Their open cases go back to the queue.';

  @override
  String get pushOpen => 'Open';

  @override
  String get chatToday => 'Today';

  @override
  String get chatLoadEarlier => 'Load earlier messages';

  @override
  String get supportPeople => 'People';

  @override
  String get supportTimes => 'Times';

  @override
  String get supportRequestInfo => 'Request';

  @override
  String get supportType => 'Type';

  @override
  String get supportResolve => 'Mark as resolved';

  @override
  String ticketsWaiting(int count) {
    return '$count waiting for a reply';
  }

  @override
  String get ticketsAllClear => 'All caught up';

  @override
  String get photoReviewHint =>
      'Photos the AI held back. They stay hidden until you decide.';

  @override
  String get reasonAdult => 'Nudity or sexual content';

  @override
  String get reasonRacy => 'Suggestive content';

  @override
  String get reasonViolence => 'Violence or blood';

  @override
  String get likelihoodPossible => 'Possible';

  @override
  String get likelihoodLikely => 'Likely';

  @override
  String get likelihoodVeryLikely => 'Very likely';

  @override
  String get hiddenByAi => 'Hidden by AI';

  @override
  String get petPhoto => 'Pet photo';

  @override
  String get listingPhoto => 'Listing photo';

  @override
  String uploadedBy(String name) {
    return 'By $name';
  }

  @override
  String get tapToView => 'Tap to view';

  @override
  String get approvePhoto => 'Approve';

  @override
  String get removePhotoTitle => 'Remove this photo?';

  @override
  String get removePhotoMessage =>
      'It will be removed from the user\'s pet or listing, and the user will be told why.';

  @override
  String get photoApproved => 'Photo approved';

  @override
  String get photoRemovedDone => 'Photo removed';

  @override
  String get photoUnderReview =>
      'A photo is being checked by our team and is hidden until then.';

  @override
  String get reportedTabPhotos => 'AI photos';

  @override
  String get reportedTabReports => 'User reports';

  @override
  String get noPhotosToReview => 'No photos to review';

  @override
  String get noPhotosToReviewMessage =>
      'Photos the AI holds back will appear here.';

  @override
  String get aFriend => 'A friend';

  @override
  String get addContact => 'Add contact';

  @override
  String get addTestContacts => 'Add test contacts';

  @override
  String get adjustPoints => 'Adjust points';

  @override
  String get adjustPointsAmount => 'Points to add or remove';

  @override
  String get adjustPointsAmountHelp =>
      'Use a minus sign to remove points, e.g. -20';

  @override
  String get adjustPointsInvalid => 'Enter a number of points and a reason.';

  @override
  String get adjustPointsReason => 'Reason (shown to the user)';

  @override
  String get adminContactsSubtitle =>
      'Vets, associations and services shown to users';

  @override
  String get adminEmergenciesSubtitle => 'Reported animal emergencies';

  @override
  String get alertEmergencyDescription =>
      'Animals that need urgent help near your city';

  @override
  String get alertEmergencyTitle => 'Emergencies nearby';

  @override
  String get allContacts => 'All';

  @override
  String get ambassadorLevels => 'Ambassador levels';

  @override
  String get call112 => 'Call 112';

  @override
  String get claim => 'Claim';

  @override
  String get claimed => 'Claimed';

  @override
  String get codeCopied => 'Code copied';

  @override
  String get confirm => 'Confirm';

  @override
  String get contactActive => 'Shown to users';

  @override
  String get contactActiveHelp =>
      'Turn off to hide this contact without deleting it.';

  @override
  String get contactAddress => 'Address';

  @override
  String get contactAreaKm => 'Area covered (km)';

  @override
  String get contactAreaKmHelp =>
      'How far from its address it can help. Leave empty to use the default from the emergency settings.';

  @override
  String get contactCity => 'Town or city';

  @override
  String get contactHandles => 'Emergencies it handles';

  @override
  String get contactHandlesHelp => 'Leave all off if it handles every kind.';

  @override
  String get contactHoursHint => 'Opening hours, e.g. Mon–Fri 9:00–18:00';

  @override
  String get contactInactive => 'Hidden';

  @override
  String get contactKindAssociation => 'Animal welfare association';

  @override
  String get contactKindOther => 'Other service';

  @override
  String get contactKindPublicService => 'Public veterinary service';

  @override
  String get contactKindVet => 'Vet';

  @override
  String get contactMissingFields => 'Add a name and place the pin on the map.';

  @override
  String get contactName => 'Name';

  @override
  String get contactNameHint => 'e.g. Clinica Veterinaria San Francesco';

  @override
  String get contactPhones => 'Phone numbers';

  @override
  String get contactPhonesHint => 'Separate numbers with commas';

  @override
  String get contactPlace => 'Where it is';

  @override
  String get contactRecommendedHelp =>
      'Shown before nearer contacts when an emergency is reported.';

  @override
  String get contactTestHelp =>
      'Placeholder for testing. Shown with a TEST label, never verified or emailed.';

  @override
  String get contactType => 'Type';

  @override
  String get contactVerifiedHelp =>
      'Only after the organization agreed to be listed and the details were checked.';

  @override
  String get copyCode => 'Copy';

  @override
  String get dailyActive => 'Active today';

  @override
  String get dailyCheckin => 'Daily check-in';

  @override
  String get dailyRewards => 'Daily rewards';

  @override
  String get deleteContactTitle => 'Delete this contact?';

  @override
  String get directions => 'Directions';

  @override
  String get editContact => 'Edit contact';

  @override
  String get emergencies => 'Emergencies';

  @override
  String get emergenciesActive => 'Active';

  @override
  String get emergenciesAll => 'All';

  @override
  String get emergenciesNearYou => 'Near you';

  @override
  String get emergenciesSubtitle => 'Animals that need urgent help';

  @override
  String get emergencyAddPhotos => 'Add a photo';

  @override
  String get emergencyAddPhotosHint =>
      'Helps others find and recognise the animal';

  @override
  String get emergencyAllContacts => 'See all emergency contacts';

  @override
  String get emergencyAlreadyReported => 'You already reported this.';

  @override
  String get emergencyCallReporter => 'Call the person who reported it';

  @override
  String get emergencyClose => 'Close';

  @override
  String get emergencyCloseTitle => 'Close this emergency?';

  @override
  String get emergencyContacts => 'Emergency contacts';

  @override
  String get emergencyDetails => 'What\'s happening?';

  @override
  String get emergencyDetailsHint =>
      'e.g. Dog hit by a car, lying by the road, still breathing';

  @override
  String get emergencyDetailsRequired =>
      'Describe the situation in a few words.';

  @override
  String get emergencyDisclaimer =>
      'CodaMi is not an emergency service. If an animal is in immediate danger, call 112 or a vet first. Don\'t rely only on app notifications.';

  @override
  String get emergencyFalseAlarmTitle => 'Mark as a false alarm?';

  @override
  String get emergencyFindingContacts => 'Finding contacts near this place…';

  @override
  String get emergencyHelpDone =>
      'Thank you! The person who reported it was told.';

  @override
  String get emergencyHelpMessage =>
      'The person who reported it will know someone is coming. Only go if it\'s safe for you.';

  @override
  String get emergencyHelpTitle => 'Are you going to help?';

  @override
  String get emergencyImHelping => 'I\'m going to help';

  @override
  String get emergencyMarkFalseAlarm => 'Mark as false alarm';

  @override
  String get emergencyMarkResolved => 'Mark as resolved';

  @override
  String get emergencyMissingFields =>
      'Choose what happened and the animal, describe it and place the pin.';

  @override
  String get emergencyNoContacts =>
      'No contacts listed for this area yet. Call 112 or a vet.';

  @override
  String get emergencyPhoneHint =>
      'Shown to people who want to help, so they can call you.';

  @override
  String get emergencyPinHint =>
      'Move the map to put the pin where the animal is.';

  @override
  String get emergencyPinned => 'Pin placed';

  @override
  String get emergencyReopen => 'Reopen';

  @override
  String get emergencyReportFalse => 'Report as false';

  @override
  String get emergencyReportFalseDone => 'Thanks, our team will check it.';

  @override
  String get emergencyReportFalseMessage =>
      'Our team will check this emergency.';

  @override
  String get emergencyReportFalseTitle => 'Is this emergency false?';

  @override
  String get emergencyResolveTitle => 'Mark as resolved?';

  @override
  String get emergencyResolved => 'Marked as resolved';

  @override
  String get emergencySend => 'Send emergency';

  @override
  String get emergencySendFailed =>
      'Couldn\'t send the emergency. Check your connection and try again, or call 112.';

  @override
  String get emergencySending => 'Sending…';

  @override
  String get emergencySent =>
      'Emergency sent. People nearby are being alerted. You can also call the contacts below directly.';

  @override
  String get emergencySettings => 'Emergency settings';

  @override
  String get emergencySettingsSubtitle =>
      'Alert distances and how contacts are ranked';

  @override
  String get emergencyStatusClosed => 'Closed';

  @override
  String get emergencyStatusFalseAlarm => 'False alarm';

  @override
  String get emergencyStatusHelping => 'Help on the way';

  @override
  String get emergencyStatusOpen => 'Needs help';

  @override
  String get emergencyStatusResolved => 'Resolved';

  @override
  String get emergencySuggestedContacts => 'Who can help';

  @override
  String get emergencySuggestedContactsHint =>
      'Nearest suitable contacts first. Call them directly.';

  @override
  String get emergencyTypeAbandoned => 'Abandoned animal';

  @override
  String get emergencyTypeDanger => 'Animal in danger';

  @override
  String get emergencyTypeInjured => 'Injured animal';

  @override
  String get emergencyTypeIntervention => 'Request for intervention';

  @override
  String get emergencyTypeOther => 'Other emergency';

  @override
  String get emergencyTypeUrgentFound => 'Found, needs urgent care';

  @override
  String get emergencyUnavailable => 'This emergency is no longer available.';

  @override
  String get emergencyWhatHappened => 'What happened?';

  @override
  String get emergencyWhere => 'Where is the animal?';

  @override
  String get emergencyWhereHint =>
      'The exact place is shared so helpers can find the animal.';

  @override
  String get emergencyYouAreHelping =>
      'You said you\'re going to help. Thank you!';

  @override
  String get emergencyYourPhone => 'Your phone';

  @override
  String get flagBurst =>
      'Many friends of this user became active on the same day';

  @override
  String get flagDeviceUsed => 'This phone was already used for another invite';

  @override
  String get flagSameDevice => 'Same phone as the person who invited them';

  @override
  String get haveInviteCode => 'Did a friend invite you? Enter their code';

  @override
  String get invitePromptTitle => 'Did a friend invite you?';

  @override
  String get invitePromptBody =>
      'Enter their invite code so your friend gets the credit for bringing you to CodaMi.';

  @override
  String invitePromptLater(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'You can also add it later in Profile → Invite friends, within $days days of signing up.',
      one: 'You can also add it later today in Profile → Invite friends.',
    );
    return '$_temp0';
  }

  @override
  String get inviteCodeLabel => 'Invite code';

  @override
  String get inviteCodeFromLink =>
      'Filled in from your invite link. Tap Use to confirm.';

  @override
  String get inviteCodeFormat =>
      'Invite codes have 6 letters and numbers, like ABC234.';

  @override
  String get inviteCodeNotFound =>
      'We couldn\'t find this code. Check it with your friend.';

  @override
  String get inviteCodeOwn =>
      'That\'s your own code. Share it with your friends instead.';

  @override
  String inviteCodeTooLate(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'Invite codes can only be added in the first $days days after signing up.',
      one: 'Invite codes can only be added on the day you sign up.',
    );
    return '$_temp0';
  }

  @override
  String get inviteCodeTooManyTries =>
      'Too many wrong codes today. Try again tomorrow.';

  @override
  String get howInvitesWork => 'How it works';

  @override
  String get inviteApproved => 'Invite approved';

  @override
  String get inviteCodeAlreadyUsed => 'You already used an invite code.';

  @override
  String get inviteCodeInvalid => 'This code isn\'t valid.';

  @override
  String get inviteCodeNotAllowed =>
      'This code can\'t be used: it\'s your own code, or it\'s too long since you signed up.';

  @override
  String get inviteFriends => 'Invite friends';

  @override
  String get inviteFriendsSubtitle => 'Become a CodaMi ambassador';

  @override
  String get inviteIntro =>
      'Every new CodaMi user is one more pair of eyes for lost pets. Invite your friends and become a CodaMi ambassador.';

  @override
  String get inviteRejected => 'Invite rejected';

  @override
  String get inviteStatusExpired => 'Didn\'t become active in time';

  @override
  String get inviteStatusPending => 'Joined, not active yet';

  @override
  String get inviteStatusQualified => 'Active – points earned';

  @override
  String get inviteStatusRejected => 'Not counted';

  @override
  String get inviteStatusReview => 'Being checked';

  @override
  String get inviteStep1 =>
      'Share your code. Your friend enters it in Profile → Invite friends after signing up.';

  @override
  String get invitedFriends => 'Invited friends (active)';

  @override
  String get invitesToReview => 'Invites to review';

  @override
  String get invitesToReviewSubtitle => 'Invites held by the anti-fraud checks';

  @override
  String get levelAmbassador => 'Ambassador';

  @override
  String get levelBonus => 'Bonus points';

  @override
  String get settingsActiveFriends => 'Active friends';

  @override
  String get levelChampion => 'CodaMi Champion';

  @override
  String get levelSuperAmbassador => 'Super Ambassador';

  @override
  String get levelSupporter => 'Supporter';

  @override
  String get myEmergencies => 'Mine';

  @override
  String get myPoints => 'My points';

  @override
  String get noActiveEmergencies => 'No emergencies';

  @override
  String get noEmergenciesMessage =>
      'Emergencies reported near your city appear here.';

  @override
  String get noEmergenciesNearby => 'No emergencies near you';

  @override
  String get noEmergencyContacts => 'No contacts yet';

  @override
  String get noEmergencyContactsAdmin =>
      'Add vets, associations and services, or add test contacts to try the feature.';

  @override
  String get noEmergencyContactsMessage =>
      'Contacts will be added soon. In an emergency, call 112 or a vet.';

  @override
  String get noInvitesToReview => 'Nothing to review';

  @override
  String get noInvitesToReviewMessage =>
      'Invites that look suspicious appear here. Nothing is rejected without you.';

  @override
  String get noInvitesYet => 'No invites yet. Share your code to start.';

  @override
  String get noLevelYet => 'No level yet';

  @override
  String get noMyEmergencies => 'You haven\'t reported any emergencies';

  @override
  String get noPointsYet => 'No points yet. Claim your daily reward to start.';

  @override
  String get open24h => 'Open 24 hours';

  @override
  String get openMapFailed => 'Couldn\'t open the map.';

  @override
  String get photos => 'Photos';

  @override
  String get pointsAdjusted => 'Adjusted by CodaMi';

  @override
  String get pointsDailyActive => 'Active today';

  @override
  String get pointsDailyCheckin => 'Daily check-in';

  @override
  String get pointsFriendJoined => 'A friend became active';

  @override
  String get pointsHistory => 'History';

  @override
  String get pointsLevelBonus => 'New level bonus';

  @override
  String get pointsOther => 'Points';

  @override
  String get pointsSettings => 'Points and rewards';

  @override
  String get pointsSettingsIntro =>
      'Changes apply straight away. Values out of range are replaced by the defaults.';

  @override
  String get pointsSettingsSubtitle => 'Daily rewards, invites and levels';

  @override
  String get pointsStreakBonus => 'Streak bonus';

  @override
  String get pointsWelcome => 'Welcome bonus';

  @override
  String get recommendedContact => 'Recommended';

  @override
  String get reject => 'Reject';

  @override
  String get reportEmergency => 'Report an emergency';

  @override
  String get searchContacts => 'Search by name or town';

  @override
  String get settingsActiveMinutes => 'Minutes of use for “Active today”';

  @override
  String get settingsAlertsNearby => 'Alerts to people nearby';

  @override
  String get settingsAutoCloseHours => 'Close after (hours without updates)';

  @override
  String get settingsAutoCloseHoursHelp =>
      'Open emergencies close by themselves after this time.';

  @override
  String get settingsCodeEntryDays => 'Days after sign-up to enter a code';

  @override
  String get settingsContactsPriority => 'Contact priority';

  @override
  String get settingsDefaultAreaKm => 'Default area covered (km)';

  @override
  String get settingsDefaultAreaKmHelp =>
      'Used for contacts without their own area.';

  @override
  String get settingsEmailContacts => 'Email alerts to contacts';

  @override
  String get settingsEmailContactsHelp =>
      'Sends an email to verified contacts. The email service must be set up first.';

  @override
  String get settingsMaxPerDay => 'Active friends per day before a check';

  @override
  String get settingsMaxPerDayHelp =>
      'More than this in 24 hours sends the invite to review.';

  @override
  String get settingsMaxRecipients => 'Maximum people alerted';

  @override
  String get settingsMaxSuggested => 'Contacts suggested';

  @override
  String get settingsMinRecipients => 'People to reach';

  @override
  String get settingsMinRecipientsHelp =>
      'The next circle is used until this many people are reached.';

  @override
  String get settingsQualifyDays => 'Active days needed';

  @override
  String get settingsQualifyWithinDays => 'Within (days after sign-up)';

  @override
  String get settingsReferralPoints => 'Points for each active friend';

  @override
  String get settingsRings => 'Alert circles (km)';

  @override
  String get settingsRingsHelp =>
      'Comma separated, smallest first, e.g. 5, 10, 25';

  @override
  String get settingsSaved => 'Saved';

  @override
  String get settingsStreakDays => 'Days for a streak bonus';

  @override
  String get settingsWeight24h => 'Bonus for open 24 hours';

  @override
  String get settingsWeightHelp =>
      'Contacts get these bonuses and lose points for each km of distance. The highest score comes first.';

  @override
  String get settingsWeightPerKm => 'Penalty per km';

  @override
  String get settingsWeightPerKmHelp =>
      'With 1, a recommended contact (20) comes before one up to 20 km nearer.';

  @override
  String get settingsWeightRecommended => 'Bonus for recommended';

  @override
  String get settingsWeightVerified => 'Bonus for verified';

  @override
  String get settingsWelcomePoints => 'Points for the invited friend';

  @override
  String get settingsWelcomePointsHelp =>
      'Given when they enter a code. 0 turns it off.';

  @override
  String get shareInvite => 'Share';

  @override
  String get statActiveEmergencies => 'Active emergencies';

  @override
  String get testContactBadge => 'TEST – not a real contact';

  @override
  String get topLevelReached => 'You reached the top level. Thank you!';

  @override
  String get useCode => 'Use';

  @override
  String get verifiedContact => 'Verified';

  @override
  String get viewInvitee => 'Invited user';

  @override
  String get viewInviter => 'Inviter';

  @override
  String get yourInviteCode => 'Your invite code';

  @override
  String get yourInvites => 'Your invites';

  @override
  String get zeroTurnsOff => '0 turns it off';

  @override
  String activeProgress(int done, int total) {
    return '$done of $total minutes today';
  }

  @override
  String claimedPoints(int points) {
    return '+$points points!';
  }

  @override
  String claimedWithBonus(int points, int bonus) {
    return '+$points points and a +$bonus streak bonus!';
  }

  @override
  String emergenciesNearYouCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count animal emergencies near you',
      one: '1 animal emergency near you',
    );
    return '$_temp0';
  }

  @override
  String emergencyAlertedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count people nearby were alerted',
      one: '1 person nearby was alerted',
      zero: 'Nobody nearby has alerts on yet',
    );
    return '$_temp0';
  }

  @override
  String emergencyFalseReports(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Reported as false $count times',
      one: 'Reported as false once',
    );
    return '$_temp0';
  }

  @override
  String emergencyHelpersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count people are going to help',
      one: '1 person is going to help',
    );
    return '$_temp0';
  }

  @override
  String inviteCodeAccepted(String name) {
    return 'Code accepted. $name invited you – welcome to CodaMi!';
  }

  @override
  String inviteShareText(String code, String link) {
    return 'I use CodaMi to help lost pets get back home. Join me with my invite code $code: $link';
  }

  @override
  String inviteStep2(int days, int within) {
    return 'They set their city and use the app on $days different days within $within days of signing up.';
  }

  @override
  String inviteStep3(int points) {
    return 'You get $points points and move up the ambassador levels.';
  }

  @override
  String kmAway(String km) {
    return '$km km away';
  }

  @override
  String levelFriends(String level) {
    return '$level: active friends';
  }

  @override
  String levelRule(String level, int friends, int bonus) {
    return '$level · $friends+ friends · +$bonus';
  }

  @override
  String nextLevelHint(int count, String level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count more active friends to become $level',
      one: '1 more active friend to become $level',
    );
    return '$_temp0';
  }

  @override
  String plusPoints(int points) {
    return '+$points points';
  }

  @override
  String pointsTotal(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points points',
      one: '1 point',
    );
    return '$_temp0';
  }

  @override
  String streakLine(int streak, int days, int bonus) {
    return '$streak-day streak · +$bonus bonus every $days days';
  }

  @override
  String get pointsFeedback => 'Feedback sent';

  @override
  String get whatsNew => 'What\'s new';

  @override
  String get whatsNewSubtitle => 'Changes in each version';

  @override
  String get whatsNewTitle => 'What\'s new in CodaMi';

  @override
  String get whatsNewIntro => 'Here\'s what changed in the latest update.';

  @override
  String whatsNewVersion(String version) {
    return 'Version $version';
  }

  @override
  String get whatsNewSectionNew => 'New';

  @override
  String get whatsNewSectionImproved => 'Improved';

  @override
  String get whatsNewSectionFixed => 'Fixed';

  @override
  String get whatsNewEmpty => 'No update notes yet.';

  @override
  String get whatsNewDone => 'Got it';

  @override
  String get feedbackTitle => 'How do you like CodaMi?';

  @override
  String get feedbackBody =>
      'Your feedback goes straight to the CodaMi team and helps us make the app better.';

  @override
  String feedbackPointsOffer(int points) {
    return '+$points points for your first feedback';
  }

  @override
  String get feedbackStarsHint => 'Tap a star to rate';

  @override
  String get feedbackCommentHint =>
      'What do you like, or what could be better? (optional)';

  @override
  String get feedbackSend => 'Send feedback';

  @override
  String get feedbackLater => 'Not now';

  @override
  String get feedbackThanks => 'Thanks for your feedback!';

  @override
  String feedbackThanksPoints(int points) {
    return 'Thanks for your feedback! +$points points';
  }

  @override
  String get feedbackAlreadyToday =>
      'You already sent feedback today. You can send more tomorrow.';

  @override
  String get sendFeedbackSubtitle => 'Tell the team what you think';

  @override
  String get rateCodaMi => 'Rate CodaMi';

  @override
  String get rateCodaMiSubtitle => 'Leave a review on Google Play';

  @override
  String get adminFeedback => 'Feedback';

  @override
  String get adminFeedbackSubtitle => 'What users think of the app';

  @override
  String get adminFeedbackEmpty => 'No feedback yet.';

  @override
  String feedbackRatingsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ratings',
      one: '1 rating',
    );
    return '$_temp0';
  }

  @override
  String get feedbackNoComment => 'No comment';

  @override
  String get adminWhatsNewSubtitle => 'Notes shown to users after each update';

  @override
  String get releaseAdd => 'Add version';

  @override
  String get releaseEdit => 'Edit notes';

  @override
  String get releaseVersion => 'Version number';

  @override
  String get releaseVersionHelp =>
      'Like 1.1.0. It must match the version name of the app in the store.';

  @override
  String get releaseVersionInvalid => 'Use numbers and dots, like 1.1.0.';

  @override
  String get releaseVersionExists => 'This version already has notes.';

  @override
  String get releasePublishedHelp => 'Users only see published notes.';

  @override
  String get releaseDraft => 'Draft';

  @override
  String get releaseLinesHelp => 'One change per line.';

  @override
  String get releaseLanguageHelp =>
      'Languages left empty show the English notes.';

  @override
  String get releaseEnglishRequired =>
      'Write the English notes first: other languages fall back to them.';

  @override
  String get releaseDeleteTitle => 'Delete these notes?';

  @override
  String releaseDeleteBody(String version) {
    return 'The notes for version $version will be removed for everyone.';
  }

  @override
  String get releaseNone =>
      'No versions yet. Add the notes for your next update.';

  @override
  String releaseThisApp(String version) {
    return 'This app: version $version';
  }

  @override
  String get feedbackAndReviews => 'Feedback and reviews';

  @override
  String get settingsFeedbackPoints => 'Points for the first feedback';

  @override
  String get settingsFeedbackAfterDays =>
      'Days after sign-up before asking for feedback';

  @override
  String get settingsReviewActiveDays => 'Days of use before asking';

  @override
  String get settingsReviewAfterDays =>
      'Days after sign-up before the store rating window';

  @override
  String get settingsReviewEveryDays => 'Days between store rating requests';

  @override
  String get settingsReviewHelp =>
      'The store rating window never gives points: Google Play and the App Store don\'t allow it.';

  @override
  String get petitions => 'Petitions';

  @override
  String get petition => 'Petition';

  @override
  String get petitionsSubtitle => 'Animal welfare campaigns picked by our team';

  @override
  String get adminPetitionsSubtitle =>
      'Add, review and publish animal welfare petitions';

  @override
  String petitionsBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count animal welfare petitions to sign',
      one: '1 animal welfare petition to sign',
    );
    return '$_temp0';
  }

  @override
  String get petitionsIntro =>
      'The CodaMi team checks every petition before it appears here. You read and sign it on the original site.';

  @override
  String get petitionsEmpty =>
      'No petitions yet. The team will add animal welfare campaigns here.';

  @override
  String get petitionAdminEmpty =>
      'No petitions here. Tap Add petition to add one from Change.org, Care2, Avaaz or a trusted organization.';

  @override
  String get petitionView => 'View petition';

  @override
  String get petitionSignOnSite => 'Read and sign on the original site';

  @override
  String get petitionOpenFailed => 'Couldn\'t open the petition page.';

  @override
  String get petitionIssue => 'The issue';

  @override
  String get petitionAction => 'What the petition asks for';

  @override
  String get petitionWhy => 'Why it matters for animals';

  @override
  String get petitionWhere => 'Original petition';

  @override
  String petitionStartedOn(String date) {
    return 'Started $date';
  }

  @override
  String get petitionDisclaimer =>
      'This petition is hosted by an external site. CodaMi does not collect signatures and is not responsible for the content of the original page.';

  @override
  String get petitionEndedNote =>
      'This campaign has ended. You can still read the original page.';

  @override
  String get petitionUnavailableNote =>
      'The original petition is no longer available.';

  @override
  String get petitionTopicPets => 'Pets';

  @override
  String get petitionTopicWildlife => 'Wildlife';

  @override
  String get petitionTopicFarm => 'Farm animals';

  @override
  String get petitionTopicTesting => 'Animal testing';

  @override
  String get petitionTopicEntertainment => 'Circuses and zoos';

  @override
  String get petitionTopicMarine => 'Marine life';

  @override
  String get petitionTopicOther => 'Other';

  @override
  String get petitionStatusActive => 'Active';

  @override
  String get petitionStatusCompleted => 'Completed';

  @override
  String get petitionStatusClosed => 'Closed';

  @override
  String get petitionStatusUnavailable => 'No longer available';

  @override
  String get petitionReviewPending => 'To review';

  @override
  String get petitionReviewApproved => 'Approved';

  @override
  String get petitionReviewRejected => 'Rejected';

  @override
  String get petitionAdd => 'Add petition';

  @override
  String get petitionEdit => 'Edit petition';

  @override
  String get petitionSectionSource => 'Original petition';

  @override
  String get petitionUrl => 'Petition link';

  @override
  String get petitionUrlInvalid =>
      'Paste the full link, starting with https://';

  @override
  String get petitionTitle => 'Title';

  @override
  String get petitionSource => 'Platform or organization';

  @override
  String get petitionCountry => 'Country or area';

  @override
  String get petitionCountryHelp => 'Leave empty for international campaigns.';

  @override
  String get petitionStartedOnPick => 'Petition start date (optional)';

  @override
  String get petitionTopic => 'Topic';

  @override
  String get petitionSectionText => 'Our description';

  @override
  String get petitionOwnWordsHelp =>
      'Write in your own words. Don\'t copy text from the original page.';

  @override
  String get petitionSummary => 'Short summary';

  @override
  String get petitionImage => 'Image';

  @override
  String get petitionImageAdd => 'Add image';

  @override
  String get petitionImageChange => 'Change image';

  @override
  String get petitionImageHelp =>
      'Optional. Without an image, the card shows the topic icon.';

  @override
  String get petitionImagePermission => 'We have permission to use this image';

  @override
  String get petitionImagePermissionNeeded =>
      'Confirm you have permission to use the image, or remove it.';

  @override
  String get petitionImageTooBig =>
      'The image is too large. Choose one under 5 MB.';

  @override
  String get petitionChecks => 'Verification';

  @override
  String get petitionChecksHelp => 'All four are needed to approve or publish.';

  @override
  String get petitionCheckExists => 'The original page exists and opens';

  @override
  String get petitionCheckGenuine =>
      'It is about a genuine animal welfare issue';

  @override
  String get petitionCheckGoal => 'It has a clear goal';

  @override
  String get petitionCheckHonest => 'No misleading or fraudulent claims';

  @override
  String get petitionChecksNeeded =>
      'Tick all verification checks before approving or publishing.';

  @override
  String get petitionReview => 'Review';

  @override
  String get petitionReviewHelp =>
      'Only published petitions are shown to users.';

  @override
  String get petitionRejectReason => 'Reason (only seen by admins)';

  @override
  String get petitionStatus => 'Petition status';

  @override
  String get petitionStatusHelp =>
      'Update it when the campaign ends or the page is removed.';

  @override
  String get petitionFixFields => 'Fill in the fields marked in red.';

  @override
  String get petitionDeleteTitle => 'Delete this petition?';

  @override
  String get petitionDeleteBody =>
      'It will be removed from the app for everyone.';

  @override
  String petitionAddedOn(String date) {
    return 'Added $date';
  }

  @override
  String petitionPublishedOn(String date) {
    return 'Published $date';
  }

  @override
  String petitionUpdatedOn(String date) {
    return 'Updated $date';
  }

  @override
  String get appUpdates => 'App updates';

  @override
  String get adminAppUpdatesSubtitle => 'Store versions and required updates';

  @override
  String get appUpdatesSubtitle => 'Versions in the stores';

  @override
  String get appUpdatesIntro =>
      'Users on an older version see an update message with the What\'s new notes of the latest version. Below the minimum version, the app can\'t be used until it\'s updated. No new build is needed to change these.';

  @override
  String appUpdatesThisPhone(String version) {
    return 'This phone has version $version';
  }

  @override
  String get appUpdatesAndroid => 'Android (Google Play)';

  @override
  String get appUpdatesIos => 'iPhone (App Store)';

  @override
  String get appUpdatesLatest => 'Latest version in the store';

  @override
  String get appUpdatesLatestHelp =>
      'Set it once the update is live in the store. Leave empty to show no update message.';

  @override
  String get appUpdatesMinimum => 'Minimum version';

  @override
  String get appUpdatesMinimumHelp =>
      'Older versions must update before using the app. Leave empty for none.';

  @override
  String get appUpdatesStoreId => 'App Store ID';

  @override
  String get appUpdatesStoreIdHelp =>
      'The number in the App Store link (apps.apple.com/app/id…). Needed for the Update button on iPhone.';

  @override
  String appUpdatesNotesPublished(String version) {
    return 'The notes for $version are published and shown with the update';
  }

  @override
  String appUpdatesNotesDraft(String version) {
    return 'The notes for $version are saved but not published';
  }

  @override
  String appUpdatesNotesMissing(String version) {
    return 'No What\'s new notes for $version yet';
  }

  @override
  String get appUpdatesBadVersion => 'Use a version like 1.2.0';

  @override
  String get appUpdatesMinimumAbove =>
      'The minimum can\'t be higher than the latest version';

  @override
  String get appUpdatesBadStoreId => 'The App Store ID has only digits';

  @override
  String get appUpdatesRequireTitle => 'Require the update?';

  @override
  String appUpdatesRequireBody(String version) {
    return 'Everyone below version $version will have to update before they can use the app.';
  }

  @override
  String get appUpdatesRequireConfirm => 'Require';

  @override
  String get updateAvailableTitle => 'Update available';

  @override
  String updateAvailableBody(String latest, String installed) {
    return 'Version $latest of CodaMi is ready. You have $installed.';
  }

  @override
  String get updateNow => 'Update now';

  @override
  String get updateLater => 'Later';

  @override
  String get updateRequiredTitle => 'Update required';

  @override
  String updateRequiredBody(String version) {
    return 'This version of CodaMi is no longer supported. Update to version $version to keep using the app.';
  }

  @override
  String updateBanner(String version) {
    return 'Version $version is available';
  }

  @override
  String get updateStoreFailed =>
      'Couldn\'t open the store. Please update CodaMi from the store app.';

  @override
  String get rateCodaMiSubtitleIos => 'Leave a review on the App Store';

  @override
  String get updateContinueAsAdmin => 'Continue as admin';

  @override
  String get navShop => 'Shop';

  @override
  String get shop => 'Shop';

  @override
  String get adminShopSubtitle =>
      'Products, brands, suppliers and the on/off switch';

  @override
  String get shopSubtitle => 'Products for your pets';

  @override
  String get shopSearchHint => 'Search products';

  @override
  String get shopEmpty => 'Products are coming soon. Check back later!';

  @override
  String get shopNoResults => 'No products match.';

  @override
  String get shopInStock => 'In stock';

  @override
  String get shopLowStock => 'Only a few left';

  @override
  String get shopOutOfStock => 'Out of stock';

  @override
  String get shopComingSoon => 'Coming soon';

  @override
  String get shopModelOwnStock => 'Our stock';

  @override
  String get shopModelBrand => 'Brand partner';

  @override
  String get shopModelDropship => 'Dropshipping';

  @override
  String get shopModelAffiliate => 'Affiliate link';

  @override
  String get shopModelOwnStockHelp => 'CodaMi holds the stock and ships it.';

  @override
  String get shopModelBrandHelp =>
      'The brand sells through CodaMi and ships the order.';

  @override
  String get shopModelDropshipHelp =>
      'A supplier ships the order straight to the customer.';

  @override
  String get shopModelAffiliateHelp =>
      'Bought on the partner\'s site through our link; CodaMi earns a commission.';

  @override
  String shopBuyOn(String partner) {
    return 'Buy on $partner';
  }

  @override
  String shopAffiliateNote(String partner) {
    return 'Sold and shipped by $partner. CodaMi may earn a commission on this purchase.';
  }

  @override
  String shopPriceOnPartner(String partner) {
    return 'Price on $partner';
  }

  @override
  String get shopAddToCart => 'Add to cart';

  @override
  String get shopCheckoutSoon => 'Buying in the app is coming soon.';

  @override
  String get shopAllAnimals => 'For all animals';

  @override
  String get shopDescription => 'Description';

  @override
  String get shopOpenFailed => 'Couldn\'t open the link.';

  @override
  String get shopPreviewOff => 'Preview: the shop is off, users can\'t see it.';

  @override
  String get shopAdminIntro =>
      'Manage the CodaMi Shop. Users only see it while it\'s on.';

  @override
  String get shopOpenSwitch => 'Shop open to users';

  @override
  String get shopOnHelp => 'On: everyone sees the Shop tab.';

  @override
  String get shopOffHelp =>
      'Off: users don\'t see the shop. Admins can still prepare it.';

  @override
  String get shopTurnOnTitle => 'Open the shop?';

  @override
  String get shopTurnOnBody =>
      'Every user will see the Shop tab and the active products straight away.';

  @override
  String get shopTurnOffTitle => 'Close the shop?';

  @override
  String get shopTurnOffBody =>
      'The Shop tab disappears for every user straight away. Products and settings are kept.';

  @override
  String get shopTurnOn => 'Open';

  @override
  String get shopTurnOff => 'Close';

  @override
  String get shopSalesModels => 'Sales models';

  @override
  String get shopSalesModelsHelp =>
      'Turning a model off hides all its products from users.';

  @override
  String get shopCatalog => 'Catalogue';

  @override
  String get shopProducts => 'Products';

  @override
  String get shopCategories => 'Categories';

  @override
  String get shopBrands => 'Brands';

  @override
  String get shopSuppliers => 'Suppliers';

  @override
  String get shopPreview => 'Preview the shop';

  @override
  String get shopPreviewSubtitle => 'See the shop as users will';

  @override
  String shopProductsCount(int active, int total) {
    return '$active active · $total in total';
  }

  @override
  String get shopAddProduct => 'Add product';

  @override
  String get shopEditProduct => 'Edit product';

  @override
  String get shopProductsEmpty => 'No products yet. Add the first one.';

  @override
  String get shopActive => 'Active';

  @override
  String get shopHidden => 'Hidden';

  @override
  String get shopNeedCategory => 'Add a category first (Shop → Categories).';

  @override
  String get shopPhotos => 'Photos';

  @override
  String get shopPhotosHelp =>
      'Up to 6 photos. The first one is the cover; hold and drag to reorder.';

  @override
  String get shopAddPhoto => 'Add photo';

  @override
  String get shopImageTooBig => 'Images must be smaller than 5 MB.';

  @override
  String get shopDetails => 'Details';

  @override
  String get shopName => 'Name';

  @override
  String get shopCategory => 'Category';

  @override
  String get shopPickCategory => 'Choose a category';

  @override
  String get shopAnimals => 'Animals';

  @override
  String get shopAnimalsHelp =>
      'None selected means for every animal. Users see products for their own pets first.';

  @override
  String get shopSalesModel => 'Sales model';

  @override
  String get shopPartnerName => 'Partner shop';

  @override
  String get shopAffiliateUrl => 'Affiliate link';

  @override
  String get shopBrand => 'Brand';

  @override
  String get shopNoBrand => 'No brand';

  @override
  String get shopSupplier => 'Supplier';

  @override
  String get shopNoSupplier => 'No supplier';

  @override
  String get shopPriceSection => 'Price';

  @override
  String get shopPrice => 'Price (€)';

  @override
  String get shopPriceAffiliateHelp =>
      'Optional: prices change on the partner\'s site.';

  @override
  String get shopPriceInvalid => 'Enter a price, for example 12.90';

  @override
  String get shopCompareAt => 'Price before discount (€)';

  @override
  String get shopCompareAtHelp =>
      'Optional. Shown crossed out next to the price.';

  @override
  String get shopCompareAtInvalid => 'Must be higher than the price.';

  @override
  String get shopAvailability => 'Availability';

  @override
  String get shopVisible => 'Visible to users';

  @override
  String get shopVisibleHelp => 'Hidden products are only seen by admins.';

  @override
  String get shopCategoryVisibleHelp =>
      'When hidden, the category and all its products are hidden from users.';

  @override
  String get shopBrandVisibleHelp =>
      'When hidden, all of the brand\'s products are hidden from users.';

  @override
  String get shopSupplierActiveHelp =>
      'When off, all of this supplier\'s products are hidden from users.';

  @override
  String get shopDeleteProductTitle => 'Delete this product?';

  @override
  String get shopDeleteProductBody =>
      'It is removed from the shop with its photos. This can\'t be undone.';

  @override
  String shopDeleteTitle(String name) {
    return 'Delete $name?';
  }

  @override
  String get shopDeleteBody => 'This can\'t be undone.';

  @override
  String get shopInUse =>
      'Still used by products or sub-categories, so it can\'t be deleted. Hide it instead.';

  @override
  String get shopFixFields => 'Check the fields marked in red.';

  @override
  String get shopLinkInvalid => 'Enter a full link starting with https://';

  @override
  String get shopAddCategory => 'Add category';

  @override
  String get shopEditCategory => 'Edit category';

  @override
  String get shopAddStarting => 'Add the starting categories';

  @override
  String get shopStartingHelp =>
      'Start with food, accessories, care, toys, beds, carriers, tech and other. You can rename, hide or remove them later.';

  @override
  String get shopParent => 'Inside category';

  @override
  String get shopNoParent => 'None (main category)';

  @override
  String get shopIcon => 'Icon';

  @override
  String get shopOrder => 'Position';

  @override
  String get shopOrderHelp => 'Lower numbers come first.';

  @override
  String get shopCatFood => 'Pet food';

  @override
  String get shopCatAccessories => 'Accessories';

  @override
  String get shopCatCare => 'Pet care';

  @override
  String get shopCatToys => 'Toys';

  @override
  String get shopCatBeds => 'Beds';

  @override
  String get shopCatCarriers => 'Carriers';

  @override
  String get shopCatTech => 'Pet tech';

  @override
  String get shopCatOther => 'Other';

  @override
  String get shopAddBrand => 'Add brand';

  @override
  String get shopEditBrand => 'Edit brand';

  @override
  String get shopBrandsEmpty =>
      'No brands yet. Brands are optional; add them when you have partners.';

  @override
  String get shopWebsite => 'Website';

  @override
  String get shopLogo => 'Logo';

  @override
  String get shopAddLogo => 'Choose logo';

  @override
  String get shopAddSupplier => 'Add supplier';

  @override
  String get shopEditSupplier => 'Edit supplier';

  @override
  String get shopSuppliersEmpty => 'No suppliers yet.';

  @override
  String get shopSuppliersHelp =>
      'Only admins see suppliers and their details. Turning a supplier off hides its products.';

  @override
  String get shopContactName => 'Contact person';

  @override
  String get shopEmail => 'Email';

  @override
  String get shopEmailInvalid => 'Enter a valid email address.';

  @override
  String get shopPhone => 'Phone';

  @override
  String get shopOrderMethod => 'How orders reach them';

  @override
  String get shopOrderManual => 'By hand';

  @override
  String get shopOrderManualHelp =>
      'The team forwards each order to the supplier.';

  @override
  String get shopOrderEmail => 'Automatic email';

  @override
  String get shopOrderEmailHelp =>
      'Each paid order is emailed to the supplier (starts with checkout).';

  @override
  String get shopNotes => 'Notes (admins only)';

  @override
  String get shopForYourPets => 'For your pets';

  @override
  String get shopOnSale => 'On sale';

  @override
  String get shopAllProducts => 'All products';

  @override
  String get shopResults => 'Results';

  @override
  String shopProductCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count products',
      one: '1 product',
    );
    return '$_temp0';
  }

  @override
  String shopYouSave(String amount) {
    return 'You save $amount';
  }
}
