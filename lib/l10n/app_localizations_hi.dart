// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get navHome => 'होम';

  @override
  String get navPets => 'पालतू';

  @override
  String get navProfile => 'प्रोफ़ाइल';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get delete => 'हटाएँ';

  @override
  String get notSet => 'सेट नहीं';

  @override
  String get soon => 'जल्द';

  @override
  String comingSoon(String feature) {
    return '$feature जल्द आ रहा है।';
  }

  @override
  String get profileTitle => 'प्रोफ़ाइल';

  @override
  String get myPets => 'मेरे पालतू';

  @override
  String get myReports => 'मेरी रिपोर्ट';

  @override
  String get homeCity => 'शहर';

  @override
  String get notifications => 'सूचनाएँ';

  @override
  String get chooseLanguage => 'अपनी भाषा चुनें';

  @override
  String get language => 'भाषा';

  @override
  String get signOut => 'साइन आउट';

  @override
  String get signOutTitle => 'साइन आउट करें?';

  @override
  String get signOutMessage => 'आप कभी भी फिर से लॉग इन कर सकते हैं।';

  @override
  String get deleteAccount => 'खाता हटाएँ';

  @override
  String get deleteAccountTitle => 'अपना खाता हटाएँ?';

  @override
  String get deleteAccountMessage =>
      'आपकी प्रोफ़ाइल, आपके पालतू, आपकी रिपोर्ट और उनकी तस्वीरें हमेशा के लिए हट जाएँगी। इसे वापस नहीं किया जा सकता।';

  @override
  String get deletingAccount => 'आपका खाता हटाया जा रहा है…';

  @override
  String get myReportsSubtitle => 'अपनी रिपोर्ट अपडेट रखें।';

  @override
  String get statTotal => 'कुल';

  @override
  String postedOn(String date) {
    return '$date को पोस्ट किया';
  }

  @override
  String get reportActive => 'सक्रिय';

  @override
  String get reportResolved => 'हल हो गई';

  @override
  String get myReportsLoadError => 'आपकी रिपोर्ट लोड नहीं हो सकीं';

  @override
  String get checkConnection => 'अपना कनेक्शन जाँचें और फिर कोशिश करें।';

  @override
  String get noActiveReports => 'कोई सक्रिय रिपोर्ट नहीं';

  @override
  String get noActiveReportsMessage =>
      'खोए या मिले पालतू जानवरों के लिए आपकी रिपोर्ट यहाँ दिखेंगी।';

  @override
  String get reportAPet => 'पालतू की रिपोर्ट करें';

  @override
  String get nothingResolved => 'अभी तक कुछ हल नहीं हुआ';

  @override
  String get nothingResolvedMessage =>
      'जब आप किसी रिपोर्ट को हल के रूप में चिह्नित करेंगे, वह यहाँ आ जाएगी।';

  @override
  String get markAsFound => 'मिल गया चिह्नित करें';

  @override
  String get returnedToOwner => 'मालिक को लौटाया';

  @override
  String get backHome => 'घर लौट आया';

  @override
  String get reunited => 'परिवार से मिला';

  @override
  String get deleteReport => 'रिपोर्ट हटाएँ';

  @override
  String resolveLostTitle(String petName) {
    return 'क्या $petName घर लौट आया?';
  }

  @override
  String get resolveFoundTitle => 'क्या मालिक मिल गया?';

  @override
  String resolveLostMessage(String petName) {
    return 'रिपोर्ट \"मिले\" टैब में \"घर लौट आया\" में चली जाएगी, ताकि पड़ोसियों को पता चले कि $petName सुरक्षित है।';
  }

  @override
  String get resolveFoundMessage =>
      'रिपोर्ट \"मिले\" टैब में \"परिवार से मिला\" में चली जाएगी।';

  @override
  String get notYet => 'अभी नहीं';

  @override
  String get yesResolved => 'हाँ, हल हो गया';

  @override
  String get reportResolvedSuccess => 'बहुत अच्छी ख़बर! रिपोर्ट हल हो गई।';

  @override
  String get deleteReportTitle => 'यह रिपोर्ट हटाएँ?';

  @override
  String deleteOpenReportMessage(String petName) {
    return 'यह मैप और सूचियों से हट जाएगी। अगर $petName सुरक्षित है, तो इसके बजाय रिपोर्ट को हल चिह्नित करें ताकि पड़ोसियों को पता चले।';
  }

  @override
  String get deleteResolvedReportMessage =>
      'यह मैप और \"घर लौट आया\" सूची से हटा दी जाएगी।';

  @override
  String get reportDeleted => 'रिपोर्ट हटा दी गई।';

  @override
  String get onboarding1Title => 'हर पालतू को चाहिए\n';

  @override
  String get onboarding1Highlight => 'घर का रास्ता';

  @override
  String get onboarding1Body =>
      'CodaMi पड़ोसियों को जोड़ता है ताकि खोए हुए कुत्ते और बिल्लियाँ उन लोगों तक लौट सकें जो उनसे प्यार करते हैं।';

  @override
  String get onboarding2Title => 'पालतू की रिपोर्ट करें\n';

  @override
  String get onboarding2Highlight => 'कुछ ही सेकंड में';

  @override
  String get onboarding2Body =>
      'फ़ोटो लें, जगह चुनें और खोने या मिलने की रिपोर्ट पोस्ट करें। आस-पास सभी को यह तुरंत दिखेगी।';

  @override
  String get onboarding3Title => 'देखें कौन है\n';

  @override
  String get onboarding3Highlight => 'आपके पास';

  @override
  String get onboarding3Body =>
      'आपके आस-पास खोए और मिले पालतू, एक ही मैप पर लाइव, ताकि आपको हमेशा पता रहे कि कहाँ ढूँढना है।';

  @override
  String get skip => 'छोड़ें';

  @override
  String get getStarted => 'शुरू करें';

  @override
  String get lost => 'खोया';

  @override
  String get found => 'मिला';

  @override
  String get you => 'आप';

  @override
  String get published => 'प्रकाशित';

  @override
  String get onboardingSampleBreed => 'गोल्डन रिट्रीवर · 3 साल';

  @override
  String get onboardingSamplePlace => 'मिलान · 2 घंटे पहले';

  @override
  String get validationNameRequired => 'कृपया अपना नाम लिखें';

  @override
  String get validationNameTooShort => 'नाम कम से कम 2 अक्षरों का होना चाहिए';

  @override
  String get validationNameTooLong => 'नाम 50 अक्षरों से कम होना चाहिए';

  @override
  String get validationNameInvalid =>
      'नाम में केवल अक्षर, स्पेस, हाइफ़न और एपॉस्ट्रॉफ़ी हो सकते हैं';

  @override
  String get validationEmailRequired => 'कृपया अपना ईमेल लिखें';

  @override
  String get validationEmailInvalid => 'कृपया सही ईमेल पता लिखें';

  @override
  String get validationPasswordRequired => 'कृपया अपना पासवर्ड लिखें';

  @override
  String get validationPasswordTooShort =>
      'पासवर्ड कम से कम 8 अक्षरों का होना चाहिए';

  @override
  String get validationConfirmRequired => 'कृपया पासवर्ड की पुष्टि करें';

  @override
  String get validationPasswordsDontMatch => 'पासवर्ड मेल नहीं खाते';

  @override
  String get spamNote =>
      'रीसेट ईमेल नहीं मिल रहा? अपना स्पैम या जंक फ़ोल्डर देखें, कभी-कभी वह वहाँ चला जाता है।';

  @override
  String get logIn => 'लॉग इन';

  @override
  String get signUp => 'साइन अप';

  @override
  String get authResetSentTitle => 'अपना इनबॉक्स देखें';

  @override
  String get authResetSentSubtitle =>
      'हमने आपको पासवर्ड रीसेट करने का लिंक भेजा है।';

  @override
  String get authLoginTitle => 'फिर से स्वागत है!';

  @override
  String get authLoginSubtitle =>
      'लॉग इन करें और पालतू जानवरों को घर पहुँचाने में मदद करते रहें।';

  @override
  String get authSignupTitle => 'हमारे साथ जुड़ें';

  @override
  String get authSignupSubtitle => 'खाता बनाएँ और अपने मोहल्ले की मदद करें।';

  @override
  String get authForgotTitle => 'पासवर्ड भूल गए?';

  @override
  String get authForgotSubtitle =>
      'कोई बात नहीं, हम आपको रीसेट लिंक ईमेल कर देंगे।';

  @override
  String get fullName => 'पूरा नाम';

  @override
  String get email => 'ईमेल';

  @override
  String get password => 'पासवर्ड';

  @override
  String get confirmPassword => 'पासवर्ड की पुष्टि करें';

  @override
  String get forgotPassword => 'पासवर्ड भूल गए?';

  @override
  String get createAccount => 'खाता बनाएँ';

  @override
  String get sendResetLink => 'रीसेट लिंक भेजें';

  @override
  String get or => 'या';

  @override
  String get continueWithGoogle => 'Google के साथ जारी रखें';

  @override
  String get continueWithApple => 'Apple के साथ जारी रखें';

  @override
  String get resetLinkSentTo => 'हमने रीसेट लिंक भेजा है';

  @override
  String get backToLogIn => 'लॉग इन पर वापस जाएँ';

  @override
  String get sendAgain => 'नहीं मिला? फिर से भेजें';

  @override
  String get errorOffline =>
      'आप ऑफ़लाइन हैं। अपना कनेक्शन जाँचें और फिर कोशिश करें।';

  @override
  String get errorSessionExpired =>
      'आपका सत्र समाप्त हो गया। कृपया फिर से साइन इन करें।';

  @override
  String get deleteAccountFailed =>
      'आपका खाता नहीं हटाया जा सका। फिर कोशिश करें।';

  @override
  String get authErrorGeneric => 'कुछ गड़बड़ हो गई। फिर कोशिश करें।';

  @override
  String get authErrorDisabled => 'यह खाता बंद कर दिया गया है।';

  @override
  String get authErrorWrongCredentials => 'ईमेल या पासवर्ड गलत है।';

  @override
  String get authErrorEmailInUse =>
      'इस ईमेल से पहले ही एक खाता है। लॉग इन करके देखें।';

  @override
  String get authErrorTooManyRequests =>
      'बहुत अधिक प्रयास। थोड़ी देर रुककर फिर कोशिश करें।';

  @override
  String get citySearchFailed => 'शहर खोज विफल रही। फिर कोशिश करें।';

  @override
  String get placeSearchFailed => 'जगह खोज विफल रही। फिर कोशिश करें।';

  @override
  String get placeOutsideCity =>
      'यह जगह आपके शहर से बाहर है। कृपया शहर के अंदर की जगह चुनें।';

  @override
  String get placeNotFound => 'हमें वह जगह नहीं मिली। कृपया कोई दूसरी चुनें।';

  @override
  String get citySearchOffline =>
      'शहर खोज तक नहीं पहुँच सके। अपना कनेक्शन जाँचें और फिर कोशिश करें।';

  @override
  String get searchCityHint => 'अपना शहर खोजें, जैसे मिलान';

  @override
  String noCitiesFound(String query) {
    return '\"$query\" के लिए कोई शहर नहीं मिला।';
  }

  @override
  String homeCityUpdated(String city) {
    return 'शहर बदलकर $city कर दिया गया।';
  }

  @override
  String get saveCityFailed => 'आपका शहर सेव नहीं हो सका। फिर कोशिश करें।';

  @override
  String get citySetupTitle => 'आप ';

  @override
  String get citySetupHighlight => 'कहाँ हैं?';

  @override
  String get cityEditTitle => 'अपना ';

  @override
  String get cityEditHighlight => 'शहर बदलें';

  @override
  String get citySetupBody =>
      'अपना शहर चुनें ताकि हम आपके पास खोए और मिले पालतू दिखा सकें और आपके इलाके में कोई पालतू खोने पर आपको बता सकें।';

  @override
  String get saveCity => 'शहर सेव करें';

  @override
  String get continueLabel => 'जारी रखें';

  @override
  String get notYouSignOut => 'आप नहीं हैं? साइन आउट करें';

  @override
  String greeting(String name) {
    return 'नमस्ते, $name!';
  }

  @override
  String get showPetsWithin => 'इतनी दूरी तक पालतू दिखाएँ';

  @override
  String distanceFrom(String city) {
    return '$city से दूरी';
  }

  @override
  String get everywhere => 'हर जगह';

  @override
  String distanceKm(int km) {
    return '$km किमी';
  }

  @override
  String withinKm(int km) {
    return '$km किमी के अंदर';
  }

  @override
  String get areaNotSet => 'इलाका अभी सेट नहीं';

  @override
  String get reportPetSemantics => 'खोए या मिले पालतू की रिपोर्ट करें';

  @override
  String get map => 'मैप';

  @override
  String get locationServicesOff =>
      'अपनी लोकेशन इस्तेमाल करने के लिए लोकेशन सेवाएँ चालू करें।';

  @override
  String get locationPermissionDenied =>
      'अपनी लोकेशन इस्तेमाल करने के लिए सेटिंग्स में लोकेशन की अनुमति दें।';

  @override
  String get locationFailed => 'आपकी लोकेशन नहीं मिल सकी। फिर कोशिश करें।';

  @override
  String get back => 'वापस';

  @override
  String get fullScreen => 'फ़ुल स्क्रीन';

  @override
  String get loadingPets => 'पालतू लोड हो रहे हैं…';

  @override
  String get mapLoadFailed => 'रिपोर्ट लोड नहीं हो सकीं। अपना कनेक्शन जाँचें।';

  @override
  String get mapNoLost => 'इस इलाके में कोई खोया पालतू नहीं';

  @override
  String get mapNoFound => 'इस इलाके में कोई मिला पालतू नहीं';

  @override
  String get mapNoPets => 'इस इलाके में कोई खोया या मिला पालतू नहीं';

  @override
  String get zoomIn => 'ज़ूम इन';

  @override
  String get zoomOut => 'ज़ूम आउट';

  @override
  String get myLocation => 'मेरी लोकेशन';

  @override
  String get myCity => 'मेरा शहर';

  @override
  String get all => 'सभी';

  @override
  String get timeJustNow => 'अभी-अभी';

  @override
  String timeMinutesAgo(int minutes) {
    return '$minutes मिनट पहले';
  }

  @override
  String timeHoursAgo(int hours) {
    return '$hours घंटे पहले';
  }

  @override
  String get timeYesterday => 'कल';

  @override
  String timeDaysAgo(int days) {
    return '$days दिन पहले';
  }

  @override
  String notifLostTitle(String city) {
    return '$city में पालतू खो गया';
  }

  @override
  String notifLostBodyNear(String pet, String street, String city) {
    return '$pet को आख़िरी बार $street, $city के पास देखा गया था। नज़र रखें!';
  }

  @override
  String notifLostBodyIn(String pet, String city) {
    return '$pet को आख़िरी बार $city में देखा गया था। नज़र रखें!';
  }

  @override
  String notifFoundTitle(String city) {
    return '$city में पालतू मिला';
  }

  @override
  String notifFoundBodyNear(String pet, String street, String city) {
    return '$pet $street, $city के पास मिला है। क्या आप इसके मालिक को जानते हैं?';
  }

  @override
  String notifFoundBodyIn(String pet, String city) {
    return '$pet $city में मिला है। क्या आप इसके मालिक को जानते हैं?';
  }

  @override
  String notifBackHomeTitle(String pet) {
    return '$pet घर लौट आया';
  }

  @override
  String notifBackHomeBody(String pet, String city) {
    return '$city से अच्छी ख़बर: $pet मिल गया है। मदद के लिए धन्यवाद!';
  }

  @override
  String notifReunitedTitle(String pet) {
    return '$pet अपने परिवार से मिल गया';
  }

  @override
  String notifReunitedBody(String city) {
    return '$city में मिला पालतू अपने परिवार के पास लौट गया है।';
  }

  @override
  String get notificationsTitle => 'सूचनाएँ';

  @override
  String get markAllRead => 'सभी को पढ़ा चिह्नित करें';

  @override
  String get notificationsLoadError => 'सूचनाएँ लोड नहीं हो सकीं';

  @override
  String get allCaughtUp => 'कोई नई सूचना नहीं';

  @override
  String get notificationsEmpty =>
      'जब आपके शहर में कोई पालतू खोएगा या मिलेगा, हम आपको बताएँगे।';

  @override
  String get notificationsNew => 'नई';

  @override
  String get notificationsEarlier => 'पहले की';

  @override
  String get reportNotAvailable => 'रिपोर्ट उपलब्ध नहीं';

  @override
  String get reportRemoved => 'इस रिपोर्ट को इसके मालिक ने हटा दिया है।';

  @override
  String get reportsLoadError => 'रिपोर्ट लोड नहीं हो सकीं';

  @override
  String get pullToRetry =>
      'अपना कनेक्शन जाँचें और फिर कोशिश करने के लिए नीचे खींचें।';

  @override
  String get noLostNearby => 'आस-पास कोई खोया पालतू नहीं';

  @override
  String get noLostNearbyMessage =>
      'अच्छी ख़बर! आपके इलाके में अभी तक किसी ने खोए पालतू की रिपोर्ट नहीं की है।';

  @override
  String get noFoundYet => 'अभी तक कोई मिला पालतू नहीं';

  @override
  String get noFoundYetMessage => 'आपके पड़ोसियों को मिले पालतू यहाँ दिखेंगे।';

  @override
  String get backHomeSection => 'घर लौट आए';

  @override
  String get backHomeSectionSubtitle => 'पालतू जो अपने परिवार के पास लौट आए।';

  @override
  String get loadMore => 'और लोड करें';

  @override
  String get speciesDog => 'कुत्ता';

  @override
  String get speciesCat => 'बिल्ली';

  @override
  String get speciesOther => 'अन्य';

  @override
  String get sexMale => 'नर';

  @override
  String get sexFemale => 'मादा';

  @override
  String get sexUnknown => 'पता नहीं';

  @override
  String nearPlace(String street, String city) {
    return '$street, $city के पास';
  }

  @override
  String get callFailed => 'कॉल शुरू नहीं हो सकी।';

  @override
  String get whatsappFailed => 'WhatsApp नहीं खुल सका।';

  @override
  String get emailFailed => 'आपका ईमेल ऐप नहीं खुल सका।';

  @override
  String whatsappMessageLost(String pet) {
    return 'नमस्ते! मैं CodaMi पर खोए पालतू \"$pet\" के बारे में संपर्क कर रहा हूँ।';
  }

  @override
  String whatsappMessageFound(String pet) {
    return 'नमस्ते! मैं CodaMi पर मिले पालतू \"$pet\" के बारे में संपर्क कर रहा हूँ।';
  }

  @override
  String emailSubjectLost(String pet) {
    return '$pet के बारे में (CodaMi पर खोया पालतू)';
  }

  @override
  String emailSubjectFound(String pet) {
    return '$pet के बारे में (CodaMi पर मिला पालतू)';
  }

  @override
  String shareTitleLost(String pet) {
    return 'खोया पालतू: $pet';
  }

  @override
  String shareTitleFound(String pet) {
    return 'मिला पालतू: $pet';
  }

  @override
  String get shareFooter =>
      'क्या आपने यह पालतू देखा है? संपर्क करने के लिए CodaMi खोलें।';

  @override
  String get lastSeen => 'आख़िरी बार देखा गया';

  @override
  String get foundAt => 'यहाँ मिला';

  @override
  String areaAbout(int meters) {
    return 'लगभग $meters मी का इलाका';
  }

  @override
  String get when => 'कब';

  @override
  String get postedBy => 'पोस्ट करने वाले';

  @override
  String get description => 'विवरण';

  @override
  String get call => 'कॉल करें';

  @override
  String contactTitleLost(String pet) {
    return '$pet को देखा? संपर्क करें';
  }

  @override
  String get contactTitleFound => 'क्या यह आपका पालतू है? संपर्क करें';

  @override
  String get noContactShared => 'कोई संपर्क जानकारी साझा नहीं की गई।';

  @override
  String resolvedThanksLost(String pet) {
    return '$pet घर लौट आया। CodaMi इस्तेमाल करने के लिए धन्यवाद!';
  }

  @override
  String get resolvedThanksFound =>
      'यह पालतू अपने परिवार के पास लौट आया। मदद के लिए धन्यवाद!';

  @override
  String get yourContactDetails => 'आपकी संपर्क जानकारी';

  @override
  String markPetAsFound(String pet) {
    return '$pet को मिल गया चिह्नित करें';
  }

  @override
  String get markReturnedToOwner => 'मालिक को लौटाया चिह्नित करें';

  @override
  String get copiedToClipboard => 'क्लिपबोर्ड पर कॉपी किया गया।';

  @override
  String get petSaveFailed => 'आपका पालतू सेव नहीं हो सका। फिर कोशिश करें।';

  @override
  String get petDeleteFailed => 'आपका पालतू हटाया नहीं जा सका। फिर कोशिश करें।';

  @override
  String get errorPermission => 'आपको ऐसा करने की अनुमति नहीं है।';

  @override
  String get storageNotReady =>
      'फ़ोटो स्टोरेज अभी तैयार नहीं है। बाद में कोशिश करें।';

  @override
  String get storageFull => 'स्टोरेज अभी भरा हुआ है। बाद में कोशिश करें।';

  @override
  String petAdded(String name) {
    return '$name आपके पालतुओं में जोड़ दिया गया।';
  }

  @override
  String get petsLoadError => 'आपके पालतू लोड नहीं हो सके';

  @override
  String get noPetsYet => 'अभी कोई पालतू नहीं';

  @override
  String get noPetsYetMessage =>
      'अपने पालतू अभी जोड़ें, ताकि कभी खो जाएँ तो आप सेकंडों में रिपोर्ट कर सकें।';

  @override
  String get addFirstPet => 'पहला पालतू जोड़ें';

  @override
  String get petsHeaderEmpty =>
      'अपने पालतुओं की प्रोफ़ाइल तैयार रखें, कभी भी काम आ सकती है।';

  @override
  String petsHeaderCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count प्यारे दोस्त, किसी भी स्थिति के लिए तैयार।',
      one: '1 प्यारा दोस्त, किसी भी स्थिति के लिए तैयार।',
    );
    return '$_temp0';
  }

  @override
  String get addPet => 'जोड़ें';

  @override
  String petUpdated(String name) {
    return '$name अपडेट हो गया।';
  }

  @override
  String removePetTitle(String name) {
    return '$name को हटाएँ?';
  }

  @override
  String get removePetMessage =>
      'प्रोफ़ाइल और उसकी तस्वीरें हट जाएँगी। इसे वापस नहीं किया जा सकता।';

  @override
  String get remove => 'हटाएँ';

  @override
  String petRemoved(String name) {
    return '$name हटा दिया गया।';
  }

  @override
  String get breed => 'नस्ल';

  @override
  String get color => 'रंग';

  @override
  String get age => 'उम्र';

  @override
  String get sex => 'लिंग';

  @override
  String petAddedOn(String date) {
    return '$date को जोड़ा';
  }

  @override
  String get distinctiveFeatures => 'ख़ास पहचान';

  @override
  String ifPetGoesMissing(String name) {
    return 'अगर $name कभी खो जाए';
  }

  @override
  String get ifPetGoesMissingBody =>
      'इस प्रोफ़ाइल से सेकंडों में खोने की रिपोर्ट पोस्ट करें, आस-पास के पड़ोसियों को सूचना मिलेगी।';

  @override
  String reportPetAsLost(String name) {
    return '$name के खोने की रिपोर्ट करें';
  }

  @override
  String get colorBlack => 'काला';

  @override
  String get colorWhite => 'सफ़ेद';

  @override
  String get colorBrown => 'भूरा';

  @override
  String get colorGolden => 'सुनहरा';

  @override
  String get colorGrey => 'स्लेटी';

  @override
  String get colorCream => 'क्रीम';

  @override
  String get colorGinger => 'नारंगी';

  @override
  String get petPhotoRequired => 'अपने पालतू की कम से कम एक फ़ोटो जोड़ें।';

  @override
  String get petSpeciesRequired =>
      'चुनें कि आपका पालतू कुत्ता, बिल्ली या कुछ और है।';

  @override
  String get checkHighlightedFields => 'कृपया हाइलाइट किए गए फ़ील्ड जाँचें।';

  @override
  String get signInToSave => 'सेव करने के लिए फिर से साइन इन करें।';

  @override
  String get discardChangesTitle => 'बदलाव छोड़ दें?';

  @override
  String get discardPetChanges => 'इस पालतू में किए गए बदलाव खो जाएँगे।';

  @override
  String get keepEditing => 'एडिट जारी रखें';

  @override
  String get discard => 'छोड़ें';

  @override
  String editPetTitle(String name) {
    return '$name एडिट करें';
  }

  @override
  String get newPet => 'नया पालतू';

  @override
  String get whatKindOfPet => 'कैसा पालतू है?';

  @override
  String get name => 'नाम';

  @override
  String get petNameHint => 'जैसे लूना';

  @override
  String get petNameRequired => 'कृपया अपने पालतू का नाम लिखें';

  @override
  String get petNameTooLong => 'नाम 40 अक्षरों से कम होना चाहिए';

  @override
  String get breedHint => 'जैसे गोल्डन रिट्रीवर, मिक्स्ड';

  @override
  String get colorHint => 'जैसे सुनहरा, सफ़ेद छाती';

  @override
  String get ageHint => 'जैसे 3 साल, 8 महीने';

  @override
  String get featuresHint =>
      'पट्टा, माइक्रोचिप, निशान, धब्बे… कुछ भी जो आपके पालतू को पहचानने में मदद करे।';

  @override
  String get saveChanges => 'बदलाव सेव करें';

  @override
  String get savePet => 'पालतू सेव करें';

  @override
  String get cameraPermission => 'कृपया सेटिंग्स में कैमरे की अनुमति दें।';

  @override
  String get photosPermission => 'कृपया सेटिंग्स में फ़ोटो की अनुमति दें।';

  @override
  String get cameraFailed => 'कैमरा नहीं खुल सका।';

  @override
  String get galleryFailed => 'गैलरी नहीं खुल सकी।';

  @override
  String get optional => 'वैकल्पिक';

  @override
  String get addPetPhotos => 'अपने पालतू की फ़ोटो जोड़ें';

  @override
  String get addPetPhotosHint =>
      'साफ़ और हाल की फ़ोटो पहचानने में मदद करती हैं';

  @override
  String get photoRequired => 'कम से कम एक फ़ोटो ज़रूरी है';

  @override
  String get tapToMakeCover => 'किसी फ़ोटो को कवर बनाने के लिए उस पर टैप करें।';

  @override
  String get cover => 'कवर';

  @override
  String uploadingPhotos(int percent) {
    return 'फ़ोटो अपलोड हो रही हैं… $percent%';
  }

  @override
  String get saving => 'सेव हो रहा है…';

  @override
  String get takePhoto => 'फ़ोटो लें';

  @override
  String get useCamera => 'अपना कैमरा इस्तेमाल करें';

  @override
  String get chooseFromGallery => 'गैलरी से चुनें';

  @override
  String get pickExistingPhoto => 'कोई मौजूदा फ़ोटो चुनें';

  @override
  String get yourPet => 'आपका पालतू';

  @override
  String get unknownDog => 'अनजान कुत्ता';

  @override
  String get unknownCat => 'अनजान बिल्ली';

  @override
  String get unknownPet => 'अनजान पालतू';

  @override
  String get errorChooseType =>
      'चुनें कि आपका पालतू खो गया या आपको कोई पालतू मिला।';

  @override
  String get errorPickPet => 'खोया हुआ पालतू चुनें।';

  @override
  String get errorFoundPhoto => 'पालतू की कम से कम एक फ़ोटो जोड़ें।';

  @override
  String get errorFoundSpecies => 'यह कुत्ता है, बिल्ली है या कुछ और?';

  @override
  String get errorChooseCity => 'वह शहर चुनें जहाँ यह हुआ।';

  @override
  String get errorFutureDate => 'तारीख़ भविष्य की नहीं हो सकती।';

  @override
  String get errorDescriptionShort =>
      'छोटा सा विवरण जोड़ें (कम से कम 10 अक्षर)।';

  @override
  String get errorContactRequired =>
      'फ़ोन नंबर या ईमेल जोड़ें ताकि लोग आपसे संपर्क कर सकें।';

  @override
  String get errorPhoneInvalid => 'कृपया सही फ़ोन नंबर लिखें।';

  @override
  String get discardReportTitle => 'यह रिपोर्ट छोड़ दें?';

  @override
  String get discardReportMessage => 'अब तक आपने जो लिखा है वह खो जाएगा।';

  @override
  String get signInToPublish => 'पोस्ट करने के लिए फिर से साइन इन करें।';

  @override
  String publishedLost(String pet) {
    return '$pet अब मैप पर है। हमें उम्मीद है कि वह जल्द घर लौट आएगा।';
  }

  @override
  String publishedFound(String pet) {
    return 'धन्यवाद! $pet अब मैप पर है।';
  }

  @override
  String get reportLostPetTitle => 'खोए पालतू की रिपोर्ट करें';

  @override
  String get reportFoundPetTitle => 'मिले पालतू की रिपोर्ट करें';

  @override
  String get newReport => 'नई रिपोर्ट';

  @override
  String stepOf(int current, int total) {
    return '$total में से $current';
  }

  @override
  String get publishReport => 'रिपोर्ट पोस्ट करें';

  @override
  String get stepTypeTitle => 'क्या हुआ?';

  @override
  String get stepTypeSubtitle =>
      'आइए जल्दी से आस-पास के लोगों तक बात पहुँचाएँ।';

  @override
  String get stepFoundPetTitle => 'पालतू के बारे में बताएँ';

  @override
  String get stepFoundPetSubtitle =>
      'साफ़ फ़ोटो मालिक के पहचानने का सबसे तेज़ तरीका है।';

  @override
  String get addFoundPhotos => 'पालतू की फ़ोटो जोड़ें';

  @override
  String get addFoundPhotosHint => 'अभी एक फ़ोटो लें, या गैलरी से चुनें';

  @override
  String get whatKindOfAnimal => 'कौन सा जानवर है?';

  @override
  String get collarName => 'पट्टे या टैग पर लिखा नाम';

  @override
  String get collarNameHint => 'पता न हो तो खाली छोड़ दें';

  @override
  String get stepLostPetTitle => 'कौन सा पालतू खोया है?';

  @override
  String get stepLostPetSubtitle =>
      'हम उसकी प्रोफ़ाइल और फ़ोटो इस्तेमाल करेंगे, आपको कुछ भी दोबारा नहीं लिखना होगा।';

  @override
  String get stepWhereFoundTitle => 'आपको यह कहाँ मिला?';

  @override
  String stepWhereLostTitle(String pet) {
    return '$pet को आख़िरी बार कहाँ देखा गया था?';
  }

  @override
  String get stepWhereSubtitle =>
      'शहर चुनें, फिर मैप पर जगह चिह्नित करें। लोगों को सिर्फ़ लगभग 100 मी का इलाका दिखता है, सटीक पता कभी नहीं।';

  @override
  String get streetOrLandmark => 'सड़क या पहचान की जगह';

  @override
  String get pinExactSpot => 'सटीक जगह चिह्नित करें';

  @override
  String spotHintFound(String pet) {
    return 'मैप को खिसकाएँ ताकि पिन वहाँ हो जहाँ आपको $pet मिला।';
  }

  @override
  String spotHintLost(String pet) {
    return 'मैप को खिसकाएँ ताकि पिन वहाँ हो जहाँ $pet को आख़िरी बार देखा गया।';
  }

  @override
  String spotFarFromCity(int km, String city) {
    return 'यह जगह $city से $km किमी दूर है। क्या शहर सही है?';
  }

  @override
  String spotPinned(int meters) {
    return 'चिह्नित हो गया। लोगों को इसके आस-पास सिर्फ़ लगभग $meters मी का इलाका दिखता है, सटीक जगह कभी नहीं।';
  }

  @override
  String get timeHourAgo => '1 घंटा पहले';

  @override
  String get timeThisMorning => 'आज सुबह';

  @override
  String get stepWhenFoundTitle => 'आपको यह कब मिला?';

  @override
  String stepWhenLostTitle(String pet) {
    return 'आपने $pet को आख़िरी बार कब देखा?';
  }

  @override
  String get stepWhenSubtitle => 'अंदाज़न समय भी चलेगा।';

  @override
  String get changeDate => 'तारीख़ बदलें';

  @override
  String get changeTime => 'समय बदलें';

  @override
  String get stepDetailsTitle => 'और कुछ जो हमें जानना चाहिए?';

  @override
  String get stepDetailsSubtitle =>
      'जानकारी से पड़ोसी पालतू को पहचान पाते हैं और आपसे जल्दी संपर्क कर पाते हैं।';

  @override
  String descriptionHintLost(String pet) {
    return 'पट्टे का रंग, स्वभाव, $pet कैसे खोया…';
  }

  @override
  String get descriptionHintFound => 'हालत, पट्टा, व्यवहार, ठीक कहाँ मिला…';

  @override
  String get howToReachYou => 'लोग आपसे कैसे संपर्क करें?';

  @override
  String get contactPrivacyNote =>
      'सिर्फ़ रिपोर्ट पेज पर दिखेगा, सूचियों में कभी नहीं।';

  @override
  String get phoneHint => 'फ़ोन, जैसे +39 333 123 4567';

  @override
  String get reachableOnWhatsapp => 'WhatsApp पर उपलब्ध';

  @override
  String get reachableOnWhatsappHint => 'लोग आपको इस नंबर पर मैसेज कर सकते हैं';

  @override
  String get stepReviewTitle => 'पोस्ट करने के लिए तैयार?';

  @override
  String get stepReviewSubtitle =>
      'आस-पास के लोगों को आपकी रिपोर्ट ऐसी दिखेगी।';

  @override
  String get iLostMyPet => 'मेरा पालतू खो गया';

  @override
  String get iFoundAPet => 'मुझे एक पालतू मिला';

  @override
  String get iLostMyPetHint =>
      'आस-पास के लोगों को बताएँ और खोजने में मदद पाएँ।';

  @override
  String get iFoundAPetHint => 'किसी खोए पालतू को घर पहुँचाने में मदद करें।';

  @override
  String get addAPet => 'पालतू जोड़ें';

  @override
  String get pleaseChooseCity => 'कृपया शहर चुनें';

  @override
  String noPlacesFound(String city, String query) {
    return '$city में \"$query\" के लिए कोई जगह नहीं मिली।';
  }

  @override
  String searchStreetHint(String city) {
    return '$city में खोजें, जैसे Via Dante';
  }

  @override
  String get yourCity => 'आपका शहर';

  @override
  String get useMyLocation => 'मेरी लोकेशन इस्तेमाल करें';

  @override
  String get publishFailed => 'आपकी रिपोर्ट पोस्ट नहीं हो सकी। फिर कोशिश करें।';

  @override
  String get updateReportFailed => 'रिपोर्ट अपडेट नहीं हो सकी। फिर कोशिश करें।';

  @override
  String get deleteReportFailed => 'रिपोर्ट हटाई नहीं जा सकी। फिर कोशिश करें।';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get termsOfUse => 'उपयोग की शर्तें';

  @override
  String legalLastUpdated(String date) {
    return 'अंतिम अपडेट: $date';
  }

  @override
  String get deleteAccountPasswordPrompt =>
      'पुष्टि करने के लिए अपना पासवर्ड लिखें।';

  @override
  String deleteAccountTypeConfirm(String word) {
    return 'पुष्टि करने के लिए $word लिखें।';
  }

  @override
  String get wrongPassword => 'गलत पासवर्ड। फिर कोशिश करें।';

  @override
  String get confirmPasswordAgain =>
      'आपकी सुरक्षा के लिए, कृपया अपना पासवर्ड फिर से पुष्टि करें।';

  @override
  String get contactUs => 'हमसे संपर्क करें';

  @override
  String get legalQuestions =>
      'इस दस्तावेज़ या अपने डेटा के बारे में सवाल हैं?';
}
