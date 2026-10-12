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
  String get legalEnglishOnly =>
      'يُعرض هذا المستند باللغة الإنجليزية. ستتوفر الترجمة قريبًا.';

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
}
