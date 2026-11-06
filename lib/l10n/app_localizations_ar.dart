// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navPets => 'حيواناتي';

  @override
  String get navProfile => 'الملف';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get notSet => 'غير محددة';

  @override
  String get soon => 'قريبًا';

  @override
  String comingSoon(String feature) {
    return 'ميزة $feature ستتوفر قريبًا.';
  }

  @override
  String get profileTitle => 'الملف الشخصي';

  @override
  String get myPets => 'حيواناتي';

  @override
  String get myReports => 'بلاغاتي';

  @override
  String get homeCity => 'المدينة';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get chooseLanguage => 'اختر لغتك';

  @override
  String get language => 'اللغة';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get signOutTitle => 'تسجيل الخروج؟';

  @override
  String get signOutMessage => 'يمكنك تسجيل الدخول مجددًا في أي وقت.';

  @override
  String get deleteAccount => 'حذف الحساب';

  @override
  String get deleteAccountTitle => 'حذف حسابك؟';

  @override
  String get deleteAccountMessage =>
      'سيتم حذف ملفك الشخصي وحيواناتك وبلاغاتك وصورها نهائيًا. لا يمكن التراجع عن ذلك.';

  @override
  String get deletingAccount => 'جارٍ حذف حسابك…';

  @override
  String get myReportsSubtitle => 'حافظ على تحديث بلاغاتك.';

  @override
  String get statTotal => 'الإجمالي';

  @override
  String postedOn(String date) {
    return 'نُشر في $date';
  }

  @override
  String get reportActive => 'نشطة';

  @override
  String get reportResolved => 'محلولة';

  @override
  String get myReportsLoadError => 'تعذّر تحميل بلاغاتك';

  @override
  String get checkConnection => 'تحقق من اتصالك وحاول مرة أخرى.';

  @override
  String get noActiveReports => 'لا توجد بلاغات نشطة';

  @override
  String get noActiveReportsMessage =>
      'ستظهر هنا البلاغات التي تنشرها عن الحيوانات المفقودة أو التي عُثر عليها.';

  @override
  String get reportAPet => 'أبلغ عن حيوان';

  @override
  String get nothingResolved => 'لا توجد بلاغات محلولة بعد';

  @override
  String get nothingResolvedMessage =>
      'عندما تحدد بلاغًا على أنه محلول، سينتقل إلى هنا.';

  @override
  String get markAsFound => 'تحديد كمعثور عليه';

  @override
  String get returnedToOwner => 'أُعيد إلى صاحبه';

  @override
  String get backHome => 'عاد إلى المنزل';

  @override
  String get reunited => 'عاد إلى عائلته';

  @override
  String get deleteReport => 'حذف البلاغ';

  @override
  String resolveLostTitle(String petName) {
    return 'هل عاد $petName إلى المنزل؟';
  }

  @override
  String get resolveFoundTitle => 'هل وجدت صاحبه؟';

  @override
  String resolveLostMessage(String petName) {
    return 'سينتقل البلاغ إلى \"عاد إلى المنزل\" في تبويب المعثور عليها، ليعرف الجيران أن $petName بأمان.';
  }

  @override
  String get resolveFoundMessage =>
      'سينتقل البلاغ إلى \"عاد إلى عائلته\" في تبويب المعثور عليها.';

  @override
  String get notYet => 'ليس بعد';

  @override
  String get yesResolved => 'نعم، تم الحل';

  @override
  String get reportResolvedSuccess => 'خبر رائع! تم حل البلاغ.';

  @override
  String get deleteReportTitle => 'حذف هذا البلاغ؟';

  @override
  String deleteOpenReportMessage(String petName) {
    return 'سيختفي من الخريطة والقوائم. إذا كان $petName بأمان، فحدد البلاغ كمحلول بدلًا من ذلك ليعرف الجيران.';
  }

  @override
  String get deleteResolvedReportMessage =>
      'ستتم إزالته من الخريطة ومن قائمة \"عاد إلى المنزل\".';

  @override
  String get reportDeleted => 'تم حذف البلاغ.';

  @override
  String get onboarding1Title => 'كل حيوان أليف يستحق\n';

  @override
  String get onboarding1Highlight => 'العودة إلى البيت';

  @override
  String get onboarding1Body =>
      'يجمع CodaMi الجيران لتعود الكلاب والقطط المفقودة إلى من يحبونها.';

  @override
  String get onboarding2Title => 'أبلغ عن حيوان\nفي ';

  @override
  String get onboarding2Highlight => 'ثوانٍ';

  @override
  String get onboarding2Body =>
      'التقط صورة، وحدد المكان، وانشر بلاغ فقدان أو عثور. يراه كل من بالقرب منك فورًا.';

  @override
  String get onboarding3Title => 'شاهد من\n';

  @override
  String get onboarding3Highlight => 'بالقرب منك';

  @override
  String get onboarding3Body =>
      'الحيوانات المفقودة والمعثور عليها حولك، مباشرة على خريطة واحدة، لتعرف دائمًا أين تبحث.';

  @override
  String get skip => 'تخطي';

  @override
  String get getStarted => 'ابدأ';

  @override
  String get lost => 'مفقود';

  @override
  String get found => 'معثور عليه';

  @override
  String get you => 'أنت';

  @override
  String get published => 'تم النشر';

  @override
  String get onboardingSampleBreed => 'غولدن ريتريفر · 3 سنوات';

  @override
  String get onboardingSamplePlace => 'ميلانو · قبل ساعتين';

  @override
  String get validationNameRequired => 'يرجى إدخال اسمك';

  @override
  String get validationNameTooShort => 'يجب أن يتكون الاسم من حرفين على الأقل';

  @override
  String get validationNameTooLong => 'يجب أن يكون الاسم أقل من 50 حرفًا';

  @override
  String get validationNameInvalid =>
      'يمكن أن يحتوي الاسم على أحرف ومسافات وشرطات وفواصل علوية فقط';

  @override
  String get validationEmailRequired => 'يرجى إدخال بريدك الإلكتروني';

  @override
  String get validationEmailInvalid => 'يرجى إدخال بريد إلكتروني صالح';

  @override
  String get validationPasswordRequired => 'يرجى إدخال كلمة المرور';

  @override
  String get validationPasswordTooShort =>
      'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل';

  @override
  String get validationConfirmRequired => 'يرجى تأكيد كلمة المرور';

  @override
  String get validationPasswordsDontMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get spamNote =>
      'لم تجد رسالة إعادة التعيين؟ تحقق من مجلد البريد العشوائي، فقد تصل إليه أحيانًا.';

  @override
  String get logIn => 'تسجيل الدخول';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get authResetSentTitle => 'تحقق من بريدك';

  @override
  String get authResetSentSubtitle =>
      'أرسلنا إليك رابطًا لإعادة تعيين كلمة المرور.';

  @override
  String get authLoginTitle => 'مرحبًا بعودتك!';

  @override
  String get authLoginSubtitle =>
      'سجّل الدخول لتواصل مساعدة الحيوانات على العودة إلى بيوتها.';

  @override
  String get authSignupTitle => 'انضم إلى القطيع';

  @override
  String get authSignupSubtitle => 'أنشئ حسابًا وساعد حيّك.';

  @override
  String get authForgotTitle => 'نسيت كلمة المرور؟';

  @override
  String get authForgotSubtitle =>
      'لا تقلق، سنرسل إليك رابط إعادة التعيين عبر البريد الإلكتروني.';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get sendResetLink => 'إرسال الرابط';

  @override
  String get or => 'أو';

  @override
  String get continueWithGoogle => 'المتابعة باستخدام Google';

  @override
  String get continueWithApple => 'المتابعة باستخدام Apple';

  @override
  String get resetLinkSentTo => 'أرسلنا رابطًا إلى';

  @override
  String get backToLogIn => 'العودة لتسجيل الدخول';

  @override
  String get sendAgain => 'لم يصلك؟ أعد الإرسال';

  @override
  String get errorOffline => 'أنت غير متصل. تحقق من اتصالك وحاول مرة أخرى.';

  @override
  String get errorSessionExpired => 'انتهت جلستك. يرجى تسجيل الدخول مجددًا.';

  @override
  String get deleteAccountFailed => 'تعذّر حذف حسابك. حاول مرة أخرى.';

  @override
  String get authErrorGeneric => 'حدث خطأ ما. حاول مرة أخرى.';

  @override
  String get authErrorDisabled => 'تم تعطيل هذا الحساب.';

  @override
  String get authErrorWrongCredentials =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة.';

  @override
  String get authErrorEmailInUse =>
      'يوجد حساب بهذا البريد الإلكتروني بالفعل. جرّب تسجيل الدخول.';

  @override
  String get authErrorTooManyRequests =>
      'محاولات كثيرة جدًا. انتظر قليلًا وحاول مرة أخرى.';

  @override
  String get citySearchFailed => 'فشل البحث عن المدينة. حاول مرة أخرى.';

  @override
  String get placeSearchFailed => 'فشل البحث عن المكان. حاول مرة أخرى.';

  @override
  String get placeOutsideCity =>
      'هذا المكان خارج مدينتك. يرجى اختيار مكان داخلها.';

  @override
  String get placeNotFound => 'لم نعثر على هذا المكان. يرجى اختيار مكان آخر.';

  @override
  String get citySearchOffline =>
      'تعذّر الوصول إلى البحث عن المدن. تحقق من اتصالك وحاول مرة أخرى.';

  @override
  String get searchCityHint => 'ابحث عن مدينتك، مثل ميلانو';

  @override
  String noCitiesFound(String query) {
    return 'لم يتم العثور على مدن لـ \"$query\".';
  }

  @override
  String homeCityUpdated(String city) {
    return 'تم تحديث المدينة إلى $city.';
  }

  @override
  String get saveCityFailed => 'تعذّر حفظ مدينتك. حاول مرة أخرى.';

  @override
  String get citySetupTitle => 'أين ';

  @override
  String get citySetupHighlight => 'أنت؟';

  @override
  String get cityEditTitle => 'غيّر ';

  @override
  String get cityEditHighlight => 'مدينتك';

  @override
  String get citySetupBody =>
      'اختر مدينتك لنعرض لك الحيوانات المفقودة والمعثور عليها بالقرب منك، ونخبرك عندما يُفقد حيوان في منطقتك.';

  @override
  String get saveCity => 'حفظ المدينة';

  @override
  String get continueLabel => 'متابعة';

  @override
  String get notYouSignOut => 'لست أنت؟ سجّل الخروج';

  @override
  String greeting(String name) {
    return 'مرحبًا، $name!';
  }

  @override
  String get showPetsWithin => 'عرض الحيوانات ضمن';

  @override
  String distanceFrom(String city) {
    return 'المسافة من $city';
  }

  @override
  String get everywhere => 'في كل مكان';

  @override
  String distanceKm(int km) {
    return '$km كم';
  }

  @override
  String withinKm(int km) {
    return 'ضمن $km كم';
  }

  @override
  String get areaNotSet => 'لم تُحدد المنطقة بعد';

  @override
  String get reportPetSemantics => 'أبلغ عن حيوان مفقود أو معثور عليه';

  @override
  String get map => 'الخريطة';

  @override
  String get locationServicesOff => 'فعّل خدمات الموقع لاستخدام موقعك.';

  @override
  String get locationPermissionDenied =>
      'اسمح بالوصول إلى الموقع من الإعدادات لاستخدام موقعك.';

  @override
  String get locationFailed => 'تعذّر تحديد موقعك. حاول مرة أخرى.';

  @override
  String get back => 'رجوع';

  @override
  String get fullScreen => 'ملء الشاشة';

  @override
  String get loadingPets => 'جارٍ تحميل الحيوانات…';

  @override
  String get mapLoadFailed => 'تعذّر تحميل البلاغات. تحقق من اتصالك.';

  @override
  String get mapNoLost => 'لا توجد حيوانات مفقودة في هذه المنطقة';

  @override
  String get mapNoFound => 'لا توجد حيوانات معثور عليها في هذه المنطقة';

  @override
  String get mapNoPets =>
      'لا توجد حيوانات مفقودة أو معثور عليها في هذه المنطقة';

  @override
  String get zoomIn => 'تكبير';

  @override
  String get zoomOut => 'تصغير';

  @override
  String get myLocation => 'موقعي';

  @override
  String get myCity => 'مدينتي';

  @override
  String get all => 'الكل';

  @override
  String get timeJustNow => 'الآن';

  @override
  String timeMinutesAgo(int minutes) {
    return 'قبل $minutes د';
  }

  @override
  String timeHoursAgo(int hours) {
    return 'قبل $hours س';
  }

  @override
  String get timeYesterday => 'أمس';

  @override
  String timeDaysAgo(int days) {
    return 'قبل $days يوم';
  }

  @override
  String notifLostTitle(String city) {
    return 'حيوان مفقود في $city';
  }

  @override
  String notifLostBodyNear(String pet, String street, String city) {
    return 'شوهد $pet آخر مرة قرب $street، $city. ابقَ منتبهًا!';
  }

  @override
  String notifLostBodyIn(String pet, String city) {
    return 'شوهد $pet آخر مرة في $city. ابقَ منتبهًا!';
  }

  @override
  String notifFoundTitle(String city) {
    return 'عُثر على حيوان في $city';
  }

  @override
  String notifFoundBodyNear(String pet, String street, String city) {
    return 'عُثر على $pet قرب $street، $city. هل تعرف صاحبه؟';
  }

  @override
  String notifFoundBodyIn(String pet, String city) {
    return 'عُثر على $pet في $city. هل تعرف صاحبه؟';
  }

  @override
  String notifBackHomeTitle(String pet) {
    return 'عاد $pet إلى المنزل';
  }

  @override
  String notifBackHomeBody(String pet, String city) {
    return 'أخبار سارة من $city: تم العثور على $pet. شكرًا لمساعدتك!';
  }

  @override
  String notifReunitedTitle(String pet) {
    return 'عاد $pet إلى عائلته';
  }

  @override
  String notifReunitedBody(String city) {
    return 'الحيوان الذي عُثر عليه في $city عاد إلى عائلته.';
  }

  @override
  String get notificationsTitle => 'الإشعارات';

  @override
  String get markAllRead => 'تحديد الكل كمقروء';

  @override
  String get notificationsLoadError => 'تعذّر تحميل الإشعارات';

  @override
  String get allCaughtUp => 'لا جديد حاليًا';

  @override
  String get notificationsEmpty =>
      'سنخبرك عندما يُفقد حيوان أو يُعثر عليه في مدينتك.';

  @override
  String get notificationsNew => 'جديدة';

  @override
  String get notificationsEarlier => 'سابقة';

  @override
  String get reportNotAvailable => 'البلاغ غير متاح';

  @override
  String get reportRemoved => 'أزال صاحب البلاغ هذا البلاغ.';

  @override
  String get reportsLoadError => 'تعذّر تحميل البلاغات';

  @override
  String get pullToRetry => 'تحقق من اتصالك واسحب للأسفل للمحاولة مجددًا.';

  @override
  String get noLostNearby => 'لا توجد حيوانات مفقودة بالقرب منك';

  @override
  String get noLostNearbyMessage =>
      'أخبار جيدة! لم يبلّغ أحد عن حيوان مفقود في منطقتك بعد.';

  @override
  String get noFoundYet => 'لا توجد حيوانات معثور عليها بعد';

  @override
  String get noFoundYetMessage => 'ستظهر هنا الحيوانات التي يعثر عليها جيرانك.';

  @override
  String get backHomeSection => 'عادوا إلى المنزل';

  @override
  String get backHomeSectionSubtitle => 'حيوانات وجدت طريقها إلى عائلاتها.';

  @override
  String get loadMore => 'تحميل المزيد';

  @override
  String get speciesDog => 'كلب';

  @override
  String get speciesCat => 'قطة';

  @override
  String get speciesOther => 'آخر';

  @override
  String get sexMale => 'ذكر';

  @override
  String get sexFemale => 'أنثى';

  @override
  String get sexUnknown => 'غير معروف';

  @override
  String nearPlace(String street, String city) {
    return 'قرب $street، $city';
  }

  @override
  String get callFailed => 'تعذّر بدء المكالمة.';

  @override
  String get whatsappFailed => 'تعذّر فتح واتساب.';

  @override
  String get emailFailed => 'تعذّر فتح تطبيق البريد.';

  @override
  String whatsappMessageLost(String pet) {
    return 'مرحبًا! أتواصل معك بخصوص الحيوان المفقود \"$pet\" على CodaMi.';
  }

  @override
  String whatsappMessageFound(String pet) {
    return 'مرحبًا! أتواصل معك بخصوص الحيوان المعثور عليه \"$pet\" على CodaMi.';
  }

  @override
  String emailSubjectLost(String pet) {
    return 'بخصوص $pet (حيوان مفقود على CodaMi)';
  }

  @override
  String emailSubjectFound(String pet) {
    return 'بخصوص $pet (حيوان معثور عليه على CodaMi)';
  }

  @override
  String shareTitleLost(String pet) {
    return 'حيوان مفقود: $pet';
  }

  @override
  String shareTitleFound(String pet) {
    return 'حيوان معثور عليه: $pet';
  }

  @override
  String get shareFooter => 'هل رأيت هذا الحيوان؟ افتح CodaMi للتواصل.';

  @override
  String get lastSeen => 'آخر مرة شوهد';

  @override
  String get foundAt => 'عُثر عليه في';

  @override
  String areaAbout(int meters) {
    return 'منطقة بحوالي $meters م';
  }

  @override
  String get when => 'متى';

  @override
  String get postedBy => 'نشره';

  @override
  String get description => 'الوصف';

  @override
  String get call => 'اتصال';

  @override
  String contactTitleLost(String pet) {
    return 'هل رأيت $pet؟ تواصل معنا';
  }

  @override
  String get contactTitleFound => 'هل هذا حيوانك؟ تواصل';

  @override
  String get noContactShared => 'لم تتم مشاركة أي بيانات تواصل.';

  @override
  String resolvedThanksLost(String pet) {
    return 'عاد $pet إلى المنزل. شكرًا لاستخدامك CodaMi!';
  }

  @override
  String get resolvedThanksFound =>
      'عاد هذا الحيوان إلى عائلته. شكرًا لمساعدتك!';

  @override
  String get yourContactDetails => 'بيانات التواصل الخاصة بك';

  @override
  String markPetAsFound(String pet) {
    return 'تحديد $pet كمعثور عليه';
  }

  @override
  String get markReturnedToOwner => 'تحديد كمُعاد إلى صاحبه';

  @override
  String get copiedToClipboard => 'تم النسخ.';

  @override
  String get petSaveFailed => 'تعذّر حفظ حيوانك. حاول مرة أخرى.';

  @override
  String get petDeleteFailed => 'تعذّر حذف حيوانك. حاول مرة أخرى.';

  @override
  String get errorPermission => 'ليس لديك إذن للقيام بذلك.';

  @override
  String get storageNotReady => 'تخزين الصور غير جاهز بعد. حاول لاحقًا.';

  @override
  String get storageFull => 'مساحة التخزين ممتلئة حاليًا. حاول لاحقًا.';

  @override
  String petAdded(String name) {
    return 'تمت إضافة $name إلى حيواناتك.';
  }

  @override
  String get petsLoadError => 'تعذّر تحميل حيواناتك';

  @override
  String get noPetsYet => 'لا توجد حيوانات بعد';

  @override
  String get noPetsYetMessage =>
      'أضف حيواناتك الآن لتتمكن من الإبلاغ عنها خلال ثوانٍ إذا فُقدت.';

  @override
  String get addFirstPet => 'أضف حيوانك الأول';

  @override
  String get petsHeaderEmpty => 'جهّز ملفات حيواناتك، تحسبًا لأي طارئ.';

  @override
  String petsHeaderCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'عدد الأصدقاء الأليفين: $count، جاهزون لأي طارئ.',
      one: 'صديق أليف واحد، جاهز لأي طارئ.',
    );
    return '$_temp0';
  }

  @override
  String get addPet => 'إضافة';

  @override
  String petUpdated(String name) {
    return 'تم تحديث $name.';
  }

  @override
  String removePetTitle(String name) {
    return 'إزالة $name؟';
  }

  @override
  String get removePetMessage =>
      'سيتم حذف الملف وصوره. لا يمكن التراجع عن ذلك.';

  @override
  String get remove => 'إزالة';

  @override
  String petRemoved(String name) {
    return 'تمت إزالة $name.';
  }

  @override
  String get breed => 'السلالة';

  @override
  String get color => 'اللون';

  @override
  String get age => 'العمر';

  @override
  String get sex => 'الجنس';

  @override
  String petAddedOn(String date) {
    return 'أُضيف في $date';
  }

  @override
  String get distinctiveFeatures => 'علامات مميزة';

  @override
  String ifPetGoesMissing(String name) {
    return 'إذا فُقد $name يومًا ما';
  }

  @override
  String get ifPetGoesMissingBody =>
      'انشر بلاغ فقدان بهذا الملف خلال ثوانٍ، وسيتم تنبيه الجيران القريبين.';

  @override
  String reportPetAsLost(String name) {
    return 'الإبلاغ عن فقدان $name';
  }

  @override
  String get colorBlack => 'أسود';

  @override
  String get colorWhite => 'أبيض';

  @override
  String get colorBrown => 'بني';

  @override
  String get colorGolden => 'ذهبي';

  @override
  String get colorGrey => 'رمادي';

  @override
  String get colorCream => 'كريمي';

  @override
  String get colorGinger => 'برتقالي';

  @override
  String get petPhotoRequired => 'أضف صورة واحدة على الأقل لحيوانك.';

  @override
  String get petSpeciesRequired =>
      'اختر ما إذا كان حيوانك كلبًا أو قطة أو غير ذلك.';

  @override
  String get checkHighlightedFields => 'يرجى مراجعة الحقول المحددة.';

  @override
  String get signInToSave => 'سجّل الدخول مجددًا للحفظ.';

  @override
  String get discardChangesTitle => 'تجاهل التغييرات؟';

  @override
  String get discardPetChanges =>
      'ستُفقد التغييرات التي أجريتها على هذا الحيوان.';

  @override
  String get keepEditing => 'متابعة التعديل';

  @override
  String get discard => 'تجاهل';

  @override
  String editPetTitle(String name) {
    return 'تعديل $name';
  }

  @override
  String get newPet => 'حيوان جديد';

  @override
  String get whatKindOfPet => 'ما نوع حيوانك؟';

  @override
  String get name => 'الاسم';

  @override
  String get petNameHint => 'مثل لونا';

  @override
  String get petNameRequired => 'يرجى إدخال اسم حيوانك';

  @override
  String get petNameTooLong => 'يجب أن يكون الاسم أقل من 40 حرفًا';

  @override
  String get breedHint => 'مثل غولدن ريتريفر، هجين';

  @override
  String get colorHint => 'مثل ذهبي بصدر أبيض';

  @override
  String get ageHint => 'مثل 3 سنوات، 8 أشهر';

  @override
  String get featuresHint =>
      'طوق، شريحة إلكترونية، ندوب، بقع… أي شيء يساعد على التعرف على حيوانك.';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get savePet => 'حفظ الحيوان';

  @override
  String get cameraPermission =>
      'يرجى السماح بالوصول إلى الكاميرا من الإعدادات.';

  @override
  String get photosPermission => 'يرجى السماح بالوصول إلى الصور من الإعدادات.';

  @override
  String get cameraFailed => 'تعذّر فتح الكاميرا.';

  @override
  String get galleryFailed => 'تعذّر فتح المعرض.';

  @override
  String get optional => 'اختياري';

  @override
  String get addPetPhotos => 'أضف صورًا لحيوانك';

  @override
  String get addPetPhotosHint => 'الصور الواضحة والحديثة تساعد على التعرف عليه';

  @override
  String get photoRequired => 'مطلوب صورة واحدة على الأقل';

  @override
  String get tapToMakeCover => 'اضغط على صورة لجعلها صورة الغلاف.';

  @override
  String get cover => 'الغلاف';

  @override
  String uploadingPhotos(int percent) {
    return 'جارٍ رفع الصور… $percent%';
  }

  @override
  String get saving => 'جارٍ الحفظ…';

  @override
  String get takePhoto => 'التقاط صورة';

  @override
  String get useCamera => 'استخدم الكاميرا';

  @override
  String get chooseFromGallery => 'اختيار من المعرض';

  @override
  String get pickExistingPhoto => 'اختر صورة موجودة';

  @override
  String get yourPet => 'حيوانك';

  @override
  String get unknownDog => 'كلب مجهول';

  @override
  String get unknownCat => 'قطة مجهولة';

  @override
  String get unknownPet => 'حيوان مجهول';

  @override
  String get errorChooseType => 'اختر ما إذا كنت قد فقدت حيوانًا أو عثرت عليه.';

  @override
  String get errorPickPet => 'اختر الحيوان المفقود.';

  @override
  String get errorFoundPhoto => 'أضف صورة واحدة على الأقل للحيوان.';

  @override
  String get errorFoundSpecies => 'هل هو كلب أم قطة أم غير ذلك؟';

  @override
  String get errorChooseCity => 'اختر المدينة التي حدث فيها ذلك.';

  @override
  String get errorFutureDate => 'لا يمكن أن يكون التاريخ في المستقبل.';

  @override
  String get errorDescriptionShort => 'أضف وصفًا قصيرًا (10 أحرف على الأقل).';

  @override
  String get errorContactRequired =>
      'أضف رقم هاتف أو بريدًا إلكترونيًا ليتمكن الناس من التواصل معك.';

  @override
  String get errorPhoneInvalid => 'يرجى إدخال رقم هاتف صالح.';

  @override
  String get discardReportTitle => 'تجاهل هذا البلاغ؟';

  @override
  String get discardReportMessage => 'ستفقد ما أدخلته حتى الآن.';

  @override
  String get signInToPublish => 'سجّل الدخول مجددًا للنشر.';

  @override
  String publishedLost(String pet) {
    return 'أصبح $pet على الخريطة الآن. نتمنى أن يعود إلى المنزل قريبًا.';
  }

  @override
  String publishedFound(String pet) {
    return 'شكرًا! أصبح $pet على الخريطة الآن.';
  }

  @override
  String get reportLostPetTitle => 'الإبلاغ عن حيوان مفقود';

  @override
  String get reportFoundPetTitle => 'الإبلاغ عن حيوان معثور عليه';

  @override
  String get newReport => 'بلاغ جديد';

  @override
  String stepOf(int current, int total) {
    return '$current من $total';
  }

  @override
  String get publishReport => 'نشر البلاغ';

  @override
  String get stepTypeTitle => 'ماذا حدث؟';

  @override
  String get stepTypeSubtitle => 'لننشر الخبر بسرعة بين الناس القريبين.';

  @override
  String get stepFoundPetTitle => 'أخبرنا عن الحيوان';

  @override
  String get stepFoundPetSubtitle =>
      'الصورة الواضحة هي أسرع طريقة ليتعرف عليه صاحبه.';

  @override
  String get addFoundPhotos => 'أضف صورًا للحيوان';

  @override
  String get addFoundPhotosHint => 'التقط صورة الآن أو اختر من المعرض';

  @override
  String get whatKindOfAnimal => 'ما نوع الحيوان؟';

  @override
  String get collarName => 'الاسم على الطوق أو البطاقة';

  @override
  String get collarNameHint => 'اتركه فارغًا إذا كنت لا تعرف';

  @override
  String get stepLostPetTitle => 'أي حيوان مفقود؟';

  @override
  String get stepLostPetSubtitle =>
      'سنستخدم ملفه وصوره، فلن تحتاج إلى إعادة كتابة أي شيء.';

  @override
  String get stepWhereFoundTitle => 'أين عثرت عليه؟';

  @override
  String stepWhereLostTitle(String pet) {
    return 'أين شوهد $pet آخر مرة؟';
  }

  @override
  String get stepWhereSubtitle =>
      'اختر المدينة، ثم حدد المكان على الخريطة. يرى الآخرون منطقة بحوالي 100 م فقط، وليس العنوان الدقيق أبدًا.';

  @override
  String get streetOrLandmark => 'الشارع أو معلم قريب';

  @override
  String get pinExactSpot => 'حدد المكان بدقة';

  @override
  String spotHintFound(String pet) {
    return 'حرّك الخريطة حتى تصبح العلامة حيث عثرت على $pet.';
  }

  @override
  String spotHintLost(String pet) {
    return 'حرّك الخريطة حتى تصبح العلامة حيث شوهد $pet آخر مرة.';
  }

  @override
  String spotFarFromCity(int km, String city) {
    return 'هذا المكان يبعد $km كم عن $city. هل المدينة صحيحة؟';
  }

  @override
  String spotPinned(int meters) {
    return 'تم التحديد. يرى الآخرون منطقة بحوالي $meters م حوله فقط، وليس المكان الدقيق أبدًا.';
  }

  @override
  String get timeHourAgo => 'قبل ساعة';

  @override
  String get timeThisMorning => 'هذا الصباح';

  @override
  String get stepWhenFoundTitle => 'متى عثرت عليه؟';

  @override
  String stepWhenLostTitle(String pet) {
    return 'متى رأيت $pet آخر مرة؟';
  }

  @override
  String get stepWhenSubtitle => 'الوقت التقريبي كافٍ.';

  @override
  String get changeDate => 'تغيير التاريخ';

  @override
  String get changeTime => 'تغيير الوقت';

  @override
  String get stepDetailsTitle => 'هل هناك شيء آخر يجب أن نعرفه؟';

  @override
  String get stepDetailsSubtitle =>
      'التفاصيل تساعد الجيران على التعرف على الحيوان والتواصل معك بسرعة.';

  @override
  String descriptionHintLost(String pet) {
    return 'لون الطوق، السلوك، كيف فُقد $pet…';
  }

  @override
  String get descriptionHintFound =>
      'الحالة، الطوق، السلوك، أين عثرت عليه بالضبط…';

  @override
  String get howToReachYou => 'كيف يمكن التواصل معك؟';

  @override
  String get contactPrivacyNote =>
      'تظهر فقط في صفحة البلاغ، وليس في القوائم أبدًا.';

  @override
  String get phoneHint => 'الهاتف، مثل ‎+39 333 123 4567';

  @override
  String get reachableOnWhatsapp => 'متاح على واتساب';

  @override
  String get reachableOnWhatsappHint => 'يمكن للناس مراسلتك على هذا الرقم';

  @override
  String get stepReviewTitle => 'جاهز للنشر؟';

  @override
  String get stepReviewSubtitle => 'هكذا سيرى الناس القريبون بلاغك.';

  @override
  String get iLostMyPet => 'فقدت حيواني';

  @override
  String get iFoundAPet => 'عثرت على حيوان';

  @override
  String get iLostMyPetHint => 'نبّه الناس القريبين واحصل على مساعدة في البحث.';

  @override
  String get iFoundAPetHint => 'ساعد حيوانًا مفقودًا على العودة إلى منزله.';

  @override
  String get addAPet => 'إضافة حيوان';

  @override
  String get pleaseChooseCity => 'يرجى اختيار مدينة';

  @override
  String noPlacesFound(String city, String query) {
    return 'لم يتم العثور على أماكن في $city لـ \"$query\".';
  }

  @override
  String searchStreetHint(String city) {
    return 'ابحث في $city، مثل Via Dante';
  }

  @override
  String get yourCity => 'مدينتك';

  @override
  String get useMyLocation => 'استخدم موقعي';

  @override
  String get publishFailed => 'تعذّر نشر بلاغك. حاول مرة أخرى.';

  @override
  String get updateReportFailed => 'تعذّر تحديث البلاغ. حاول مرة أخرى.';

  @override
  String get deleteReportFailed => 'تعذّر حذف البلاغ. حاول مرة أخرى.';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get termsOfUse => 'شروط الاستخدام';

  @override
  String legalLastUpdated(String date) {
    return 'آخر تحديث: $date';
  }

  @override
  String get deleteAccountPasswordPrompt => 'أدخل كلمة المرور للتأكيد.';

  @override
  String deleteAccountTypeConfirm(String word) {
    return 'اكتب $word للتأكيد.';
  }

  @override
  String get wrongPassword => 'كلمة المرور غير صحيحة. حاول مرة أخرى.';

  @override
  String get confirmPasswordAgain => 'لأمانك، يرجى تأكيد كلمة المرور مرة أخرى.';

  @override
  String get contactUs => 'تواصل معنا';

  @override
  String get legalQuestions => 'هل لديك أسئلة حول هذا المستند أو بياناتك؟';

  @override
  String get languageChangeLater => 'يمكنك تغييرها في أي وقت من ملفك الشخصي.';

  @override
  String get reward => 'مكافأة';

  @override
  String get rewardHint => 'المبلغ باليورو';

  @override
  String get rewardNote =>
      'المكافأة اتفاق خاص بين المالك ومن يجد الحيوان. لا تضمن CodaMi أي دفعة ولا تعالجها.';

  @override
  String rewardAmount(String amount) {
    return 'مكافأة $amount';
  }

  @override
  String get adminPanel => 'لوحة الإدارة';

  @override
  String get roleAdmin => 'مسؤول';

  @override
  String get roleSupport => 'الدعم';

  @override
  String get supportStaff => 'فريق الدعم';

  @override
  String get supportStaffSubtitle => 'الأشخاص الذين يردّون على طلبات الدعم';

  @override
  String get adminUsers => 'المستخدمون';

  @override
  String get adminListings => 'الإعلانات';

  @override
  String get adminReportedContent => 'المحتوى المُبلَّغ عنه';

  @override
  String get adminTickets => 'طلبات الدعم';

  @override
  String get adminVideos => 'الفيديوهات';

  @override
  String get addSupportStaff => 'إضافة إلى الدعم';

  @override
  String get addSupportStaffHint =>
      'أدخل البريد الإلكتروني لحساب CodaMi موجود.';

  @override
  String get userNotFound => 'لا يوجد حساب CodaMi بهذا البريد الإلكتروني.';

  @override
  String get alreadyStaff => 'هذا الشخص ضمن الفريق بالفعل.';

  @override
  String staffAdded(String name) {
    return 'أصبح $name ضمن فريق الدعم.';
  }

  @override
  String removeStaffTitle(String name) {
    return 'إزالة $name؟';
  }

  @override
  String get removeStaffMessage =>
      'لن يتمكن بعد الآن من الوصول إلى لوحة الإدارة.';

  @override
  String get noSupportStaff => 'لا يوجد أحد في فريق الدعم بعد.';

  @override
  String get add => 'إضافة';

  @override
  String get actionFailed => 'حدث خطأ ما. يُرجى المحاولة مرة أخرى.';

  @override
  String get adminDashboard => 'لوحة المعلومات';

  @override
  String get adminMore => 'المزيد';

  @override
  String get adminReportedShort => 'المُبلَّغ عنه';

  @override
  String get adminTicketsShort => 'الطلبات';

  @override
  String get adminSectionSoon => 'هذا القسم قادم قريبًا.';

  @override
  String get statUsers => 'المستخدمون المسجلون';

  @override
  String get statOpenLost => 'بلاغات فقدان مفتوحة';

  @override
  String get statOpenFound => 'بلاغات عثور مفتوحة';

  @override
  String get statBackHome => 'حيوانات عادت إلى البيت';

  @override
  String get flagListing => 'الإبلاغ عن الإعلان';

  @override
  String get flagTitle => 'لماذا تبلّغ عن هذا الإعلان؟';

  @override
  String get flagHint => 'سيراجعه فريقنا. لن يعرف صاحب الإعلان من أبلغ عنه.';

  @override
  String get flagReasonSpam => 'رسائل مزعجة أو إعلانات';

  @override
  String get flagReasonScam => 'احتيال';

  @override
  String get flagReasonInappropriate => 'محتوى غير لائق';

  @override
  String get flagReasonWrongInfo => 'معلومات خاطئة أو مضللة';

  @override
  String get flagReasonOther => 'سبب آخر';

  @override
  String get flagNoteHint => 'أضف تفاصيل (اختياري)';

  @override
  String get flagSubmit => 'إرسال البلاغ';

  @override
  String get flagSent => 'شكرًا. سيراجع فريقنا هذا الإعلان.';

  @override
  String get alreadyFlagged => 'لقد أبلغت عن هذا الإعلان من قبل.';

  @override
  String blockUser(String name) {
    return 'حظر $name';
  }

  @override
  String blockUserTitle(String name) {
    return 'حظر $name؟';
  }

  @override
  String get blockUserMessage =>
      'لن ترى إعلاناته ولن تصلك تنبيهات عنها. يمكنك إلغاء الحظر من الملف الشخصي ← المستخدمون المحظورون.';

  @override
  String get block => 'حظر';

  @override
  String userBlocked(String name) {
    return 'تم حظر $name.';
  }

  @override
  String get blockedUsers => 'المستخدمون المحظورون';

  @override
  String get noBlockedUsers => 'لم تحظر أحدًا.';

  @override
  String get unblock => 'إلغاء الحظر';

  @override
  String userUnblocked(String name) {
    return 'تم إلغاء حظر $name.';
  }

  @override
  String get unknownUser => 'مستخدم غير معروف';

  @override
  String get hiddenListing => 'مخفي';

  @override
  String get hiddenListingNotice =>
      'أخفى فريق CodaMi هذا الإعلان ولم يعد عامًا.';

  @override
  String get moderation => 'الإشراف';

  @override
  String get noFlagsOnListing => 'لم يبلّغ أحد عن هذا الإعلان.';

  @override
  String flagCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count بلاغ',
      few: '$count بلاغات',
      two: 'بلاغان',
      one: 'بلاغ واحد',
    );
    return '$_temp0';
  }

  @override
  String get dismissFlags => 'تجاهل البلاغات';

  @override
  String get flagsDismissed => 'تم تجاهل البلاغات.';

  @override
  String get hideListing => 'إخفاء الإعلان';

  @override
  String get restoreListing => 'استعادة الإعلان';

  @override
  String get listingHidden => 'تم إخفاء الإعلان. صاحبه فقط يستطيع رؤيته.';

  @override
  String get listingRestored => 'تمت استعادة الإعلان.';

  @override
  String get deleteListing => 'حذف الإعلان';

  @override
  String get deleteListingTitle => 'حذف هذا الإعلان؟';

  @override
  String get deleteListingMessage =>
      'سيُحذف الإعلان وصوره للجميع. لا يمكن التراجع عن ذلك.';

  @override
  String get listingDeleted => 'تم حذف الإعلان.';

  @override
  String get listingUnavailable => 'الإعلان لم يعد متاحًا';

  @override
  String get noReportedContent => 'لا توجد بلاغات';

  @override
  String get noReportedContentMessage =>
      'ستظهر هنا الإعلانات التي أبلغ عنها المستخدمون.';

  @override
  String get filterOpen => 'مفتوحة';

  @override
  String get filterResolved => 'محلولة';

  @override
  String get filterHidden => 'مخفية';

  @override
  String get noListings => 'لا توجد إعلانات';

  @override
  String get tryAnotherFilter => 'جرّب فلترًا آخر.';

  @override
  String get adminUsersSubtitle => 'عرض الحسابات أو تعطيلها أو حذفها';

  @override
  String get searchByEmail => 'البحث بالبريد الإلكتروني';

  @override
  String get noUsersFound => 'لم يتم العثور على مستخدمين.';

  @override
  String get roleUser => 'مستخدم';

  @override
  String get userDisabled => 'معطّل';

  @override
  String get phone => 'الهاتف';

  @override
  String get memberSince => 'عضو منذ';

  @override
  String get disableAccount => 'تعطيل الحساب';

  @override
  String get enableAccount => 'تفعيل الحساب';

  @override
  String disableUserTitle(String name) {
    return 'تعطيل حساب $name؟';
  }

  @override
  String get disableUserMessage =>
      'سيتم تسجيل خروجه ولن يتمكن من الدخول. ستبقى إعلاناته المفتوحة مخفية حتى يُعاد تفعيل الحساب.';

  @override
  String get accountDisabled => 'تم تعطيل الحساب.';

  @override
  String get accountEnabled => 'تم تفعيل الحساب.';

  @override
  String deleteUserTitle(String name) {
    return 'حذف حساب $name؟';
  }

  @override
  String get deleteUserMessage =>
      'سيُحذف ملفه الشخصي وحيواناته وإعلاناته وصوره نهائيًا. لا يمكن التراجع عن ذلك.';

  @override
  String get userDeleted => 'تم حذف الحساب.';

  @override
  String get save => 'حفظ';

  @override
  String get requiredField => 'مطلوب';

  @override
  String get notificationSettingsIntro =>
      'اختر التنبيهات التي تصلك وخصص لكل منها صوتًا مختلفًا، لتعرف ما حدث قبل أن تنظر.';

  @override
  String get notificationSound => 'الصوت';

  @override
  String get alertLostTitle => 'حيوانات مفقودة بالقرب منك';

  @override
  String get alertLostDescription => 'عندما يُفقد حيوان في مدينتك';

  @override
  String get alertFoundTitle => 'حيوانات تم العثور عليها بالقرب منك';

  @override
  String get alertFoundDescription => 'عندما يعثر شخص على حيوان في مدينتك';

  @override
  String get alertResolvedTitle => 'نهايات سعيدة';

  @override
  String get alertResolvedDescription =>
      'عندما يعود حيوان مفقود أو تم العثور عليه إلى منزله';

  @override
  String get soundDefault => 'الافتراضي في الهاتف';

  @override
  String get soundSilent => 'صامت';

  @override
  String get soundChime => 'رنين';

  @override
  String get soundBell => 'جرس';

  @override
  String get soundBright => 'مشرق';

  @override
  String get soundSoft => 'هادئ';

  @override
  String get soundCustom => 'صوت مخصص';

  @override
  String get soundFromPhone => 'نغمات الرنين والأصوات في هاتفك';

  @override
  String get soundFromFile => 'موسيقى أو ملف صوتي';

  @override
  String get soundIosNote =>
      'على iPhone يجب أن تكون أصوات الإشعارات من التطبيق نفسه، لذا اختر أحد الأصوات أعلاه.';

  @override
  String get soundPickFailed => 'تعذر استخدام هذا الصوت. جرّب صوتًا آخر.';

  @override
  String get videosForYou => 'فيديوهات لك';

  @override
  String get videosForYourPets => 'مختارة لحيواناتك';

  @override
  String get videosGeneral =>
      'رعاية الحيوان والعناية المسؤولة بالحيوانات الأليفة';

  @override
  String get videosShuffle => 'عرض فيديوهات أخرى';

  @override
  String get videoMotivational => 'تحفيز';

  @override
  String get videoEducational => 'تعلّم';

  @override
  String get videoTagGeneral => 'للجميع';

  @override
  String get videoLoadError => 'لا يمكن تشغيل هذا الفيديو الآن. حاول لاحقًا.';

  @override
  String get adminVideosSubtitle => 'رفع الفيديوهات وإدارتها';

  @override
  String get addVideo => 'إضافة فيديو';

  @override
  String get editVideo => 'تعديل الفيديو';

  @override
  String get noVideosYet => 'لا توجد فيديوهات بعد. أضف أول فيديو بالزر أدناه.';

  @override
  String get deleteVideoTitle => 'حذف هذا الفيديو؟';

  @override
  String get deleteVideoMessage =>
      'ستتم إزالته من التطبيق للجميع. لا يمكن التراجع عن ذلك.';

  @override
  String get videoHidden => 'مخفي';

  @override
  String get allLanguages => 'كل اللغات';

  @override
  String get chooseVideo => 'اختر فيديو';

  @override
  String get chooseVideoHint =>
      'من معرض الصور، حتى 200 ميغابايت. الفيديوهات القصيرة (أقل من دقيقتين) هي الأفضل.';

  @override
  String get videoTitle => 'العنوان';

  @override
  String get videoType => 'النوع';

  @override
  String get videoAnimals => 'الحيوانات';

  @override
  String get videoAnimalsHint =>
      'اختر الحيوانات التي يتناولها الفيديو. اختر \"للجميع\" للفيديوهات العامة التي تظهر لكل المستخدمين.';

  @override
  String get videoVisible => 'ظاهر في التطبيق';

  @override
  String get videoVisibleHint => 'الفيديوهات المخفية يراها المشرفون فقط.';

  @override
  String get videoTooLarge =>
      'حجم الفيديو أكبر من 200 ميغابايت. اختر فيديو أقصر.';

  @override
  String get videoSaved => 'تم حفظ الفيديو.';

  @override
  String uploadingProgress(int percent) {
    return 'جارٍ الرفع… $percent%';
  }

  @override
  String get navVideos => 'فيديوهات';

  @override
  String get videosEmptyTitle => 'الفيديوهات في الطريق';

  @override
  String get videosEmptyMessage =>
      'قريبًا ستجد هنا فيديوهات قصيرة عن العناية بحيواناتك.';

  @override
  String get moreVideos => 'المزيد من الفيديوهات';

  @override
  String get videoWatched => 'تمت المشاهدة';

  @override
  String get videoBack10 => 'رجوع 10 ثوانٍ';

  @override
  String get videoForward10 => 'تقديم 10 ثوانٍ';

  @override
  String get videoFullscreen => 'ملء الشاشة';

  @override
  String get videoExitFullscreen => 'الخروج من ملء الشاشة';

  @override
  String get videoRetry => 'إعادة المحاولة';

  @override
  String get videoDeleted => 'تم حذف الفيديو.';

  @override
  String get noVideosYetTitle => 'لا توجد فيديوهات بعد';

  @override
  String get videoVisibleShort => 'ظاهرة';

  @override
  String get play => 'تشغيل';

  @override
  String get edit => 'تعديل';

  @override
  String get change => 'تغيير';

  @override
  String get videoSectionFile => 'الفيديو';

  @override
  String get videoSectionDetails => 'التفاصيل';

  @override
  String get videoSectionAudience => 'من يشاهده';

  @override
  String get videoCover => 'صورة الغلاف';

  @override
  String get videoCoverHint => 'اختيارية. تظهر على بطاقة الفيديو.';

  @override
  String get videoMotivationalHint => 'قصص ملهمة ولحظات سعيدة';

  @override
  String get videoEducationalHint => 'نصائح وإرشادات للمالكين';

  @override
  String get uploadVideo => 'رفع الفيديو';

  @override
  String get helpSupport => 'المساعدة والدعم';

  @override
  String get helpSupportSubtitle => 'تحدّث معنا أو أرسل طلبًا';

  @override
  String get supportIntroTitle => 'كيف يمكننا مساعدتك؟';

  @override
  String get supportIntroMessage =>
      'يرد فريقنا هنا داخل التطبيق. سيصلك إشعار عندما نرد.';

  @override
  String get supportStartChat => 'ابدأ محادثة مباشرة';

  @override
  String get supportStartChatOnline => 'يوجد موظف دعم متصل الآن';

  @override
  String get supportChatOffline =>
      'لا يوجد موظف دعم متصل الآن. أرسل طلبًا وسنرد في أقرب وقت ممكن.';

  @override
  String get supportSendRequest => 'أرسل طلبًا';

  @override
  String get supportSendRequestSubtitle => 'نرد عادةً خلال 24 ساعة';

  @override
  String get supportMyRequests => 'طلباتي';

  @override
  String get supportNoRequests => 'لا توجد طلبات بعد';

  @override
  String get supportNoRequestsMessage => 'ستظهر محادثاتك مع الدعم هنا.';

  @override
  String get supportNewChat => 'محادثة مباشرة جديدة';

  @override
  String get supportNewRequest => 'طلب جديد';

  @override
  String get supportCategory => 'الموضوع';

  @override
  String get categoryAccount => 'الحساب وتسجيل الدخول';

  @override
  String get categoryListing => 'إعلان عن حيوان مفقود أو معثور عليه';

  @override
  String get categoryApp => 'مشكلة في التطبيق';

  @override
  String get categoryOther => 'شيء آخر';

  @override
  String get supportSubject => 'العنوان';

  @override
  String get supportSubjectHint => 'في كلمات قليلة';

  @override
  String get supportSubjectTooShort => 'اكتب 3 أحرف على الأقل';

  @override
  String get supportMessage => 'الرسالة';

  @override
  String get supportMessageHint => 'أخبرنا بما حدث';

  @override
  String get supportMessageRequired => 'اكتب رسالة';

  @override
  String get supportSend => 'إرسال';

  @override
  String get supportTooManyOpen => 'لديك بالفعل 3 طلبات مفتوحة. تابع في أحدها.';

  @override
  String get supportTypeMessage => 'اكتب رسالة…';

  @override
  String get supportTeam => 'دعم CodaMi';

  @override
  String get supportMarkSolved => 'وضع علامة تم الحل';

  @override
  String get supportMarkSolvedConfirm =>
      'هل تريد وضع علامة تم الحل على هذا الطلب؟ يمكنك الكتابة مجددًا إذا احتجت إلى مساعدة.';

  @override
  String get supportClosedNote =>
      'هذا الطلب مغلق. ابدأ طلبًا جديدًا إذا احتجت إلى مساعدة.';

  @override
  String get supportResolvedNote =>
      'تم وضع علامة تم الحل. الكتابة مجددًا تعيد فتحه.';

  @override
  String get supportWaitingNote => 'شكرًا! سيرد فريقنا هنا قريبًا.';

  @override
  String get kindChat => 'محادثة مباشرة';

  @override
  String get kindTicket => 'طلب';

  @override
  String get caseStatusOpen => 'مفتوح';

  @override
  String get caseStatusInProgress => 'قيد المعالجة';

  @override
  String get caseStatusWaitingUser => 'بانتظار الرد';

  @override
  String get caseStatusResolved => 'تم الحل';

  @override
  String get caseStatusClosed => 'مغلق';

  @override
  String get filterUnanswered => 'دون رد';

  @override
  String get filterUnassigned => 'غير مُسندة';

  @override
  String get filterMine => 'الخاصة بي';

  @override
  String get filterActive => 'النشطة';

  @override
  String get filterDone => 'المنتهية';

  @override
  String get supportSearchHint => 'ابحث عن CM-1042 أو البريد';

  @override
  String get supportNoCases => 'لا توجد طلبات هنا';

  @override
  String get supportNoCasesMessage => 'لا يوجد شيء بانتظارك في هذه القائمة.';

  @override
  String get supportTake => 'تولَّ هذه الحالة';

  @override
  String get supportTakeToReply => 'تولَّ الحالة لتتمكن من الرد.';

  @override
  String get supportAlreadyTaken => 'تولّى موظف آخر هذه الحالة بالفعل.';

  @override
  String get supportUnassigned => 'غير مُسندة';

  @override
  String get supportReassign => 'إعادة الإسناد';

  @override
  String get supportAssignTo => 'إسناد إلى';

  @override
  String get supportBackToQueue => 'إعادة إلى قائمة الانتظار';

  @override
  String get supportChangeStatus => 'تغيير الحالة';

  @override
  String get supportChat => 'المحادثة';

  @override
  String get supportTimeline => 'السجل';

  @override
  String get supportDetails => 'التفاصيل';

  @override
  String supportWaitingFor(String time) {
    return 'بانتظار منذ $time';
  }

  @override
  String get supportOverdue => 'رد متأخر';

  @override
  String get supportOpened => 'فُتح';

  @override
  String get supportTakenOver => 'تم التولي';

  @override
  String get supportWaitToTake => 'الانتظار قبل التولي';

  @override
  String get supportFirstReply => 'أول رد';

  @override
  String get supportAvgReply => 'متوسط وقت الرد';

  @override
  String get supportHandlingTime => 'الوقت المستغرق';

  @override
  String get supportResolvedAt => 'تم الحل';

  @override
  String get supportMessagesCount => 'الرسائل';

  @override
  String get supportOperator => 'موظف الدعم';

  @override
  String get supportUserLabel => 'المستخدم';

  @override
  String eventCreated(String name) {
    return 'فتحها $name';
  }

  @override
  String eventTaken(String name) {
    return 'تولّاها $name';
  }

  @override
  String eventReassigned(String from, String to) {
    return 'أُعيد إسنادها من $from إلى $to';
  }

  @override
  String eventStatus(String name, String status) {
    return 'غيّر $name الحالة إلى $status';
  }

  @override
  String get eventReopened => 'أعاد المستخدم فتحها';

  @override
  String get eventOverdue => 'لا رد خلال المهلة';

  @override
  String get eventAutoClosed => 'أُغلقت تلقائيًا';

  @override
  String get presenceOnline => 'متصل';

  @override
  String get presenceAway => 'بعيد';

  @override
  String get presenceOffline => 'غير متصل';

  @override
  String get presenceAvailable => 'متاح للمحادثة المباشرة';

  @override
  String get presenceAvailableSubtitle =>
      'يمكن للمستخدمين بدء محادثة ما دام موظف دعم متصلًا';

  @override
  String get supportOperators => 'موظفو الدعم';

  @override
  String get supportOperatorsSubtitle => 'النشاط والحالات وأوقات الرد';

  @override
  String get operatorOpenCases => 'حالات مفتوحة';

  @override
  String get operatorTaken => 'تم توليها';

  @override
  String get operatorResolved => 'تم حلها';

  @override
  String get operatorReplies => 'الردود';

  @override
  String get operatorAvgHandling => 'متوسط الوقت لكل حالة';

  @override
  String operatorLastActive(String time) {
    return 'آخر نشاط $time';
  }

  @override
  String get operatorCases => 'الحالات';

  @override
  String get noOperators => 'لا يوجد موظفو دعم بعد. أضفهم من فريق الدعم.';

  @override
  String get statUnassigned => 'طلبات غير مُسندة';

  @override
  String get statUnanswered => 'طلبات دون رد';

  @override
  String get statOverdue => 'ردود متأخرة';

  @override
  String get alertSupportTitle => 'ردود الدعم';

  @override
  String get alertSupportDescription => 'عندما يراسلك دعم CodaMi';

  @override
  String durationSeconds(int n) {
    return '$n ث';
  }

  @override
  String durationMinutes(int n) {
    return '$n د';
  }

  @override
  String durationHours(int h, int m) {
    return '$h س $m د';
  }

  @override
  String durationDays(int d, int h) {
    return '$d ي $h س';
  }

  @override
  String get searchUsersHint => 'ابحث بالاسم أو البريد';

  @override
  String get searchTooShort => 'اكتب حرفين على الأقل';

  @override
  String get pickStaffTitle => 'اختر مستخدمًا';

  @override
  String get pickStaffHint => 'اضغط على شخص لإضافته إلى فريق الدعم.';

  @override
  String makeStaffTitle(String name) {
    return 'هل تريد إضافة $name إلى فريق الدعم؟';
  }

  @override
  String get makeStaffMessage =>
      'سيرى قسم الإدارة ويمكنه الرد على الطلبات والمحادثات. يمكنك إزالته في أي وقت.';

  @override
  String get makeStaff => 'إضافة إلى الفريق';

  @override
  String get supportStaffSwitch => 'فريق الدعم';

  @override
  String get supportStaffSwitchSubtitle => 'يمكنه الرد على الطلبات والمحادثات';

  @override
  String staffRemoved(String name) {
    return 'لم يعد $name ضمن فريق الدعم.';
  }

  @override
  String get removeStaffCasesNote => 'تعود حالاته المفتوحة إلى قائمة الانتظار.';

  @override
  String get pushOpen => 'فتح';

  @override
  String get chatToday => 'اليوم';

  @override
  String get chatLoadEarlier => 'تحميل الرسائل الأقدم';

  @override
  String get supportPeople => 'الأشخاص';

  @override
  String get supportTimes => 'الأوقات';

  @override
  String get supportRequestInfo => 'الطلب';

  @override
  String get supportType => 'النوع';

  @override
  String get supportResolve => 'وضع علامة تم الحل';

  @override
  String ticketsWaiting(int count) {
    return '$count بانتظار الرد';
  }

  @override
  String get ticketsAllClear => 'لا شيء بانتظارك';

  @override
  String get photoReviewHint =>
      'صور أوقفها الذكاء الاصطناعي. تبقى مخفية حتى تقرر.';

  @override
  String get reasonAdult => 'عُري أو محتوى جنسي';

  @override
  String get reasonRacy => 'محتوى مثير';

  @override
  String get reasonViolence => 'عنف أو دماء';

  @override
  String get likelihoodPossible => 'محتمل';

  @override
  String get likelihoodLikely => 'مرجّح';

  @override
  String get likelihoodVeryLikely => 'مرجّح جدًا';

  @override
  String get hiddenByAi => 'أخفاها الذكاء الاصطناعي';

  @override
  String get petPhoto => 'صورة الحيوان';

  @override
  String get listingPhoto => 'صورة الإعلان';

  @override
  String uploadedBy(String name) {
    return 'من $name';
  }

  @override
  String get tapToView => 'اضغط للعرض';

  @override
  String get approvePhoto => 'موافقة';

  @override
  String get removePhotoTitle => 'إزالة هذه الصورة؟';

  @override
  String get removePhotoMessage =>
      'ستُزال من حيوان المستخدم أو إعلانه، وسيُبلَّغ المستخدم بالسبب.';

  @override
  String get photoApproved => 'تمت الموافقة على الصورة';

  @override
  String get photoRemovedDone => 'تمت إزالة الصورة';

  @override
  String get photoUnderReview =>
      'يتحقق فريقنا من إحدى الصور، وستبقى مخفية حتى ذلك الحين.';

  @override
  String get reportedTabPhotos => 'صور الذكاء الاصطناعي';

  @override
  String get reportedTabReports => 'بلاغات المستخدمين';

  @override
  String get noPhotosToReview => 'لا توجد صور للمراجعة';

  @override
  String get noPhotosToReviewMessage =>
      'ستظهر هنا الصور التي يوقفها الذكاء الاصطناعي.';

  @override
  String get aFriend => 'صديق';

  @override
  String get addContact => 'إضافة جهة اتصال';

  @override
  String get addTestContacts => 'إضافة جهات اتصال تجريبية';

  @override
  String get adjustPoints => 'تعديل النقاط';

  @override
  String get adjustPointsAmount => 'النقاط المراد إضافتها أو خصمها';

  @override
  String get adjustPointsAmountHelp =>
      'استخدم علامة الطرح لخصم النقاط، مثل -20';

  @override
  String get adjustPointsInvalid => 'أدخل عدد النقاط وسببًا.';

  @override
  String get adjustPointsReason => 'السبب (يظهر للمستخدم)';

  @override
  String get adminContactsSubtitle =>
      'أطباء بيطريون وجمعيات وخدمات تظهر للمستخدمين';

  @override
  String get adminEmergenciesSubtitle =>
      'حالات الحيوانات الطارئة المُبلَّغ عنها';

  @override
  String get alertEmergencyDescription =>
      'حيوانات تحتاج إلى مساعدة عاجلة قرب مدينتك';

  @override
  String get alertEmergencyTitle => 'حالات طارئة قريبة';

  @override
  String get allContacts => 'الكل';

  @override
  String get ambassadorLevels => 'مستويات السفير';

  @override
  String get call112 => 'اتصل بـ 112';

  @override
  String get claim => 'استلام';

  @override
  String get claimed => 'تم الاستلام';

  @override
  String get codeCopied => 'تم نسخ الرمز';

  @override
  String get confirm => 'تأكيد';

  @override
  String get contactActive => 'ظاهر للمستخدمين';

  @override
  String get contactActiveHelp => 'أوقفه لإخفاء جهة الاتصال دون حذفها.';

  @override
  String get contactAddress => 'العنوان';

  @override
  String get contactAreaKm => 'المنطقة المشمولة (كم)';

  @override
  String get contactAreaKmHelp =>
      'إلى أي مسافة من عنوانها يمكنها المساعدة. اتركه فارغًا لاستخدام القيمة الافتراضية من إعدادات الطوارئ.';

  @override
  String get contactCity => 'البلدة أو المدينة';

  @override
  String get contactHandles => 'الحالات التي تتعامل معها';

  @override
  String get contactHandlesHelp =>
      'اترك الكل غير مفعّل إذا كانت تتعامل مع كل الأنواع.';

  @override
  String get contactHoursHint => 'ساعات العمل، مثل الإثنين–الجمعة 9:00–18:00';

  @override
  String get contactInactive => 'مخفي';

  @override
  String get contactKindAssociation => 'جمعية لحماية الحيوانات';

  @override
  String get contactKindOther => 'خدمة أخرى';

  @override
  String get contactKindPublicService => 'خدمة بيطرية عامة';

  @override
  String get contactKindVet => 'طبيب بيطري';

  @override
  String get contactMissingFields => 'أضف اسمًا وضع العلامة على الخريطة.';

  @override
  String get contactName => 'الاسم';

  @override
  String get contactNameHint => 'مثل عيادة سان فرانشيسكو البيطرية';

  @override
  String get contactPhones => 'أرقام الهاتف';

  @override
  String get contactPhonesHint => 'افصل بين الأرقام بفواصل';

  @override
  String get contactPlace => 'الموقع';

  @override
  String get contactRecommendedHelp =>
      'تظهر قبل جهات اتصال أقرب عند الإبلاغ عن حالة طارئة.';

  @override
  String get contactTestHelp =>
      'جهة تجريبية للاختبار. تظهر بعلامة «تجريبي»، ولا تُوثّق ولا تُراسَل أبدًا.';

  @override
  String get contactType => 'النوع';

  @override
  String get contactVerifiedHelp =>
      'فقط بعد موافقة الجهة على الظهور والتحقق من بياناتها.';

  @override
  String get copyCode => 'نسخ';

  @override
  String get dailyActive => 'نشط اليوم';

  @override
  String get dailyCheckin => 'تسجيل الحضور اليومي';

  @override
  String get dailyRewards => 'المكافآت اليومية';

  @override
  String get deleteContactTitle => 'حذف جهة الاتصال هذه؟';

  @override
  String get directions => 'الاتجاهات';

  @override
  String get editContact => 'تعديل جهة الاتصال';

  @override
  String get emergencies => 'الحالات الطارئة';

  @override
  String get emergenciesActive => 'النشطة';

  @override
  String get emergenciesAll => 'الكل';

  @override
  String get emergenciesNearYou => 'بالقرب منك';

  @override
  String get emergenciesSubtitle => 'حيوانات تحتاج إلى مساعدة عاجلة';

  @override
  String get emergencyAddPhotos => 'أضف صورة';

  @override
  String get emergencyAddPhotosHint =>
      'تساعد الآخرين في العثور على الحيوان والتعرف عليه';

  @override
  String get emergencyAllContacts => 'عرض كل جهات اتصال الطوارئ';

  @override
  String get emergencyAlreadyReported => 'لقد أبلغت عن ذلك بالفعل.';

  @override
  String get emergencyCallReporter => 'اتصل بمن أبلغ';

  @override
  String get emergencyClose => 'إغلاق';

  @override
  String get emergencyCloseTitle => 'إغلاق هذه الحالة؟';

  @override
  String get emergencyContacts => 'جهات اتصال الطوارئ';

  @override
  String get emergencyDetails => 'ماذا يحدث؟';

  @override
  String get emergencyDetailsHint =>
      'مثل كلب صدمته سيارة، ملقى على جانب الطريق ولا يزال يتنفس';

  @override
  String get emergencyDetailsRequired => 'صف الوضع ببضع كلمات.';

  @override
  String get emergencyDisclaimer =>
      'CodaMi ليس خدمة طوارئ. إذا كان الحيوان في خطر مباشر، اتصل أولًا بـ 112 أو بطبيب بيطري. لا تعتمد على إشعارات التطبيق وحدها.';

  @override
  String get emergencyFalseAlarmTitle => 'اعتبارها إنذارًا كاذبًا؟';

  @override
  String get emergencyFindingContacts =>
      'جارٍ البحث عن جهات اتصال قرب هذا المكان…';

  @override
  String get emergencyHelpDone => 'شكرًا! تم إخبار من أبلغ.';

  @override
  String get emergencyHelpMessage =>
      'سيعرف من أبلغ أن أحدًا قادم. اذهب فقط إذا كان ذلك آمنًا لك.';

  @override
  String get emergencyHelpTitle => 'هل ستساعد؟';

  @override
  String get emergencyImHelping => 'سأساعد';

  @override
  String get emergencyMarkFalseAlarm => 'اعتبارها إنذارًا كاذبًا';

  @override
  String get emergencyMarkResolved => 'تحديدها كمحلولة';

  @override
  String get emergencyMissingFields =>
      'اختر ما حدث ونوع الحيوان، وصف الوضع، وضع العلامة.';

  @override
  String get emergencyNoContacts =>
      'لا توجد جهات اتصال لهذه المنطقة بعد. اتصل بـ 112 أو بطبيب بيطري.';

  @override
  String get emergencyPhoneHint =>
      'يظهر لمن يريد المساعدة ليتمكن من الاتصال بك.';

  @override
  String get emergencyPinHint => 'حرّك الخريطة لوضع العلامة حيث يوجد الحيوان.';

  @override
  String get emergencyPinned => 'تم وضع العلامة';

  @override
  String get emergencyReopen => 'إعادة فتح';

  @override
  String get emergencyReportFalse => 'الإبلاغ عنها كحالة كاذبة';

  @override
  String get emergencyReportFalseDone => 'شكرًا، سيتحقق فريقنا منها.';

  @override
  String get emergencyReportFalseMessage => 'سيتحقق فريقنا من هذه الحالة.';

  @override
  String get emergencyReportFalseTitle => 'هل هذه الحالة كاذبة؟';

  @override
  String get emergencyResolveTitle => 'تحديدها كمحلولة؟';

  @override
  String get emergencyResolved => 'تم تحديدها كمحلولة';

  @override
  String get emergencySend => 'إرسال الحالة الطارئة';

  @override
  String get emergencySendFailed =>
      'تعذّر إرسال الحالة. تحقق من اتصالك وحاول مجددًا، أو اتصل بـ 112.';

  @override
  String get emergencySending => 'جارٍ الإرسال…';

  @override
  String get emergencySent =>
      'تم إرسال الحالة. يجري تنبيه الأشخاص القريبين. يمكنك أيضًا الاتصال مباشرة بجهات الاتصال أدناه.';

  @override
  String get emergencySettings => 'إعدادات الطوارئ';

  @override
  String get emergencySettingsSubtitle => 'مسافات التنبيه وترتيب جهات الاتصال';

  @override
  String get emergencyStatusClosed => 'مغلقة';

  @override
  String get emergencyStatusFalseAlarm => 'إنذار كاذب';

  @override
  String get emergencyStatusHelping => 'المساعدة في الطريق';

  @override
  String get emergencyStatusOpen => 'تحتاج إلى مساعدة';

  @override
  String get emergencyStatusResolved => 'محلولة';

  @override
  String get emergencySuggestedContacts => 'من يمكنه المساعدة';

  @override
  String get emergencySuggestedContactsHint =>
      'أقرب جهات الاتصال المناسبة أولًا. اتصل بها مباشرة.';

  @override
  String get emergencyTypeAbandoned => 'حيوان متروك';

  @override
  String get emergencyTypeDanger => 'حيوان في خطر';

  @override
  String get emergencyTypeInjured => 'حيوان مصاب';

  @override
  String get emergencyTypeIntervention => 'طلب تدخل';

  @override
  String get emergencyTypeOther => 'حالة طارئة أخرى';

  @override
  String get emergencyTypeUrgentFound => 'عُثر عليه ويحتاج رعاية عاجلة';

  @override
  String get emergencyUnavailable => 'هذه الحالة لم تعد متاحة.';

  @override
  String get emergencyWhatHappened => 'ماذا حدث؟';

  @override
  String get emergencyWhere => 'أين الحيوان؟';

  @override
  String get emergencyWhereHint =>
      'يُشارَك المكان الدقيق ليتمكن المساعدون من العثور على الحيوان.';

  @override
  String get emergencyYouAreHelping => 'قلت إنك ستساعد. شكرًا لك!';

  @override
  String get emergencyYourPhone => 'هاتفك';

  @override
  String get flagBurst =>
      'أصبح كثير من أصدقاء هذا المستخدم نشطين في اليوم نفسه';

  @override
  String get flagDeviceUsed => 'استُخدم هذا الهاتف من قبل لدعوة أخرى';

  @override
  String get flagSameDevice => 'الهاتف نفسه الذي يستخدمه صاحب الدعوة';

  @override
  String get haveInviteCode => 'هل دعاك صديق؟ أدخل رمزه';

  @override
  String get invitePromptTitle => 'هل دعاك صديق؟';

  @override
  String get invitePromptBody =>
      'أدخل رمز الدعوة الخاص به ليحصل صديقك على الفضل في انضمامك إلى CodaMi.';

  @override
  String invitePromptLater(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'يمكنك أيضًا إضافته لاحقًا من الملف الشخصي ← دعوة الأصدقاء، خلال $days أيام من التسجيل.',
      one: 'يمكنك أيضًا إضافته لاحقًا اليوم من الملف الشخصي ← دعوة الأصدقاء.',
    );
    return '$_temp0';
  }

  @override
  String get inviteCodeLabel => 'رمز الدعوة';

  @override
  String get inviteCodeFromLink =>
      'تمت تعبئته من رابط الدعوة. اضغط على استخدام للتأكيد.';

  @override
  String get inviteCodeFormat =>
      'تتكون رموز الدعوة من 6 أحرف وأرقام، مثل ABC234.';

  @override
  String get inviteCodeNotFound => 'لم نعثر على هذا الرمز. تحقّق منه مع صديقك.';

  @override
  String get inviteCodeOwn => 'هذا رمزك الخاص. شاركه مع أصدقائك بدلًا من ذلك.';

  @override
  String inviteCodeTooLate(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'لا يمكن إضافة رموز الدعوة إلا خلال أول $days أيام بعد التسجيل.',
      one: 'لا يمكن إضافة رموز الدعوة إلا في يوم التسجيل.',
    );
    return '$_temp0';
  }

  @override
  String get inviteCodeTooManyTries =>
      'رموز خاطئة كثيرة اليوم. حاول مرة أخرى غدًا.';

  @override
  String get howInvitesWork => 'كيف تعمل';

  @override
  String get inviteApproved => 'تمت الموافقة على الدعوة';

  @override
  String get inviteCodeAlreadyUsed => 'لقد استخدمت رمز دعوة من قبل.';

  @override
  String get inviteCodeInvalid => 'هذا الرمز غير صالح.';

  @override
  String get inviteCodeNotAllowed =>
      'لا يمكن استخدام هذا الرمز: إنه رمزك أنت، أو مرّ وقت طويل على تسجيلك.';

  @override
  String get inviteFriends => 'دعوة الأصدقاء';

  @override
  String get inviteFriendsSubtitle => 'كن سفيرًا لـ CodaMi';

  @override
  String get inviteIntro =>
      'كل مستخدم جديد في CodaMi هو عينان إضافيتان تبحثان عن الحيوانات المفقودة. ادعُ أصدقاءك وكن سفيرًا لـ CodaMi.';

  @override
  String get inviteRejected => 'تم رفض الدعوة';

  @override
  String get inviteStatusExpired => 'لم يصبح نشطًا في الوقت المحدد';

  @override
  String get inviteStatusPending => 'سجّل، ولم يصبح نشطًا بعد';

  @override
  String get inviteStatusQualified => 'نشط – تم كسب النقاط';

  @override
  String get inviteStatusRejected => 'لم تُحتسب';

  @override
  String get inviteStatusReview => 'قيد التحقق';

  @override
  String get inviteStep1 =>
      'شارك رمزك. يُدخله صديقك في الملف الشخصي ← دعوة الأصدقاء بعد التسجيل.';

  @override
  String get invitedFriends => 'الأصدقاء المدعوون (النشطون)';

  @override
  String get invitesToReview => 'دعوات للمراجعة';

  @override
  String get invitesToReviewSubtitle => 'دعوات أوقفتها فحوص مكافحة الاحتيال';

  @override
  String get levelAmbassador => 'سفير';

  @override
  String get levelBonus => 'نقاط المكافأة';

  @override
  String get settingsActiveFriends => 'أصدقاء نشطون';

  @override
  String get levelChampion => 'بطل CodaMi';

  @override
  String get levelSuperAmbassador => 'سفير متميز';

  @override
  String get levelSupporter => 'صديق CodaMi';

  @override
  String get myEmergencies => 'حالاتي';

  @override
  String get myPoints => 'نقاطي';

  @override
  String get noActiveEmergencies => 'لا توجد حالات طارئة';

  @override
  String get noEmergenciesMessage =>
      'تظهر هنا الحالات الطارئة المُبلَّغ عنها قرب مدينتك.';

  @override
  String get noEmergenciesNearby => 'لا توجد حالات طارئة بالقرب منك';

  @override
  String get noEmergencyContacts => 'لا توجد جهات اتصال بعد';

  @override
  String get noEmergencyContactsAdmin =>
      'أضف أطباء بيطريين وجمعيات وخدمات، أو جهات اتصال تجريبية لتجربة الميزة.';

  @override
  String get noEmergencyContactsMessage =>
      'ستُضاف جهات الاتصال قريبًا. في الطوارئ، اتصل بـ 112 أو بطبيب بيطري.';

  @override
  String get noInvitesToReview => 'لا شيء للمراجعة';

  @override
  String get noInvitesToReviewMessage =>
      'تظهر هنا الدعوات المشبوهة. لا يُرفض شيء دون قرارك.';

  @override
  String get noInvitesYet => 'لا توجد دعوات بعد. شارك رمزك لتبدأ.';

  @override
  String get noLevelYet => 'لا يوجد مستوى بعد';

  @override
  String get noMyEmergencies => 'لم تُبلغ عن أي حالة طارئة';

  @override
  String get noPointsYet => 'لا توجد نقاط بعد. استلم مكافأتك اليومية لتبدأ.';

  @override
  String get open24h => 'مفتوح 24 ساعة';

  @override
  String get openMapFailed => 'تعذّر فتح الخريطة.';

  @override
  String get photos => 'الصور';

  @override
  String get pointsAdjusted => 'عدّلها CodaMi';

  @override
  String get pointsDailyActive => 'نشط اليوم';

  @override
  String get pointsDailyCheckin => 'تسجيل الحضور اليومي';

  @override
  String get pointsFriendJoined => 'أصبح صديق نشطًا';

  @override
  String get pointsHistory => 'السجل';

  @override
  String get pointsLevelBonus => 'مكافأة المستوى الجديد';

  @override
  String get pointsOther => 'نقاط';

  @override
  String get pointsSettings => 'النقاط والمكافآت';

  @override
  String get pointsSettingsIntro =>
      'تُطبَّق التغييرات فورًا. تُستبدل القيم خارج الحدود بالقيم الافتراضية.';

  @override
  String get pointsSettingsSubtitle => 'المكافآت اليومية والدعوات والمستويات';

  @override
  String get pointsStreakBonus => 'مكافأة الأيام المتتالية';

  @override
  String get pointsWelcome => 'مكافأة الترحيب';

  @override
  String get recommendedContact => 'موصى به';

  @override
  String get reject => 'رفض';

  @override
  String get reportEmergency => 'الإبلاغ عن حالة طارئة';

  @override
  String get searchContacts => 'ابحث بالاسم أو البلدة';

  @override
  String get settingsActiveMinutes => 'دقائق الاستخدام لـ «نشط اليوم»';

  @override
  String get settingsAlertsNearby => 'تنبيهات للأشخاص القريبين';

  @override
  String get settingsAutoCloseHours => 'إغلاق بعد (ساعات دون تحديثات)';

  @override
  String get settingsAutoCloseHoursHelp =>
      'تُغلق الحالات المفتوحة تلقائيًا بعد هذه المدة.';

  @override
  String get settingsCodeEntryDays => 'أيام بعد التسجيل لإدخال رمز';

  @override
  String get settingsContactsPriority => 'أولوية جهات الاتصال';

  @override
  String get settingsDefaultAreaKm => 'المنطقة الافتراضية (كم)';

  @override
  String get settingsDefaultAreaKmHelp =>
      'تُستخدم لجهات الاتصال التي ليس لها منطقة خاصة.';

  @override
  String get settingsEmailContacts => 'تنبيهات بالبريد لجهات الاتصال';

  @override
  String get settingsEmailContactsHelp =>
      'يرسل بريدًا إلى جهات الاتصال الموثقة. يجب إعداد خدمة البريد أولًا.';

  @override
  String get settingsMaxPerDay => 'الأصدقاء النشطون يوميًا قبل التحقق';

  @override
  String get settingsMaxPerDayHelp =>
      'إذا زاد العدد خلال 24 ساعة تُحال الدعوة إلى المراجعة.';

  @override
  String get settingsMaxRecipients => 'الحد الأقصى للأشخاص المنبَّهين';

  @override
  String get settingsMaxSuggested => 'جهات الاتصال المقترحة';

  @override
  String get settingsMinRecipients => 'عدد الأشخاص المطلوب الوصول إليهم';

  @override
  String get settingsMinRecipientsHelp =>
      'تُستخدم الدائرة التالية حتى الوصول إلى هذا العدد.';

  @override
  String get settingsQualifyDays => 'أيام النشاط المطلوبة';

  @override
  String get settingsQualifyWithinDays => 'خلال (أيام بعد التسجيل)';

  @override
  String get settingsReferralPoints => 'نقاط لكل صديق نشط';

  @override
  String get settingsRings => 'دوائر التنبيه (كم)';

  @override
  String get settingsRingsHelp => 'مفصولة بفواصل، من الأصغر، مثل 5, 10, 25';

  @override
  String get settingsSaved => 'تم الحفظ';

  @override
  String get settingsStreakDays => 'أيام مكافأة التتابع';

  @override
  String get settingsWeight24h => 'مكافأة الفتح 24 ساعة';

  @override
  String get settingsWeightHelp =>
      'تحصل جهات الاتصال على هذه المكافآت وتخسر نقاطًا عن كل كم من المسافة. الأعلى نتيجة يظهر أولًا.';

  @override
  String get settingsWeightPerKm => 'خصم لكل كم';

  @override
  String get settingsWeightPerKmHelp =>
      'مع 1، تظهر جهة موصى بها (20) قبل جهة أقرب منها بما يصل إلى 20 كم.';

  @override
  String get settingsWeightRecommended => 'مكافأة الموصى به';

  @override
  String get settingsWeightVerified => 'مكافأة الموثّق';

  @override
  String get settingsWelcomePoints => 'نقاط للصديق المدعو';

  @override
  String get settingsWelcomePointsHelp => 'تُمنح عند إدخال الرمز. 0 يوقفها.';

  @override
  String get shareInvite => 'مشاركة';

  @override
  String get statActiveEmergencies => 'حالات طارئة نشطة';

  @override
  String get testContactBadge => 'تجريبي – ليست جهة اتصال حقيقية';

  @override
  String get topLevelReached => 'وصلت إلى أعلى مستوى. شكرًا لك!';

  @override
  String get useCode => 'استخدام';

  @override
  String get verifiedContact => 'موثّق';

  @override
  String get viewInvitee => 'المستخدم المدعو';

  @override
  String get viewInviter => 'صاحب الدعوة';

  @override
  String get yourInviteCode => 'رمز دعوتك';

  @override
  String get yourInvites => 'دعواتك';

  @override
  String get zeroTurnsOff => '0 يوقفها';

  @override
  String activeProgress(int done, int total) {
    return '$done من $total دقائق اليوم';
  }

  @override
  String claimedPoints(int points) {
    return '+$points نقطة!';
  }

  @override
  String claimedWithBonus(int points, int bonus) {
    return '+$points نقطة ومكافأة تتابع +$bonus!';
  }

  @override
  String emergenciesNearYouCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count حالات طارئة لحيوانات بالقرب منك',
      one: 'حالة طارئة واحدة لحيوان بالقرب منك',
    );
    return '$_temp0';
  }

  @override
  String emergencyAlertedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تم تنبيه $count أشخاص قريبين',
      one: 'تم تنبيه شخص واحد قريب',
      zero: 'لم يفعّل أحد قريب التنبيهات بعد',
    );
    return '$_temp0';
  }

  @override
  String emergencyFalseReports(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'أُبلغ عنها ككاذبة $count مرات',
      one: 'أُبلغ عنها ككاذبة مرة واحدة',
    );
    return '$_temp0';
  }

  @override
  String emergencyHelpersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count أشخاص سيساعدون',
      one: 'شخص واحد سيساعد',
    );
    return '$_temp0';
  }

  @override
  String inviteCodeAccepted(String name) {
    return 'تم قبول الرمز. دعاك $name – مرحبًا بك في CodaMi!';
  }

  @override
  String inviteShareText(String code, String link) {
    return 'أستخدم CodaMi لمساعدة الحيوانات المفقودة على العودة إلى منازلها. انضم إليّ برمز دعوتي $code: $link';
  }

  @override
  String inviteStep2(int days, int within) {
    return 'يحدد مدينته ويستخدم التطبيق في $days أيام مختلفة خلال $within يومًا من التسجيل.';
  }

  @override
  String inviteStep3(int points) {
    return 'تحصل على $points نقطة وترتقي في مستويات السفير.';
  }

  @override
  String kmAway(String km) {
    return 'على بعد $km كم';
  }

  @override
  String levelFriends(String level) {
    return '$level: الأصدقاء النشطون';
  }

  @override
  String levelRule(String level, int friends, int bonus) {
    return '$level · $friends+ أصدقاء · +$bonus';
  }

  @override
  String nextLevelHint(int count, String level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count أصدقاء نشطين إضافيين لتصبح $level',
      one: 'صديق نشط واحد إضافي لتصبح $level',
    );
    return '$_temp0';
  }

  @override
  String plusPoints(int points) {
    return '+$points نقطة';
  }

  @override
  String pointsTotal(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points نقطة',
      one: 'نقطة واحدة',
    );
    return '$_temp0';
  }

  @override
  String streakLine(int streak, int days, int bonus) {
    return '$streak أيام متتالية · مكافأة +$bonus كل $days أيام';
  }

  @override
  String get pointsFeedback => 'تم إرسال الرأي';

  @override
  String get whatsNew => 'ما الجديد';

  @override
  String get whatsNewSubtitle => 'التغييرات في كل إصدار';

  @override
  String get whatsNewTitle => 'ما الجديد في CodaMi';

  @override
  String get whatsNewIntro => 'إليك ما تغيّر في آخر تحديث.';

  @override
  String whatsNewVersion(String version) {
    return 'الإصدار $version';
  }

  @override
  String get whatsNewSectionNew => 'جديد';

  @override
  String get whatsNewSectionImproved => 'تحسينات';

  @override
  String get whatsNewSectionFixed => 'إصلاحات';

  @override
  String get whatsNewEmpty => 'لا توجد ملاحظات تحديث بعد.';

  @override
  String get whatsNewDone => 'حسنًا';

  @override
  String get feedbackTitle => 'ما رأيك في CodaMi؟';

  @override
  String get feedbackBody =>
      'يصل رأيك مباشرةً إلى فريق CodaMi ويساعدنا على تحسين التطبيق.';

  @override
  String feedbackPointsOffer(int points) {
    return '+$points نقطة على أول رأي ترسله';
  }

  @override
  String get feedbackStarsHint => 'اضغط على نجمة للتقييم';

  @override
  String get feedbackCommentHint =>
      'ما الذي يعجبك، أو ما الذي يمكن تحسينه؟ (اختياري)';

  @override
  String get feedbackSend => 'إرسال الرأي';

  @override
  String get feedbackLater => 'ليس الآن';

  @override
  String get feedbackThanks => 'شكرًا على رأيك!';

  @override
  String feedbackThanksPoints(int points) {
    return 'شكرًا على رأيك! +$points نقطة';
  }

  @override
  String get feedbackAlreadyToday =>
      'لقد أرسلت رأيك اليوم بالفعل. يمكنك إرسال المزيد غدًا.';

  @override
  String get sendFeedbackSubtitle => 'أخبر الفريق برأيك';

  @override
  String get rateCodaMi => 'قيّم CodaMi';

  @override
  String get rateCodaMiSubtitle => 'اترك مراجعة على Google Play';

  @override
  String get adminFeedback => 'الآراء';

  @override
  String get adminFeedbackSubtitle => 'رأي المستخدمين في التطبيق';

  @override
  String get adminFeedbackEmpty => 'لا توجد آراء بعد.';

  @override
  String feedbackRatingsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count تقييم',
      few: '$count تقييمات',
      two: 'تقييمان',
      one: 'تقييم واحد',
    );
    return '$_temp0';
  }

  @override
  String get feedbackNoComment => 'بلا تعليق';

  @override
  String get adminWhatsNewSubtitle => 'ملاحظات تظهر للمستخدمين بعد كل تحديث';

  @override
  String get releaseAdd => 'إضافة إصدار';

  @override
  String get releaseEdit => 'تعديل الملاحظات';

  @override
  String get releaseVersion => 'رقم الإصدار';

  @override
  String get releaseVersionHelp =>
      'مثل 1.1.0. يجب أن يطابق اسم إصدار التطبيق في المتجر.';

  @override
  String get releaseVersionInvalid => 'استخدم أرقامًا ونقاطًا، مثل 1.1.0.';

  @override
  String get releaseVersionExists => 'هذا الإصدار لديه ملاحظات بالفعل.';

  @override
  String get releasePublishedHelp =>
      'لا يرى المستخدمون إلا الملاحظات المنشورة.';

  @override
  String get releaseDraft => 'مسودة';

  @override
  String get releaseLinesHelp => 'تغيير واحد في كل سطر.';

  @override
  String get releaseLanguageHelp =>
      'اللغات المتروكة فارغة تعرض الملاحظات الإنجليزية.';

  @override
  String get releaseEnglishRequired =>
      'اكتب الملاحظات الإنجليزية أولًا: تعتمد عليها اللغات الأخرى عند غياب ترجمتها.';

  @override
  String get releaseDeleteTitle => 'حذف هذه الملاحظات؟';

  @override
  String releaseDeleteBody(String version) {
    return 'ستُحذف ملاحظات الإصدار $version لدى الجميع.';
  }

  @override
  String get releaseNone => 'لا توجد إصدارات بعد. أضف ملاحظات تحديثك القادم.';

  @override
  String releaseThisApp(String version) {
    return 'هذا التطبيق: الإصدار $version';
  }

  @override
  String get feedbackAndReviews => 'الآراء والمراجعات';

  @override
  String get settingsFeedbackPoints => 'نقاط أول رأي';

  @override
  String get settingsFeedbackAfterDays =>
      'عدد الأيام بعد التسجيل قبل طلب الرأي';

  @override
  String get settingsReviewActiveDays => 'أيام الاستخدام قبل الطلب';

  @override
  String get settingsReviewAfterDays =>
      'عدد الأيام بعد التسجيل قبل نافذة التقييم في المتجر';

  @override
  String get settingsReviewEveryDays =>
      'عدد الأيام بين طلبات التقييم في المتجر';

  @override
  String get settingsReviewHelp =>
      'نافذة التقييم في المتجر لا تمنح نقاطًا أبدًا: لا يسمح Google Play وApp Store بذلك.';

  @override
  String get petitions => 'العرائض';

  @override
  String get petition => 'عريضة';

  @override
  String get petitionsSubtitle => 'حملات للرفق بالحيوان يختارها فريقنا';

  @override
  String get adminPetitionsSubtitle =>
      'أضف عرائض الرفق بالحيوان وراجعها وانشرها';

  @override
  String petitionsBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count عريضة للرفق بالحيوان بانتظار توقيعك',
      many: '$count عريضة للرفق بالحيوان بانتظار توقيعك',
      few: '$count عرائض للرفق بالحيوان بانتظار توقيعك',
      two: 'عريضتان للرفق بالحيوان بانتظار توقيعك',
      one: 'عريضة واحدة للرفق بالحيوان بانتظار توقيعك',
      zero: 'لا توجد عرائض للرفق بالحيوان بانتظار توقيعك',
    );
    return '$_temp0';
  }

  @override
  String get petitionsIntro =>
      'يتحقق فريق CodaMi من كل عريضة قبل ظهورها هنا. تقرأها وتوقّعها على الموقع الأصلي.';

  @override
  String get petitionsEmpty =>
      'لا توجد عرائض بعد. سيضيف الفريق هنا حملات للرفق بالحيوان.';

  @override
  String get petitionAdminEmpty =>
      'لا توجد عرائض هنا. اضغط على إضافة عريضة لإضافة واحدة من Change.org أو Care2 أو Avaaz أو من منظمة موثوقة.';

  @override
  String get petitionView => 'عرض العريضة';

  @override
  String get petitionSignOnSite => 'اقرأ ووقّع على الموقع الأصلي';

  @override
  String get petitionOpenFailed => 'تعذّر فتح صفحة العريضة.';

  @override
  String get petitionIssue => 'القضية';

  @override
  String get petitionAction => 'ما تطالب به العريضة';

  @override
  String get petitionWhy => 'لماذا يهم ذلك الحيوانات';

  @override
  String get petitionWhere => 'العريضة الأصلية';

  @override
  String petitionStartedOn(String date) {
    return 'بدأت في $date';
  }

  @override
  String get petitionDisclaimer =>
      'هذه العريضة مستضافة على موقع خارجي. لا يجمع CodaMi التوقيعات وليس مسؤولًا عن محتوى الصفحة الأصلية.';

  @override
  String get petitionEndedNote =>
      'انتهت هذه الحملة. لا يزال بإمكانك قراءة الصفحة الأصلية.';

  @override
  String get petitionUnavailableNote => 'العريضة الأصلية لم تعد متاحة.';

  @override
  String get petitionTopicPets => 'الحيوانات الأليفة';

  @override
  String get petitionTopicWildlife => 'الحياة البرية';

  @override
  String get petitionTopicFarm => 'حيوانات المزارع';

  @override
  String get petitionTopicTesting => 'التجارب على الحيوانات';

  @override
  String get petitionTopicEntertainment => 'السيرك وحدائق الحيوان';

  @override
  String get petitionTopicMarine => 'الحياة البحرية';

  @override
  String get petitionTopicOther => 'أخرى';

  @override
  String get petitionStatusActive => 'نشطة';

  @override
  String get petitionStatusCompleted => 'مكتملة';

  @override
  String get petitionStatusClosed => 'مغلقة';

  @override
  String get petitionStatusUnavailable => 'لم تعد متاحة';

  @override
  String get petitionReviewPending => 'بانتظار المراجعة';

  @override
  String get petitionReviewApproved => 'مقبولة';

  @override
  String get petitionReviewRejected => 'مرفوضة';

  @override
  String get petitionAdd => 'إضافة عريضة';

  @override
  String get petitionEdit => 'تعديل العريضة';

  @override
  String get petitionSectionSource => 'العريضة الأصلية';

  @override
  String get petitionUrl => 'رابط العريضة';

  @override
  String get petitionUrlInvalid => 'الصق الرابط كاملًا بدءًا من https://';

  @override
  String get petitionTitle => 'العنوان';

  @override
  String get petitionSource => 'المنصة أو المنظمة';

  @override
  String get petitionCountry => 'الدولة أو المنطقة';

  @override
  String get petitionCountryHelp => 'اتركه فارغًا للحملات الدولية.';

  @override
  String get petitionStartedOnPick => 'تاريخ بدء العريضة (اختياري)';

  @override
  String get petitionTopic => 'الموضوع';

  @override
  String get petitionSectionText => 'وصفنا';

  @override
  String get petitionOwnWordsHelp =>
      'اكتب بكلماتك الخاصة. لا تنسخ نصًا من الصفحة الأصلية.';

  @override
  String get petitionSummary => 'ملخص قصير';

  @override
  String get petitionImage => 'الصورة';

  @override
  String get petitionImageAdd => 'إضافة صورة';

  @override
  String get petitionImageChange => 'تغيير الصورة';

  @override
  String get petitionImageHelp =>
      'اختياري. بدون صورة، تعرض البطاقة أيقونة الموضوع.';

  @override
  String get petitionImagePermission => 'لدينا إذن باستخدام هذه الصورة';

  @override
  String get petitionImagePermissionNeeded =>
      'أكّد أن لديك إذنًا باستخدام الصورة، أو أزلها.';

  @override
  String get petitionImageTooBig =>
      'الصورة كبيرة جدًا. اختر صورة أصغر من 5 ميغابايت.';

  @override
  String get petitionChecks => 'التحقق';

  @override
  String get petitionChecksHelp =>
      'يلزم استيفاء البنود الأربعة للقبول أو النشر.';

  @override
  String get petitionCheckExists => 'الصفحة الأصلية موجودة وتفتح';

  @override
  String get petitionCheckGenuine => 'تتناول قضية حقيقية تخص الرفق بالحيوان';

  @override
  String get petitionCheckGoal => 'لها هدف واضح';

  @override
  String get petitionCheckHonest => 'لا تتضمن ادعاءات مضللة أو احتيالية';

  @override
  String get petitionChecksNeeded =>
      'حدّد جميع بنود التحقق قبل القبول أو النشر.';

  @override
  String get petitionReview => 'المراجعة';

  @override
  String get petitionReviewHelp => 'لا تظهر للمستخدمين إلا العرائض المنشورة.';

  @override
  String get petitionRejectReason => 'السبب (يراه المسؤولون فقط)';

  @override
  String get petitionStatus => 'حالة العريضة';

  @override
  String get petitionStatusHelp => 'حدّثها عند انتهاء الحملة أو حذف الصفحة.';

  @override
  String get petitionFixFields => 'املأ الحقول المحددة باللون الأحمر.';

  @override
  String get petitionDeleteTitle => 'حذف هذه العريضة؟';

  @override
  String get petitionDeleteBody => 'ستُزال من التطبيق لدى الجميع.';

  @override
  String petitionAddedOn(String date) {
    return 'أُضيفت في $date';
  }

  @override
  String petitionPublishedOn(String date) {
    return 'نُشرت في $date';
  }

  @override
  String petitionUpdatedOn(String date) {
    return 'حُدّثت في $date';
  }

  @override
  String get appUpdates => 'تحديثات التطبيق';

  @override
  String get adminAppUpdatesSubtitle => 'إصدارات المتاجر والتحديثات الإلزامية';

  @override
  String get appUpdatesSubtitle => 'الإصدارات في المتاجر';

  @override
  String get appUpdatesIntro =>
      'يرى مستخدمو الإصدارات الأقدم رسالة تحديث مع ملاحظات الجديد في أحدث إصدار. تحت الحد الأدنى للإصدار، لا يمكن استخدام التطبيق حتى يتم تحديثه. لا حاجة لإصدار جديد لتغيير ذلك.';

  @override
  String appUpdatesThisPhone(String version) {
    return 'إصدار هذا الهاتف $version';
  }

  @override
  String get appUpdatesAndroid => 'أندرويد (Google Play)';

  @override
  String get appUpdatesIos => 'آيفون (App Store)';

  @override
  String get appUpdatesLatest => 'أحدث إصدار في المتجر';

  @override
  String get appUpdatesLatestHelp =>
      'اضبطه بعد توفر التحديث في المتجر. اتركه فارغًا لعدم عرض أي رسالة.';

  @override
  String get appUpdatesMinimum => 'الحد الأدنى للإصدار';

  @override
  String get appUpdatesMinimumHelp =>
      'يجب تحديث الإصدارات الأقدم قبل استخدام التطبيق. اتركه فارغًا لعدم التقييد.';

  @override
  String get appUpdatesStoreId => 'معرّف App Store';

  @override
  String get appUpdatesStoreIdHelp =>
      'الرقم الموجود في رابط App Store ‏(apps.apple.com/app/id…). مطلوب لزر التحديث على آيفون.';

  @override
  String appUpdatesNotesPublished(String version) {
    return 'ملاحظات $version منشورة وتظهر مع التحديث';
  }

  @override
  String appUpdatesNotesDraft(String version) {
    return 'ملاحظات $version محفوظة لكنها غير منشورة';
  }

  @override
  String appUpdatesNotesMissing(String version) {
    return 'لا توجد ملاحظات للإصدار $version بعد';
  }

  @override
  String get appUpdatesBadVersion => 'استخدم إصدارًا مثل 1.2.0';

  @override
  String get appUpdatesMinimumAbove =>
      'لا يمكن أن يكون الحد الأدنى أعلى من أحدث إصدار';

  @override
  String get appUpdatesBadStoreId => 'معرّف App Store يتكون من أرقام فقط';

  @override
  String get appUpdatesRequireTitle => 'جعل التحديث إلزاميًا؟';

  @override
  String appUpdatesRequireBody(String version) {
    return 'سيتعين على كل من لديه إصدار أقل من $version التحديث قبل استخدام التطبيق.';
  }

  @override
  String get appUpdatesRequireConfirm => 'اجعله إلزاميًا';

  @override
  String get updateAvailableTitle => 'يتوفر تحديث';

  @override
  String updateAvailableBody(String latest, String installed) {
    return 'الإصدار $latest من CodaMi جاهز. لديك $installed.';
  }

  @override
  String get updateNow => 'حدّث الآن';

  @override
  String get updateLater => 'لاحقًا';

  @override
  String get updateRequiredTitle => 'التحديث مطلوب';

  @override
  String updateRequiredBody(String version) {
    return 'لم يعد هذا الإصدار من CodaMi مدعومًا. حدّث إلى الإصدار $version لمتابعة استخدام التطبيق.';
  }

  @override
  String updateBanner(String version) {
    return 'الإصدار $version متوفر';
  }

  @override
  String get updateStoreFailed =>
      'تعذر فتح المتجر. يرجى تحديث CodaMi من تطبيق المتجر.';

  @override
  String get rateCodaMiSubtitleIos => 'اترك تقييمًا على App Store';

  @override
  String get updateContinueAsAdmin => 'المتابعة كمسؤول';

  @override
  String get navShop => 'المتجر';

  @override
  String get shop => 'المتجر';

  @override
  String get adminShopSubtitle => 'المنتجات والعلامات والموردون ومفتاح التشغيل';

  @override
  String get shopSubtitle => 'منتجات لحيواناتك الأليفة';

  @override
  String get shopSearchHint => 'ابحث عن منتجات';

  @override
  String get shopEmpty => 'المنتجات قادمة قريبًا. عد لاحقًا!';

  @override
  String get shopNoResults => 'لا توجد منتجات مطابقة.';

  @override
  String get shopInStock => 'متوفر';

  @override
  String get shopLowStock => 'كمية محدودة';

  @override
  String get shopOutOfStock => 'نفد المخزون';

  @override
  String get shopComingSoon => 'قريبًا';

  @override
  String get shopModelOwnStock => 'مخزوننا';

  @override
  String get shopModelBrand => 'علامة شريكة';

  @override
  String get shopModelDropship => 'الشحن المباشر';

  @override
  String get shopModelAffiliate => 'رابط تسويق بالعمولة';

  @override
  String get shopModelOwnStockHelp => 'تحتفظ CodaMi بالمخزون وتشحنه.';

  @override
  String get shopModelBrandHelp => 'تبيع العلامة عبر CodaMi وتشحن الطلب.';

  @override
  String get shopModelDropshipHelp => 'يشحن المورد الطلب مباشرة إلى العميل.';

  @override
  String get shopModelAffiliateHelp =>
      'يتم الشراء من موقع الشريك عبر رابطنا وتحصل CodaMi على عمولة.';

  @override
  String shopBuyOn(String partner) {
    return 'اشترِ من $partner';
  }

  @override
  String shopAffiliateNote(String partner) {
    return 'يبيعه ويشحنه $partner. قد تحصل CodaMi على عمولة من هذه العملية.';
  }

  @override
  String shopPriceOnPartner(String partner) {
    return 'السعر على $partner';
  }

  @override
  String get shopAddToCart => 'أضف إلى السلة';

  @override
  String get shopCheckoutSoon => 'الشراء داخل التطبيق قادم قريبًا.';

  @override
  String get shopAllAnimals => 'لجميع الحيوانات';

  @override
  String get shopDescription => 'الوصف';

  @override
  String get shopOpenFailed => 'تعذر فتح الرابط.';

  @override
  String get shopPreviewOff => 'معاينة: المتجر مغلق ولا يراه المستخدمون.';

  @override
  String get shopAdminIntro =>
      'أدر متجر CodaMi. لا يراه المستخدمون إلا عند تشغيله.';

  @override
  String get shopOpenSwitch => 'المتجر مفتوح للمستخدمين';

  @override
  String get shopOnHelp => 'مفعّل: يرى الجميع تبويب المتجر.';

  @override
  String get shopOffHelp =>
      'معطّل: لا يرى المستخدمون المتجر، ويمكن للمشرفين تجهيزه.';

  @override
  String get shopTurnOnTitle => 'فتح المتجر؟';

  @override
  String get shopTurnOnBody =>
      'سيرى جميع المستخدمين تبويب المتجر والمنتجات النشطة فورًا.';

  @override
  String get shopTurnOffTitle => 'إغلاق المتجر؟';

  @override
  String get shopTurnOffBody =>
      'سيختفي تبويب المتجر فورًا لدى الجميع، مع الاحتفاظ بالمنتجات والإعدادات.';

  @override
  String get shopTurnOn => 'فتح';

  @override
  String get shopTurnOff => 'إغلاق';

  @override
  String get shopSalesModels => 'نماذج البيع';

  @override
  String get shopSalesModelsHelp =>
      'إيقاف نموذج يخفي كل منتجاته عن المستخدمين.';

  @override
  String get shopCatalog => 'الكتالوج';

  @override
  String get shopProducts => 'المنتجات';

  @override
  String get shopCategories => 'الفئات';

  @override
  String get shopBrands => 'العلامات التجارية';

  @override
  String get shopSuppliers => 'الموردون';

  @override
  String get shopPreview => 'معاينة المتجر';

  @override
  String get shopPreviewSubtitle => 'شاهد المتجر كما سيراه المستخدمون';

  @override
  String shopProductsCount(int active, int total) {
    return '$active نشط · $total إجمالًا';
  }

  @override
  String get shopAddProduct => 'إضافة منتج';

  @override
  String get shopEditProduct => 'تعديل المنتج';

  @override
  String get shopProductsEmpty => 'لا توجد منتجات بعد. أضف أول منتج.';

  @override
  String get shopActive => 'نشط';

  @override
  String get shopHidden => 'مخفي';

  @override
  String get shopNeedCategory => 'أضف فئة أولًا (المتجر ← الفئات).';

  @override
  String get shopPhotos => 'الصور';

  @override
  String get shopPhotosHelp =>
      'حتى 6 صور. الأولى هي الغلاف؛ اضغط مطولًا واسحب لإعادة الترتيب.';

  @override
  String get shopAddPhoto => 'إضافة صورة';

  @override
  String get shopImageTooBig => 'يجب أن تكون الصور أصغر من 5 ميغابايت.';

  @override
  String get shopDetails => 'التفاصيل';

  @override
  String get shopName => 'الاسم';

  @override
  String get shopCategory => 'الفئة';

  @override
  String get shopPickCategory => 'اختر فئة';

  @override
  String get shopAnimals => 'الحيوانات';

  @override
  String get shopAnimalsHelp =>
      'عدم الاختيار يعني لكل الحيوانات. يرى المستخدمون منتجات حيواناتهم أولًا.';

  @override
  String get shopSalesModel => 'نموذج البيع';

  @override
  String get shopPartnerName => 'المتجر الشريك';

  @override
  String get shopAffiliateUrl => 'رابط العمولة';

  @override
  String get shopBrand => 'العلامة التجارية';

  @override
  String get shopNoBrand => 'بدون علامة';

  @override
  String get shopSupplier => 'المورد';

  @override
  String get shopNoSupplier => 'بدون مورد';

  @override
  String get shopPriceSection => 'السعر';

  @override
  String get shopPrice => 'السعر (€)';

  @override
  String get shopPriceAffiliateHelp =>
      'اختياري: تتغير الأسعار على موقع الشريك.';

  @override
  String get shopPriceInvalid => 'أدخل سعرًا، مثل 12.90';

  @override
  String get shopCompareAt => 'السعر قبل الخصم (€)';

  @override
  String get shopCompareAtHelp => 'اختياري. يظهر مشطوبًا بجانب السعر.';

  @override
  String get shopCompareAtInvalid => 'يجب أن يكون أعلى من السعر.';

  @override
  String get shopAvailability => 'التوفر';

  @override
  String get shopVisible => 'مرئي للمستخدمين';

  @override
  String get shopVisibleHelp => 'المنتجات المخفية يراها المشرفون فقط.';

  @override
  String get shopCategoryVisibleHelp =>
      'عند الإخفاء تُخفى الفئة وكل منتجاتها عن المستخدمين.';

  @override
  String get shopBrandVisibleHelp =>
      'عند الإخفاء تُخفى كل منتجات العلامة عن المستخدمين.';

  @override
  String get shopSupplierActiveHelp =>
      'عند الإيقاف تُخفى كل منتجات هذا المورد عن المستخدمين.';

  @override
  String get shopDeleteProductTitle => 'حذف هذا المنتج؟';

  @override
  String get shopDeleteProductBody =>
      'سيُزال من المتجر مع صوره. لا يمكن التراجع.';

  @override
  String shopDeleteTitle(String name) {
    return 'حذف $name؟';
  }

  @override
  String get shopDeleteBody => 'لا يمكن التراجع عن ذلك.';

  @override
  String get shopInUse =>
      'لا يزال مستخدمًا في منتجات أو فئات فرعية، لذا لا يمكن حذفه. أخفِه بدلًا من ذلك.';

  @override
  String get shopFixFields => 'تحقق من الحقول المميزة بالأحمر.';

  @override
  String get shopLinkInvalid => 'أدخل رابطًا كاملًا يبدأ بـ https://';

  @override
  String get shopAddCategory => 'إضافة فئة';

  @override
  String get shopEditCategory => 'تعديل الفئة';

  @override
  String get shopAddStarting => 'إضافة الفئات الأساسية';

  @override
  String get shopStartingHelp =>
      'ابدأ بالطعام والإكسسوارات والعناية والألعاب والأسرّة وحقائب النقل والتقنية وغيرها. يمكنك تعديلها لاحقًا.';

  @override
  String get shopParent => 'ضمن الفئة';

  @override
  String get shopNoParent => 'لا شيء (فئة رئيسية)';

  @override
  String get shopIcon => 'الأيقونة';

  @override
  String get shopOrder => 'الترتيب';

  @override
  String get shopOrderHelp => 'الأرقام الأصغر تأتي أولًا.';

  @override
  String get shopCatFood => 'طعام';

  @override
  String get shopCatAccessories => 'إكسسوارات';

  @override
  String get shopCatCare => 'العناية';

  @override
  String get shopCatToys => 'ألعاب';

  @override
  String get shopCatBeds => 'أسرّة';

  @override
  String get shopCatCarriers => 'حقائب النقل';

  @override
  String get shopCatTech => 'تقنية';

  @override
  String get shopCatOther => 'أخرى';

  @override
  String get shopAddBrand => 'إضافة علامة';

  @override
  String get shopEditBrand => 'تعديل العلامة';

  @override
  String get shopBrandsEmpty =>
      'لا توجد علامات بعد. وهي اختيارية؛ أضفها عند وجود شركاء.';

  @override
  String get shopWebsite => 'الموقع الإلكتروني';

  @override
  String get shopLogo => 'الشعار';

  @override
  String get shopAddLogo => 'اختر الشعار';

  @override
  String get shopAddSupplier => 'إضافة مورد';

  @override
  String get shopEditSupplier => 'تعديل المورد';

  @override
  String get shopSuppliersEmpty => 'لا يوجد موردون بعد.';

  @override
  String get shopSuppliersHelp =>
      'يرى المشرفون فقط الموردين وبياناتهم. إيقاف مورد يخفي منتجاته.';

  @override
  String get shopContactName => 'جهة الاتصال';

  @override
  String get shopEmail => 'البريد الإلكتروني';

  @override
  String get shopEmailInvalid => 'أدخل بريدًا إلكترونيًا صالحًا.';

  @override
  String get shopPhone => 'الهاتف';

  @override
  String get shopOrderMethod => 'كيف تصلهم الطلبات';

  @override
  String get shopOrderManual => 'يدويًا';

  @override
  String get shopOrderManualHelp => 'يحوّل الفريق كل طلب إلى المورد.';

  @override
  String get shopOrderEmail => 'بريد تلقائي';

  @override
  String get shopOrderEmailHelp =>
      'يُرسل كل طلب مدفوع إلى المورد بالبريد (مع بدء الدفع).';

  @override
  String get shopNotes => 'ملاحظات (للمشرفين فقط)';

  @override
  String get shopForYourPets => 'لحيواناتك الأليفة';

  @override
  String get shopOnSale => 'تخفيضات';

  @override
  String get shopAllProducts => 'كل المنتجات';

  @override
  String get shopResults => 'النتائج';

  @override
  String shopProductCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count منتجات',
      one: 'منتج واحد',
    );
    return '$_temp0';
  }

  @override
  String shopYouSave(String amount) {
    return 'توفّر $amount';
  }

  @override
  String get shopCart => 'السلة';

  @override
  String get shopCartClear => 'إفراغ';

  @override
  String get shopCartEmpty => 'سلتك فارغة. أضف منتجات من المتجر.';

  @override
  String shopCartUnavailable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count منتجات لم تعد متاحة',
      one: 'منتج واحد لم يعد متاحًا',
    );
    return '$_temp0';
  }

  @override
  String get shopCheckout => 'الدفع';

  @override
  String get shopPaymentSoon => 'الدفع داخل التطبيق قادم قريبًا.';

  @override
  String get shopViewCart => 'عرض السلة';

  @override
  String get shopShipping => 'الشحن';

  @override
  String get shopShipTo => 'الشحن إلى';

  @override
  String get shopShippingNotSet => 'ستظهر خيارات الشحن هنا قريبًا.';

  @override
  String get shopFree => 'مجاني';

  @override
  String shopFreeAbove(String amount) {
    return 'مجاني فوق $amount';
  }

  @override
  String shopFreeShippingGap(String amount) {
    return 'أضف $amount للحصول على شحن مجاني';
  }

  @override
  String get shopSummary => 'الملخص';

  @override
  String get shopSubtotal => 'المجموع الفرعي';

  @override
  String get shopTotal => 'الإجمالي';

  @override
  String get shopVatIncluded => 'شامل ضريبة القيمة المضافة';

  @override
  String get shopSponsored => 'مُموَّل';

  @override
  String get shopSponsoredSection => 'مُموَّل';

  @override
  String get shopSponsoredHelp =>
      'يظهر أولًا في المتجر وفئته مع علامة \"مُموَّل\".';

  @override
  String get shopSponsorFrom => 'من';

  @override
  String get shopSponsorUntil => 'حتى';

  @override
  String get shopSponsorDatesHelp =>
      'اتركه فارغًا للبدء الآن والاستمرار حتى الإيقاف.';

  @override
  String get shopSponsorDatesInvalid => 'تاريخ الانتهاء قبل تاريخ البدء.';

  @override
  String get shopNoDate => 'بدون تاريخ';

  @override
  String get shopCost => 'سعر التكلفة (€، للمشرفين فقط)';

  @override
  String get shopCostHelp =>
      'ما تدفعه CodaMi للمورد أو العلامة. لا يراه المستخدمون أبدًا.';

  @override
  String shopMargin(String amount, int percent) {
    return 'الهامش: $amount ($percent%)';
  }

  @override
  String get shopAffiliateClicks => 'نقرات الروابط';

  @override
  String shopClicksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count نقرات على \"شراء\"',
      one: 'نقرة واحدة على \"شراء\"',
    );
    return '$_temp0';
  }

  @override
  String get shopLast30Days => 'آخر 30 يومًا · اضغط للتحديث';

  @override
  String get shopShippingIntro =>
      'إلى أين وكيف وبكم تشحن. الأسعار شاملة الضريبة. تُطبَّق على الجميع فورًا.';

  @override
  String get shopShippingStarting => 'إضافة الإعداد الأساسي';

  @override
  String get shopZones => 'المناطق';

  @override
  String get shopZonesHelp =>
      'المناطق التي تشحن إليها. أوقف منطقة لإيقاف الشحن إليها.';

  @override
  String get shopZoneName => 'اسم المنطقة';

  @override
  String get shopAddZone => 'إضافة منطقة';

  @override
  String get shopZoneItaly => 'إيطاليا';

  @override
  String get shopZoneIslands => 'صقلية وسردينيا';

  @override
  String get shopZoneEurope => 'الاتحاد الأوروبي';

  @override
  String get shopMethod => 'طريقة الشحن';

  @override
  String get shopAddMethod => 'إضافة طريقة شحن';

  @override
  String get shopMethodActive => 'متاح للمستخدمين';

  @override
  String get shopMethodStandard => 'عادي';

  @override
  String get shopMethodExpress => 'سريع';

  @override
  String get shopMethodStandardTime => '3–5 أيام عمل';

  @override
  String get shopMethodExpressTime => '1–2 يوم عمل';

  @override
  String get shopDeliveryTime => 'مدة التوصيل المعروضة';

  @override
  String get shopPricePerZone => 'السعر لكل منطقة';

  @override
  String get shopPricePerZoneHelp =>
      'اتركه فارغًا حيث لا تتوفر الطريقة. 0 تعني مجانًا.';

  @override
  String get shopFreeAboveLabel => 'شحن مجاني فوق (€)';

  @override
  String get shopFreeAboveHelp => 'اختياري. اتركه فارغًا لتحصيل الشحن دائمًا.';

  @override
  String get inviteQrTitle => 'رمز QR الخاص بك';

  @override
  String get inviteQrSubtitle => 'احفظه أو اطبع منشورًا لدعوة من حولك.';

  @override
  String get inviteQrScreenTitle => 'رمز QR والمنشور';

  @override
  String get inviteQrCode => 'رمز QR';

  @override
  String get inviteFlyer => 'منشور';

  @override
  String get inviteQrHelp =>
      'يمسحه أصدقاؤك بكاميرا الهاتف للحصول على CodaMi برمز دعوتك.';

  @override
  String get inviteFlyerHelp => 'منشور جاهز للطباعة والتوزيع في منطقتك.';

  @override
  String get inviteSaveToPhotos => 'حفظ في الصور';

  @override
  String get inviteSaved => 'تم الحفظ في صورك';

  @override
  String get inviteSaveDenied =>
      'تعذر الحفظ. اسمح لـ CodaMi بإضافة الصور من إعدادات الهاتف.';

  @override
  String get flyerTitle => 'ساعد الحيوانات الضائعة على العودة';

  @override
  String get flyerText =>
      'انضم إلى CodaMi، التطبيق المجاني حيث يساعد الجيران الحيوانات الضائعة والمعثور عليها.';

  @override
  String get flyerScan => 'امسحه بكاميرا هاتفك';

  @override
  String flyerCode(String code) {
    return 'رمز الدعوة: $code';
  }

  @override
  String get flyerFree => 'تطبيق مجاني';

  @override
  String get walksTitle => 'أماكن للتنزه';

  @override
  String get walksSubtitle => 'حدائق ومناطق للكلاب ومسارات قريبة منك';

  @override
  String get adminWalksSubtitle =>
      'بحث Google والمسافة والأنواع والأماكن المخفية';

  @override
  String get walkDogParks => 'حدائق الكلاب';

  @override
  String get walkParks => 'حدائق';

  @override
  String get walkGreen => 'مساحات خضراء';

  @override
  String get walkTrails => 'مسارات';

  @override
  String walkNearYou(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count أماكن قريبة منك',
      one: 'مكان واحد قريب منك',
      zero: 'لا أماكن قريبة',
    );
    return '$_temp0';
  }

  @override
  String walkNearCity(int count, String city) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count أماكن قرب $city',
      one: 'مكان واحد قرب $city',
      zero: 'لا أماكن قرب $city',
    );
    return '$_temp0';
  }

  @override
  String get walkUseMyLocation => 'استخدم موقعي';

  @override
  String get walkNeedLocation =>
      'اسمح بالموقع أو حدد مدينتك في الملف الشخصي لرؤية الأماكن القريبة.';

  @override
  String get walkShowMap => 'عرض الخريطة';

  @override
  String get walkShowList => 'عرض القائمة';

  @override
  String get walkSearching => 'جارٍ البحث عن أماكن…';

  @override
  String get walkNoPlaces => 'لم يتم العثور على أماكن. جرّب مسافة أكبر.';

  @override
  String get walkLimitReached => 'وصلت إلى حد البحث اليومي. حاول غدًا.';

  @override
  String get walkTurnedOff => 'أماكن التنزه غير متاحة حاليًا.';

  @override
  String get walkUnavailable =>
      'تعذر تحميل الأماكن. تحقق من الاتصال وحاول مجددًا.';

  @override
  String get walkSearchHere => 'ابحث في هذه المنطقة';

  @override
  String get walkDataFromGoogle => 'بيانات الأماكن من Google';

  @override
  String walkPhotoBy(String name) {
    return 'الصورة: $name (Google)';
  }

  @override
  String get walkOpenNow => 'مفتوح الآن';

  @override
  String get walkClosedNow => 'مغلق الآن';

  @override
  String get walkDogsAllowed => 'يُسمح بالكلاب';

  @override
  String get walkDogsNotAllowed => 'لا يُسمح بالكلاب';

  @override
  String get walkOpeningHours => 'ساعات العمل';

  @override
  String get walkDirections => 'الاتجاهات';

  @override
  String get walkCall => 'اتصال';

  @override
  String get walkWebsite => 'الموقع';

  @override
  String get walkDetailsFailed => 'تعذر تحميل مزيد من التفاصيل.';

  @override
  String get walkOpenFailed => 'تعذر الفتح.';

  @override
  String get walkHide => 'إخفاء هذا المكان (مشرف)';

  @override
  String get walkHidden => 'مخفي للجميع';

  @override
  String get walkAdminIntro =>
      'يعثر Google على الحدائق ومناطق الكلاب والمساحات الخضراء والمسارات حول كل مستخدم. لكل بحث تكلفة بسيطة، والحدود تحمي الميزانية.';

  @override
  String get walkShowToUsers => 'عرض للمستخدمين';

  @override
  String get walkOnHelp =>
      'مفعّل: يظهر في الملف الشخصي وعلى خريطة الصفحة الرئيسية.';

  @override
  String get walkOffHelp => 'معطّل: يمكن للمشرفين فقط تجربته من الزر أدناه.';

  @override
  String get walkDefaultDistance => 'المسافة الافتراضية';

  @override
  String get walkPlaceTypes => 'أنواع الأماكن';

  @override
  String get walkLimits => 'الحدود اليومية لكل مستخدم';

  @override
  String get walkDailySearches => 'عمليات البحث';

  @override
  String get walkDailySearchesHelp => 'كل بحث يبحث عن أماكن في منطقة واحدة.';

  @override
  String get walkDailyDetails => 'تفاصيل الأماكن';

  @override
  String get walkDailyDetailsHelp => 'فتح مكان يحمّل صورته وتقييمه ومواعيده.';

  @override
  String get walkLimitInvalid => 'يجب أن تكون الحدود بين 1 و1000.';

  @override
  String get walkHiddenPlaces => 'الأماكن المخفية';

  @override
  String get walkHiddenEmpty =>
      'لا شيء. افتح مكانًا كمشرف واضغط \"إخفاء هذا المكان\".';

  @override
  String get walkShowAgain => 'إظهار مجددًا';

  @override
  String get walkOpenScreen => 'فتح أماكن للتنزه';

  @override
  String get supportCodami => 'ادعم CodaMi';

  @override
  String get supportProfileSubtitle => 'اختياري، للمساعدة في استمرار CodaMi';

  @override
  String get adminSupportSubtitle => 'الدعم الطوعي: أين ومتى والمبالغ';

  @override
  String get supportHeaderTitle => 'CodaMi مجاني وسيبقى مجانيًا';

  @override
  String get supportHeaderText =>
      'إذا أعجبك ما يقدمه CodaMi للحيوانات، يمكنك المساعدة بمساهمة طوعية صغيرة. الأمر اختياري تمامًا.';

  @override
  String get supportUsesTitle => 'فيمَ يُستخدم دعمك';

  @override
  String get supportUseServers => 'الخوادم التي تُشغّل التطبيق';

  @override
  String get supportUseDevelopment => 'تطوير التطبيق';

  @override
  String get supportUseModeration => 'الإشراف على المحتوى';

  @override
  String get supportUseSupport => 'دعم المستخدمين';

  @override
  String get supportUseTranslations => 'الترجمات';

  @override
  String get supportUseFeatures => 'ميزات وتحسينات جديدة';

  @override
  String get supportUseCampaigns => 'حملات التوعية برعاية الحيوان';

  @override
  String get supportChooseAmount => 'اختر مبلغًا';

  @override
  String supportWith(Object amount) {
    return 'ادعم بمبلغ $amount';
  }

  @override
  String get supportFinePrint =>
      'يتم الدفع عبر Google Play أو App Store. يذهب دعمك لتشغيل CodaMi وتحسينه؛ وهو ليس تبرعًا لجمعية خيرية ولا يمنح مزايا في التطبيق. يمكنك استخدام CodaMi بالكامل بدونه.';

  @override
  String get supportThanks => 'شكرًا لك!';

  @override
  String get supportThanksText =>
      'دعمك يساعد CodaMi على مواصلة مساعدة الحيوانات.';

  @override
  String get supportSoon =>
      'الدفع داخل التطبيق قادم قريبًا. شكرًا لرغبتك في المساعدة!';

  @override
  String get supportClose => 'إغلاق';

  @override
  String get supportPromptReportTitle => 'تم نشر بلاغك';

  @override
  String get supportPromptFoundTitle => 'خبر رائع!';

  @override
  String get supportPromptText =>
      'CodaMi مجاني للجميع. إن أردت، تساعد مساهمة طوعية صغيرة في استمراره. اختياري تمامًا.';

  @override
  String get supportAdminIntro =>
      'دعم طوعي من المستخدمين عبر Google Play وApp Store. اختياري دائمًا ولا يُمنع أحد.';

  @override
  String get supportPaymentsNotReady =>
      'مدفوعات المتجر غير متصلة بعد: يرى المستخدمون الصفحة والمبالغ، والزر يقول إن الدفع قادم قريبًا. يلزم ملف الدفع في Google Play Console والمنتجات في المتجرين.';

  @override
  String get supportShowToUsers => 'عرض للمستخدمين';

  @override
  String get supportOnHelp => 'مفعّل: يظهر في الأماكن المفعّلة أدناه.';

  @override
  String get supportOffHelp =>
      'معطّل: لا يراه المستخدمون. يمكنك معاينة الصفحة.';

  @override
  String get supportWhere => 'أين يظهر';

  @override
  String get supportWhereProfile => 'الملف الشخصي ← ادعم CodaMi';

  @override
  String get supportWhereReport => 'بعد نشر بلاغ';

  @override
  String get supportWhereFound => 'عند العثور على حيوان أو حل بلاغ';

  @override
  String get supportSettings => 'الإعدادات';

  @override
  String get supportDaysBetween => 'الأيام بين الرسائل';

  @override
  String get supportDaysBetweenHelp =>
      'تظهر الرسالة بعد البلاغ أو العثور على حيوان مرة واحدة على الأكثر خلال هذه الأيام.';

  @override
  String get supportAmounts => 'المبالغ (€)';

  @override
  String get supportAmountsHelp =>
      'حتى 6 مبالغ مفصولة بفواصل. يصبح كل مبلغ منتجًا في المتجرين.';

  @override
  String get supportAmountsInvalid => 'أدخل حتى 6 مبالغ، مثل 1، 3، 5، 10، 25';

  @override
  String get supportPreview => 'معاينة الصفحة';

  @override
  String get adminInvites => 'الدعوات';

  @override
  String get adminInvitesSubtitle =>
      'عدد الدعوات ومسح رموز QR والترتيب حسب المستخدم';

  @override
  String get inviteBucketActive => 'نشطة';

  @override
  String get inviteBucketInactive => 'غير نشطة';

  @override
  String get inviteBucketWaiting => 'قيد الانتظار';

  @override
  String get inviteStillUsing => 'ما زالوا يستخدمون التطبيق';

  @override
  String get inviteQrScans => 'مسح رمز QR';

  @override
  String get inviteLinkOpens => 'فتح الرابط';

  @override
  String get inviteSignedUp => 'مسجّلون';

  @override
  String get inviteBucketsHelp =>
      'نشطة: بدأ الصديق باستخدام CodaMi وحصل صاحب الدعوة على النقاط. غير نشطة: لم يصبح نشطًا في الوقت المحدد، أو رُفضت. قيد الانتظار: ما زال لديه وقت ليصبح نشطًا.';

  @override
  String inviteStillUsingHelp(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'ما زالوا يستخدمونه: أصدقاء نشطون فتحوا التطبيق خلال آخر $days يومًا.',
      few:
          'ما زالوا يستخدمونه: أصدقاء نشطون فتحوا التطبيق خلال آخر $days أيام.',
      two: 'ما زالوا يستخدمونه: أصدقاء نشطون فتحوا التطبيق خلال آخر يومين.',
      one: 'ما زالوا يستخدمونه: أصدقاء نشطون فتحوا التطبيق اليوم.',
    );
    return '$_temp0';
  }

  @override
  String get invitedFriendsTitle => 'الأصدقاء المدعوون';

  @override
  String get seeInvitedFriends => 'عرض الأصدقاء المدعوين';

  @override
  String inviteJoinedOn(String date) {
    return 'سجّل في $date';
  }

  @override
  String inviteLastInApp(String date) {
    return 'آخر مرة في التطبيق: $date';
  }

  @override
  String get periodThisMonth => 'هذا الشهر';

  @override
  String get periodLastMonth => 'الشهر الماضي';

  @override
  String get periodAllTime => 'كل الوقت';

  @override
  String get periodChooseDates => 'اختيار التواريخ';

  @override
  String get sortMostActive => 'الأكثر نشاطًا';

  @override
  String get sortMostInvited => 'الأكثر دعوات';

  @override
  String get inviteWholeApp => 'التطبيق كله';

  @override
  String get inviteRanking => 'الترتيب';

  @override
  String inviteRankingUsers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مستخدم',
      few: '$count مستخدمين',
      two: 'مستخدمان',
      one: 'مستخدم واحد',
    );
    return '$_temp0';
  }

  @override
  String get noInvitesInPeriod => 'لا توجد دعوات في هذه الفترة';

  @override
  String get noInvitesInPeriodMessage =>
      'سيظهر هنا الأصدقاء الذين يسجّلون برمز دعوة، وعدد مرات فتح رمز QR أو الرابط.';

  @override
  String get adminNoInvites => 'لم يدعُ هذا المستخدم أحدًا بعد.';

  @override
  String get invitesLoadError =>
      'تعذّر تحميل الدعوات. تحقّق من الاتصال وحاول مرة أخرى.';

  @override
  String get settingsStillUsingDays =>
      'عدد الأيام التي تُحتسب «ما زال يستخدم التطبيق»';

  @override
  String get breedScanner => 'ماسح السلالات';

  @override
  String get scannerSubtitle => 'اكتشف سلالة حيوانك الأليف بالذكاء الاصطناعي';

  @override
  String get adminScannerSubtitle =>
      'ماسح السلالات بالذكاء الاصطناعي: تشغيل/إيقاف، عدد المسوح يوميًا، نموذج الذكاء الاصطناعي';

  @override
  String get scannerIntroTitle => 'ما هذه السلالة؟';

  @override
  String get scannerIntroText =>
      'التقط أو اختر صورة لكلب أو قطة أو حيوان أليف آخر. يقترح الذكاء الاصطناعي السلالات الأكثر احتمالًا ويعرّفك بها.';

  @override
  String get scannerTipWhole => 'الحيوان كاملًا، من الجانب أو من الأمام';

  @override
  String get scannerTipLight => 'إضاءة جيدة، بدون اهتزاز';

  @override
  String get scannerTipOne => 'حيوان واحد فقط في الصورة';

  @override
  String get scannerScanning => 'جارٍ فحص الصورة…';

  @override
  String get scannerEstimate =>
      'هذا تقدير من الذكاء الاصطناعي وليس ضمانًا. وحده الطبيب البيطري أو اختبار الحمض النووي يمكنه تأكيد السلالة.';

  @override
  String get scannerPrivacy => 'تُستخدم الصورة للمسح فقط ولا يتم حفظها.';

  @override
  String get scannerMostLikely => 'الأكثر احتمالًا';

  @override
  String get scannerMixed => 'سلالة مختلطة';

  @override
  String scannerPercent(int value) {
    return '$value%';
  }

  @override
  String get scannerConfidenceHigh => 'مرجح جدًا';

  @override
  String get scannerConfidenceMedium => 'مرجح';

  @override
  String get scannerConfidenceLow => 'غير متأكد';

  @override
  String get scannerOtherBreeds => 'سلالات محتملة أخرى';

  @override
  String get scannerMixOthers => 'سلالات أخرى في الخليط';

  @override
  String get scannerPoorPhoto =>
      'الصورة ليست واضحة جدًا، لذا قد تكون النتيجة أقل دقة. جرّب صورة أخرى للحصول على نتيجة أفضل.';

  @override
  String get scannerAboutBreed => 'عن هذه السلالة';

  @override
  String get scannerAboutMix => 'عن هذا الخليط';

  @override
  String get breedFactSize => 'الحجم';

  @override
  String get breedFactWeight => 'الوزن';

  @override
  String get breedFactLifeSpan => 'متوسط العمر';

  @override
  String get breedFactTemperament => 'الطباع';

  @override
  String get breedFactCharacteristics => 'الصفات';

  @override
  String get breedFactCare => 'العناية';

  @override
  String get scannerNoAnimalTitle => 'لم يتم العثور على حيوان';

  @override
  String get scannerNoAnimalText =>
      'لم نتمكن من رؤية حيوان بوضوح. جرّب صورة للحيوان كاملًا في إضاءة جيدة.';

  @override
  String get scannerTryAnother => 'جرّب صورة أخرى';

  @override
  String get scannerSaveToPet => 'احفظ السلالة لحيواني';

  @override
  String get scannerUseBreed => 'استخدم هذه السلالة';

  @override
  String get scannerChoosePet => 'أي حيوان؟';

  @override
  String scannerBreedSaved(String name) {
    return 'تم حفظ السلالة لـ $name';
  }

  @override
  String get scannerNoPets => 'أضف حيوانًا أليفًا أولًا، ثم يمكنك حفظ سلالته.';

  @override
  String get scannerLimit => 'لقد استخدمت مسوح اليوم. حاول مرة أخرى غدًا.';

  @override
  String get scannerOff => 'ماسح السلالات غير متاح.';

  @override
  String get scannerBadPhoto =>
      'لا يمكن استخدام هذه الصورة. يرجى اختيار صورة أخرى.';

  @override
  String get scannerUnavailable =>
      'الماسح غير متاح الآن. يرجى المحاولة لاحقًا.';

  @override
  String get scannerIdentifyWithAi => 'اعرف السلالة بالذكاء الاصطناعي';

  @override
  String get scannerAdminIntro =>
      'يلتقط المستخدمون صورة أو يختارونها، ويقترح الذكاء الاصطناعي السلالة مع سلالات محتملة أخرى ومعلومات عنها. تكلفة كل مسح أقل من سنت واحد. لا يتم حفظ الصور.';

  @override
  String get scannerOnHelp =>
      'مُفعّل: يرى المستخدمون الماسح في الملف الشخصي وعند إضافة حيوان.';

  @override
  String get scannerOffHelp => 'متوقف: يمكن للمشرفين فقط تجربته.';

  @override
  String get scannerSettings => 'إعدادات المسح';

  @override
  String get scannerDailyScans => 'عدد المسوح لكل مستخدم يوميًا';

  @override
  String get scannerDailyScansHelp => 'من 1 إلى 100. المسوح الفاشلة لا تُحتسب.';

  @override
  String get scannerModel => 'نموذج الذكاء الاصطناعي';

  @override
  String get scannerModelHelp =>
      'نموذج Google Gemini المستخدم في المسح. اضغط للاختيار من النماذج التي تقدمها Google حاليًا.';

  @override
  String get scannerModelInvalid =>
      'أدخل اسم نموذج Gemini، مثل gemini-3.8-flash.';

  @override
  String get scannerLimitInvalid => 'أدخل رقمًا من 1 إلى 100.';

  @override
  String get scannerOpen => 'جرّب الماسح';

  @override
  String get scannerModelChoose => 'اختر نموذج الذكاء الاصطناعي';

  @override
  String get scannerModelTierLite => 'الأرخص والأسرع، أقل دقة قليلًا';

  @override
  String get scannerModelTierFlash => 'سريع ودقيق بتكلفة منخفضة';

  @override
  String get scannerModelTierPro => 'الأكثر دقة، لكنه أبطأ وأعلى تكلفة';

  @override
  String get scannerModelRecommended => 'موصى به';

  @override
  String get scannerModelFromGoogle =>
      'نماذج Gemini التي تقدمها Google حاليًا.';

  @override
  String get scannerModelOffline =>
      'تعذّر تحميل قائمة Google، لذلك تظهر النماذج المعتادة.';

  @override
  String get scannerModelGone =>
      'لم تعد Google تقدم هذا النموذج. اختر نموذجًا آخر لكي يستمر المسح في العمل.';

  @override
  String get scannerModelRetry => 'حاول مرة أخرى';

  @override
  String get heatCalendar => 'تقويم الشياع';

  @override
  String heatCalendarOf(String name) {
    return 'تقويم الشياع لـ $name';
  }

  @override
  String get adminHeatSubtitle => 'الشياع: تشغيل/إيقاف والقيم المعتادة لكل نوع';

  @override
  String get heatRecord => 'سجّل فترة شياع';

  @override
  String get heatEdit => 'تعديل فترة الشياع';

  @override
  String heatInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'بعد $days يومًا',
      few: 'بعد $days أيام',
      two: 'بعد يومين',
      one: 'غدًا',
      zero: 'اليوم',
    );
    return '$_temp0';
  }

  @override
  String get heatUpcoming => 'فترات الشياع المتوقعة القادمة';

  @override
  String get heatHistory => 'السجل';

  @override
  String get heatHistoryEmpty =>
      'لا توجد فترات شياع مسجلة بعد. اضغط «سجّل فترة شياع» لإضافة الأولى.';

  @override
  String get heatOngoing => 'مستمرة';

  @override
  String heatLengthDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days يومًا',
      few: '$days أيام',
      two: 'يومان',
      one: 'يوم واحد',
    );
    return '$_temp0';
  }

  @override
  String get heatEstimateNote =>
      'التواريخ القادمة تقديرية وكل حيوان مختلف. استشر طبيبك البيطري بشأن التزاوج والتعقيم وأي مخاوف صحية.';

  @override
  String get heatInHeatNow => 'في فترة الشياع الآن';

  @override
  String heatDayNumber(int day) {
    return 'اليوم $day';
  }

  @override
  String get heatEndToday => 'انتهى الشياع اليوم';

  @override
  String get heatNextExpected => 'الشياع التالي متوقع في حوالي';

  @override
  String get heatNoEstimate =>
      'سجّل أول فترة شياع لمعرفة موعد الفترة التالية المتوقع.';

  @override
  String get heatNoEstimateMore =>
      'سجّل فترة شياع أخرى لمعرفة موعد الفترة التالية المتوقع.';

  @override
  String heatCycleSummary(int cycle, int heat) {
    return 'الدورة نحو $cycle يوم · يستمر الشياع نحو $heat يوم';
  }

  @override
  String heatBasedOn(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'بناءً على $count فترة مسجلة.',
      few: 'بناءً على $count فترات مسجلة.',
      two: 'بناءً على فترتين مسجلتين.',
      one: 'بناءً على فترة واحدة مسجلة.',
    );
    return '$_temp0';
  }

  @override
  String get heatBasedOnTypical => 'قيمة معتادة للنوع حتى تتوفر سجلات أكثر.';

  @override
  String get heatReminders => 'التذكيرات';

  @override
  String get heatRemindMe => 'ذكّرني قبل الشياع التالي';

  @override
  String get heatRemindNeedsEstimate => 'متاح عند وجود تاريخ متوقع.';

  @override
  String heatRemindDaysBefore(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'قبل $days يومًا',
      few: 'قبل $days أيام',
      two: 'قبل يومين',
      one: 'قبل يوم واحد',
    );
    return '$_temp0';
  }

  @override
  String heatNextReminder(String date) {
    return 'التذكير التالي: $date';
  }

  @override
  String get heatDeleteConfirm => 'حذف فترة الشياع هذه؟';

  @override
  String get heatDeleteMessage => 'ستُزال من السجل ومن التقديرات.';

  @override
  String get heatDelete => 'حذف';

  @override
  String get heatEndBeforeStart => 'لا يمكن أن تكون النهاية قبل البداية.';

  @override
  String get heatStart => 'البداية';

  @override
  String get heatEnd => 'النهاية';

  @override
  String get heatStillInHeat => 'ما زالت في الشياع';

  @override
  String get heatNotes => 'ملاحظات';

  @override
  String get heatNotesHint => 'السلوك، النزيف، زيارة الطبيب البيطري…';

  @override
  String heatCardInHeat(int day) {
    return 'في فترة الشياع الآن · اليوم $day';
  }

  @override
  String heatCardNext(String date) {
    return 'الشياع التالي متوقع في حوالي $date';
  }

  @override
  String get heatCardRecordFirst =>
      'سجّل فترات الشياع واحصل على تذكير قبل الفترة التالية';

  @override
  String get heatLegendRecorded => 'شياع مسجل';

  @override
  String get heatLegendEstimated => 'متوقع';

  @override
  String get heatLegendToday => 'اليوم';

  @override
  String get heatAdminIntro =>
      'يسجّل المالكون فترات الشياع لإناث حيواناتهم. يقدّر التطبيق الفترات التالية ويمكنه إرسال تذكير مسبق. تُستخدم القيم المعتادة حتى تتوفر سجلات خاصة بالحيوان.';

  @override
  String get heatOnHelp =>
      'مُفعّل: يرى المالكون تقويم الشياع في صفحة إناث حيواناتهم.';

  @override
  String get heatOffHelp => 'متوقف: يراه المشرفون فقط.';

  @override
  String get heatTypicalCycle => 'الدورة المعتادة (أيام)';

  @override
  String get heatTypicalHeat => 'مدة الشياع المعتادة (أيام)';

  @override
  String get heatTypicalHelp =>
      'تُستخدم حتى يكون للحيوان فترتا شياع مسجلتان. للحيوانات الأخرى، الدورة 0 تعني عدم وجود تقدير حتى ذلك الحين.';

  @override
  String get heatInvalidValues =>
      'الدورة: من 7 إلى 400 يوم (يُسمح بـ 0 للحيوانات الأخرى). المدة: من 1 إلى 60 يومًا.';

  @override
  String get adminSittingSubtitle =>
      'رعاية الحيوانات: تشغيل/إيقاف، البلاغات، الطلبات، المربّون، التقييمات';

  @override
  String get sitAbout => 'نبذة عني';

  @override
  String get sitAboutHint => 'من أنت ولماذا تحب الحيوانات';

  @override
  String get sitAboutTooShort => 'اكتب بضع كلمات على الأقل عن نفسك.';

  @override
  String get sitAccept => 'قبول';

  @override
  String get sitAcceptText =>
      'سيُحجز الطلب مع هذا المربّي وتُرفض العروض الأخرى.';

  @override
  String sitAcceptTitle(String name) {
    return 'اختيار $name؟';
  }

  @override
  String get sitAccepted => 'تم الحجز! ألقِ التحية في الدردشة.';

  @override
  String get sitAddPetFirst => 'أضف حيوانك أولًا في تبويب الحيوانات.';

  @override
  String get sitAdminIntro =>
      'ينشر المالكون الطلبات ويرسل المربّون العروض ويتحدث الطرفان داخل التطبيق. لا يمكن التقييم إلا بعد تأكيد الطرفين للخدمة. يتم الاتفاق على الدفع بين المستخدمين.';

  @override
  String get sitAdminReported => 'المُبلغ عنها';

  @override
  String get sitAdminReviews => 'التقييمات';

  @override
  String get sitAdminSettings => 'الإعدادات';

  @override
  String get sitAlreadyReviewed => 'لقد قيّمت هذه الخدمة بالفعل.';

  @override
  String get sitAnimals => 'الحيوانات التي أرعاها';

  @override
  String get sitArea => 'المسافة التي أتنقلها';

  @override
  String get sitAvailability => 'أوقات التوفر';

  @override
  String get sitAvailabilityHint => 'مثلًا: عطلات نهاية الأسبوع، المساء، أغسطس';

  @override
  String get sitBecomeSitter => 'كن مربّيًا للحيوانات';

  @override
  String get sitBecomeSitterText =>
      'أنشئ ملفك الشخصي واعرض رعاية الحيوانات القريبة منك.';

  @override
  String get sitBecomeSitterToOffer => 'أنشئ ملف مربٍّ لإرسال عرض';

  @override
  String sitBookedWith(String name) {
    return 'تم الحجز مع $name';
  }

  @override
  String get sitBudget => 'الميزانية (اختياري)';

  @override
  String get sitBudgetHint => 'مثلًا: 20 يورو يوميًا';

  @override
  String get sitCancelBooking => 'إلغاء الحجز';

  @override
  String get sitCantMessage => 'لا يمكنك مراسلة هذا المستخدم.';

  @override
  String get sitChat => 'دردشة';

  @override
  String get sitChatSafety =>
      'حافظ على أمان مدفوعاتك وبياناتك. أبلغ عن أي شيء مريب.';

  @override
  String sitChatWith(String name) {
    return 'دردشة مع $name';
  }

  @override
  String get sitChats => 'الدردشات';

  @override
  String get sitChoosePets => 'اختر حيوانًا واحدًا على الأقل.';

  @override
  String get sitChooseSpeciesServices => 'اختر حيوانًا وخدمة واحدة على الأقل.';

  @override
  String sitCityArea(String city, int km) {
    return '$city · حتى $km كم';
  }

  @override
  String sitCityDistance(String city, int km) {
    return '$city · على بعد $km كم';
  }

  @override
  String get sitCloseRequest => 'إغلاق الطلب';

  @override
  String get sitCloseText => 'لن يتمكن أحد من إرسال عروض بعد ذلك.';

  @override
  String get sitCloseTitle => 'إغلاق هذا الطلب؟';

  @override
  String sitCompletedCount(int count) {
    return 'المكتملة: $count';
  }

  @override
  String get sitConfirmButton => 'نعم، تمت';

  @override
  String get sitConfirmText =>
      'أكّد بعد أن تتم الرعاية. عندما تؤكدان كلاكما، يمكن ترك تقييم موثّق.';

  @override
  String get sitConfirmTitle => 'هل تمت الرعاية؟';

  @override
  String get sitConfirmed => 'شكرًا، تم التأكيد.';

  @override
  String get sitDaysInvalid => 'أدخل رقمًا من 0 إلى 60.';

  @override
  String get sitDecline => 'رفض';

  @override
  String get sitDismiss => 'تجاهل';

  @override
  String get sitEdit => 'تعديل';

  @override
  String get sitExperience => 'الخبرة';

  @override
  String get sitExperienceHint =>
      'الحيوانات التي امتلكتها أو رعيتها، تدريب، دورات';

  @override
  String get sitFrom => 'من';

  @override
  String get sitHiddenDone => 'تم الإخفاء.';

  @override
  String get sitHiddenLabel => 'مخفي';

  @override
  String get sitHide => 'إخفاء';

  @override
  String get sitHideTheirProfile => 'إخفاء ملفه كمربٍّ';

  @override
  String get sitKindChat => 'دردشة';

  @override
  String get sitKindRequest => 'طلب';

  @override
  String get sitKindReview => 'تقييم';

  @override
  String get sitKindSitter => 'ملف المربّي';

  @override
  String sitLeaveReview(String name) {
    return 'قيّم $name';
  }

  @override
  String get sitMessageHint => 'اكتب رسالة';

  @override
  String get sitMinAccountDays => 'الأيام قبل أن يتمكن حساب جديد من التقييم';

  @override
  String get sitMinAccountDaysHelp => 'من 0 إلى 60. يساعد ضد الحسابات المزيفة.';

  @override
  String get sitMyOffers => 'عروضي';

  @override
  String get sitMyRequests => 'طلباتي';

  @override
  String get sitMySitterProfile => 'ملفي كمربٍّ';

  @override
  String get sitNeedCity =>
      'حدّد مدينتك في الملف الشخصي أولًا: تُظهر الطلبات والملفات المدينة فقط، وليس عنوانك أبدًا.';

  @override
  String get sitNewRequest => 'طلب جديد';

  @override
  String get sitNoChats => 'لا توجد دردشات بعد.';

  @override
  String get sitNoMyRequests => 'لم تطلب مربّيًا بعد.';

  @override
  String get sitNoOffersYet => 'لا توجد عروض بعد. سيرى المربّون القريبون طلبك.';

  @override
  String get sitNoRequestsNearby => 'لا توجد طلبات قريبة منك الآن.';

  @override
  String get sitNoReviewsYet => 'لا توجد تقييمات بعد';

  @override
  String get sitNoSittersNearby => 'لا يوجد مربّون قريبون منك بعد.';

  @override
  String get sitNotAvailableNow => 'هذا غير ممكن الآن.';

  @override
  String get sitNotFound => 'غير موجود أو لم يعد متاحًا.';

  @override
  String get sitNotes => 'التفاصيل';

  @override
  String get sitNotesHint =>
      'الروتين، الطعام، الأدوية، وكل ما يجب أن يعرفه المربّي';

  @override
  String get sitNothingReported => 'لا توجد بلاغات.';

  @override
  String get sitOffHelp => 'متوقف: يراه المشرفون فقط.';

  @override
  String get sitOfferAccepted => 'مقبول';

  @override
  String get sitOfferDeclined => 'مرفوض';

  @override
  String get sitOfferMessage => 'رسالتك';

  @override
  String get sitOfferMessageHint => 'عرّف بنفسك واذكر كيف سترعى الحيوان';

  @override
  String get sitOfferPending => 'قيد الانتظار';

  @override
  String get sitOfferPrice => 'سعرك (اختياري)';

  @override
  String get sitOfferSent => 'تم إرسال العرض.';

  @override
  String get sitOfferWithdrawn => 'مسحوب';

  @override
  String sitOffersTitle(int count) {
    return 'العروض ($count)';
  }

  @override
  String get sitOnHelp =>
      'مُفعّل: يرى المستخدمون رعاية الحيوانات في تبويب الحيوانات وفي الملف الشخصي.';

  @override
  String get sitOpen => 'فتح';

  @override
  String sitPrice(String price) {
    return 'السعر: $price';
  }

  @override
  String get sitProfilePaused => 'متوقف مؤقتًا: غير ظاهر للآخرين';

  @override
  String get sitProfileVisible => 'ظاهر لمالكي الحيوانات';

  @override
  String get sitPromo => 'اعثر على مربٍّ أو ارعَ حيوانات قريبة منك';

  @override
  String get sitPublish => 'نشر';

  @override
  String sitRatingSummary(String rating, int count) {
    return '$rating ($count)';
  }

  @override
  String get sitReport => 'إبلاغ';

  @override
  String get sitRequest => 'طلب رعاية';

  @override
  String get sitRequestPublished => 'تم نشر الطلب.';

  @override
  String get sitReviewHint =>
      'فقط للخدمات التي أكدها الطرفان. كن منصفًا ومحددًا.';

  @override
  String get sitReviewText => 'تقييمك (اختياري)';

  @override
  String sitReviewsTitle(int count) {
    return 'التقييمات الموثّقة ($count)';
  }

  @override
  String get sitSafetyText =>
      'يربط CodaMi بين الناس وليس طرفًا في الخدمة. التقوا أولًا، وتحقق من الملف والتقييمات، واتفقوا على الدفع مباشرة، ولا تدفع مسبقًا للغرباء أبدًا.';

  @override
  String get sitSafetyTitle => 'ابقَ آمنًا';

  @override
  String sitSayHello(String name) {
    return 'ألقِ التحية على $name';
  }

  @override
  String get sitSend => 'إرسال';

  @override
  String get sitSendOffer => 'إرسال عرض';

  @override
  String get sitServiceBoarding => 'الإقامة لدى المربّي';

  @override
  String get sitServiceDaycare => 'رعاية نهارية';

  @override
  String get sitServiceOvernight => 'المبيت في المنزل';

  @override
  String get sitServiceVisits => 'زيارات منزلية';

  @override
  String get sitServiceWalks => 'نزهات';

  @override
  String get sitServices => 'الخدمات';

  @override
  String get sitShow => 'إظهار';

  @override
  String get sitShowMyProfile => 'إظهار ملفي';

  @override
  String sitShownArea(String city) {
    return 'يظهر كالتالي: $city';
  }

  @override
  String get sitShownDone => 'أصبح ظاهرًا مرة أخرى.';

  @override
  String get sitSitterProfile => 'مربّي الحيوانات';

  @override
  String get sitStatusBooked => 'محجوز';

  @override
  String get sitStatusClosed => 'مغلق';

  @override
  String get sitStatusDone => 'مكتمل';

  @override
  String get sitStatusOpen => 'مفتوح';

  @override
  String get sitTabMine => 'الخاصة بي';

  @override
  String get sitTabRequests => 'الطلبات';

  @override
  String get sitTabSitters => 'المربّون';

  @override
  String get sitThanksReview => 'شكرًا على تقييمك!';

  @override
  String get sitTitle => 'رعاية الحيوانات';

  @override
  String get sitTo => 'إلى';

  @override
  String get sitVerifiedService => 'خدمة موثّقة';

  @override
  String get sitViewProfile => 'عرض الملف';

  @override
  String get sitWaitingOtherConfirm => 'بانتظار تأكيد الطرف الآخر.';

  @override
  String get sitWhatService => 'ماذا تحتاج؟';

  @override
  String get sitWhen => 'متى';

  @override
  String get sitWhichPets => 'أي حيوانات؟';

  @override
  String get sitWithdraw => 'سحب';

  @override
  String get sitYes => 'نعم';

  @override
  String get sitYouAreBooked => 'أنت المربّي لهذا الطلب.';

  @override
  String sitYouBlocked(String name) {
    return 'لقد حظرت $name.';
  }

  @override
  String get sitYourOffer => 'عرضك';

  @override
  String get sitHeroText =>
      'أشخاص موثوقون بالقرب منك، مع تقييمات من خدمات حقيقية مكتملة.';

  @override
  String sitDaysTotal(int count) {
    return 'الأيام: $count';
  }

  @override
  String get sitStepPublished => 'منشور';

  @override
  String get sitStepConfirmed => 'مؤكد';

  @override
  String get sitStepReviewed => 'تم التقييم';

  @override
  String get sitStatRating => 'التقييم';

  @override
  String get sitStatOpenRequests => 'الطلبات المفتوحة';

  @override
  String get sitAdminOverview => 'نظرة عامة';

  @override
  String get schTitle => 'جدولي';

  @override
  String schTitleOf(String name) {
    return 'جدول $name';
  }

  @override
  String get schSubtitle => 'زيارات البيطري والأدوية والعناية والتذكيرات';

  @override
  String get schPromo => 'خطط لزيارات البيطري والأدوية وغيرها، مع تذكيرات';

  @override
  String schNext(String what, String when) {
    return 'التالي: $what · $when';
  }

  @override
  String get schAddEvent => 'حدث جديد';

  @override
  String get schEditEvent => 'تعديل الحدث';

  @override
  String get schEdit => 'تعديل';

  @override
  String get schTabCalendar => 'التقويم';

  @override
  String get schTabUpcoming => 'القادمة';

  @override
  String get schTabDone => 'المنجزة';

  @override
  String get schToday => 'اليوم';

  @override
  String get schTomorrow => 'غدًا';

  @override
  String get schAllDay => 'طوال اليوم';

  @override
  String get schEmptyTitle => 'لا شيء مخطط بعد';

  @override
  String get schEmptyUpcoming =>
      'اضغط «حدث جديد» لإضافة زيارة بيطري أو دواء أو موعد إطعام أو أي تذكير.';

  @override
  String get schEmptyDay => 'لا شيء في هذا اليوم.';

  @override
  String get schEmptyDone => 'تظهر هنا الأحداث التي تحددها كمنجزة.';

  @override
  String get schMissed => 'لم تُنجز بعد';

  @override
  String get schAllPets => 'الكل';

  @override
  String get schAllTypes => 'كل الأنواع';

  @override
  String get schType => 'النوع';

  @override
  String get schTypeVet => 'زيارة البيطري';

  @override
  String get schTypeVaccine => 'تطعيم';

  @override
  String get schTypeMedicine => 'دواء';

  @override
  String get schTypeGrooming => 'عناية وتجميل';

  @override
  String get schTypeFeeding => 'إطعام';

  @override
  String get schTypeWalk => 'نزهة أو نشاط';

  @override
  String get schTypeNote => 'ملاحظة';

  @override
  String get schTypeOther => 'أخرى';

  @override
  String get schEventTitle => 'العنوان';

  @override
  String schTitleHint(String type) {
    return 'اختياري. إذا تُرك فارغًا: $type';
  }

  @override
  String get schVaccineName => 'اللقاح';

  @override
  String get schVaccineHint => 'مثل: داء الكلب، جرعة معززة';

  @override
  String get schMedicineName => 'الدواء والجرعة';

  @override
  String get schMedicineHint => 'مثل: مضاد حيوي، قرص واحد';

  @override
  String get schForPets => 'لأي حيوانات؟';

  @override
  String get schForPetsHelp => 'لا تختر أي حيوان لتذكير عام.';

  @override
  String get schDate => 'التاريخ';

  @override
  String get schRepeat => 'التكرار';

  @override
  String get schRepeatNone => 'لا يتكرر';

  @override
  String get schRepeatDaily => 'كل يوم';

  @override
  String get schRepeatWeekly => 'كل أسبوع';

  @override
  String get schRepeatMonthly => 'كل شهر';

  @override
  String get schRepeatYearly => 'كل سنة';

  @override
  String get schEvery => 'كل';

  @override
  String schUnitDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'يومًا',
      few: 'أيام',
      two: 'يومين',
      one: 'يوم',
    );
    return '$_temp0';
  }

  @override
  String schUnitWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'أسبوعًا',
      few: 'أسابيع',
      two: 'أسبوعين',
      one: 'أسبوع',
    );
    return '$_temp0';
  }

  @override
  String schUnitMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'شهرًا',
      few: 'أشهر',
      two: 'شهرين',
      one: 'شهر',
    );
    return '$_temp0';
  }

  @override
  String schUnitYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'سنة',
      few: 'سنوات',
      two: 'سنتين',
      one: 'سنة',
    );
    return '$_temp0';
  }

  @override
  String get schOnDays => 'في هذه الأيام';

  @override
  String get schEnds => 'ينتهي';

  @override
  String get schEndsNever => 'أبدًا';

  @override
  String get schEndsOn => 'في تاريخ';

  @override
  String get schEndsAfter => 'بعد عدد من المرات';

  @override
  String get schTimes => 'عدد المرات';

  @override
  String get schInvalidEvery => 'أدخل رقمًا من 1 إلى 99.';

  @override
  String get schInvalidCount => 'أدخل رقمًا من 1 إلى 999.';

  @override
  String get schUntilBeforeStart =>
      'لا يمكن أن يكون تاريخ الانتهاء قبل البداية.';

  @override
  String get schRemind => 'التذكيرات';

  @override
  String get schRemindHelp =>
      'حتى تذكيرين، تُرسل كإشعارات حتى عندما يكون التطبيق مغلقًا.';

  @override
  String get schRemindMax => 'يمكنك اختيار تذكيرين كحد أقصى.';

  @override
  String get schRemindAtTime => 'في الموعد';

  @override
  String get schRemindAllDay => 'في اليوم نفسه، الساعة 9:00';

  @override
  String get schRemind15 => 'قبل 15 دقيقة';

  @override
  String get schRemind60 => 'قبل ساعة';

  @override
  String get schRemindDay => 'قبل يوم';

  @override
  String get schRemindWeek => 'قبل أسبوع';

  @override
  String get schNoReminders => 'بلا تذكيرات';

  @override
  String get schPlace => 'المكان';

  @override
  String get schPlaceHint => 'عيادة، صالون تجميل، حديقة…';

  @override
  String get schNotes => 'ملاحظات';

  @override
  String get schMarkDone => 'تحديد كمنجز';

  @override
  String get schUndoDone => 'تحديد كغير منجز';

  @override
  String get schDoneLabel => 'منجز';

  @override
  String get schSkip => 'تخطي هذه المرة';

  @override
  String get schSkipped => 'تم التخطي هذه المرة';

  @override
  String get schDeleteConfirm => 'حذف هذا الحدث؟';

  @override
  String get schDeleteMessage => 'سيُحذف مع تذكيراته.';

  @override
  String get schDeleted => 'تم الحذف';

  @override
  String get schRepeatScopeText =>
      'هذا الحدث يتكرر. هذه المرة فقط أم كل المرات؟';

  @override
  String get schOnlyThis => 'هذه المرة فقط';

  @override
  String get schAllTimes => 'كل المرات';

  @override
  String schEveryDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'كل $count يومًا',
      few: 'كل $count أيام',
      two: 'كل يومين',
      one: 'كل يوم',
    );
    return '$_temp0';
  }

  @override
  String schEveryWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'كل $count أسبوعًا',
      few: 'كل $count أسابيع',
      two: 'كل أسبوعين',
      one: 'كل أسبوع',
    );
    return '$_temp0';
  }

  @override
  String schEveryMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'كل $count شهرًا',
      few: 'كل $count أشهر',
      two: 'كل شهرين',
      one: 'كل شهر',
    );
    return '$_temp0';
  }

  @override
  String schEveryYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'كل $count سنة',
      few: 'كل $count سنوات',
      two: 'كل سنتين',
      one: 'كل سنة',
    );
    return '$_temp0';
  }

  @override
  String schUntil(String date) {
    return 'حتى $date';
  }

  @override
  String schTimesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مرة',
      few: '$count مرات',
      two: 'مرتين',
      one: 'مرة واحدة',
    );
    return '$_temp0';
  }

  @override
  String schHeatExpected(String name) {
    return '$name: الشياع متوقع';
  }

  @override
  String get schEstimate => 'تقدير';

  @override
  String get schSeeAll => 'عرض الكل';

  @override
  String schPetEmpty(String name) {
    return 'لا توجد أحداث قادمة لـ $name.';
  }

  @override
  String schPetEventsTitle(String name, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'لدى $name $count حدثًا مجدولًا',
      few: 'لدى $name $count أحداث مجدولة',
      two: 'لدى $name حدثان مجدولان',
      one: 'لدى $name حدث واحد مجدول',
    );
    return '$_temp0';
  }

  @override
  String get schPetEventsMessage =>
      'حذفها أيضًا؟ الأحداث المشتركة مع حيوانات أخرى تبقى، لكن بدون هذا الحيوان.';

  @override
  String get schKeepEvents => 'الاحتفاظ بها';

  @override
  String get schDeleteEvents => 'حذفها';

  @override
  String get schWhenNow => 'الآن';

  @override
  String schWhenInMinutes(int count) {
    return 'بعد $count دقيقة';
  }

  @override
  String get schWhenInHour => 'بعد ساعة';

  @override
  String schWhenOn(String date) {
    return 'يوم $date';
  }

  @override
  String get adminScheduleSubtitle =>
      'الجدول الشخصي والتذكيرات: تشغيل أو إيقاف';

  @override
  String get schAdminIntro =>
      'لكل مستخدم جدول خاص لزيارات البيطري والتطعيمات والأدوية والعناية والإطعام والأنشطة الأخرى، مع تذكيرات فورية. لا يراه إلا المستخدم نفسه، ولا حتى المشرفون.';

  @override
  String get schOnHelp =>
      'تشغيل: يرى المستخدمون «جدولي» في تبويب «حيواناتي» وصفحات حيواناتهم والملف الشخصي.';

  @override
  String get schOffHelp => 'إيقاف: لا يراه إلا المشرفون.';

  @override
  String get shareBadgeLost => 'مفقود';

  @override
  String get shareBadgeFound => 'تم العثور عليه';

  @override
  String get shareBadgeHome => 'عاد إلى البيت';

  @override
  String get shareBadgeReunited => 'اجتمع شمله';

  @override
  String shareLostOn(String date) {
    return 'فُقد في $date';
  }

  @override
  String shareFoundOn(String date) {
    return 'عُثر عليه في $date';
  }

  @override
  String shareHomeTitle(String name) {
    return 'عاد $name إلى البيت!';
  }

  @override
  String get shareHomeThanks => 'شكرًا لكل من شارك';

  @override
  String get shareHomeHelp =>
      'كل مشاركة تساعد. انضم إلى CodaMi وساعد الحيوانات من حولك.';

  @override
  String shareSeenHelp(String name) {
    return 'هل رأيت $name؟ امسح الرمز أو ابحث عن CodaMi.';
  }

  @override
  String get shareYoursHelp => 'هل هذا حيوانك؟ امسح الرمز أو ابحث عن CodaMi.';

  @override
  String get shareScan => 'امسحني';

  @override
  String get shareTagline => 'نساعد الحيوانات الضائعة على العودة إلى البيت';

  @override
  String shareSheetTitleLost(String name) {
    return 'ساعد $name على العودة إلى البيت';
  }

  @override
  String shareSheetTextLost(String name) {
    return 'معظم الحيوانات الضائعة يُعثر عليها بفضل الجيران. كل مشاركة تقرّب $name من البيت.';
  }

  @override
  String get shareSheetTitleFound => 'ساعد في العثور على العائلة';

  @override
  String get shareSheetTextFound =>
      'شاركه ليراه صاحبه بسرعة. هناك من يبحث عن هذا الحيوان الآن.';

  @override
  String get shareSheetTitleHome => 'شارك الخبر السعيد! 🎉';

  @override
  String get shareSheetTextHome =>
      'النهايات السعيدة تشجع الآخرين على المساعدة وتجلب المزيد من الناس إلى CodaMi.';

  @override
  String shareMessageLost(
    String name,
    String species,
    String place,
    String date,
  ) {
    return '🚨 مفقود $species: $name\n📍 $place · $date\nشارك وساعد $name على العودة إلى البيت!';
  }

  @override
  String shareMessageFound(String species, String place, String date) {
    return '🐾 تم العثور على $species\n📍 $place · $date\nهل تعرف صاحبه؟ شارك من فضلك!';
  }

  @override
  String shareMessageHome(String name) {
    return '🎉 عاد $name إلى البيت!\nشكرًا لكل من شارك. ❤️';
  }

  @override
  String get shareMessageFooter =>
      'يساعد CodaMi الحيوانات الضائعة على العودة إلى البيت 🐾';

  @override
  String get shareTagLost => '#حيوان_مفقود';

  @override
  String get shareTagFound => '#حيوان_موجود';

  @override
  String get shareTagHome => '#عاد_للبيت';

  @override
  String get shareCaptionCopiedFacebook =>
      'تم نسخ النص مع الرابط. الصقه في منشورك على Facebook.';

  @override
  String get shareCaptionCopiedInstagram =>
      'تم نسخ النص. الصقه في منشورك أو قصتك على Instagram.';

  @override
  String get shareCaptionCopiedTiktok =>
      'تم نسخ النص. الصقه في منشورك على TikTok.';

  @override
  String get shareImageSaved => 'تم حفظ الصورة في صورك';

  @override
  String get shareLinkCopied => 'تم نسخ الرابط';

  @override
  String get shareFailed => 'تعذرت المشاركة الآن. حاول مرة أخرى.';

  @override
  String get shareMore => 'المزيد';

  @override
  String get shareSave => 'حفظ الصورة';

  @override
  String get shareCopyLink => 'نسخ الرابط';

  @override
  String get shareTip =>
      'لا تتم مشاركة رقم الهاتف أو العنوان الدقيق. يتواصل الناس معك داخل التطبيق.';

  @override
  String get shareNotNow => 'ليس الآن';

  @override
  String shareStatsLine(int shares, int views) {
    String _temp0 = intl.Intl.pluralLogic(
      shares,
      locale: localeName,
      other: 'تمت المشاركة $shares مرة',
      few: 'تمت المشاركة $shares مرات',
      two: 'تمت المشاركة مرتين',
      one: 'تمت المشاركة مرة واحدة',
    );
    String _temp1 = intl.Intl.pluralLogic(
      views,
      locale: localeName,
      other: '$views زيارة للصفحة',
      few: '$views زيارات للصفحة',
      two: 'زيارتان للصفحة',
      one: 'زيارة واحدة للصفحة',
    );
    return '$_temp0 · $_temp1';
  }

  @override
  String get shareAdminTitle => 'المشاركة على مواقع التواصل';

  @override
  String get shareAdminSubtitle => 'نافذة المشاركة والأرقام';

  @override
  String get shareAdminIntro =>
      'بعد نشر بلاغ عن حيوان مفقود أو تم العثور عليه، وعند عودة حيوان إلى البيت، يُطلب من المستخدمين مشاركته على WhatsApp وFacebook وInstagram وTikTok وغيرها، مع صورة ورابط لصفحة البلاغ على الويب.';

  @override
  String get shareAdminPopup => 'نافذة المشاركة';

  @override
  String get shareAdminOnHelp =>
      'تشغيل: تظهر النافذة بعد النشر وعند عودة حيوان إلى البيت.';

  @override
  String get shareAdminOffHelp =>
      'إيقاف: لا يرى النافذة إلا المشرفون. زر المشاركة في البلاغات يعمل دائمًا.';

  @override
  String get shareAdminLast30 => 'آخر 30 يومًا';

  @override
  String get shareAdminShares => 'المشاركات';

  @override
  String get shareAdminViews => 'زيارات الصفحات';

  @override
  String get shareAdminByApp => 'تمت المشاركة على';

  @override
  String get shareAdminVisitsFrom => 'الزيارات من';

  @override
  String get shareNoneYet => 'لا شيء بعد.';

  @override
  String get shareFromQr => 'رمز QR';

  @override
  String get shareDirect => 'رابط مباشر';

  @override
  String get alertShareTitle => 'تذكيرات المشاركة';

  @override
  String get alertShareDescription =>
      'مرة في الأسبوع تقريبًا، تذكير بدعوة أصدقائك إلى CodaMi.';

  @override
  String get shareAppTitle => 'شارك CodaMi';

  @override
  String get shareAppHeadline => 'ساعد CodaMi على إحداث فرق!';

  @override
  String get shareAppText =>
      'مشاركة تطبيقنا لا تكلفك شيئًا، لكن دعمك قد يُحدث أثرًا كبيرًا في مجتمعنا ويساعد المزيد من الحيوانات على العودة إلى البيت. شارك CodaMi مع أصدقائك وعلى شبكاتك الاجتماعية!';

  @override
  String get shareAppPosterTitle => 'انضم إلى CodaMi';

  @override
  String get shareAppPosterText =>
      'التطبيق المجاني الذي يساعد الحيوانات الضائعة على العودة إلى البيت';

  @override
  String get shareAppBenefitAlerts => 'تنبيهات عند فقدان حيوان بالقرب منك';

  @override
  String get shareAppBenefitMap => 'خريطة مباشرة للحيوانات المفقودة والموجودة';

  @override
  String get shareAppBenefitNeighbours => 'جيران يساعدون جيرانهم';

  @override
  String get shareAppCode => 'رمز الدعوة';

  @override
  String get shareAppFree => 'مجاني على Google Play وApp Store';

  @override
  String shareAppMessage(String code) {
    return '🐾 أستخدم CodaMi، التطبيق المجاني الذي يساعد الحيوانات الضائعة على العودة إلى البيت. انضم إلي: كلما زاد الجيران، عُثر عليها أسرع! رمز دعوتي: $code';
  }

  @override
  String shareAppJoined(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'انضم $count صديقًا عبر رابطك',
      few: 'انضم $count أصدقاء عبر رابطك',
      two: 'انضم صديقان عبر رابطك',
      one: 'انضم صديق واحد عبر رابطك',
      zero: 'لم ينضم أي صديق بعد',
    );
    return '$_temp0';
  }

  @override
  String get shareAppSeeRewards => 'اطّلع على مستويات الدعوة والمكافآت';

  @override
  String get shareAppStop => 'لا تذكّرني مرة أخرى';

  @override
  String get shareAppStopped =>
      'لن تصلك تذكيرات المشاركة بعد الآن. يمكنك إعادة تشغيلها من الإشعارات.';

  @override
  String get shareRemAdminTitle => 'تذكيرات المشاركة';

  @override
  String get shareRemAdminSubtitle =>
      'إشعار أسبوعي يدعو المستخدمين لمشاركة CodaMi';

  @override
  String get shareRemAdminIntro =>
      'بعد أيام قليلة من التسجيل، ثم مرة في الأسبوع تقريبًا، يتلقى المستخدمون إشعارًا يدعوهم لمشاركة CodaMi. يفتح شاشة فيها رابط الدعوة ورمز QR والمشاركة بلمسة واحدة.';

  @override
  String get shareRemOnHelp =>
      'تشغيل: تُرسل التذكيرات كل مساء نحو الساعة 18:00 (بتوقيت إيطاليا).';

  @override
  String get shareRemOffHelp => 'إيقاف: لا تُرسل أي تذكيرات.';

  @override
  String get shareRemWhen => 'متى';

  @override
  String get shareRemFirstDays => 'أيام بعد التسجيل قبل أول تذكير';

  @override
  String get shareRemEveryDays => 'أيام بين التذكيرات';

  @override
  String get shareRemMax => 'إجمالي التذكيرات لكل مستخدم';

  @override
  String get shareRemInvalid =>
      'الأول: من 1 إلى 60 يومًا. الفاصل: من 3 إلى 60 يومًا. الإجمالي: من 1 إلى 52.';

  @override
  String get shareRemHelp =>
      'لا تُرسل لمن أوقفها، أو شارك شيئًا خلال الأسبوعين الماضيين، أو لم يفتح التطبيق منذ 60 يومًا. ولا تُرسل أبدًا في يوم طلب فيه التطبيق رأيًا أو تقييمًا.';

  @override
  String get shareRemSent => 'المُرسلة';

  @override
  String get shareRemOpened => 'المفتوحة';

  @override
  String get shareRemShares => 'المشاركات';

  @override
  String get shareRemTry => 'جرّب';

  @override
  String get shareRemPreview => 'معاينة الشاشة التي يراها المستخدمون';

  @override
  String get shareRemTest => 'أرسل لي تذكيرًا تجريبيًا';

  @override
  String get shareRemTestSent => 'تم إرسال التذكير التجريبي إلى هاتفك.';

  @override
  String get shareRemTestFailed =>
      'تعذر الإرسال. تأكد من السماح بالإشعارات على هذا الهاتف.';

  @override
  String get fbQuickTitle => 'سؤال سريع 🐾';

  @override
  String get fbQuickBody =>
      'استخدمت هذا الجزء من CodaMi كثيرًا. كيف تجده؟ الأفكار والمشكلات تساعدنا أكثر من أي شيء.';

  @override
  String get fbSelfBody =>
      'أفكار أو أخطاء أو مشكلات: كل شيء يصل مباشرةً إلى فريق CodaMi.';

  @override
  String get fbTypeLabel => 'عمّ يتعلق الأمر؟';

  @override
  String get fbTypeSuggestion => 'اقتراح';

  @override
  String get fbTypeBug => 'خطأ';

  @override
  String get fbTypeProblem => 'مشكلة';

  @override
  String get fbTypeImprovement => 'تحسين';

  @override
  String get fbTypeGeneral => 'عام';

  @override
  String get fbAreaLabel => 'أي جزء من التطبيق؟';

  @override
  String get fbAreaGeneral => 'التطبيق كله';

  @override
  String get fbAreaReports => 'المفقودات والموجودات';

  @override
  String get fbAreaMap => 'الخريطة';

  @override
  String get fbAreaWalks => 'النزهات';

  @override
  String get fbAreaSitting => 'رعاية الحيوانات';

  @override
  String get fbAreaSchedule => 'الجدول';

  @override
  String get fbAreaHeat => 'تقويم الشياع';

  @override
  String get fbAreaScanner => 'ماسح السلالات';

  @override
  String get fbAreaShop => 'المتجر';

  @override
  String get fbAreaSharing => 'المشاركة';

  @override
  String get fbRatingLabel => 'تقييمك (اختياري)';

  @override
  String get fbHintSuggestion => 'ما الذي تودّ رؤيته في CodaMi؟';

  @override
  String get fbHintBug => 'ماذا حدث، وماذا كنت تتوقع؟';

  @override
  String get fbHintProblem => 'ما الصعب أو ما الذي لا يعمل؟';

  @override
  String get fbHintImprovement => 'ما الذي يمكن أن يعمل بشكل أفضل، وكيف؟';

  @override
  String get fbScreenshotAdd => 'إضافة لقطة شاشة';

  @override
  String get fbAutoInfo => 'تُضاف نسخة التطبيق وطراز الهاتف تلقائيًا.';

  @override
  String get fbNeedSomething => 'أضف نجومًا أو بضع كلمات للإرسال';

  @override
  String get fbDontAsk => 'لا تسألني مرة أخرى';

  @override
  String get fbDontAskDone =>
      'حسنًا، لن نسأل مرة أخرى. يمكنك دائمًا إرسال رأيك من الملف الشخصي.';

  @override
  String get fbLimitToday =>
      'شكرًا، هذه آراء كثيرة لليوم! يمكنك إرسال المزيد غدًا.';

  @override
  String get fbProfileSubtitle => 'اقتراحات وأخطاء وأفكار للفريق';

  @override
  String get fbStatusNew => 'جديد';

  @override
  String get fbStatusProgress => 'قيد العمل';

  @override
  String get fbStatusDone => 'تم';

  @override
  String get fbAdminOverview => 'آخر 30 يومًا';

  @override
  String get fbAdminStarsByArea => 'متوسط النجوم لكل جزء من التطبيق';

  @override
  String get fbAdminNoStars => 'لا توجد نجوم في آخر 30 يومًا.';

  @override
  String get fbAdminNoRating => 'بلا نجوم';

  @override
  String get fbAdminAnyStars => 'كل النجوم';

  @override
  String get fbAdminAllAreas => 'كل الأجزاء';

  @override
  String get fbAdminAsked => 'سُئل في التطبيق';

  @override
  String get fbAdminSelf => 'أُرسل من الملف الشخصي';

  @override
  String get fbAdminNote => 'ملاحظة خاصة';

  @override
  String get fbAdminNoteHint => 'الفريق فقط يرى هذه الملاحظة';

  @override
  String get fbAdminMarkDoneTitle => 'وضع علامة تم؟';

  @override
  String get fbAdminNotify => 'شكر المستخدم';

  @override
  String get fbAdminNotifyHelp =>
      'يصله إشعار قصير بلغته: \"شكرًا، أصلحنا المشكلة!\" للأخطاء والمشكلات، و\"فكرتك أصبحت في CodaMi!\" لغير ذلك.';

  @override
  String get fbAdminNotified => 'تم الحفظ. وصل الشكر إلى المستخدم.';

  @override
  String get fbAdminThanked => 'تم الشكر';

  @override
  String get fbAdminEmptyTab => 'لا شيء هنا.';

  @override
  String get fbAdminOpenUser => 'فتح الملف الشخصي';

  @override
  String get fbAdminChangeStatus => 'تغيير الحالة';

  @override
  String get fbAdminSettings => 'أسئلة الآراء';

  @override
  String get fbSetIntro =>
      'اختر متى يطلب التطبيق رأي المستخدمين. يمكنهم دائمًا إرسال رأيهم من الملف الشخصي.';

  @override
  String get fbSetOnHelp =>
      'مفعّل: يُسأل المستخدم بعد استخدام جزء من التطبيق عدة مرات';

  @override
  String get fbSetOffHelp =>
      'متوقف: لا يُسأل أحد، لكن إرسال الرأي من الملف الشخصي يعمل';

  @override
  String get fbSetWhen => 'متى نسأل';

  @override
  String get fbSetUsesMin => 'مرات الاستخدام قبل السؤال: من';

  @override
  String get fbSetUsesMax => 'مرات الاستخدام قبل السؤال: إلى';

  @override
  String get fbSetPause => 'أيام التوقف بعد السؤال';

  @override
  String get fbSetMax => 'أقصى عدد للأسئلة لكل مستخدم';

  @override
  String get fbSetHelp =>
      'يحصل كل مستخدم على عدد عشوائي من مرات الاستخدام ضمن هذا النطاق لكل جزء من التطبيق، ويُسأل عن كل جزء مرة واحدة فقط. تنتظر الحسابات الجديدة 3 أيام. نافذة تقييم Google Play تحترم فترة التوقف أيضًا.';

  @override
  String get fbSetInvalid =>
      'تحقق من الأرقام: \"من\" بين 1 و100، و\"إلى\" ليست أقل من \"من\" وبحد أقصى 200، والتوقف بين 3 و90 يومًا، والأسئلة بين 1 و20.';

  @override
  String get ttlContributor => 'مساهم في المجتمع';

  @override
  String get ttlRescuer => 'منقذ الحيوانات';

  @override
  String get ttlVolunteer => 'متطوع نشط';

  @override
  String get ttlAdvocate => 'مدافع عن الحيوانات';

  @override
  String get ttlHelper => 'مساعد المجتمع';

  @override
  String get ttlTrusted => 'عضو موثوق';

  @override
  String get ttlSitter => 'مُرافق حيوانات موثّق';

  @override
  String get ttlAmbassador => 'سفير';

  @override
  String get ttlTeam => 'فريق CodaMi';

  @override
  String get ttlPartner => 'ملجأ شريك';

  @override
  String get ttlDonor1 => 'داعم';

  @override
  String get ttlDonor2 => 'متبرع برونزي';

  @override
  String get ttlDonor3 => 'متبرع فضي';

  @override
  String get ttlDonor4 => 'متبرع ذهبي';

  @override
  String get ttlDonor5 => 'متبرع بلاتيني';

  @override
  String get ttlDonor6 => 'داعم مدى الحياة';

  @override
  String get ttlHowContributor =>
      'انشر بلاغات عن حيوانات مفقودة أو موجودة. البلاغات التي يحذفها المشرفون لا تُحتسب.';

  @override
  String get ttlHowRescuer =>
      'ساعد الحيوانات على العودة إلى البيت: بلاغاتك عن حيوانات موجودة التي انتهت بـ\"عاد إلى البيت\"، والطوارئ التي أبلغت عنها أو ساعدت فيها وتم حلها.';

  @override
  String get ttlHowVolunteer => 'اضغط \"أنا أساعد\" على حالة طوارئ قريبة منك.';

  @override
  String get ttlHowAdvocate =>
      'شارك البلاغات وCodaMi مع أصدقائك. تُحتسب حتى 3 مشاركات يوميًا.';

  @override
  String get ttlHowHelper =>
      'أرسل اقتراحات أو بلاغات أخطاء. يُحتسب كل ما يضع عليه الفريق علامة تم.';

  @override
  String get ttlHowTrusted =>
      'افتح CodaMi في أيام مختلفة، دون أن يحذف المشرفون شيئًا خلال آخر 90 يومًا.';

  @override
  String get ttlHowSitter =>
      'أكمل رعايات أكدها الطرفان، بمتوسط تقييم 4★ أو أكثر.';

  @override
  String get ttlHowAmbassador => 'ادعُ أصدقاء يصبحون نشطين على CodaMi.';

  @override
  String get ttlHowManual => 'يمنحه فريق CodaMi.';

  @override
  String get ttlAchievements => 'إنجازاتي';

  @override
  String get ttlProfileSubtitle => 'ألقابك وما يمكنك فتحه بعد ذلك';

  @override
  String get ttlMainTitle => 'اللقب الرئيسي';

  @override
  String get ttlChange => 'تغيير';

  @override
  String get ttlChooseMain => 'اختر لقبك الرئيسي';

  @override
  String get ttlChooseMainBody => 'يظهر تحت اسمك للمستخدمين الآخرين.';

  @override
  String get ttlAutomatic => 'تلقائي (أفضل ألقابك)';

  @override
  String get ttlNoTitle => 'لا يوجد لقب بعد';

  @override
  String get ttlNoTitleBody =>
      'انشر بلاغًا أو ساعد في حالة طوارئ أو ادعُ صديقًا لتحصل على لقبك الأول.';

  @override
  String ttlUnlockedCount(int count, int total) {
    return 'تم فتح $count من $total ألقاب';
  }

  @override
  String get ttlNextGoal => 'الهدف التالي';

  @override
  String ttlProgress(int done, int goal) {
    return '$done من $goal';
  }

  @override
  String get ttlAllTitles => 'كل الألقاب';

  @override
  String get ttlAllDone => 'تم فتح كل المستويات 🎉';

  @override
  String ttlUnlockedOn(String date) {
    return 'فُتح في $date';
  }

  @override
  String ttlNeeded(int count) {
    return 'يتطلب $count';
  }

  @override
  String get ttlPausedTrusted => 'متوقف: حذف المشرفون شيئًا خلال آخر 90 يومًا.';

  @override
  String get ttlPausedSitter => 'متوقف: متوسط التقييم أقل من 4★.';

  @override
  String get ttlSetMain => 'اجعله اللقب الرئيسي';

  @override
  String get ttlDonorSection => 'دعم CodaMi';

  @override
  String get ttlDonorIntro =>
      'ألقاب شكر لمن يساعدون CodaMi على الاستمرار. يرى الآخرون اللقب فقط، وليس المبلغ أبدًا.';

  @override
  String get ttlAnyDonation => 'أي تبرع';

  @override
  String ttlFrom(String amount) {
    return 'من $amount';
  }

  @override
  String ttlYourTotal(String amount) {
    return 'مجموعك: $amount';
  }

  @override
  String get ttlOnlyYou => 'أنت فقط ترى هذا';

  @override
  String get ttlShowDonor => 'إظهار لقب المتبرع للآخرين';

  @override
  String get ttlNewTitle => 'لقب جديد!';

  @override
  String ttlNewTitles(int count) {
    return '$count ألقاب جديدة!';
  }

  @override
  String get ttlCelebrateBody => 'أحسنت! يظهر الآن في ملفك الشخصي.';

  @override
  String get ttlSeeAll => 'عرض إنجازاتي';

  @override
  String ttlBonus(int points) {
    return '+$points نقطة';
  }

  @override
  String get pointsTitle => 'لقب جديد';

  @override
  String get ttlAdminTitle => 'الألقاب والإنجازات';

  @override
  String get ttlAdminSubtitle => 'الألقاب والمستويات وألقاب المتبرعين';

  @override
  String get ttlAdminIntro =>
      'يحصل المستخدمون على ألقاب مما يفعلونه في CodaMi، ويحسبها الخادم. اختر الأرقام لكل مستوى والألقاب التي تظهر.';

  @override
  String get ttlAdminOnHelp =>
      'مفعّل: يرى المستخدمون ألقابهم، ويراها الآخرون بجانب أسمائهم';

  @override
  String get ttlAdminOffHelp => 'متوقف: تُحسب الألقاب، لكن يراها المشرفون فقط';

  @override
  String get ttlAdminShown => 'إظهار هذا اللقب';

  @override
  String ttlAdminHolders(int count) {
    return 'يملكه $count مستخدم';
  }

  @override
  String get ttlAdminAmbassadorHelp =>
      'تتبع المستويات مستويات الدعوة في النقاط والمكافآت (صديق CodaMi، سفير، سفير مميز، بطل).';

  @override
  String get ttlAdminBonus => 'نقاط إضافية لكل مستوى';

  @override
  String get ttlAdminBonusHelp =>
      'تُمنح مرة واحدة لكل مستوى. لا تُمنح أبدًا لألقاب المتبرعين أو الدعوات.';

  @override
  String get ttlAdminDonor => 'ألقاب المتبرعين (المجموع باليورو)';

  @override
  String get ttlAdminDonorHelp =>
      'داعم: أي تبرع. تحتاج الألقاب الأخرى إلى هذا المجموع باليورو.';

  @override
  String get ttlAdminInvalid =>
      'تحقق من الأرقام: كل مستوى أعلى من السابق (من 1 إلى 100,000)، والنقاط من 0 إلى 10,000، ومجاميع المتبرعين تصاعدية من 1 €.';

  @override
  String get ttlAdminUserBox => 'الألقاب';

  @override
  String get ttlAdminGive => 'منح لقب';

  @override
  String get ttlAdminTakeAway => 'سحب';

  @override
  String get ttlAdminAllowAgain => 'السماح مجددًا';

  @override
  String get ttlAdminGiven => 'منحه الفريق';

  @override
  String get ttlAdminTakenAway => 'سحبه الفريق';

  @override
  String get ttlAdminChooseLevel => 'المستوى';

  @override
  String get ttlAdminDonations => 'التبرعات';

  @override
  String get ttlAdminRecord => 'تسجيل تبرع';

  @override
  String get ttlAdminRecordHelp =>
      'للتبرعات خارج التطبيق، مثل التحويل البنكي. يتبع لقب المتبرع المجموع.';

  @override
  String get ttlAdminAmount => 'المبلغ (€)';

  @override
  String get ttlAdminNoteField => 'ملاحظة (مثلًا: تحويل بنكي)';

  @override
  String get ttlAdminNoDonations => 'لا توجد تبرعات مسجلة.';

  @override
  String get ttlAdminDeleteDonation => 'حذف هذا التبرع؟';

  @override
  String ttlAdminTotal(String amount) {
    return 'المجموع: $amount';
  }

  @override
  String get adjPtsAdd => 'إضافة';

  @override
  String get adjPtsRemove => 'خصم';

  @override
  String get adjPtsBalance => 'الرصيد الحالي';

  @override
  String get adjPtsNewBalance => 'الرصيد الجديد';

  @override
  String get adjPtsAmount => 'كم نقطة؟';

  @override
  String adjPtsTooMany(String total) {
    return 'لديه $total فقط.';
  }

  @override
  String get adjPtsReasonHint => 'لماذا؟ يرى المستخدم ذلك في سجل نقاطه.';

  @override
  String get adjPtsReason1 => 'جائزة فعالية';

  @override
  String get adjPtsReason2 => 'شكرًا على المساعدة';

  @override
  String get adjPtsReason3 => 'تصحيح';

  @override
  String get adjPtsReason4 => 'الفائز في المسابقة';

  @override
  String adjPtsSaveAdd(String amount) {
    return 'إضافة $amount';
  }

  @override
  String adjPtsSaveRemove(String amount) {
    return 'خصم $amount';
  }
}
