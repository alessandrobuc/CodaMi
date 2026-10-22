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
  String get levelSupporter => 'داعم';

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
}
