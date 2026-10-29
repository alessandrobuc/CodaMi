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

  @override
  String get languageChangeLater =>
      'आप इसे कभी भी अपनी प्रोफ़ाइल में बदल सकते हैं।';

  @override
  String get reward => 'इनाम';

  @override
  String get rewardHint => 'राशि यूरो में';

  @override
  String get rewardNote =>
      'इनाम मालिक और पालतू ढूँढने वाले के बीच एक निजी समझौता है। CodaMi किसी भुगतान की गारंटी नहीं देता और न ही उसे संसाधित करता है।';

  @override
  String rewardAmount(String amount) {
    return 'इनाम $amount';
  }

  @override
  String get adminPanel => 'एडमिन पैनल';

  @override
  String get roleAdmin => 'एडमिन';

  @override
  String get roleSupport => 'सपोर्ट';

  @override
  String get supportStaff => 'सपोर्ट टीम';

  @override
  String get supportStaffSubtitle => 'सपोर्ट अनुरोधों का जवाब देने वाले लोग';

  @override
  String get adminUsers => 'उपयोगकर्ता';

  @override
  String get adminListings => 'लिस्टिंग';

  @override
  String get adminReportedContent => 'रिपोर्ट की गई सामग्री';

  @override
  String get adminTickets => 'सपोर्ट अनुरोध';

  @override
  String get adminVideos => 'वीडियो';

  @override
  String get addSupportStaff => 'सपोर्ट में जोड़ें';

  @override
  String get addSupportStaffHint =>
      'किसी मौजूदा CodaMi खाते का ईमेल दर्ज करें।';

  @override
  String get userNotFound => 'इस ईमेल से कोई CodaMi खाता नहीं है।';

  @override
  String get alreadyStaff => 'यह व्यक्ति पहले से टीम में है।';

  @override
  String staffAdded(String name) {
    return '$name अब सपोर्ट टीम में है।';
  }

  @override
  String removeStaffTitle(String name) {
    return '$name को हटाएँ?';
  }

  @override
  String get removeStaffMessage =>
      'उनके पास अब एडमिन पैनल की पहुँच नहीं रहेगी।';

  @override
  String get noSupportStaff => 'सपोर्ट टीम में अभी कोई नहीं है।';

  @override
  String get add => 'जोड़ें';

  @override
  String get actionFailed => 'कुछ गलत हो गया। कृपया फिर से कोशिश करें।';

  @override
  String get adminDashboard => 'डैशबोर्ड';

  @override
  String get adminMore => 'और';

  @override
  String get adminReportedShort => 'रिपोर्ट किए गए';

  @override
  String get adminTicketsShort => 'अनुरोध';

  @override
  String get adminSectionSoon => 'यह सेक्शन जल्द आ रहा है।';

  @override
  String get statUsers => 'पंजीकृत उपयोगकर्ता';

  @override
  String get statOpenLost => 'खुली गुमशुदगी रिपोर्ट';

  @override
  String get statOpenFound => 'खुली मिले पालतू रिपोर्ट';

  @override
  String get statBackHome => 'घर लौटे पालतू';

  @override
  String get flagListing => 'लिस्टिंग की शिकायत करें';

  @override
  String get flagTitle => 'आप इस लिस्टिंग की शिकायत क्यों कर रहे हैं?';

  @override
  String get flagHint =>
      'हमारी टीम इसकी जाँच करेगी। मालिक को पता नहीं चलेगा कि शिकायत किसने की।';

  @override
  String get flagReasonSpam => 'स्पैम या विज्ञापन';

  @override
  String get flagReasonScam => 'धोखाधड़ी';

  @override
  String get flagReasonInappropriate => 'अनुचित सामग्री';

  @override
  String get flagReasonWrongInfo => 'गलत या भ्रामक जानकारी';

  @override
  String get flagReasonOther => 'कुछ और';

  @override
  String get flagNoteHint => 'विवरण जोड़ें (वैकल्पिक)';

  @override
  String get flagSubmit => 'शिकायत भेजें';

  @override
  String get flagSent => 'धन्यवाद। हमारी टीम इस लिस्टिंग की जाँच करेगी।';

  @override
  String get alreadyFlagged => 'आप पहले ही इस लिस्टिंग की शिकायत कर चुके हैं।';

  @override
  String blockUser(String name) {
    return '$name को ब्लॉक करें';
  }

  @override
  String blockUserTitle(String name) {
    return '$name को ब्लॉक करें?';
  }

  @override
  String get blockUserMessage =>
      'आपको उनकी लिस्टिंग नहीं दिखेंगी और उनके बारे में अलर्ट नहीं मिलेंगे। आप प्रोफ़ाइल → ब्लॉक किए गए उपयोगकर्ता में अनब्लॉक कर सकते हैं।';

  @override
  String get block => 'ब्लॉक करें';

  @override
  String userBlocked(String name) {
    return '$name को ब्लॉक कर दिया गया।';
  }

  @override
  String get blockedUsers => 'ब्लॉक किए गए उपयोगकर्ता';

  @override
  String get noBlockedUsers => 'आपने किसी को ब्लॉक नहीं किया है।';

  @override
  String get unblock => 'अनब्लॉक करें';

  @override
  String userUnblocked(String name) {
    return '$name को अनब्लॉक कर दिया गया।';
  }

  @override
  String get unknownUser => 'अज्ञात उपयोगकर्ता';

  @override
  String get hiddenListing => 'छिपाई गई';

  @override
  String get hiddenListingNotice =>
      'CodaMi टीम ने यह लिस्टिंग छिपा दी है और अब यह सार्वजनिक नहीं है।';

  @override
  String get moderation => 'मॉडरेशन';

  @override
  String get noFlagsOnListing => 'किसी ने इस लिस्टिंग की शिकायत नहीं की है।';

  @override
  String flagCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count बार शिकायत',
      one: '1 बार शिकायत',
    );
    return '$_temp0';
  }

  @override
  String get dismissFlags => 'शिकायतें खारिज करें';

  @override
  String get flagsDismissed => 'शिकायतें खारिज कर दी गईं।';

  @override
  String get hideListing => 'लिस्टिंग छिपाएँ';

  @override
  String get restoreListing => 'लिस्टिंग वापस लाएँ';

  @override
  String get listingHidden =>
      'लिस्टिंग छिपा दी गई। अब केवल मालिक इसे देख सकता है।';

  @override
  String get listingRestored => 'लिस्टिंग वापस आ गई।';

  @override
  String get deleteListing => 'लिस्टिंग हटाएँ';

  @override
  String get deleteListingTitle => 'यह लिस्टिंग हटाएँ?';

  @override
  String get deleteListingMessage =>
      'लिस्टिंग और उसकी फ़ोटो सभी के लिए हटा दी जाएँगी। इसे पूर्ववत नहीं किया जा सकता।';

  @override
  String get listingDeleted => 'लिस्टिंग हटा दी गई।';

  @override
  String get listingUnavailable => 'लिस्टिंग अब उपलब्ध नहीं है';

  @override
  String get noReportedContent => 'कोई शिकायत नहीं';

  @override
  String get noReportedContentMessage =>
      'उपयोगकर्ताओं द्वारा शिकायत की गई लिस्टिंग यहाँ दिखेंगी।';

  @override
  String get filterOpen => 'खुली';

  @override
  String get filterResolved => 'हल हो चुकी';

  @override
  String get filterHidden => 'छिपाई गई';

  @override
  String get noListings => 'कोई लिस्टिंग नहीं';

  @override
  String get tryAnotherFilter => 'कोई दूसरा फ़िल्टर आज़माएँ।';

  @override
  String get adminUsersSubtitle => 'खाते देखें, बंद करें या हटाएँ';

  @override
  String get searchByEmail => 'ईमेल से खोजें';

  @override
  String get noUsersFound => 'कोई उपयोगकर्ता नहीं मिला।';

  @override
  String get roleUser => 'उपयोगकर्ता';

  @override
  String get userDisabled => 'बंद';

  @override
  String get phone => 'फ़ोन';

  @override
  String get memberSince => 'सदस्य कब से';

  @override
  String get disableAccount => 'खाता बंद करें';

  @override
  String get enableAccount => 'खाता चालू करें';

  @override
  String disableUserTitle(String name) {
    return '$name का खाता बंद करें?';
  }

  @override
  String get disableUserMessage =>
      'उन्हें साइन आउट कर दिया जाएगा और वे लॉग इन नहीं कर पाएँगे। खाता फिर से चालू होने तक उनकी खुली लिस्टिंग छिपी रहेंगी।';

  @override
  String get accountDisabled => 'खाता बंद कर दिया गया।';

  @override
  String get accountEnabled => 'खाता चालू कर दिया गया।';

  @override
  String deleteUserTitle(String name) {
    return '$name का खाता हटाएँ?';
  }

  @override
  String get deleteUserMessage =>
      'उनकी प्रोफ़ाइल, पालतू जानवर, लिस्टिंग और फ़ोटो हमेशा के लिए हटा दी जाएँगी। इसे पूर्ववत नहीं किया जा सकता।';

  @override
  String get userDeleted => 'खाता हटा दिया गया।';

  @override
  String get save => 'सहेजें';

  @override
  String get requiredField => 'आवश्यक';

  @override
  String get notificationSettingsIntro =>
      'चुनें कि आपको कौन-से अलर्ट मिलें और हर एक को अपनी अलग आवाज़ दें, ताकि देखने से पहले ही पता चल जाए कि क्या हुआ।';

  @override
  String get notificationSound => 'आवाज़';

  @override
  String get alertLostTitle => 'आस-पास खोए पालतू जानवर';

  @override
  String get alertLostDescription => 'जब आपके शहर में कोई पालतू जानवर खो जाए';

  @override
  String get alertFoundTitle => 'आस-पास मिले पालतू जानवर';

  @override
  String get alertFoundDescription => 'जब कोई आपके शहर में पालतू जानवर पाए';

  @override
  String get alertResolvedTitle => 'खुशखबरी';

  @override
  String get alertResolvedDescription =>
      'जब खोया या मिला पालतू जानवर घर लौट आए';

  @override
  String get soundDefault => 'फ़ोन की डिफ़ॉल्ट';

  @override
  String get soundSilent => 'साइलेंट';

  @override
  String get soundChime => 'चाइम';

  @override
  String get soundBell => 'घंटी';

  @override
  String get soundBright => 'चमकीली';

  @override
  String get soundSoft => 'कोमल';

  @override
  String get soundCustom => 'कस्टम आवाज़';

  @override
  String get soundFromPhone => 'आपके फ़ोन की रिंगटोन और टोन';

  @override
  String get soundFromFile => 'संगीत या ऑडियो फ़ाइल';

  @override
  String get soundIosNote =>
      'iPhone पर नोटिफ़िकेशन की आवाज़ ऐप से ही होनी चाहिए, इसलिए ऊपर दी गई आवाज़ों में से एक चुनें।';

  @override
  String get soundPickFailed =>
      'यह आवाज़ इस्तेमाल नहीं हो सकी। कृपया कोई दूसरी चुनें।';

  @override
  String get videosForYou => 'आपके लिए वीडियो';

  @override
  String get videosForYourPets => 'आपके पालतू जानवरों के लिए चुने गए';

  @override
  String get videosGeneral => 'पशु कल्याण और ज़िम्मेदार देखभाल';

  @override
  String get videosShuffle => 'दूसरे वीडियो दिखाएँ';

  @override
  String get videoMotivational => 'प्रेरणा';

  @override
  String get videoEducational => 'सीखें';

  @override
  String get videoTagGeneral => 'सभी के लिए';

  @override
  String get videoLoadError =>
      'यह वीडियो अभी नहीं चल सकता। कृपया बाद में फिर कोशिश करें।';

  @override
  String get adminVideosSubtitle => 'वीडियो अपलोड और मैनेज करें';

  @override
  String get addVideo => 'वीडियो जोड़ें';

  @override
  String get editVideo => 'वीडियो बदलें';

  @override
  String get noVideosYet =>
      'अभी कोई वीडियो नहीं है। नीचे दिए बटन से पहला वीडियो जोड़ें।';

  @override
  String get deleteVideoTitle => 'यह वीडियो हटाएँ?';

  @override
  String get deleteVideoMessage =>
      'यह सभी के लिए ऐप से हट जाएगा। इसे वापस नहीं किया जा सकता।';

  @override
  String get videoHidden => 'छिपा हुआ';

  @override
  String get allLanguages => 'सभी भाषाएँ';

  @override
  String get chooseVideo => 'वीडियो चुनें';

  @override
  String get chooseVideoHint =>
      'गैलरी से, 200 MB तक। छोटे वीडियो (2 मिनट से कम) सबसे अच्छे रहते हैं।';

  @override
  String get videoTitle => 'शीर्षक';

  @override
  String get videoType => 'प्रकार';

  @override
  String get videoAnimals => 'जानवर';

  @override
  String get videoAnimalsHint =>
      'चुनें कि यह वीडियो किन जानवरों के बारे में है। सभी उपयोगकर्ताओं को दिखने वाले सामान्य वीडियो के लिए \"सभी के लिए\" चुनें।';

  @override
  String get videoVisible => 'ऐप में दिखाएँ';

  @override
  String get videoVisibleHint => 'छिपे हुए वीडियो केवल एडमिन देख सकते हैं।';

  @override
  String get videoTooLarge =>
      'यह वीडियो 200 MB से बड़ा है। कृपया छोटा वीडियो चुनें।';

  @override
  String get videoSaved => 'वीडियो सहेजा गया।';

  @override
  String uploadingProgress(int percent) {
    return 'अपलोड हो रहा है… $percent%';
  }

  @override
  String get navVideos => 'वीडियो';

  @override
  String get videosEmptyTitle => 'वीडियो जल्द आ रहे हैं';

  @override
  String get videosEmptyMessage =>
      'जल्द ही यहाँ आपके जानवरों की देखभाल पर छोटे वीडियो मिलेंगे।';

  @override
  String get moreVideos => 'और वीडियो';

  @override
  String get videoWatched => 'देखा गया';

  @override
  String get videoBack10 => '10 सेकंड पीछे';

  @override
  String get videoForward10 => '10 सेकंड आगे';

  @override
  String get videoFullscreen => 'फ़ुल स्क्रीन';

  @override
  String get videoExitFullscreen => 'फ़ुल स्क्रीन बंद करें';

  @override
  String get videoRetry => 'फिर कोशिश करें';

  @override
  String get videoDeleted => 'वीडियो हटाया गया।';

  @override
  String get noVideosYetTitle => 'अभी कोई वीडियो नहीं';

  @override
  String get videoVisibleShort => 'दिखने वाले';

  @override
  String get play => 'चलाएँ';

  @override
  String get edit => 'बदलें';

  @override
  String get change => 'बदलें';

  @override
  String get videoSectionFile => 'वीडियो';

  @override
  String get videoSectionDetails => 'विवरण';

  @override
  String get videoSectionAudience => 'कौन देखेगा';

  @override
  String get videoCover => 'कवर इमेज';

  @override
  String get videoCoverHint => 'वैकल्पिक। वीडियो कार्ड पर दिखती है।';

  @override
  String get videoMotivationalHint => 'प्रेरक कहानियाँ और खुशी के पल';

  @override
  String get videoEducationalHint => 'मालिकों के लिए टिप्स और तरीके';

  @override
  String get uploadVideo => 'वीडियो अपलोड करें';

  @override
  String get helpSupport => 'मदद और सहायता';

  @override
  String get helpSupportSubtitle => 'हमसे चैट करें या अनुरोध भेजें';

  @override
  String get supportIntroTitle => 'हम कैसे मदद कर सकते हैं?';

  @override
  String get supportIntroMessage =>
      'हमारी टीम यहीं ऐप में जवाब देती है। जवाब आने पर आपको सूचना मिलेगी।';

  @override
  String get supportStartChat => 'लाइव चैट शुरू करें';

  @override
  String get supportStartChatOnline => 'अभी एक ऑपरेटर ऑनलाइन है';

  @override
  String get supportChatOffline =>
      'अभी कोई ऑपरेटर ऑनलाइन नहीं है। अनुरोध भेजें, हम जल्द से जल्द जवाब देंगे।';

  @override
  String get supportSendRequest => 'अनुरोध भेजें';

  @override
  String get supportSendRequestSubtitle =>
      'हम आमतौर पर 24 घंटे में जवाब देते हैं';

  @override
  String get supportMyRequests => 'मेरे अनुरोध';

  @override
  String get supportNoRequests => 'अभी कोई अनुरोध नहीं';

  @override
  String get supportNoRequestsMessage =>
      'सहायता टीम से आपकी बातचीत यहाँ दिखेगी।';

  @override
  String get supportNewChat => 'नई लाइव चैट';

  @override
  String get supportNewRequest => 'नया अनुरोध';

  @override
  String get supportCategory => 'विषय';

  @override
  String get categoryAccount => 'खाता और लॉगिन';

  @override
  String get categoryListing => 'खोई या मिली पोस्ट';

  @override
  String get categoryApp => 'ऐप में समस्या';

  @override
  String get categoryOther => 'कुछ और';

  @override
  String get supportSubject => 'शीर्षक';

  @override
  String get supportSubjectHint => 'कुछ शब्दों में';

  @override
  String get supportSubjectTooShort => 'कम से कम 3 अक्षर लिखें';

  @override
  String get supportMessage => 'संदेश';

  @override
  String get supportMessageHint => 'बताइए क्या हुआ';

  @override
  String get supportMessageRequired => 'कृपया संदेश लिखें';

  @override
  String get supportSend => 'भेजें';

  @override
  String get supportTooManyOpen =>
      'आपके पहले से 3 खुले अनुरोध हैं। कृपया उन्हीं में से किसी में जारी रखें।';

  @override
  String get supportTypeMessage => 'संदेश लिखें…';

  @override
  String get supportTeam => 'CodaMi सहायता';

  @override
  String get supportMarkSolved => 'हल हुआ चिह्नित करें';

  @override
  String get supportMarkSolvedConfirm =>
      'इस अनुरोध को हल हुआ चिह्नित करें? ज़रूरत हो तो आप फिर से लिख सकते हैं।';

  @override
  String get supportClosedNote =>
      'यह अनुरोध बंद है। और मदद चाहिए तो नया शुरू करें।';

  @override
  String get supportResolvedNote =>
      'हल हुआ चिह्नित है। फिर से लिखने पर यह दोबारा खुल जाएगा।';

  @override
  String get supportWaitingNote => 'धन्यवाद! हमारी टीम जल्द यहाँ जवाब देगी।';

  @override
  String get kindChat => 'लाइव चैट';

  @override
  String get kindTicket => 'अनुरोध';

  @override
  String get caseStatusOpen => 'खुला';

  @override
  String get caseStatusInProgress => 'प्रगति में';

  @override
  String get caseStatusWaitingUser => 'जवाब का इंतज़ार';

  @override
  String get caseStatusResolved => 'हल हुआ';

  @override
  String get caseStatusClosed => 'बंद';

  @override
  String get filterUnanswered => 'बिना जवाब';

  @override
  String get filterUnassigned => 'असाइन नहीं';

  @override
  String get filterMine => 'मेरे';

  @override
  String get filterActive => 'सक्रिय';

  @override
  String get filterDone => 'पूरे';

  @override
  String get supportSearchHint => 'CM-1042 या ईमेल खोजें';

  @override
  String get supportNoCases => 'यहाँ कोई अनुरोध नहीं';

  @override
  String get supportNoCasesMessage => 'इस सूची में कुछ भी बाकी नहीं है।';

  @override
  String get supportTake => 'यह केस लें';

  @override
  String get supportTakeToReply => 'जवाब देने के लिए यह केस लें।';

  @override
  String get supportAlreadyTaken =>
      'किसी दूसरे ऑपरेटर ने यह केस पहले ही ले लिया है।';

  @override
  String get supportUnassigned => 'असाइन नहीं';

  @override
  String get supportReassign => 'दोबारा असाइन करें';

  @override
  String get supportAssignTo => 'इन्हें असाइन करें';

  @override
  String get supportBackToQueue => 'कतार में वापस';

  @override
  String get supportChangeStatus => 'स्थिति बदलें';

  @override
  String get supportChat => 'चैट';

  @override
  String get supportTimeline => 'टाइमलाइन';

  @override
  String get supportDetails => 'विवरण';

  @override
  String supportWaitingFor(String time) {
    return '$time से इंतज़ार';
  }

  @override
  String get supportOverdue => 'जवाब में देर';

  @override
  String get supportOpened => 'खुला';

  @override
  String get supportTakenOver => 'लिया गया';

  @override
  String get supportWaitToTake => 'लेने से पहले इंतज़ार';

  @override
  String get supportFirstReply => 'पहला जवाब';

  @override
  String get supportAvgReply => 'औसत जवाब समय';

  @override
  String get supportHandlingTime => 'लगा समय';

  @override
  String get supportResolvedAt => 'हल हुआ';

  @override
  String get supportMessagesCount => 'संदेश';

  @override
  String get supportOperator => 'ऑपरेटर';

  @override
  String get supportUserLabel => 'उपयोगकर्ता';

  @override
  String eventCreated(String name) {
    return '$name ने खोला';
  }

  @override
  String eventTaken(String name) {
    return '$name ने लिया';
  }

  @override
  String eventReassigned(String from, String to) {
    return '$from से $to को दोबारा असाइन किया';
  }

  @override
  String eventStatus(String name, String status) {
    return '$name ने स्थिति $status की';
  }

  @override
  String get eventReopened => 'उपयोगकर्ता ने दोबारा खोला';

  @override
  String get eventOverdue => 'समय सीमा में जवाब नहीं';

  @override
  String get eventAutoClosed => 'अपने आप बंद हुआ';

  @override
  String get presenceOnline => 'ऑनलाइन';

  @override
  String get presenceAway => 'दूर';

  @override
  String get presenceOffline => 'ऑफ़लाइन';

  @override
  String get presenceAvailable => 'लाइव चैट के लिए उपलब्ध';

  @override
  String get presenceAvailableSubtitle =>
      'किसी ऑपरेटर के ऑनलाइन रहने पर उपयोगकर्ता लाइव चैट शुरू कर सकते हैं';

  @override
  String get supportOperators => 'ऑपरेटर';

  @override
  String get supportOperatorsSubtitle => 'गतिविधि, केस और जवाब का समय';

  @override
  String get operatorOpenCases => 'खुले केस';

  @override
  String get operatorTaken => 'लिए गए';

  @override
  String get operatorResolved => 'हल किए';

  @override
  String get operatorReplies => 'जवाब';

  @override
  String get operatorAvgHandling => 'प्रति केस औसत समय';

  @override
  String operatorLastActive(String time) {
    return 'आख़िरी गतिविधि $time';
  }

  @override
  String get operatorCases => 'केस';

  @override
  String get noOperators =>
      'अभी कोई सहायता स्टाफ़ नहीं। उन्हें सहायता स्टाफ़ में जोड़ें।';

  @override
  String get statUnassigned => 'असाइन न किए गए अनुरोध';

  @override
  String get statUnanswered => 'बिना जवाब के अनुरोध';

  @override
  String get statOverdue => 'देर से जवाब';

  @override
  String get alertSupportTitle => 'सहायता के जवाब';

  @override
  String get alertSupportDescription => 'जब CodaMi सहायता आपको लिखे';

  @override
  String durationSeconds(int n) {
    return '$n सेकंड';
  }

  @override
  String durationMinutes(int n) {
    return '$n मिनट';
  }

  @override
  String durationHours(int h, int m) {
    return '$h घंटे $m मिनट';
  }

  @override
  String durationDays(int d, int h) {
    return '$d दिन $h घंटे';
  }

  @override
  String get searchUsersHint => 'नाम या ईमेल से खोजें';

  @override
  String get searchTooShort => 'कम से कम 2 अक्षर लिखें';

  @override
  String get pickStaffTitle => 'उपयोगकर्ता चुनें';

  @override
  String get pickStaffHint =>
      'किसी व्यक्ति को सहायता टीम में जोड़ने के लिए टैप करें।';

  @override
  String makeStaffTitle(String name) {
    return '$name को सहायता स्टाफ़ बनाएँ?';
  }

  @override
  String get makeStaffMessage =>
      'वे एडमिन सेक्शन देख पाएँगे और अनुरोधों व चैट का जवाब दे सकेंगे। आप उन्हें कभी भी हटा सकते हैं।';

  @override
  String get makeStaff => 'टीम में जोड़ें';

  @override
  String get supportStaffSwitch => 'सहायता स्टाफ़';

  @override
  String get supportStaffSwitchSubtitle =>
      'अनुरोधों और चैट का जवाब दे सकते हैं';

  @override
  String staffRemoved(String name) {
    return '$name अब सहायता टीम में नहीं हैं।';
  }

  @override
  String get removeStaffCasesNote => 'उनके खुले केस कतार में वापस चले जाएँगे।';

  @override
  String get pushOpen => 'खोलें';

  @override
  String get chatToday => 'आज';

  @override
  String get chatLoadEarlier => 'पुराने संदेश लोड करें';

  @override
  String get supportPeople => 'लोग';

  @override
  String get supportTimes => 'समय';

  @override
  String get supportRequestInfo => 'अनुरोध';

  @override
  String get supportType => 'प्रकार';

  @override
  String get supportResolve => 'हल हुआ चिह्नित करें';

  @override
  String ticketsWaiting(int count) {
    return '$count जवाब का इंतज़ार कर रहे हैं';
  }

  @override
  String get ticketsAllClear => 'सब निपट गया';

  @override
  String get photoReviewHint =>
      'AI द्वारा रोकी गई फ़ोटो। आपके फ़ैसले तक ये छिपी रहेंगी।';

  @override
  String get reasonAdult => 'नग्नता या यौन सामग्री';

  @override
  String get reasonRacy => 'उत्तेजक सामग्री';

  @override
  String get reasonViolence => 'हिंसा या ख़ून';

  @override
  String get likelihoodPossible => 'संभव';

  @override
  String get likelihoodLikely => 'संभावित';

  @override
  String get likelihoodVeryLikely => 'बहुत संभावित';

  @override
  String get hiddenByAi => 'AI ने छिपाई';

  @override
  String get petPhoto => 'पालतू की फ़ोटो';

  @override
  String get listingPhoto => 'विज्ञापन की फ़ोटो';

  @override
  String uploadedBy(String name) {
    return '$name द्वारा';
  }

  @override
  String get tapToView => 'देखने के लिए टैप करें';

  @override
  String get approvePhoto => 'मंज़ूर करें';

  @override
  String get removePhotoTitle => 'यह फ़ोटो हटाएँ?';

  @override
  String get removePhotoMessage =>
      'इसे उपयोगकर्ता के पालतू या विज्ञापन से हटा दिया जाएगा, और उपयोगकर्ता को कारण बताया जाएगा।';

  @override
  String get photoApproved => 'फ़ोटो मंज़ूर की गई';

  @override
  String get photoRemovedDone => 'फ़ोटो हटाई गई';

  @override
  String get photoUnderReview =>
      'हमारी टीम एक फ़ोटो की जाँच कर रही है, तब तक वह छिपी रहेगी।';

  @override
  String get reportedTabPhotos => 'AI फ़ोटो';

  @override
  String get reportedTabReports => 'उपयोगकर्ता रिपोर्ट';

  @override
  String get noPhotosToReview => 'जाँच के लिए कोई फ़ोटो नहीं';

  @override
  String get noPhotosToReviewMessage => 'AI द्वारा रोकी गई फ़ोटो यहाँ दिखेंगी।';

  @override
  String get aFriend => 'एक दोस्त';

  @override
  String get addContact => 'संपर्क जोड़ें';

  @override
  String get addTestContacts => 'टेस्ट संपर्क जोड़ें';

  @override
  String get adjustPoints => 'पॉइंट बदलें';

  @override
  String get adjustPointsAmount => 'जोड़ने या घटाने के पॉइंट';

  @override
  String get adjustPointsAmountHelp =>
      'पॉइंट घटाने के लिए माइनस लगाएँ, जैसे -20';

  @override
  String get adjustPointsInvalid => 'पॉइंट की संख्या और कारण लिखें।';

  @override
  String get adjustPointsReason => 'कारण (उपयोगकर्ता को दिखेगा)';

  @override
  String get adminContactsSubtitle =>
      'उपयोगकर्ताओं को दिखने वाले पशु-चिकित्सक, संस्थाएँ और सेवाएँ';

  @override
  String get adminEmergenciesSubtitle =>
      'रिपोर्ट की गई जानवरों की आपात स्थितियाँ';

  @override
  String get alertEmergencyDescription =>
      'आपके शहर के पास जिन जानवरों को तुरंत मदद चाहिए';

  @override
  String get alertEmergencyTitle => 'पास की आपात स्थितियाँ';

  @override
  String get allContacts => 'सभी';

  @override
  String get ambassadorLevels => 'राजदूत स्तर';

  @override
  String get call112 => '112 पर कॉल करें';

  @override
  String get claim => 'लें';

  @override
  String get claimed => 'मिल गए';

  @override
  String get codeCopied => 'कोड कॉपी हो गया';

  @override
  String get confirm => 'पुष्टि करें';

  @override
  String get contactActive => 'उपयोगकर्ताओं को दिखाएँ';

  @override
  String get contactActiveHelp => 'बिना हटाए संपर्क छिपाने के लिए बंद करें।';

  @override
  String get contactAddress => 'पता';

  @override
  String get contactAreaKm => 'सेवा क्षेत्र (किमी)';

  @override
  String get contactAreaKmHelp =>
      'पते से कितनी दूरी तक मदद कर सकता है। ख़ाली छोड़ें तो आपात सेटिंग का डिफ़ॉल्ट मान लगेगा।';

  @override
  String get contactCity => 'शहर या कस्बा';

  @override
  String get contactHandles => 'कौन-सी आपात स्थितियाँ संभालता है';

  @override
  String get contactHandlesHelp =>
      'अगर हर तरह की स्थिति संभालता है तो सब बंद छोड़ दें।';

  @override
  String get contactHoursHint => 'खुलने का समय, जैसे सोम–शुक्र 9:00–18:00';

  @override
  String get contactInactive => 'छिपा हुआ';

  @override
  String get contactKindAssociation => 'पशु कल्याण संस्था';

  @override
  String get contactKindOther => 'अन्य सेवा';

  @override
  String get contactKindPublicService => 'सरकारी पशु-चिकित्सा सेवा';

  @override
  String get contactKindVet => 'पशु-चिकित्सक';

  @override
  String get contactMissingFields => 'नाम लिखें और नक्शे पर पिन लगाएँ।';

  @override
  String get contactName => 'नाम';

  @override
  String get contactNameHint => 'जैसे सैन फ्रांसेस्को पशु क्लिनिक';

  @override
  String get contactPhones => 'फ़ोन नंबर';

  @override
  String get contactPhonesHint => 'नंबरों को कॉमा से अलग करें';

  @override
  String get contactPlace => 'कहाँ है';

  @override
  String get contactRecommendedHelp =>
      'आपात स्थिति रिपोर्ट होने पर पास के संपर्कों से पहले दिखता है।';

  @override
  String get contactTestHelp =>
      'टेस्ट के लिए नमूना संपर्क। TEST लेबल के साथ दिखता है, कभी सत्यापित नहीं होता और ईमेल नहीं जाता।';

  @override
  String get contactType => 'प्रकार';

  @override
  String get contactVerifiedHelp =>
      'तभी चालू करें जब संस्था सूची में आने के लिए राज़ी हो और जानकारी जाँच ली गई हो।';

  @override
  String get copyCode => 'कॉपी करें';

  @override
  String get dailyActive => 'आज सक्रिय';

  @override
  String get dailyCheckin => 'रोज़ाना चेक-इन';

  @override
  String get dailyRewards => 'रोज़ाना इनाम';

  @override
  String get deleteContactTitle => 'यह संपर्क हटाएँ?';

  @override
  String get directions => 'रास्ता';

  @override
  String get editContact => 'संपर्क बदलें';

  @override
  String get emergencies => 'आपात स्थितियाँ';

  @override
  String get emergenciesActive => 'सक्रिय';

  @override
  String get emergenciesAll => 'सभी';

  @override
  String get emergenciesNearYou => 'आपके पास';

  @override
  String get emergenciesSubtitle => 'जिन जानवरों को तुरंत मदद चाहिए';

  @override
  String get emergencyAddPhotos => 'फ़ोटो जोड़ें';

  @override
  String get emergencyAddPhotosHint =>
      'दूसरों को जानवर ढूँढने और पहचानने में मदद मिलती है';

  @override
  String get emergencyAllContacts => 'सभी आपात संपर्क देखें';

  @override
  String get emergencyAlreadyReported => 'आप पहले ही रिपोर्ट कर चुके हैं।';

  @override
  String get emergencyCallReporter => 'रिपोर्ट करने वाले को कॉल करें';

  @override
  String get emergencyClose => 'बंद करें';

  @override
  String get emergencyCloseTitle => 'यह आपात स्थिति बंद करें?';

  @override
  String get emergencyContacts => 'आपात संपर्क';

  @override
  String get emergencyDetails => 'क्या हो रहा है?';

  @override
  String get emergencyDetailsHint =>
      'जैसे कुत्ते को गाड़ी ने टक्कर मारी, सड़क किनारे पड़ा है, साँस ले रहा है';

  @override
  String get emergencyDetailsRequired => 'कुछ शब्दों में स्थिति बताएँ।';

  @override
  String get emergencyDisclaimer =>
      'CodaMi आपात सेवा नहीं है। अगर जानवर तुरंत ख़तरे में है, तो पहले 112 या किसी पशु-चिकित्सक को कॉल करें। सिर्फ़ ऐप की सूचनाओं पर निर्भर न रहें।';

  @override
  String get emergencyFalseAlarmTitle => 'झूठा अलार्म मानें?';

  @override
  String get emergencyFindingContacts =>
      'इस जगह के पास संपर्क खोजे जा रहे हैं…';

  @override
  String get emergencyHelpDone =>
      'धन्यवाद! रिपोर्ट करने वाले को बता दिया गया है।';

  @override
  String get emergencyHelpMessage =>
      'रिपोर्ट करने वाले को पता चलेगा कि कोई आ रहा है। तभी जाएँ जब यह आपके लिए सुरक्षित हो।';

  @override
  String get emergencyHelpTitle => 'क्या आप मदद के लिए जा रहे हैं?';

  @override
  String get emergencyImHelping => 'मैं मदद करूँगा';

  @override
  String get emergencyMarkFalseAlarm => 'झूठा अलार्म मानें';

  @override
  String get emergencyMarkResolved => 'हल हुआ मानें';

  @override
  String get emergencyMissingFields =>
      'क्या हुआ और कौन-सा जानवर है चुनें, स्थिति बताएँ और पिन लगाएँ।';

  @override
  String get emergencyNoContacts =>
      'इस इलाक़े के लिए अभी कोई संपर्क नहीं है। 112 या किसी पशु-चिकित्सक को कॉल करें।';

  @override
  String get emergencyPhoneHint =>
      'मदद करने वालों को दिखेगा ताकि वे आपको कॉल कर सकें।';

  @override
  String get emergencyPinHint => 'नक्शा खिसकाकर पिन वहाँ लगाएँ जहाँ जानवर है।';

  @override
  String get emergencyPinned => 'पिन लग गया';

  @override
  String get emergencyReopen => 'फिर से खोलें';

  @override
  String get emergencyReportFalse => 'झूठी बताकर रिपोर्ट करें';

  @override
  String get emergencyReportFalseDone => 'धन्यवाद, हमारी टीम जाँच करेगी।';

  @override
  String get emergencyReportFalseMessage =>
      'हमारी टीम इस आपात स्थिति की जाँच करेगी।';

  @override
  String get emergencyReportFalseTitle => 'क्या यह आपात स्थिति झूठी है?';

  @override
  String get emergencyResolveTitle => 'हल हुआ मानें?';

  @override
  String get emergencyResolved => 'हल हुआ मान लिया गया';

  @override
  String get emergencySend => 'आपात स्थिति भेजें';

  @override
  String get emergencySendFailed =>
      'भेजा नहीं जा सका। कनेक्शन जाँचकर फिर कोशिश करें, या 112 पर कॉल करें।';

  @override
  String get emergencySending => 'भेजा जा रहा है…';

  @override
  String get emergencySent =>
      'भेज दिया गया। पास के लोगों को सूचना दी जा रही है। आप नीचे दिए संपर्कों को सीधे कॉल भी कर सकते हैं।';

  @override
  String get emergencySettings => 'आपात सेटिंग';

  @override
  String get emergencySettingsSubtitle => 'सूचना की दूरी और संपर्कों का क्रम';

  @override
  String get emergencyStatusClosed => 'बंद';

  @override
  String get emergencyStatusFalseAlarm => 'झूठा अलार्म';

  @override
  String get emergencyStatusHelping => 'मदद रास्ते में है';

  @override
  String get emergencyStatusOpen => 'मदद चाहिए';

  @override
  String get emergencyStatusResolved => 'हल हुआ';

  @override
  String get emergencySuggestedContacts => 'कौन मदद कर सकता है';

  @override
  String get emergencySuggestedContactsHint =>
      'सबसे पास के उपयुक्त संपर्क पहले। उन्हें सीधे कॉल करें।';

  @override
  String get emergencyTypeAbandoned => 'छोड़ा हुआ जानवर';

  @override
  String get emergencyTypeDanger => 'ख़तरे में जानवर';

  @override
  String get emergencyTypeInjured => 'घायल जानवर';

  @override
  String get emergencyTypeIntervention => 'मदद का अनुरोध';

  @override
  String get emergencyTypeOther => 'अन्य आपात स्थिति';

  @override
  String get emergencyTypeUrgentFound => 'मिला, तुरंत देखभाल चाहिए';

  @override
  String get emergencyUnavailable => 'यह आपात स्थिति अब उपलब्ध नहीं है।';

  @override
  String get emergencyWhatHappened => 'क्या हुआ?';

  @override
  String get emergencyWhere => 'जानवर कहाँ है?';

  @override
  String get emergencyWhereHint =>
      'सटीक जगह साझा की जाती है ताकि मदद करने वाले जानवर तक पहुँच सकें।';

  @override
  String get emergencyYouAreHelping => 'आपने कहा है कि आप मदद करेंगे। धन्यवाद!';

  @override
  String get emergencyYourPhone => 'आपका फ़ोन';

  @override
  String get flagBurst => 'इस उपयोगकर्ता के कई दोस्त एक ही दिन सक्रिय हुए';

  @override
  String get flagDeviceUsed =>
      'यह फ़ोन पहले किसी दूसरे निमंत्रण में इस्तेमाल हो चुका है';

  @override
  String get flagSameDevice => 'आमंत्रित करने वाले जैसा ही फ़ोन';

  @override
  String get haveInviteCode => 'किसी दोस्त ने बुलाया? उनका कोड डालें';

  @override
  String get invitePromptTitle => 'क्या किसी दोस्त ने आपको आमंत्रित किया?';

  @override
  String get invitePromptBody =>
      'उनका आमंत्रण कोड डालें, ताकि आपको CodaMi पर लाने का श्रेय आपके दोस्त को मिले।';

  @override
  String invitePromptLater(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'आप इसे बाद में भी प्रोफ़ाइल → दोस्तों को आमंत्रित करें में जोड़ सकते हैं, साइन अप के $days दिनों के भीतर।',
      one:
          'आप इसे आज बाद में भी प्रोफ़ाइल → दोस्तों को आमंत्रित करें में जोड़ सकते हैं।',
    );
    return '$_temp0';
  }

  @override
  String get inviteCodeLabel => 'आमंत्रण कोड';

  @override
  String get inviteCodeFromLink =>
      'आपके आमंत्रण लिंक से भरा गया। पुष्टि करने के लिए इस्तेमाल करें पर टैप करें।';

  @override
  String get inviteCodeFormat =>
      'आमंत्रण कोड में 6 अक्षर और अंक होते हैं, जैसे ABC234।';

  @override
  String get inviteCodeNotFound =>
      'हमें यह कोड नहीं मिला। अपने दोस्त से इसकी पुष्टि करें।';

  @override
  String get inviteCodeOwn =>
      'यह आपका अपना कोड है। इसे अपने दोस्तों के साथ शेयर करें।';

  @override
  String inviteCodeTooLate(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'आमंत्रण कोड केवल साइन अप के पहले $days दिनों में ही जोड़ा जा सकता है।',
      one: 'आमंत्रण कोड केवल साइन अप वाले दिन ही जोड़ा जा सकता है।',
    );
    return '$_temp0';
  }

  @override
  String get inviteCodeTooManyTries =>
      'आज बहुत सारे गलत कोड डाले गए। कल फिर कोशिश करें।';

  @override
  String get howInvitesWork => 'यह कैसे काम करता है';

  @override
  String get inviteApproved => 'निमंत्रण मंज़ूर';

  @override
  String get inviteCodeAlreadyUsed =>
      'आप पहले ही एक निमंत्रण कोड इस्तेमाल कर चुके हैं।';

  @override
  String get inviteCodeInvalid => 'यह कोड मान्य नहीं है।';

  @override
  String get inviteCodeNotAllowed =>
      'यह कोड इस्तेमाल नहीं हो सकता: यह आपका अपना कोड है, या साइन अप किए बहुत समय हो गया है।';

  @override
  String get inviteFriends => 'दोस्तों को बुलाएँ';

  @override
  String get inviteFriendsSubtitle => 'CodaMi राजदूत बनें';

  @override
  String get inviteIntro =>
      'CodaMi का हर नया उपयोगकर्ता खोए हुए पालतू जानवरों के लिए एक और जोड़ी आँखें है। अपने दोस्तों को बुलाएँ और CodaMi राजदूत बनें।';

  @override
  String get inviteRejected => 'निमंत्रण अस्वीकार';

  @override
  String get inviteStatusExpired => 'समय पर सक्रिय नहीं हुए';

  @override
  String get inviteStatusPending => 'जुड़ गए, अभी सक्रिय नहीं';

  @override
  String get inviteStatusQualified => 'सक्रिय – पॉइंट मिले';

  @override
  String get inviteStatusRejected => 'गिना नहीं गया';

  @override
  String get inviteStatusReview => 'जाँच हो रही है';

  @override
  String get inviteStep1 =>
      'अपना कोड साझा करें। आपका दोस्त साइन अप के बाद प्रोफ़ाइल → दोस्तों को बुलाएँ में इसे डालता है।';

  @override
  String get invitedFriends => 'बुलाए गए दोस्त (सक्रिय)';

  @override
  String get invitesToReview => 'जाँच के लिए निमंत्रण';

  @override
  String get invitesToReviewSubtitle =>
      'धोखाधड़ी-रोधी जाँच में रोके गए निमंत्रण';

  @override
  String get levelAmbassador => 'राजदूत';

  @override
  String get levelBonus => 'बोनस पॉइंट';

  @override
  String get settingsActiveFriends => 'सक्रिय दोस्त';

  @override
  String get levelChampion => 'CodaMi चैंपियन';

  @override
  String get levelSuperAmbassador => 'सुपर राजदूत';

  @override
  String get levelSupporter => 'समर्थक';

  @override
  String get myEmergencies => 'मेरी';

  @override
  String get myPoints => 'मेरे पॉइंट';

  @override
  String get noActiveEmergencies => 'कोई आपात स्थिति नहीं';

  @override
  String get noEmergenciesMessage =>
      'आपके शहर के पास रिपोर्ट की गई आपात स्थितियाँ यहाँ दिखेंगी।';

  @override
  String get noEmergenciesNearby => 'आपके पास कोई आपात स्थिति नहीं';

  @override
  String get noEmergencyContacts => 'अभी कोई संपर्क नहीं';

  @override
  String get noEmergencyContactsAdmin =>
      'पशु-चिकित्सक, संस्थाएँ और सेवाएँ जोड़ें, या सुविधा आज़माने के लिए टेस्ट संपर्क जोड़ें।';

  @override
  String get noEmergencyContactsMessage =>
      'संपर्क जल्द जोड़े जाएँगे। आपात स्थिति में 112 या किसी पशु-चिकित्सक को कॉल करें।';

  @override
  String get noInvitesToReview => 'जाँचने को कुछ नहीं';

  @override
  String get noInvitesToReviewMessage =>
      'संदिग्ध निमंत्रण यहाँ दिखते हैं। आपके फ़ैसले के बिना कुछ अस्वीकार नहीं होता।';

  @override
  String get noInvitesYet =>
      'अभी कोई निमंत्रण नहीं। शुरू करने के लिए अपना कोड साझा करें।';

  @override
  String get noLevelYet => 'अभी कोई स्तर नहीं';

  @override
  String get noMyEmergencies => 'आपने कोई आपात स्थिति रिपोर्ट नहीं की है';

  @override
  String get noPointsYet =>
      'अभी कोई पॉइंट नहीं। शुरू करने के लिए रोज़ाना इनाम लें।';

  @override
  String get open24h => '24 घंटे खुला';

  @override
  String get openMapFailed => 'नक्शा नहीं खुल सका।';

  @override
  String get photos => 'फ़ोटो';

  @override
  String get pointsAdjusted => 'CodaMi ने बदले';

  @override
  String get pointsDailyActive => 'आज सक्रिय';

  @override
  String get pointsDailyCheckin => 'रोज़ाना चेक-इन';

  @override
  String get pointsFriendJoined => 'एक दोस्त सक्रिय हुआ';

  @override
  String get pointsHistory => 'इतिहास';

  @override
  String get pointsLevelBonus => 'नए स्तर का बोनस';

  @override
  String get pointsOther => 'पॉइंट';

  @override
  String get pointsSettings => 'पॉइंट और इनाम';

  @override
  String get pointsSettingsIntro =>
      'बदलाव तुरंत लागू होते हैं। सीमा से बाहर के मान डिफ़ॉल्ट से बदल दिए जाते हैं।';

  @override
  String get pointsSettingsSubtitle => 'रोज़ाना इनाम, निमंत्रण और स्तर';

  @override
  String get pointsStreakBonus => 'लगातार दिनों का बोनस';

  @override
  String get pointsWelcome => 'स्वागत बोनस';

  @override
  String get recommendedContact => 'सुझाया गया';

  @override
  String get reject => 'अस्वीकार करें';

  @override
  String get reportEmergency => 'आपात स्थिति रिपोर्ट करें';

  @override
  String get searchContacts => 'नाम या शहर से खोजें';

  @override
  String get settingsActiveMinutes => '“आज सक्रिय” के लिए इस्तेमाल के मिनट';

  @override
  String get settingsAlertsNearby => 'पास के लोगों को सूचना';

  @override
  String get settingsAutoCloseHours =>
      'कितनी देर बाद बंद करें (बिना अपडेट के घंटे)';

  @override
  String get settingsAutoCloseHoursHelp =>
      'खुली आपात स्थितियाँ इतने समय बाद अपने-आप बंद हो जाती हैं।';

  @override
  String get settingsCodeEntryDays => 'साइन अप के बाद कोड डालने के दिन';

  @override
  String get settingsContactsPriority => 'संपर्कों की प्राथमिकता';

  @override
  String get settingsDefaultAreaKm => 'डिफ़ॉल्ट सेवा क्षेत्र (किमी)';

  @override
  String get settingsDefaultAreaKmHelp =>
      'उन संपर्कों के लिए जिनका अपना क्षेत्र नहीं है।';

  @override
  String get settingsEmailContacts => 'संपर्कों को ईमेल सूचना';

  @override
  String get settingsEmailContactsHelp =>
      'सत्यापित संपर्कों को ईमेल भेजता है। पहले ईमेल सेवा सेट करनी होगी।';

  @override
  String get settingsMaxPerDay => 'जाँच से पहले रोज़ के सक्रिय दोस्त';

  @override
  String get settingsMaxPerDayHelp =>
      '24 घंटे में इससे ज़्यादा होने पर निमंत्रण जाँच में चला जाता है।';

  @override
  String get settingsMaxRecipients => 'ज़्यादा से ज़्यादा सूचित लोग';

  @override
  String get settingsMaxSuggested => 'सुझाए गए संपर्क';

  @override
  String get settingsMinRecipients => 'कितने लोगों तक पहुँचना है';

  @override
  String get settingsMinRecipientsHelp =>
      'इतने लोग मिलने तक अगला घेरा इस्तेमाल होता है।';

  @override
  String get settingsQualifyDays => 'ज़रूरी सक्रिय दिन';

  @override
  String get settingsQualifyWithinDays => 'इतने दिनों में (साइन अप के बाद)';

  @override
  String get settingsReferralPoints => 'हर सक्रिय दोस्त के पॉइंट';

  @override
  String get settingsRings => 'सूचना के घेरे (किमी)';

  @override
  String get settingsRingsHelp => 'कॉमा से अलग, छोटे से बड़े, जैसे 5, 10, 25';

  @override
  String get settingsSaved => 'सेव हो गया';

  @override
  String get settingsStreakDays => 'लगातार बोनस के लिए दिन';

  @override
  String get settingsWeight24h => '24 घंटे खुले का बोनस';

  @override
  String get settingsWeightHelp =>
      'संपर्कों को ये बोनस मिलते हैं और हर किमी दूरी पर पॉइंट घटते हैं। सबसे ज़्यादा स्कोर पहले आता है।';

  @override
  String get settingsWeightPerKm => 'प्रति किमी कटौती';

  @override
  String get settingsWeightPerKmHelp =>
      '1 पर, सुझाया गया संपर्क (20) अपने से 20 किमी तक पास वाले संपर्क से पहले आता है।';

  @override
  String get settingsWeightRecommended => 'सुझाए गए का बोनस';

  @override
  String get settingsWeightVerified => 'सत्यापित का बोनस';

  @override
  String get settingsWelcomePoints => 'बुलाए गए दोस्त के पॉइंट';

  @override
  String get settingsWelcomePointsHelp =>
      'कोड डालने पर मिलते हैं। 0 बंद कर देता है।';

  @override
  String get shareInvite => 'साझा करें';

  @override
  String get statActiveEmergencies => 'सक्रिय आपात स्थितियाँ';

  @override
  String get testContactBadge => 'TEST – असली संपर्क नहीं';

  @override
  String get topLevelReached => 'आप सबसे ऊँचे स्तर पर पहुँच गए। धन्यवाद!';

  @override
  String get useCode => 'इस्तेमाल करें';

  @override
  String get verifiedContact => 'सत्यापित';

  @override
  String get viewInvitee => 'बुलाया गया उपयोगकर्ता';

  @override
  String get viewInviter => 'बुलाने वाला';

  @override
  String get yourInviteCode => 'आपका निमंत्रण कोड';

  @override
  String get yourInvites => 'आपके निमंत्रण';

  @override
  String get zeroTurnsOff => '0 बंद कर देता है';

  @override
  String activeProgress(int done, int total) {
    return 'आज $total में से $done मिनट';
  }

  @override
  String claimedPoints(int points) {
    return '+$points पॉइंट!';
  }

  @override
  String claimedWithBonus(int points, int bonus) {
    return '+$points पॉइंट और +$bonus लगातार बोनस!';
  }

  @override
  String emergenciesNearYouCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'आपके पास $count जानवरों की आपात स्थितियाँ',
      one: 'आपके पास 1 जानवर की आपात स्थिति',
    );
    return '$_temp0';
  }

  @override
  String emergencyAlertedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'पास के $count लोगों को सूचना दी गई',
      one: 'पास के 1 व्यक्ति को सूचना दी गई',
      zero: 'पास में अभी किसी ने सूचनाएँ चालू नहीं की हैं',
    );
    return '$_temp0';
  }

  @override
  String emergencyFalseReports(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count बार झूठी बताई गई',
      one: 'एक बार झूठी बताई गई',
    );
    return '$_temp0';
  }

  @override
  String emergencyHelpersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count लोग मदद के लिए जा रहे हैं',
      one: '1 व्यक्ति मदद के लिए जा रहा है',
    );
    return '$_temp0';
  }

  @override
  String inviteCodeAccepted(String name) {
    return 'कोड मान लिया गया। आपको $name ने बुलाया – CodaMi में स्वागत है!';
  }

  @override
  String inviteShareText(String code, String link) {
    return 'मैं खोए पालतू जानवरों को घर पहुँचाने में मदद के लिए CodaMi इस्तेमाल करता हूँ। मेरे निमंत्रण कोड $code से जुड़ें: $link';
  }

  @override
  String inviteStep2(int days, int within) {
    return 'वे अपना शहर चुनते हैं और साइन अप के $within दिनों में $days अलग-अलग दिन ऐप इस्तेमाल करते हैं।';
  }

  @override
  String inviteStep3(int points) {
    return 'आपको $points पॉइंट मिलते हैं और आप राजदूत स्तर में आगे बढ़ते हैं।';
  }

  @override
  String kmAway(String km) {
    return '$km किमी दूर';
  }

  @override
  String levelFriends(String level) {
    return '$level: सक्रिय दोस्त';
  }

  @override
  String levelRule(String level, int friends, int bonus) {
    return '$level · $friends+ दोस्त · +$bonus';
  }

  @override
  String nextLevelHint(int count, String level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$level बनने के लिए $count और सक्रिय दोस्त',
      one: '$level बनने के लिए 1 और सक्रिय दोस्त',
    );
    return '$_temp0';
  }

  @override
  String plusPoints(int points) {
    return '+$points पॉइंट';
  }

  @override
  String pointsTotal(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points पॉइंट',
      one: '1 पॉइंट',
    );
    return '$_temp0';
  }

  @override
  String streakLine(int streak, int days, int bonus) {
    return 'लगातार $streak दिन · हर $days दिन पर +$bonus बोनस';
  }

  @override
  String get pointsFeedback => 'फ़ीडबैक भेजा';

  @override
  String get whatsNew => 'नया क्या है';

  @override
  String get whatsNewSubtitle => 'हर संस्करण में बदलाव';

  @override
  String get whatsNewTitle => 'CodaMi में नया क्या है';

  @override
  String get whatsNewIntro => 'पिछले अपडेट में ये बदलाव हुए हैं।';

  @override
  String whatsNewVersion(String version) {
    return 'संस्करण $version';
  }

  @override
  String get whatsNewSectionNew => 'नया';

  @override
  String get whatsNewSectionImproved => 'बेहतर';

  @override
  String get whatsNewSectionFixed => 'ठीक किया';

  @override
  String get whatsNewEmpty => 'अभी कोई अपडेट नोट नहीं है।';

  @override
  String get whatsNewDone => 'समझ गया';

  @override
  String get feedbackTitle => 'आपको CodaMi कैसा लगा?';

  @override
  String get feedbackBody =>
      'आपका फ़ीडबैक सीधे CodaMi टीम तक पहुँचता है और ऐप को बेहतर बनाने में हमारी मदद करता है।';

  @override
  String feedbackPointsOffer(int points) {
    return 'पहले फ़ीडबैक पर +$points पॉइंट';
  }

  @override
  String get feedbackStarsHint => 'रेटिंग देने के लिए किसी स्टार पर टैप करें';

  @override
  String get feedbackCommentHint =>
      'आपको क्या पसंद है, या क्या बेहतर हो सकता है? (वैकल्पिक)';

  @override
  String get feedbackSend => 'फ़ीडबैक भेजें';

  @override
  String get feedbackLater => 'अभी नहीं';

  @override
  String get feedbackThanks => 'आपके फ़ीडबैक के लिए धन्यवाद!';

  @override
  String feedbackThanksPoints(int points) {
    return 'आपके फ़ीडबैक के लिए धन्यवाद! +$points पॉइंट';
  }

  @override
  String get feedbackAlreadyToday =>
      'आप आज फ़ीडबैक भेज चुके हैं। कल फिर भेज सकते हैं।';

  @override
  String get sendFeedbackSubtitle => 'टीम को अपनी राय बताएँ';

  @override
  String get rateCodaMi => 'CodaMi को रेट करें';

  @override
  String get rateCodaMiSubtitle => 'Google Play पर रिव्यू दें';

  @override
  String get adminFeedback => 'फ़ीडबैक';

  @override
  String get adminFeedbackSubtitle =>
      'उपयोगकर्ता ऐप के बारे में क्या सोचते हैं';

  @override
  String get adminFeedbackEmpty => 'अभी कोई फ़ीडबैक नहीं है।';

  @override
  String feedbackRatingsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count रेटिंग',
      one: '1 रेटिंग',
    );
    return '$_temp0';
  }

  @override
  String get feedbackNoComment => 'कोई टिप्पणी नहीं';

  @override
  String get adminWhatsNewSubtitle =>
      'हर अपडेट के बाद उपयोगकर्ताओं को दिखने वाले नोट';

  @override
  String get releaseAdd => 'संस्करण जोड़ें';

  @override
  String get releaseEdit => 'नोट बदलें';

  @override
  String get releaseVersion => 'संस्करण संख्या';

  @override
  String get releaseVersionHelp =>
      'जैसे 1.1.0। यह स्टोर में ऐप के संस्करण नाम से मेल खाना चाहिए।';

  @override
  String get releaseVersionInvalid => 'अंक और बिंदु इस्तेमाल करें, जैसे 1.1.0।';

  @override
  String get releaseVersionExists => 'इस संस्करण के नोट पहले से हैं।';

  @override
  String get releasePublishedHelp => 'उपयोगकर्ता केवल प्रकाशित नोट देखते हैं।';

  @override
  String get releaseDraft => 'ड्राफ़्ट';

  @override
  String get releaseLinesHelp => 'हर पंक्ति में एक बदलाव।';

  @override
  String get releaseLanguageHelp =>
      'खाली छोड़ी गई भाषाओं में अंग्रेज़ी नोट दिखते हैं।';

  @override
  String get releaseEnglishRequired =>
      'पहले अंग्रेज़ी नोट लिखें: बाकी भाषाएँ उन्हीं पर निर्भर रहती हैं।';

  @override
  String get releaseDeleteTitle => 'ये नोट हटाएँ?';

  @override
  String releaseDeleteBody(String version) {
    return 'संस्करण $version के नोट सभी के लिए हटा दिए जाएँगे।';
  }

  @override
  String get releaseNone =>
      'अभी कोई संस्करण नहीं। अपने अगले अपडेट के नोट जोड़ें।';

  @override
  String releaseThisApp(String version) {
    return 'यह ऐप: संस्करण $version';
  }

  @override
  String get feedbackAndReviews => 'फ़ीडबैक और रिव्यू';

  @override
  String get settingsFeedbackPoints => 'पहले फ़ीडबैक के पॉइंट';

  @override
  String get settingsFeedbackAfterDays =>
      'साइन-अप के कितने दिन बाद फ़ीडबैक माँगें';

  @override
  String get settingsReviewActiveDays => 'पूछने से पहले उपयोग के दिन';

  @override
  String get settingsReviewAfterDays =>
      'साइन-अप के कितने दिन बाद स्टोर रेटिंग विंडो दिखे';

  @override
  String get settingsReviewEveryDays => 'स्टोर रेटिंग अनुरोधों के बीच दिन';

  @override
  String get settingsReviewHelp =>
      'स्टोर रेटिंग विंडो कभी पॉइंट नहीं देती: Google Play और App Store इसकी अनुमति नहीं देते।';

  @override
  String get petitions => 'याचिकाएँ';

  @override
  String get petition => 'याचिका';

  @override
  String get petitionsSubtitle => 'हमारी टीम द्वारा चुने गए पशु कल्याण अभियान';

  @override
  String get adminPetitionsSubtitle =>
      'पशु कल्याण याचिकाएँ जोड़ें, समीक्षा करें और प्रकाशित करें';

  @override
  String petitionsBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'हस्ताक्षर के लिए $count पशु कल्याण याचिकाएँ',
      one: 'हस्ताक्षर के लिए 1 पशु कल्याण याचिका',
    );
    return '$_temp0';
  }

  @override
  String get petitionsIntro =>
      'CodaMi टीम हर याचिका को यहाँ दिखाने से पहले जाँचती है। आप उसे मूल साइट पर पढ़ते और साइन करते हैं।';

  @override
  String get petitionsEmpty =>
      'अभी कोई याचिका नहीं है। टीम यहाँ पशु कल्याण अभियान जोड़ेगी।';

  @override
  String get petitionAdminEmpty =>
      'यहाँ कोई याचिका नहीं है। Change.org, Care2, Avaaz या किसी भरोसेमंद संगठन से याचिका जोड़ने के लिए याचिका जोड़ें पर टैप करें।';

  @override
  String get petitionView => 'याचिका देखें';

  @override
  String get petitionSignOnSite => 'मूल साइट पर पढ़ें और साइन करें';

  @override
  String get petitionOpenFailed => 'याचिका का पेज नहीं खुल सका।';

  @override
  String get petitionIssue => 'मुद्दा';

  @override
  String get petitionAction => 'याचिका की माँग';

  @override
  String get petitionWhy => 'यह जानवरों के लिए क्यों ज़रूरी है';

  @override
  String get petitionWhere => 'मूल याचिका';

  @override
  String petitionStartedOn(String date) {
    return '$date को शुरू हुई';
  }

  @override
  String get petitionDisclaimer =>
      'यह याचिका एक बाहरी साइट पर है। CodaMi हस्ताक्षर इकट्ठा नहीं करता और मूल पेज की सामग्री के लिए ज़िम्मेदार नहीं है।';

  @override
  String get petitionEndedNote =>
      'यह अभियान समाप्त हो गया है। आप अब भी मूल पेज पढ़ सकते हैं।';

  @override
  String get petitionUnavailableNote => 'मूल याचिका अब उपलब्ध नहीं है।';

  @override
  String get petitionTopicPets => 'पालतू जानवर';

  @override
  String get petitionTopicWildlife => 'वन्यजीव';

  @override
  String get petitionTopicFarm => 'फ़ार्म के जानवर';

  @override
  String get petitionTopicTesting => 'जानवरों पर परीक्षण';

  @override
  String get petitionTopicEntertainment => 'सर्कस और चिड़ियाघर';

  @override
  String get petitionTopicMarine => 'समुद्री जीव';

  @override
  String get petitionTopicOther => 'अन्य';

  @override
  String get petitionStatusActive => 'सक्रिय';

  @override
  String get petitionStatusCompleted => 'पूरी हुई';

  @override
  String get petitionStatusClosed => 'बंद';

  @override
  String get petitionStatusUnavailable => 'अब उपलब्ध नहीं';

  @override
  String get petitionReviewPending => 'समीक्षा बाकी';

  @override
  String get petitionReviewApproved => 'स्वीकृत';

  @override
  String get petitionReviewRejected => 'अस्वीकृत';

  @override
  String get petitionAdd => 'याचिका जोड़ें';

  @override
  String get petitionEdit => 'याचिका संपादित करें';

  @override
  String get petitionSectionSource => 'मूल याचिका';

  @override
  String get petitionUrl => 'याचिका लिंक';

  @override
  String get petitionUrlInvalid =>
      'https:// से शुरू होने वाला पूरा लिंक पेस्ट करें';

  @override
  String get petitionTitle => 'शीर्षक';

  @override
  String get petitionSource => 'प्लेटफ़ॉर्म या संगठन';

  @override
  String get petitionCountry => 'देश या क्षेत्र';

  @override
  String get petitionCountryHelp =>
      'अंतरराष्ट्रीय अभियानों के लिए खाली छोड़ें।';

  @override
  String get petitionStartedOnPick => 'याचिका शुरू होने की तारीख (वैकल्पिक)';

  @override
  String get petitionTopic => 'विषय';

  @override
  String get petitionSectionText => 'हमारा विवरण';

  @override
  String get petitionOwnWordsHelp =>
      'अपने शब्दों में लिखें। मूल पेज से टेक्स्ट कॉपी न करें।';

  @override
  String get petitionSummary => 'छोटा सारांश';

  @override
  String get petitionImage => 'इमेज';

  @override
  String get petitionImageAdd => 'इमेज जोड़ें';

  @override
  String get petitionImageChange => 'इमेज बदलें';

  @override
  String get petitionImageHelp =>
      'वैकल्पिक। इमेज न होने पर कार्ड में विषय का आइकन दिखता है।';

  @override
  String get petitionImagePermission => 'हमें इस इमेज के उपयोग की अनुमति है';

  @override
  String get petitionImagePermissionNeeded =>
      'पुष्टि करें कि आपके पास इमेज के उपयोग की अनुमति है, या उसे हटा दें।';

  @override
  String get petitionImageTooBig =>
      'इमेज बहुत बड़ी है। 5 MB से छोटी इमेज चुनें।';

  @override
  String get petitionChecks => 'सत्यापन';

  @override
  String get petitionChecksHelp =>
      'स्वीकृत या प्रकाशित करने के लिए चारों ज़रूरी हैं।';

  @override
  String get petitionCheckExists => 'मूल पेज मौजूद है और खुलता है';

  @override
  String get petitionCheckGenuine =>
      'यह पशु कल्याण के किसी वास्तविक मुद्दे से जुड़ी है';

  @override
  String get petitionCheckGoal => 'इसका लक्ष्य स्पष्ट है';

  @override
  String get petitionCheckHonest => 'कोई भ्रामक या धोखाधड़ी वाला दावा नहीं';

  @override
  String get petitionChecksNeeded =>
      'स्वीकृत या प्रकाशित करने से पहले सभी सत्यापन जाँचों पर टिक करें।';

  @override
  String get petitionReview => 'समीक्षा';

  @override
  String get petitionReviewHelp =>
      'उपयोगकर्ताओं को केवल प्रकाशित याचिकाएँ दिखाई जाती हैं।';

  @override
  String get petitionRejectReason => 'कारण (केवल एडमिन को दिखता है)';

  @override
  String get petitionStatus => 'याचिका की स्थिति';

  @override
  String get petitionStatusHelp =>
      'अभियान खत्म होने या पेज हटाए जाने पर इसे अपडेट करें।';

  @override
  String get petitionFixFields => 'लाल रंग से चिह्नित फ़ील्ड भरें।';

  @override
  String get petitionDeleteTitle => 'यह याचिका हटाएँ?';

  @override
  String get petitionDeleteBody => 'इसे सभी के लिए ऐप से हटा दिया जाएगा।';

  @override
  String petitionAddedOn(String date) {
    return '$date को जोड़ी गई';
  }

  @override
  String petitionPublishedOn(String date) {
    return '$date को प्रकाशित';
  }

  @override
  String petitionUpdatedOn(String date) {
    return '$date को अपडेट की गई';
  }

  @override
  String get appUpdates => 'ऐप अपडेट';

  @override
  String get adminAppUpdatesSubtitle => 'स्टोर वर्शन और ज़रूरी अपडेट';

  @override
  String get appUpdatesSubtitle => 'स्टोर में वर्शन';

  @override
  String get appUpdatesIntro =>
      'पुराने वर्शन वाले यूज़र्स को नए वर्शन के बदलावों के साथ अपडेट संदेश दिखेगा। न्यूनतम वर्शन से नीचे, अपडेट किए बिना ऐप इस्तेमाल नहीं हो सकता। इन्हें बदलने के लिए नया बिल्ड नहीं चाहिए।';

  @override
  String appUpdatesThisPhone(String version) {
    return 'इस फ़ोन पर वर्शन $version है';
  }

  @override
  String get appUpdatesAndroid => 'Android (Google Play)';

  @override
  String get appUpdatesIos => 'iPhone (App Store)';

  @override
  String get appUpdatesLatest => 'स्टोर में नया वर्शन';

  @override
  String get appUpdatesLatestHelp =>
      'अपडेट स्टोर में आने के बाद भरें। कोई संदेश न दिखाने के लिए खाली छोड़ें।';

  @override
  String get appUpdatesMinimum => 'न्यूनतम वर्शन';

  @override
  String get appUpdatesMinimumHelp =>
      'पुराने वर्शन को ऐप इस्तेमाल करने से पहले अपडेट करना होगा। कोई सीमा न रखने के लिए खाली छोड़ें।';

  @override
  String get appUpdatesStoreId => 'App Store ID';

  @override
  String get appUpdatesStoreIdHelp =>
      'App Store लिंक में मौजूद नंबर (apps.apple.com/app/id…)। iPhone पर अपडेट बटन के लिए ज़रूरी।';

  @override
  String appUpdatesNotesPublished(String version) {
    return '$version के नोट्स प्रकाशित हैं और अपडेट के साथ दिखते हैं';
  }

  @override
  String appUpdatesNotesDraft(String version) {
    return '$version के नोट्स सेव हैं पर प्रकाशित नहीं';
  }

  @override
  String appUpdatesNotesMissing(String version) {
    return '$version के लिए अभी कोई नोट्स नहीं';
  }

  @override
  String get appUpdatesBadVersion => '1.2.0 जैसा वर्शन लिखें';

  @override
  String get appUpdatesMinimumAbove =>
      'न्यूनतम वर्शन नए वर्शन से ज़्यादा नहीं हो सकता';

  @override
  String get appUpdatesBadStoreId => 'App Store ID में सिर्फ़ अंक होते हैं';

  @override
  String get appUpdatesRequireTitle => 'अपडेट ज़रूरी करें?';

  @override
  String appUpdatesRequireBody(String version) {
    return '$version से पुराने वर्शन वाले सभी लोगों को ऐप इस्तेमाल करने से पहले अपडेट करना होगा।';
  }

  @override
  String get appUpdatesRequireConfirm => 'ज़रूरी करें';

  @override
  String get updateAvailableTitle => 'अपडेट उपलब्ध है';

  @override
  String updateAvailableBody(String latest, String installed) {
    return 'CodaMi का वर्शन $latest तैयार है। आपके पास $installed है।';
  }

  @override
  String get updateNow => 'अभी अपडेट करें';

  @override
  String get updateLater => 'बाद में';

  @override
  String get updateRequiredTitle => 'अपडेट ज़रूरी है';

  @override
  String updateRequiredBody(String version) {
    return 'CodaMi का यह वर्शन अब समर्थित नहीं है। ऐप इस्तेमाल करते रहने के लिए वर्शन $version पर अपडेट करें।';
  }

  @override
  String updateBanner(String version) {
    return 'वर्शन $version उपलब्ध है';
  }

  @override
  String get updateStoreFailed =>
      'स्टोर नहीं खुल सका। कृपया स्टोर ऐप से CodaMi अपडेट करें।';

  @override
  String get rateCodaMiSubtitleIos => 'App Store पर रिव्यू दें';

  @override
  String get updateContinueAsAdmin => 'एडमिन के रूप में जारी रखें';

  @override
  String get navShop => 'दुकान';

  @override
  String get shop => 'दुकान';

  @override
  String get adminShopSubtitle => 'उत्पाद, ब्रांड, सप्लायर और चालू/बंद स्विच';

  @override
  String get shopSubtitle => 'आपके पालतू जानवरों के लिए उत्पाद';

  @override
  String get shopSearchHint => 'उत्पाद खोजें';

  @override
  String get shopEmpty => 'उत्पाद जल्द आ रहे हैं। बाद में फिर देखें!';

  @override
  String get shopNoResults => 'कोई मेल खाता उत्पाद नहीं।';

  @override
  String get shopInStock => 'स्टॉक में';

  @override
  String get shopLowStock => 'कुछ ही बचे हैं';

  @override
  String get shopOutOfStock => 'स्टॉक खत्म';

  @override
  String get shopComingSoon => 'जल्द आ रहा है';

  @override
  String get shopModelOwnStock => 'हमारा स्टॉक';

  @override
  String get shopModelBrand => 'ब्रांड पार्टनर';

  @override
  String get shopModelDropship => 'ड्रॉपशिपिंग';

  @override
  String get shopModelAffiliate => 'एफ़िलिएट लिंक';

  @override
  String get shopModelOwnStockHelp => 'CodaMi स्टॉक रखता है और भेजता है।';

  @override
  String get shopModelBrandHelp =>
      'ब्रांड CodaMi के ज़रिए बेचता है और ऑर्डर भेजता है।';

  @override
  String get shopModelDropshipHelp => 'सप्लायर ऑर्डर सीधे ग्राहक को भेजता है।';

  @override
  String get shopModelAffiliateHelp =>
      'हमारे लिंक से पार्टनर की साइट पर खरीदा जाता है; CodaMi को कमीशन मिलता है।';

  @override
  String shopBuyOn(String partner) {
    return '$partner पर खरीदें';
  }

  @override
  String shopAffiliateNote(String partner) {
    return '$partner द्वारा बेचा और भेजा जाता है। इस खरीद पर CodaMi को कमीशन मिल सकता है।';
  }

  @override
  String shopPriceOnPartner(String partner) {
    return 'कीमत $partner पर';
  }

  @override
  String get shopAddToCart => 'कार्ट में जोड़ें';

  @override
  String get shopCheckoutSoon => 'ऐप में खरीदारी जल्द आ रही है।';

  @override
  String get shopAllAnimals => 'सभी जानवरों के लिए';

  @override
  String get shopDescription => 'विवरण';

  @override
  String get shopOpenFailed => 'लिंक नहीं खुल सका।';

  @override
  String get shopPreviewOff =>
      'पूर्वावलोकन: दुकान बंद है, उपयोगकर्ता इसे नहीं देख सकते।';

  @override
  String get shopAdminIntro =>
      'CodaMi दुकान संभालें। चालू होने पर ही उपयोगकर्ता इसे देखते हैं।';

  @override
  String get shopOpenSwitch => 'उपयोगकर्ताओं के लिए दुकान खुली';

  @override
  String get shopOnHelp => 'चालू: सभी को दुकान टैब दिखता है।';

  @override
  String get shopOffHelp =>
      'बंद: उपयोगकर्ता दुकान नहीं देखते। एडमिन इसे तैयार कर सकते हैं।';

  @override
  String get shopTurnOnTitle => 'दुकान खोलें?';

  @override
  String get shopTurnOnBody =>
      'सभी उपयोगकर्ताओं को तुरंत दुकान टैब और सक्रिय उत्पाद दिखेंगे।';

  @override
  String get shopTurnOffTitle => 'दुकान बंद करें?';

  @override
  String get shopTurnOffBody =>
      'दुकान टैब सभी के लिए तुरंत गायब हो जाएगा। उत्पाद और सेटिंग्स सुरक्षित रहेंगी।';

  @override
  String get shopTurnOn => 'खोलें';

  @override
  String get shopTurnOff => 'बंद करें';

  @override
  String get shopSalesModels => 'बिक्री मॉडल';

  @override
  String get shopSalesModelsHelp =>
      'किसी मॉडल को बंद करने से उसके सभी उत्पाद छिप जाते हैं।';

  @override
  String get shopCatalog => 'कैटलॉग';

  @override
  String get shopProducts => 'उत्पाद';

  @override
  String get shopCategories => 'श्रेणियाँ';

  @override
  String get shopBrands => 'ब्रांड';

  @override
  String get shopSuppliers => 'सप्लायर';

  @override
  String get shopPreview => 'दुकान का पूर्वावलोकन';

  @override
  String get shopPreviewSubtitle => 'दुकान को उपयोगकर्ताओं की तरह देखें';

  @override
  String shopProductsCount(int active, int total) {
    return '$active सक्रिय · कुल $total';
  }

  @override
  String get shopAddProduct => 'उत्पाद जोड़ें';

  @override
  String get shopEditProduct => 'उत्पाद संपादित करें';

  @override
  String get shopProductsEmpty => 'अभी कोई उत्पाद नहीं। पहला जोड़ें।';

  @override
  String get shopActive => 'सक्रिय';

  @override
  String get shopHidden => 'छिपा हुआ';

  @override
  String get shopNeedCategory => 'पहले एक श्रेणी जोड़ें (दुकान → श्रेणियाँ)।';

  @override
  String get shopPhotos => 'फ़ोटो';

  @override
  String get shopPhotosHelp =>
      'अधिकतम 6 फ़ोटो। पहली कवर होगी; क्रम बदलने के लिए दबाकर खींचें।';

  @override
  String get shopAddPhoto => 'फ़ोटो जोड़ें';

  @override
  String get shopImageTooBig => 'इमेज 5 MB से छोटी होनी चाहिए।';

  @override
  String get shopDetails => 'विवरण';

  @override
  String get shopName => 'नाम';

  @override
  String get shopCategory => 'श्रेणी';

  @override
  String get shopPickCategory => 'एक श्रेणी चुनें';

  @override
  String get shopAnimals => 'जानवर';

  @override
  String get shopAnimalsHelp =>
      'कुछ न चुनने का मतलब सभी जानवरों के लिए। उपयोगकर्ता पहले अपने पालतू के उत्पाद देखते हैं।';

  @override
  String get shopSalesModel => 'बिक्री मॉडल';

  @override
  String get shopPartnerName => 'पार्टनर दुकान';

  @override
  String get shopAffiliateUrl => 'एफ़िलिएट लिंक';

  @override
  String get shopBrand => 'ब्रांड';

  @override
  String get shopNoBrand => 'कोई ब्रांड नहीं';

  @override
  String get shopSupplier => 'सप्लायर';

  @override
  String get shopNoSupplier => 'कोई सप्लायर नहीं';

  @override
  String get shopPriceSection => 'कीमत';

  @override
  String get shopPrice => 'कीमत (€)';

  @override
  String get shopPriceAffiliateHelp =>
      'वैकल्पिक: कीमतें पार्टनर की साइट पर बदलती हैं।';

  @override
  String get shopPriceInvalid => 'कीमत डालें, जैसे 12.90';

  @override
  String get shopCompareAt => 'छूट से पहले की कीमत (€)';

  @override
  String get shopCompareAtHelp => 'वैकल्पिक। कीमत के पास कटा हुआ दिखेगा।';

  @override
  String get shopCompareAtInvalid => 'कीमत से ज़्यादा होनी चाहिए।';

  @override
  String get shopAvailability => 'उपलब्धता';

  @override
  String get shopVisible => 'उपयोगकर्ताओं को दिखे';

  @override
  String get shopVisibleHelp => 'छिपे उत्पाद केवल एडमिन देखते हैं।';

  @override
  String get shopCategoryVisibleHelp =>
      'छिपाने पर श्रेणी और उसके सभी उत्पाद छिप जाते हैं।';

  @override
  String get shopBrandVisibleHelp =>
      'छिपाने पर ब्रांड के सभी उत्पाद छिप जाते हैं।';

  @override
  String get shopSupplierActiveHelp =>
      'बंद करने पर इस सप्लायर के सभी उत्पाद छिप जाते हैं।';

  @override
  String get shopDeleteProductTitle => 'यह उत्पाद हटाएँ?';

  @override
  String get shopDeleteProductBody =>
      'यह फ़ोटो सहित दुकान से हट जाएगा। इसे वापस नहीं किया जा सकता।';

  @override
  String shopDeleteTitle(String name) {
    return '$name हटाएँ?';
  }

  @override
  String get shopDeleteBody => 'इसे वापस नहीं किया जा सकता।';

  @override
  String get shopInUse =>
      'अभी उत्पादों या उप-श्रेणियों में उपयोग हो रहा है, इसलिए हटा नहीं सकते। इसे छिपा दें।';

  @override
  String get shopFixFields => 'लाल रंग वाले फ़ील्ड जाँचें।';

  @override
  String get shopLinkInvalid => 'https:// से शुरू होने वाला पूरा लिंक डालें';

  @override
  String get shopAddCategory => 'श्रेणी जोड़ें';

  @override
  String get shopEditCategory => 'श्रेणी संपादित करें';

  @override
  String get shopAddStarting => 'शुरुआती श्रेणियाँ जोड़ें';

  @override
  String get shopStartingHelp =>
      'भोजन, एक्सेसरीज़, देखभाल, खिलौने, बिस्तर, कैरियर, टेक और अन्य से शुरू करें। बाद में बदल सकते हैं।';

  @override
  String get shopParent => 'किस श्रेणी के अंदर';

  @override
  String get shopNoParent => 'कोई नहीं (मुख्य श्रेणी)';

  @override
  String get shopIcon => 'आइकन';

  @override
  String get shopOrder => 'क्रम';

  @override
  String get shopOrderHelp => 'छोटी संख्या पहले आती है।';

  @override
  String get shopCatFood => 'भोजन';

  @override
  String get shopCatAccessories => 'एक्सेसरीज़';

  @override
  String get shopCatCare => 'देखभाल';

  @override
  String get shopCatToys => 'खिलौने';

  @override
  String get shopCatBeds => 'बिस्तर';

  @override
  String get shopCatCarriers => 'कैरियर';

  @override
  String get shopCatTech => 'टेक';

  @override
  String get shopCatOther => 'अन्य';

  @override
  String get shopAddBrand => 'ब्रांड जोड़ें';

  @override
  String get shopEditBrand => 'ब्रांड संपादित करें';

  @override
  String get shopBrandsEmpty =>
      'अभी कोई ब्रांड नहीं। ये वैकल्पिक हैं; पार्टनर होने पर जोड़ें।';

  @override
  String get shopWebsite => 'वेबसाइट';

  @override
  String get shopLogo => 'लोगो';

  @override
  String get shopAddLogo => 'लोगो चुनें';

  @override
  String get shopAddSupplier => 'सप्लायर जोड़ें';

  @override
  String get shopEditSupplier => 'सप्लायर संपादित करें';

  @override
  String get shopSuppliersEmpty => 'अभी कोई सप्लायर नहीं।';

  @override
  String get shopSuppliersHelp =>
      'सप्लायर और उनकी जानकारी केवल एडमिन देखते हैं। सप्लायर बंद करने से उसके उत्पाद छिप जाते हैं।';

  @override
  String get shopContactName => 'संपर्क व्यक्ति';

  @override
  String get shopEmail => 'ईमेल';

  @override
  String get shopEmailInvalid => 'सही ईमेल पता डालें।';

  @override
  String get shopPhone => 'फ़ोन';

  @override
  String get shopOrderMethod => 'ऑर्डर उन तक कैसे पहुँचते हैं';

  @override
  String get shopOrderManual => 'हाथ से';

  @override
  String get shopOrderManualHelp => 'टीम हर ऑर्डर सप्लायर को भेजती है।';

  @override
  String get shopOrderEmail => 'स्वचालित ईमेल';

  @override
  String get shopOrderEmailHelp =>
      'हर भुगतान वाला ऑर्डर सप्लायर को ईमेल होता है (चेकआउट के साथ)।';

  @override
  String get shopNotes => 'नोट्स (केवल एडमिन)';
}
