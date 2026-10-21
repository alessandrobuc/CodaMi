// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get navHome => 'Главная';

  @override
  String get navPets => 'Питомцы';

  @override
  String get navProfile => 'Профиль';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get notSet => 'Не указан';

  @override
  String get soon => 'Скоро';

  @override
  String comingSoon(String feature) {
    return '$feature скоро появится.';
  }

  @override
  String get profileTitle => 'Профиль';

  @override
  String get myPets => 'Мои питомцы';

  @override
  String get myReports => 'Мои объявления';

  @override
  String get homeCity => 'Город';

  @override
  String get notifications => 'Уведомления';

  @override
  String get chooseLanguage => 'Выберите язык';

  @override
  String get language => 'Язык';

  @override
  String get signOut => 'Выйти';

  @override
  String get signOutTitle => 'Выйти из аккаунта?';

  @override
  String get signOutMessage => 'Вы сможете войти снова в любой момент.';

  @override
  String get deleteAccount => 'Удалить аккаунт';

  @override
  String get deleteAccountTitle => 'Удалить аккаунт?';

  @override
  String get deleteAccountMessage =>
      'Ваш профиль, питомцы, объявления и их фото будут удалены навсегда. Это действие нельзя отменить.';

  @override
  String get deletingAccount => 'Удаляем аккаунт…';

  @override
  String get myReportsSubtitle => 'Следите, чтобы объявления были актуальны.';

  @override
  String get statTotal => 'Всего';

  @override
  String postedOn(String date) {
    return 'Опубликовано $date';
  }

  @override
  String get reportActive => 'Активные';

  @override
  String get reportResolved => 'Решённые';

  @override
  String get myReportsLoadError => 'Не удалось загрузить ваши объявления';

  @override
  String get checkConnection => 'Проверьте подключение и попробуйте снова.';

  @override
  String get noActiveReports => 'Нет активных объявлений';

  @override
  String get noActiveReportsMessage =>
      'Здесь появятся ваши объявления о потерянных и найденных питомцах.';

  @override
  String get reportAPet => 'Сообщить о питомце';

  @override
  String get nothingResolved => 'Пока нет решённых объявлений';

  @override
  String get nothingResolvedMessage =>
      'Когда вы отметите объявление как решённое, оно появится здесь.';

  @override
  String get markAsFound => 'Отметить как найденного';

  @override
  String get returnedToOwner => 'Возвращён хозяину';

  @override
  String get backHome => 'Снова дома';

  @override
  String get reunited => 'С семьёй';

  @override
  String get deleteReport => 'Удалить объявление';

  @override
  String resolveLostTitle(String petName) {
    return '$petName снова дома?';
  }

  @override
  String get resolveFoundTitle => 'Хозяин нашёлся?';

  @override
  String resolveLostMessage(String petName) {
    return 'Объявление переместится в раздел \"Снова дома\" на вкладке Найденные, чтобы соседи знали, что $petName в безопасности.';
  }

  @override
  String get resolveFoundMessage =>
      'Объявление переместится в раздел \"С семьёй\" на вкладке Найденные.';

  @override
  String get notYet => 'Ещё нет';

  @override
  String get yesResolved => 'Да, решено';

  @override
  String get reportResolvedSuccess => 'Отличная новость! Объявление закрыто.';

  @override
  String get deleteReportTitle => 'Удалить это объявление?';

  @override
  String deleteOpenReportMessage(String petName) {
    return 'Оно исчезнет с карты и из списков. Если $petName в безопасности, лучше отметьте объявление как решённое, чтобы соседи знали.';
  }

  @override
  String get deleteResolvedReportMessage =>
      'Оно будет убрано с карты и из списка \"Снова дома\".';

  @override
  String get reportDeleted => 'Объявление удалено.';

  @override
  String get onboarding1Title => 'Каждый питомец заслуживает\n';

  @override
  String get onboarding1Highlight => 'вернуться домой';

  @override
  String get onboarding1Body =>
      'CodaMi объединяет соседей, чтобы потерянные собаки и кошки вернулись к тем, кто их любит.';

  @override
  String get onboarding2Title => 'Сообщите о питомце\nза ';

  @override
  String get onboarding2Highlight => 'секунды';

  @override
  String get onboarding2Body =>
      'Сделайте фото, отметьте место и опубликуйте объявление о пропаже или находке. Все рядом увидят его сразу.';

  @override
  String get onboarding3Title => 'Смотрите, кто\n';

  @override
  String get onboarding3Highlight => 'рядом';

  @override
  String get onboarding3Body =>
      'Потерянные и найденные питомцы вокруг вас — в реальном времени на одной карте, чтобы вы всегда знали, где искать.';

  @override
  String get skip => 'Пропустить';

  @override
  String get getStarted => 'Начать';

  @override
  String get lost => 'Потерян';

  @override
  String get found => 'Найден';

  @override
  String get you => 'Вы';

  @override
  String get published => 'Опубликовано';

  @override
  String get onboardingSampleBreed => 'Золотистый ретривер · 3 года';

  @override
  String get onboardingSamplePlace => 'Милан · 2 ч назад';

  @override
  String get validationNameRequired => 'Введите имя';

  @override
  String get validationNameTooShort => 'Имя должно быть не короче 2 символов';

  @override
  String get validationNameTooLong => 'Имя должно быть короче 50 символов';

  @override
  String get validationNameInvalid =>
      'Имя может содержать только буквы, пробелы, дефисы и апострофы';

  @override
  String get validationEmailRequired => 'Введите email';

  @override
  String get validationEmailInvalid => 'Введите корректный email';

  @override
  String get validationPasswordRequired => 'Введите пароль';

  @override
  String get validationPasswordTooShort =>
      'Пароль должен быть не короче 8 символов';

  @override
  String get validationConfirmRequired => 'Подтвердите пароль';

  @override
  String get validationPasswordsDontMatch => 'Пароли не совпадают';

  @override
  String get spamNote =>
      'Не нашли письмо для сброса пароля? Проверьте папку «Спам» — иногда оно попадает туда.';

  @override
  String get logIn => 'Вход';

  @override
  String get signUp => 'Регистрация';

  @override
  String get authResetSentTitle => 'Проверьте почту';

  @override
  String get authResetSentSubtitle =>
      'Мы отправили вам ссылку для сброса пароля.';

  @override
  String get authLoginTitle => 'С возвращением!';

  @override
  String get authLoginSubtitle =>
      'Войдите, чтобы и дальше помогать питомцам вернуться домой.';

  @override
  String get authSignupTitle => 'Присоединяйтесь к стае';

  @override
  String get authSignupSubtitle =>
      'Создайте аккаунт и помогайте своему району.';

  @override
  String get authForgotTitle => 'Забыли пароль?';

  @override
  String get authForgotSubtitle =>
      'Не страшно, мы пришлём ссылку для сброса на email.';

  @override
  String get fullName => 'Имя и фамилия';

  @override
  String get email => 'Email';

  @override
  String get password => 'Пароль';

  @override
  String get confirmPassword => 'Повторите пароль';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get createAccount => 'Создать аккаунт';

  @override
  String get sendResetLink => 'Отправить ссылку';

  @override
  String get or => 'или';

  @override
  String get continueWithGoogle => 'Продолжить с Google';

  @override
  String get continueWithApple => 'Продолжить с Apple';

  @override
  String get resetLinkSentTo => 'Мы отправили ссылку на';

  @override
  String get backToLogIn => 'Вернуться ко входу';

  @override
  String get sendAgain => 'Не пришло? Отправить снова';

  @override
  String get errorOffline =>
      'Нет подключения к интернету. Проверьте связь и попробуйте снова.';

  @override
  String get errorSessionExpired => 'Сессия истекла. Войдите снова.';

  @override
  String get deleteAccountFailed =>
      'Не удалось удалить аккаунт. Попробуйте снова.';

  @override
  String get authErrorGeneric => 'Что-то пошло не так. Попробуйте снова.';

  @override
  String get authErrorDisabled => 'Этот аккаунт отключён.';

  @override
  String get authErrorWrongCredentials => 'Неверный email или пароль.';

  @override
  String get authErrorEmailInUse =>
      'Аккаунт с таким email уже существует. Попробуйте войти.';

  @override
  String get authErrorTooManyRequests =>
      'Слишком много попыток. Подождите немного и попробуйте снова.';

  @override
  String get citySearchFailed => 'Не удалось найти город. Попробуйте снова.';

  @override
  String get placeSearchFailed => 'Не удалось найти место. Попробуйте снова.';

  @override
  String get placeOutsideCity =>
      'Это место за пределами вашего города. Выберите место в городе.';

  @override
  String get placeNotFound => 'Мы не нашли это место. Выберите другое.';

  @override
  String get citySearchOffline =>
      'Поиск городов недоступен. Проверьте подключение и попробуйте снова.';

  @override
  String get searchCityHint => 'Найдите свой город, например Милан';

  @override
  String noCitiesFound(String query) {
    return 'По запросу \"$query\" города не найдены.';
  }

  @override
  String homeCityUpdated(String city) {
    return 'Город изменён: $city.';
  }

  @override
  String get saveCityFailed => 'Не удалось сохранить город. Попробуйте снова.';

  @override
  String get citySetupTitle => 'Где ';

  @override
  String get citySetupHighlight => 'вы находитесь?';

  @override
  String get cityEditTitle => 'Смените ';

  @override
  String get cityEditHighlight => 'город';

  @override
  String get citySetupBody =>
      'Выберите свой город — мы покажем потерянных и найденных питомцев рядом и предупредим, если в вашем районе пропадёт животное.';

  @override
  String get saveCity => 'Сохранить город';

  @override
  String get continueLabel => 'Продолжить';

  @override
  String get notYouSignOut => 'Это не вы? Выйти';

  @override
  String greeting(String name) {
    return 'Привет, $name!';
  }

  @override
  String get showPetsWithin => 'Показывать питомцев в радиусе';

  @override
  String distanceFrom(String city) {
    return 'Расстояние от: $city';
  }

  @override
  String get everywhere => 'Везде';

  @override
  String distanceKm(int km) {
    return '$km км';
  }

  @override
  String withinKm(int km) {
    return 'в радиусе $km км';
  }

  @override
  String get areaNotSet => 'Район ещё не выбран';

  @override
  String get reportPetSemantics =>
      'Сообщить о потерянном или найденном питомце';

  @override
  String get map => 'Карта';

  @override
  String get locationServicesOff =>
      'Включите геолокацию, чтобы использовать ваше местоположение.';

  @override
  String get locationPermissionDenied =>
      'Разрешите доступ к геолокации в настройках, чтобы использовать ваше местоположение.';

  @override
  String get locationFailed =>
      'Не удалось определить местоположение. Попробуйте снова.';

  @override
  String get back => 'Назад';

  @override
  String get fullScreen => 'Во весь экран';

  @override
  String get loadingPets => 'Загружаем питомцев…';

  @override
  String get mapLoadFailed =>
      'Не удалось загрузить объявления. Проверьте подключение.';

  @override
  String get mapNoLost => 'В этом районе нет потерянных питомцев';

  @override
  String get mapNoFound => 'В этом районе нет найденных питомцев';

  @override
  String get mapNoPets => 'В этом районе нет потерянных или найденных питомцев';

  @override
  String get zoomIn => 'Приблизить';

  @override
  String get zoomOut => 'Отдалить';

  @override
  String get myLocation => 'Моё местоположение';

  @override
  String get myCity => 'Мой город';

  @override
  String get all => 'Все';

  @override
  String get timeJustNow => 'Только что';

  @override
  String timeMinutesAgo(int minutes) {
    return '$minutes мин назад';
  }

  @override
  String timeHoursAgo(int hours) {
    return '$hours ч назад';
  }

  @override
  String get timeYesterday => 'Вчера';

  @override
  String timeDaysAgo(int days) {
    return '$days дн. назад';
  }

  @override
  String notifLostTitle(String city) {
    return 'Пропал питомец: $city';
  }

  @override
  String notifLostBodyNear(String pet, String street, String city) {
    return '$pet в последний раз видели рядом с $street, $city. Будьте внимательны!';
  }

  @override
  String notifLostBodyIn(String pet, String city) {
    return '$pet в последний раз видели в городе $city. Будьте внимательны!';
  }

  @override
  String notifFoundTitle(String city) {
    return 'Найден питомец: $city';
  }

  @override
  String notifFoundBodyNear(String pet, String street, String city) {
    return '$pet: найден рядом с $street, $city. Вы знаете хозяина?';
  }

  @override
  String notifFoundBodyIn(String pet, String city) {
    return '$pet: найден в городе $city. Вы знаете хозяина?';
  }

  @override
  String notifBackHomeTitle(String pet) {
    return '$pet снова дома';
  }

  @override
  String notifBackHomeBody(String pet, String city) {
    return 'Хорошие новости из города $city: $pet нашёлся. Спасибо за помощь!';
  }

  @override
  String notifReunitedTitle(String pet) {
    return '$pet вернулся к семье';
  }

  @override
  String notifReunitedBody(String city) {
    return 'Питомец, найденный в городе $city, вернулся к своей семье.';
  }

  @override
  String get notificationsTitle => 'Уведомления';

  @override
  String get markAllRead => 'Прочитать все';

  @override
  String get notificationsLoadError => 'Не удалось загрузить уведомления';

  @override
  String get allCaughtUp => 'Новых уведомлений нет';

  @override
  String get notificationsEmpty =>
      'Мы сообщим, когда в вашем городе потеряют или найдут питомца.';

  @override
  String get notificationsNew => 'Новые';

  @override
  String get notificationsEarlier => 'Ранее';

  @override
  String get reportNotAvailable => 'Объявление недоступно';

  @override
  String get reportRemoved => 'Автор удалил это объявление.';

  @override
  String get reportsLoadError => 'Не удалось загрузить объявления';

  @override
  String get pullToRetry =>
      'Проверьте подключение и потяните вниз, чтобы обновить.';

  @override
  String get noLostNearby => 'Рядом нет потерянных питомцев';

  @override
  String get noLostNearbyMessage =>
      'Хорошие новости! В вашем районе пока никто не сообщал о пропаже питомца.';

  @override
  String get noFoundYet => 'Пока нет найденных питомцев';

  @override
  String get noFoundYetMessage =>
      'Здесь появятся питомцы, которых нашли ваши соседи.';

  @override
  String get backHomeSection => 'Снова дома';

  @override
  String get backHomeSectionSubtitle =>
      'Питомцы, которые вернулись к своим семьям.';

  @override
  String get loadMore => 'Загрузить ещё';

  @override
  String get speciesDog => 'Собака';

  @override
  String get speciesCat => 'Кошка';

  @override
  String get speciesOther => 'Другое';

  @override
  String get sexMale => 'Мальчик';

  @override
  String get sexFemale => 'Девочка';

  @override
  String get sexUnknown => 'Не знаю';

  @override
  String nearPlace(String street, String city) {
    return 'Рядом с $street, $city';
  }

  @override
  String get callFailed => 'Не удалось начать звонок.';

  @override
  String get whatsappFailed => 'Не удалось открыть WhatsApp.';

  @override
  String get emailFailed => 'Не удалось открыть почтовое приложение.';

  @override
  String whatsappMessageLost(String pet) {
    return 'Здравствуйте! Пишу по поводу потерянного питомца \"$pet\" в CodaMi.';
  }

  @override
  String whatsappMessageFound(String pet) {
    return 'Здравствуйте! Пишу по поводу найденного питомца \"$pet\" в CodaMi.';
  }

  @override
  String emailSubjectLost(String pet) {
    return 'О питомце $pet (пропал, CodaMi)';
  }

  @override
  String emailSubjectFound(String pet) {
    return 'О питомце $pet (найден, CodaMi)';
  }

  @override
  String shareTitleLost(String pet) {
    return 'ПРОПАЛ ПИТОМЕЦ: $pet';
  }

  @override
  String shareTitleFound(String pet) {
    return 'НАЙДЕН ПИТОМЕЦ: $pet';
  }

  @override
  String get shareFooter =>
      'Видели этого питомца? Откройте CodaMi, чтобы связаться.';

  @override
  String get lastSeen => 'Последний раз видели';

  @override
  String get foundAt => 'Найден';

  @override
  String areaAbout(int meters) {
    return 'район около $meters м';
  }

  @override
  String get when => 'Когда';

  @override
  String get postedBy => 'Автор';

  @override
  String get description => 'Описание';

  @override
  String get call => 'Позвонить';

  @override
  String contactTitleLost(String pet) {
    return 'Видели $pet? Свяжитесь';
  }

  @override
  String get contactTitleFound => 'Это ваш питомец? Свяжитесь';

  @override
  String get noContactShared => 'Контактные данные не указаны.';

  @override
  String resolvedThanksLost(String pet) {
    return '$pet снова дома. Спасибо, что пользуетесь CodaMi!';
  }

  @override
  String get resolvedThanksFound =>
      'Этот питомец вернулся к своей семье. Спасибо за помощь!';

  @override
  String get yourContactDetails => 'Ваши контакты';

  @override
  String markPetAsFound(String pet) {
    return 'Отметить, что $pet нашёлся';
  }

  @override
  String get markReturnedToOwner => 'Отметить как возвращённого хозяину';

  @override
  String get copiedToClipboard => 'Скопировано.';

  @override
  String get petSaveFailed => 'Не удалось сохранить питомца. Попробуйте снова.';

  @override
  String get petDeleteFailed => 'Не удалось удалить питомца. Попробуйте снова.';

  @override
  String get errorPermission => 'У вас нет прав на это действие.';

  @override
  String get storageNotReady =>
      'Хранилище фото ещё не настроено. Попробуйте позже.';

  @override
  String get storageFull => 'Хранилище сейчас заполнено. Попробуйте позже.';

  @override
  String petAdded(String name) {
    return '$name: добавлен к вашим питомцам.';
  }

  @override
  String get petsLoadError => 'Не удалось загрузить ваших питомцев';

  @override
  String get noPetsYet => 'Питомцев пока нет';

  @override
  String get noPetsYetMessage =>
      'Добавьте питомцев сейчас, чтобы за секунды сообщить о пропаже, если что-то случится.';

  @override
  String get addFirstPet => 'Добавить первого питомца';

  @override
  String get petsHeaderEmpty =>
      'Держите профили питомцев наготове — на всякий случай.';

  @override
  String petsHeaderCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count пушистых друзей готовы на всякий случай.',
      few: '$count пушистых друга готовы на всякий случай.',
      one: '$count пушистый друг готов на всякий случай.',
    );
    return '$_temp0';
  }

  @override
  String get addPet => 'Добавить';

  @override
  String petUpdated(String name) {
    return '$name: изменения сохранены.';
  }

  @override
  String removePetTitle(String name) {
    return 'Удалить $name?';
  }

  @override
  String get removePetMessage =>
      'Профиль и его фото будут удалены. Это действие нельзя отменить.';

  @override
  String get remove => 'Удалить';

  @override
  String petRemoved(String name) {
    return '$name: удалён.';
  }

  @override
  String get breed => 'Порода';

  @override
  String get color => 'Окрас';

  @override
  String get age => 'Возраст';

  @override
  String get sex => 'Пол';

  @override
  String petAddedOn(String date) {
    return 'Добавлен $date';
  }

  @override
  String get distinctiveFeatures => 'Особые приметы';

  @override
  String ifPetGoesMissing(String name) {
    return 'Если $name потеряется';
  }

  @override
  String get ifPetGoesMissingBody =>
      'Опубликуйте объявление о пропаже с этим профилем за секунды — соседи получат уведомление.';

  @override
  String reportPetAsLost(String name) {
    return 'Сообщить о пропаже: $name';
  }

  @override
  String get colorBlack => 'Чёрный';

  @override
  String get colorWhite => 'Белый';

  @override
  String get colorBrown => 'Коричневый';

  @override
  String get colorGolden => 'Золотистый';

  @override
  String get colorGrey => 'Серый';

  @override
  String get colorCream => 'Кремовый';

  @override
  String get colorGinger => 'Рыжий';

  @override
  String get petPhotoRequired => 'Добавьте хотя бы одно фото питомца.';

  @override
  String get petSpeciesRequired =>
      'Укажите, кто ваш питомец: собака, кошка или другое животное.';

  @override
  String get checkHighlightedFields => 'Проверьте выделенные поля.';

  @override
  String get signInToSave => 'Войдите снова, чтобы сохранить.';

  @override
  String get discardChangesTitle => 'Отменить изменения?';

  @override
  String get discardPetChanges => 'Изменения этого питомца будут потеряны.';

  @override
  String get keepEditing => 'Продолжить';

  @override
  String get discard => 'Отменить';

  @override
  String editPetTitle(String name) {
    return 'Изменить: $name';
  }

  @override
  String get newPet => 'Новый питомец';

  @override
  String get whatKindOfPet => 'Какой у вас питомец?';

  @override
  String get name => 'Кличка';

  @override
  String get petNameHint => 'например, Луна';

  @override
  String get petNameRequired => 'Введите кличку питомца';

  @override
  String get petNameTooLong => 'Кличка должна быть короче 40 символов';

  @override
  String get breedHint => 'например, золотистый ретривер, метис';

  @override
  String get colorHint => 'например, золотистый с белой грудкой';

  @override
  String get ageHint => 'например, 3 года, 8 месяцев';

  @override
  String get featuresHint =>
      'Ошейник, чип, шрамы, пятна… всё, что поможет узнать вашего питомца.';

  @override
  String get saveChanges => 'Сохранить изменения';

  @override
  String get savePet => 'Сохранить питомца';

  @override
  String get cameraPermission => 'Разрешите доступ к камере в настройках.';

  @override
  String get photosPermission => 'Разрешите доступ к фото в настройках.';

  @override
  String get cameraFailed => 'Не удалось открыть камеру.';

  @override
  String get galleryFailed => 'Не удалось открыть галерею.';

  @override
  String get optional => 'Необязательно';

  @override
  String get addPetPhotos => 'Добавьте фото питомца';

  @override
  String get addPetPhotosHint => 'Чёткие свежие фото помогают его узнать';

  @override
  String get photoRequired => 'Нужно хотя бы одно фото';

  @override
  String get tapToMakeCover => 'Нажмите на фото, чтобы сделать его обложкой.';

  @override
  String get cover => 'Обложка';

  @override
  String uploadingPhotos(int percent) {
    return 'Загрузка фото… $percent%';
  }

  @override
  String get saving => 'Сохраняем…';

  @override
  String get takePhoto => 'Сделать фото';

  @override
  String get useCamera => 'Использовать камеру';

  @override
  String get chooseFromGallery => 'Выбрать из галереи';

  @override
  String get pickExistingPhoto => 'Выбрать имеющееся фото';

  @override
  String get yourPet => 'ваш питомец';

  @override
  String get unknownDog => 'Неизвестная собака';

  @override
  String get unknownCat => 'Неизвестная кошка';

  @override
  String get unknownPet => 'Неизвестный питомец';

  @override
  String get errorChooseType => 'Укажите, потеряли вы питомца или нашли.';

  @override
  String get errorPickPet => 'Выберите пропавшего питомца.';

  @override
  String get errorFoundPhoto => 'Добавьте хотя бы одно фото животного.';

  @override
  String get errorFoundSpecies => 'Это собака, кошка или другое животное?';

  @override
  String get errorChooseCity => 'Выберите город, где это случилось.';

  @override
  String get errorFutureDate => 'Дата не может быть в будущем.';

  @override
  String get errorDescriptionShort =>
      'Добавьте краткое описание (не менее 10 символов).';

  @override
  String get errorContactRequired =>
      'Укажите телефон или email, чтобы с вами могли связаться.';

  @override
  String get errorPhoneInvalid => 'Введите корректный номер телефона.';

  @override
  String get discardReportTitle => 'Отменить это объявление?';

  @override
  String get discardReportMessage => 'Всё, что вы ввели, будет потеряно.';

  @override
  String get signInToPublish => 'Войдите снова, чтобы опубликовать.';

  @override
  String publishedLost(String pet) {
    return '$pet теперь на карте. Надеемся, скоро вернётся домой.';
  }

  @override
  String publishedFound(String pet) {
    return 'Спасибо! $pet теперь на карте.';
  }

  @override
  String get reportLostPetTitle => 'Сообщить о пропаже';

  @override
  String get reportFoundPetTitle => 'Сообщить о находке';

  @override
  String get newReport => 'Новое объявление';

  @override
  String stepOf(int current, int total) {
    return '$current из $total';
  }

  @override
  String get publishReport => 'Опубликовать';

  @override
  String get stepTypeTitle => 'Что случилось?';

  @override
  String get stepTypeSubtitle => 'Быстро расскажем об этом людям поблизости.';

  @override
  String get stepFoundPetTitle => 'Расскажите о животном';

  @override
  String get stepFoundPetSubtitle =>
      'Чёткое фото — самый быстрый способ, чтобы хозяин его узнал.';

  @override
  String get addFoundPhotos => 'Добавьте фото животного';

  @override
  String get addFoundPhotosHint =>
      'Сделайте снимок сейчас или выберите из галереи';

  @override
  String get whatKindOfAnimal => 'Какое это животное?';

  @override
  String get collarName => 'Кличка на ошейнике или жетоне';

  @override
  String get collarNameHint => 'Оставьте пустым, если не знаете';

  @override
  String get stepLostPetTitle => 'Какой питомец пропал?';

  @override
  String get stepLostPetSubtitle =>
      'Мы используем его профиль и фото, вводить ничего заново не нужно.';

  @override
  String get stepWhereFoundTitle => 'Где вы его нашли?';

  @override
  String stepWhereLostTitle(String pet) {
    return 'Где $pet видели в последний раз?';
  }

  @override
  String get stepWhereSubtitle =>
      'Выберите город, затем отметьте точку на карте. Другие видят только район около 100 м, а не точный адрес.';

  @override
  String get streetOrLandmark => 'Улица или ориентир';

  @override
  String get pinExactSpot => 'Отметьте точное место';

  @override
  String spotHintFound(String pet) {
    return 'Двигайте карту, пока метка не окажется там, где вы нашли $pet.';
  }

  @override
  String spotHintLost(String pet) {
    return 'Двигайте карту, пока метка не окажется там, где $pet видели в последний раз.';
  }

  @override
  String spotFarFromCity(int km, String city) {
    return 'Эта точка в $km км от города $city. Город указан верно?';
  }

  @override
  String spotPinned(int meters) {
    return 'Отмечено. Другие видят только район около $meters м вокруг, а не точное место.';
  }

  @override
  String get timeHourAgo => '1 час назад';

  @override
  String get timeThisMorning => 'Сегодня утром';

  @override
  String get stepWhenFoundTitle => 'Когда вы его нашли?';

  @override
  String stepWhenLostTitle(String pet) {
    return 'Когда вы в последний раз видели $pet?';
  }

  @override
  String get stepWhenSubtitle => 'Можно указать примерное время.';

  @override
  String get changeDate => 'Изменить дату';

  @override
  String get changeTime => 'Изменить время';

  @override
  String get stepDetailsTitle => 'Что ещё нам нужно знать?';

  @override
  String get stepDetailsSubtitle =>
      'Подробности помогут соседям узнать животное и быстро связаться с вами.';

  @override
  String descriptionHintLost(String pet) {
    return 'Цвет ошейника, характер, как пропал $pet…';
  }

  @override
  String get descriptionHintFound =>
      'Состояние, ошейник, поведение, где именно вы его нашли…';

  @override
  String get howToReachYou => 'Как с вами связаться?';

  @override
  String get contactPrivacyNote =>
      'Видно только на странице объявления, но не в списках.';

  @override
  String get phoneHint => 'Телефон, например +39 333 123 4567';

  @override
  String get reachableOnWhatsapp => 'Доступен в WhatsApp';

  @override
  String get reachableOnWhatsappHint => 'Вам смогут написать на этот номер';

  @override
  String get stepReviewTitle => 'Готовы опубликовать?';

  @override
  String get stepReviewSubtitle =>
      'Так ваше объявление увидят люди поблизости.';

  @override
  String get iLostMyPet => 'Я потерял питомца';

  @override
  String get iFoundAPet => 'Я нашёл животное';

  @override
  String get iLostMyPetHint =>
      'Предупредите людей рядом и получите помощь в поисках.';

  @override
  String get iFoundAPetHint => 'Помогите потерянному питомцу вернуться домой.';

  @override
  String get addAPet => 'Добавить питомца';

  @override
  String get pleaseChooseCity => 'Выберите город';

  @override
  String noPlacesFound(String city, String query) {
    return 'В городе $city по запросу \"$query\" ничего не найдено.';
  }

  @override
  String searchStreetHint(String city) {
    return 'Поиск в городе $city, например Via Dante';
  }

  @override
  String get yourCity => 'ваш город';

  @override
  String get useMyLocation => 'Моё местоположение';

  @override
  String get publishFailed =>
      'Не удалось опубликовать объявление. Попробуйте снова.';

  @override
  String get updateReportFailed =>
      'Не удалось обновить объявление. Попробуйте снова.';

  @override
  String get deleteReportFailed =>
      'Не удалось удалить объявление. Попробуйте снова.';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get termsOfUse => 'Условия использования';

  @override
  String legalLastUpdated(String date) {
    return 'Последнее обновление: $date';
  }

  @override
  String get deleteAccountPasswordPrompt => 'Введите пароль для подтверждения.';

  @override
  String deleteAccountTypeConfirm(String word) {
    return 'Введите $word для подтверждения.';
  }

  @override
  String get wrongPassword => 'Неверный пароль. Попробуйте снова.';

  @override
  String get confirmPasswordAgain =>
      'В целях безопасности подтвердите пароль ещё раз.';

  @override
  String get contactUs => 'Связаться с нами';

  @override
  String get legalQuestions => 'Вопросы об этом документе или ваших данных?';

  @override
  String get languageChangeLater =>
      'Вы можете изменить его в любое время в профиле.';

  @override
  String get reward => 'Вознаграждение';

  @override
  String get rewardHint => 'Сумма в евро';

  @override
  String get rewardNote =>
      'Вознаграждение — это частная договорённость между владельцем и нашедшим. CodaMi не гарантирует и не обрабатывает платежи.';

  @override
  String rewardAmount(String amount) {
    return 'Вознаграждение $amount';
  }

  @override
  String get adminPanel => 'Панель администратора';

  @override
  String get roleAdmin => 'Администратор';

  @override
  String get roleSupport => 'Поддержка';

  @override
  String get supportStaff => 'Команда поддержки';

  @override
  String get supportStaffSubtitle =>
      'Люди, которые отвечают на обращения в поддержку';

  @override
  String get adminUsers => 'Пользователи';

  @override
  String get adminListings => 'Объявления';

  @override
  String get adminReportedContent => 'Жалобы на контент';

  @override
  String get adminTickets => 'Обращения в поддержку';

  @override
  String get adminVideos => 'Видео';

  @override
  String get addSupportStaff => 'Добавить в поддержку';

  @override
  String get addSupportStaffHint =>
      'Введите email существующего аккаунта CodaMi.';

  @override
  String get userNotFound => 'Нет аккаунта CodaMi с таким email.';

  @override
  String get alreadyStaff => 'Этот человек уже в команде.';

  @override
  String staffAdded(String name) {
    return '$name теперь в команде поддержки.';
  }

  @override
  String removeStaffTitle(String name) {
    return 'Удалить $name?';
  }

  @override
  String get removeStaffMessage =>
      'Доступ к панели администратора будет закрыт.';

  @override
  String get noSupportStaff => 'В команде поддержки пока никого нет.';

  @override
  String get add => 'Добавить';

  @override
  String get actionFailed => 'Что-то пошло не так. Попробуйте ещё раз.';

  @override
  String get adminDashboard => 'Обзор';

  @override
  String get adminMore => 'Ещё';

  @override
  String get adminReportedShort => 'Жалобы';

  @override
  String get adminTicketsShort => 'Обращения';

  @override
  String get adminSectionSoon => 'Этот раздел скоро появится.';

  @override
  String get statUsers => 'Зарегистрированные пользователи';

  @override
  String get statOpenLost => 'Открытые объявления о пропаже';

  @override
  String get statOpenFound => 'Открытые объявления о находке';

  @override
  String get statBackHome => 'Вернулись домой';

  @override
  String get flagListing => 'Пожаловаться';

  @override
  String get flagTitle => 'Почему вы жалуетесь на это объявление?';

  @override
  String get flagHint =>
      'Наша команда проверит его. Владелец не узнает, кто пожаловался.';

  @override
  String get flagReasonSpam => 'Спам или реклама';

  @override
  String get flagReasonScam => 'Мошенничество';

  @override
  String get flagReasonInappropriate => 'Неприемлемый контент';

  @override
  String get flagReasonWrongInfo =>
      'Ложная или вводящая в заблуждение информация';

  @override
  String get flagReasonOther => 'Другое';

  @override
  String get flagNoteHint => 'Добавьте подробности (необязательно)';

  @override
  String get flagSubmit => 'Отправить жалобу';

  @override
  String get flagSent => 'Спасибо. Наша команда проверит это объявление.';

  @override
  String get alreadyFlagged => 'Вы уже пожаловались на это объявление.';

  @override
  String blockUser(String name) {
    return 'Заблокировать: $name';
  }

  @override
  String blockUserTitle(String name) {
    return 'Заблокировать: $name?';
  }

  @override
  String get blockUserMessage =>
      'Вы больше не увидите объявления этого пользователя и не получите уведомлений о них. Разблокировать можно в Профиль → Заблокированные.';

  @override
  String get block => 'Заблокировать';

  @override
  String userBlocked(String name) {
    return '$name: пользователь заблокирован.';
  }

  @override
  String get blockedUsers => 'Заблокированные';

  @override
  String get noBlockedUsers => 'Вы никого не заблокировали.';

  @override
  String get unblock => 'Разблокировать';

  @override
  String userUnblocked(String name) {
    return '$name: пользователь разблокирован.';
  }

  @override
  String get unknownUser => 'Неизвестный пользователь';

  @override
  String get hiddenListing => 'Скрыто';

  @override
  String get hiddenListingNotice =>
      'Команда CodaMi скрыла это объявление, оно больше не публичное.';

  @override
  String get moderation => 'Модерация';

  @override
  String get noFlagsOnListing => 'На это объявление никто не жаловался.';

  @override
  String flagCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count жалобы',
      many: '$count жалоб',
      few: '$count жалобы',
      one: '1 жалоба',
    );
    return '$_temp0';
  }

  @override
  String get dismissFlags => 'Отклонить жалобы';

  @override
  String get flagsDismissed => 'Жалобы отклонены.';

  @override
  String get hideListing => 'Скрыть объявление';

  @override
  String get restoreListing => 'Восстановить объявление';

  @override
  String get listingHidden => 'Объявление скрыто. Его видит только владелец.';

  @override
  String get listingRestored => 'Объявление восстановлено.';

  @override
  String get deleteListing => 'Удалить объявление';

  @override
  String get deleteListingTitle => 'Удалить это объявление?';

  @override
  String get deleteListingMessage =>
      'Объявление и его фото будут удалены для всех. Это действие нельзя отменить.';

  @override
  String get listingDeleted => 'Объявление удалено.';

  @override
  String get listingUnavailable => 'Объявление больше недоступно';

  @override
  String get noReportedContent => 'Жалоб нет';

  @override
  String get noReportedContentMessage =>
      'Здесь появятся объявления, на которые пожаловались пользователи.';

  @override
  String get filterOpen => 'Открытые';

  @override
  String get filterResolved => 'Решённые';

  @override
  String get filterHidden => 'Скрытые';

  @override
  String get noListings => 'Объявлений нет';

  @override
  String get tryAnotherFilter => 'Попробуйте другой фильтр.';

  @override
  String get adminUsersSubtitle => 'Просмотр, блокировка и удаление аккаунтов';

  @override
  String get searchByEmail => 'Поиск по email';

  @override
  String get noUsersFound => 'Пользователи не найдены.';

  @override
  String get roleUser => 'Пользователь';

  @override
  String get userDisabled => 'Отключён';

  @override
  String get phone => 'Телефон';

  @override
  String get memberSince => 'Участник с';

  @override
  String get disableAccount => 'Отключить аккаунт';

  @override
  String get enableAccount => 'Включить аккаунт';

  @override
  String disableUserTitle(String name) {
    return 'Отключить аккаунт: $name?';
  }

  @override
  String get disableUserMessage =>
      'Пользователь выйдет из системы и не сможет войти. Его открытые объявления будут скрыты, пока аккаунт снова не включат.';

  @override
  String get accountDisabled => 'Аккаунт отключён.';

  @override
  String get accountEnabled => 'Аккаунт включён.';

  @override
  String deleteUserTitle(String name) {
    return 'Удалить аккаунт: $name?';
  }

  @override
  String get deleteUserMessage =>
      'Профиль, питомцы, объявления и фото будут удалены навсегда. Это действие нельзя отменить.';

  @override
  String get userDeleted => 'Аккаунт удалён.';

  @override
  String get save => 'Сохранить';

  @override
  String get requiredField => 'Обязательно';

  @override
  String get notificationSettingsIntro =>
      'Выберите, какие оповещения получать, и задайте каждому свой звук, чтобы понимать, что случилось, ещё не глядя на экран.';

  @override
  String get notificationSound => 'Звук';

  @override
  String get alertLostTitle => 'Потерянные животные рядом';

  @override
  String get alertLostDescription => 'Когда в вашем городе пропадает животное';

  @override
  String get alertFoundTitle => 'Найденные животные рядом';

  @override
  String get alertFoundDescription =>
      'Когда кто-то находит животное в вашем городе';

  @override
  String get alertResolvedTitle => 'Счастливые истории';

  @override
  String get alertResolvedDescription =>
      'Когда потерянное или найденное животное вернулось домой';

  @override
  String get soundDefault => 'Звук телефона по умолчанию';

  @override
  String get soundSilent => 'Без звука';

  @override
  String get soundChime => 'Перезвон';

  @override
  String get soundBell => 'Колокольчик';

  @override
  String get soundBright => 'Яркий';

  @override
  String get soundSoft => 'Мягкий';

  @override
  String get soundCustom => 'Свой звук';

  @override
  String get soundFromPhone => 'Мелодии и сигналы телефона';

  @override
  String get soundFromFile => 'Музыка или аудиофайл';

  @override
  String get soundIosNote =>
      'На iPhone звуки уведомлений должны быть из приложения, поэтому выберите один из звуков выше.';

  @override
  String get soundPickFailed =>
      'Не удалось использовать этот звук. Попробуйте другой.';

  @override
  String get videosForYou => 'Видео для вас';

  @override
  String get videosForYourPets => 'Подобраны для ваших питомцев';

  @override
  String get videosGeneral => 'Благополучие животных и ответственный уход';

  @override
  String get videosShuffle => 'Показать другие видео';

  @override
  String get videoMotivational => 'Мотивация';

  @override
  String get videoEducational => 'Полезно знать';

  @override
  String get videoTagGeneral => 'Для всех';

  @override
  String get videoLoadError =>
      'Сейчас это видео нельзя воспроизвести. Попробуйте позже.';

  @override
  String get adminVideosSubtitle => 'Загрузка видео и управление ими';

  @override
  String get addVideo => 'Добавить видео';

  @override
  String get editVideo => 'Изменить видео';

  @override
  String get noVideosYet => 'Видео пока нет. Добавьте первое кнопкой ниже.';

  @override
  String get deleteVideoTitle => 'Удалить это видео?';

  @override
  String get deleteVideoMessage =>
      'Оно исчезнет из приложения для всех. Это действие нельзя отменить.';

  @override
  String get videoHidden => 'Скрыто';

  @override
  String get allLanguages => 'Все языки';

  @override
  String get chooseVideo => 'Выбрать видео';

  @override
  String get chooseVideoHint =>
      'Из галереи, до 200 МБ. Лучше всего подходят короткие видео (до 2 минут).';

  @override
  String get videoTitle => 'Название';

  @override
  String get videoType => 'Тип';

  @override
  String get videoAnimals => 'Животные';

  @override
  String get videoAnimalsHint =>
      'Выберите, о каких животных это видео. Выберите «Для всех» для общих видео, которые видят все.';

  @override
  String get videoVisible => 'Показывать в приложении';

  @override
  String get videoVisibleHint => 'Скрытые видео видят только администраторы.';

  @override
  String get videoTooLarge => 'Видео больше 200 МБ. Выберите покороче.';

  @override
  String get videoSaved => 'Видео сохранено.';

  @override
  String uploadingProgress(int percent) {
    return 'Загрузка… $percent%';
  }

  @override
  String get navVideos => 'Видео';

  @override
  String get videosEmptyTitle => 'Видео скоро появятся';

  @override
  String get videosEmptyMessage =>
      'Скоро здесь появятся короткие видео об уходе за вашими животными.';

  @override
  String get moreVideos => 'Ещё видео';

  @override
  String get videoWatched => 'Просмотрено';

  @override
  String get videoBack10 => 'Назад на 10 секунд';

  @override
  String get videoForward10 => 'Вперёд на 10 секунд';

  @override
  String get videoFullscreen => 'Во весь экран';

  @override
  String get videoExitFullscreen => 'Выйти из полноэкранного режима';

  @override
  String get videoRetry => 'Повторить';

  @override
  String get videoDeleted => 'Видео удалено.';

  @override
  String get noVideosYetTitle => 'Видео пока нет';

  @override
  String get videoVisibleShort => 'Видимые';

  @override
  String get play => 'Смотреть';

  @override
  String get edit => 'Изменить';

  @override
  String get change => 'Заменить';

  @override
  String get videoSectionFile => 'Видео';

  @override
  String get videoSectionDetails => 'Описание';

  @override
  String get videoSectionAudience => 'Кто увидит';

  @override
  String get videoCover => 'Обложка';

  @override
  String get videoCoverHint => 'Необязательно. Показывается на карточке видео.';

  @override
  String get videoMotivationalHint =>
      'Вдохновляющие истории и радостные моменты';

  @override
  String get videoEducationalHint => 'Советы и инструкции для владельцев';

  @override
  String get uploadVideo => 'Загрузить видео';

  @override
  String get helpSupport => 'Помощь и поддержка';

  @override
  String get helpSupportSubtitle =>
      'Напишите нам в чат или отправьте обращение';

  @override
  String get supportIntroTitle => 'Чем мы можем помочь?';

  @override
  String get supportIntroMessage =>
      'Наша команда отвечает здесь, в приложении. Вы получите уведомление, когда мы ответим.';

  @override
  String get supportStartChat => 'Начать чат';

  @override
  String get supportStartChatOnline => 'Оператор сейчас в сети';

  @override
  String get supportChatOffline =>
      'Сейчас нет операторов в сети. Отправьте обращение, и мы ответим как можно скорее.';

  @override
  String get supportSendRequest => 'Отправить обращение';

  @override
  String get supportSendRequestSubtitle =>
      'Обычно мы отвечаем в течение 24 часов';

  @override
  String get supportMyRequests => 'Мои обращения';

  @override
  String get supportNoRequests => 'Обращений пока нет';

  @override
  String get supportNoRequestsMessage =>
      'Здесь появятся ваши переписки с поддержкой.';

  @override
  String get supportNewChat => 'Новый чат';

  @override
  String get supportNewRequest => 'Новое обращение';

  @override
  String get supportCategory => 'Тема';

  @override
  String get categoryAccount => 'Аккаунт и вход';

  @override
  String get categoryListing => 'Объявление о пропаже или находке';

  @override
  String get categoryApp => 'Проблема с приложением';

  @override
  String get categoryOther => 'Другое';

  @override
  String get supportSubject => 'Тема обращения';

  @override
  String get supportSubjectHint => 'В двух словах';

  @override
  String get supportSubjectTooShort => 'Введите не менее 3 символов';

  @override
  String get supportMessage => 'Сообщение';

  @override
  String get supportMessageHint => 'Расскажите, что случилось';

  @override
  String get supportMessageRequired => 'Напишите сообщение';

  @override
  String get supportSend => 'Отправить';

  @override
  String get supportTooManyOpen =>
      'У вас уже 3 открытых обращения. Продолжите в одном из них.';

  @override
  String get supportTypeMessage => 'Напишите сообщение…';

  @override
  String get supportTeam => 'Поддержка CodaMi';

  @override
  String get supportMarkSolved => 'Отметить как решённое';

  @override
  String get supportMarkSolvedConfirm =>
      'Отметить обращение как решённое? Вы сможете написать снова, если понадобится помощь.';

  @override
  String get supportClosedNote =>
      'Обращение закрыто. Создайте новое, если нужна помощь.';

  @override
  String get supportResolvedNote =>
      'Отмечено как решённое. Новое сообщение откроет его снова.';

  @override
  String get supportWaitingNote => 'Спасибо! Наша команда скоро ответит здесь.';

  @override
  String get kindChat => 'Чат';

  @override
  String get kindTicket => 'Обращение';

  @override
  String get caseStatusOpen => 'Открыто';

  @override
  String get caseStatusInProgress => 'В работе';

  @override
  String get caseStatusWaitingUser => 'Ожидает ответа';

  @override
  String get caseStatusResolved => 'Решено';

  @override
  String get caseStatusClosed => 'Закрыто';

  @override
  String get filterUnanswered => 'Без ответа';

  @override
  String get filterUnassigned => 'Не назначены';

  @override
  String get filterMine => 'Мои';

  @override
  String get filterActive => 'Активные';

  @override
  String get filterDone => 'Завершённые';

  @override
  String get supportSearchHint => 'Поиск: CM-1042 или email';

  @override
  String get supportNoCases => 'Здесь нет обращений';

  @override
  String get supportNoCasesMessage => 'В этом списке ничего не ждёт.';

  @override
  String get supportTake => 'Взять в работу';

  @override
  String get supportTakeToReply =>
      'Возьмите обращение в работу, чтобы ответить.';

  @override
  String get supportAlreadyTaken => 'Другой оператор уже взял это обращение.';

  @override
  String get supportUnassigned => 'Не назначено';

  @override
  String get supportReassign => 'Передать';

  @override
  String get supportAssignTo => 'Назначить';

  @override
  String get supportBackToQueue => 'Вернуть в очередь';

  @override
  String get supportChangeStatus => 'Изменить статус';

  @override
  String get supportChat => 'Чат';

  @override
  String get supportTimeline => 'История';

  @override
  String get supportDetails => 'Подробности';

  @override
  String supportWaitingFor(String time) {
    return 'Ждёт $time';
  }

  @override
  String get supportOverdue => 'Ответ просрочен';

  @override
  String get supportOpened => 'Открыто';

  @override
  String get supportTakenOver => 'Взято в работу';

  @override
  String get supportWaitToTake => 'Ожидание до взятия';

  @override
  String get supportFirstReply => 'Первый ответ';

  @override
  String get supportAvgReply => 'Среднее время ответа';

  @override
  String get supportHandlingTime => 'Затрачено времени';

  @override
  String get supportResolvedAt => 'Решено';

  @override
  String get supportMessagesCount => 'Сообщения';

  @override
  String get supportOperator => 'Оператор';

  @override
  String get supportUserLabel => 'Пользователь';

  @override
  String eventCreated(String name) {
    return 'Создано: $name';
  }

  @override
  String eventTaken(String name) {
    return 'Взято в работу: $name';
  }

  @override
  String eventReassigned(String from, String to) {
    return 'Передано от $from к $to';
  }

  @override
  String eventStatus(String name, String status) {
    return '$name изменил(а) статус на «$status»';
  }

  @override
  String get eventReopened => 'Открыто пользователем повторно';

  @override
  String get eventOverdue => 'Нет ответа в установленный срок';

  @override
  String get eventAutoClosed => 'Закрыто автоматически';

  @override
  String get presenceOnline => 'В сети';

  @override
  String get presenceAway => 'Отошёл';

  @override
  String get presenceOffline => 'Не в сети';

  @override
  String get presenceAvailable => 'Доступен для чата';

  @override
  String get presenceAvailableSubtitle =>
      'Пользователи могут начать чат, пока оператор в сети';

  @override
  String get supportOperators => 'Операторы';

  @override
  String get supportOperatorsSubtitle => 'Активность, обращения и время ответа';

  @override
  String get operatorOpenCases => 'Открытые';

  @override
  String get operatorTaken => 'Взято';

  @override
  String get operatorResolved => 'Решено';

  @override
  String get operatorReplies => 'Ответы';

  @override
  String get operatorAvgHandling => 'Среднее время на обращение';

  @override
  String operatorLastActive(String time) {
    return 'Последняя активность $time';
  }

  @override
  String get operatorCases => 'Обращения';

  @override
  String get noOperators =>
      'Операторов пока нет. Добавьте их в разделе «Сотрудники поддержки».';

  @override
  String get statUnassigned => 'Неназначенные обращения';

  @override
  String get statUnanswered => 'Обращения без ответа';

  @override
  String get statOverdue => 'Просроченные ответы';

  @override
  String get alertSupportTitle => 'Ответы поддержки';

  @override
  String get alertSupportDescription => 'Когда поддержка CodaMi пишет вам';

  @override
  String durationSeconds(int n) {
    return '$n с';
  }

  @override
  String durationMinutes(int n) {
    return '$n мин';
  }

  @override
  String durationHours(int h, int m) {
    return '$h ч $m мин';
  }

  @override
  String durationDays(int d, int h) {
    return '$d д $h ч';
  }

  @override
  String get searchUsersHint => 'Поиск по имени или email';

  @override
  String get searchTooShort => 'Введите не менее 2 символов';

  @override
  String get pickStaffTitle => 'Выберите пользователя';

  @override
  String get pickStaffHint =>
      'Нажмите на человека, чтобы добавить его в поддержку.';

  @override
  String makeStaffTitle(String name) {
    return 'Сделать $name сотрудником поддержки?';
  }

  @override
  String get makeStaffMessage =>
      'Он увидит раздел администратора и сможет отвечать на обращения и чаты. Его можно убрать в любой момент.';

  @override
  String get makeStaff => 'Добавить в команду';

  @override
  String get supportStaffSwitch => 'Сотрудник поддержки';

  @override
  String get supportStaffSwitchSubtitle => 'Может отвечать на обращения и чаты';

  @override
  String staffRemoved(String name) {
    return '$name больше не в команде поддержки.';
  }

  @override
  String get removeStaffCasesNote =>
      'Его открытые обращения вернутся в очередь.';

  @override
  String get pushOpen => 'Открыть';

  @override
  String get chatToday => 'Сегодня';

  @override
  String get chatLoadEarlier => 'Загрузить более ранние';

  @override
  String get supportPeople => 'Участники';

  @override
  String get supportTimes => 'Время';

  @override
  String get supportRequestInfo => 'Обращение';

  @override
  String get supportType => 'Тип';

  @override
  String get supportResolve => 'Отметить как решённое';

  @override
  String ticketsWaiting(int count) {
    return 'Ждут ответа: $count';
  }

  @override
  String get ticketsAllClear => 'Всё обработано';

  @override
  String get photoReviewHint =>
      'Фото, задержанные ИИ. Они скрыты, пока вы не примете решение.';

  @override
  String get reasonAdult => 'Нагота или сексуальный контент';

  @override
  String get reasonRacy => 'Откровенный контент';

  @override
  String get reasonViolence => 'Насилие или кровь';

  @override
  String get likelihoodPossible => 'Возможно';

  @override
  String get likelihoodLikely => 'Вероятно';

  @override
  String get likelihoodVeryLikely => 'Очень вероятно';

  @override
  String get hiddenByAi => 'Скрыто ИИ';

  @override
  String get petPhoto => 'Фото питомца';

  @override
  String get listingPhoto => 'Фото объявления';

  @override
  String uploadedBy(String name) {
    return 'Автор: $name';
  }

  @override
  String get tapToView => 'Нажмите, чтобы посмотреть';

  @override
  String get approvePhoto => 'Одобрить';

  @override
  String get removePhotoTitle => 'Удалить это фото?';

  @override
  String get removePhotoMessage =>
      'Оно будет удалено из питомца или объявления пользователя, и пользователь узнает причину.';

  @override
  String get photoApproved => 'Фото одобрено';

  @override
  String get photoRemovedDone => 'Фото удалено';

  @override
  String get photoUnderReview =>
      'Наша команда проверяет фото. До тех пор оно скрыто.';

  @override
  String get reportedTabPhotos => 'Фото ИИ';

  @override
  String get reportedTabReports => 'Жалобы';

  @override
  String get noPhotosToReview => 'Нет фото на проверку';

  @override
  String get noPhotosToReviewMessage => 'Здесь появятся фото, задержанные ИИ.';
}
