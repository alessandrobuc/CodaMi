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
}
