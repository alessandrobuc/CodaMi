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

  @override
  String get aFriend => 'Друг';

  @override
  String get addContact => 'Добавить контакт';

  @override
  String get addTestContacts => 'Добавить тестовые контакты';

  @override
  String get adjustPoints => 'Изменить баллы';

  @override
  String get adjustPointsAmount => 'Сколько баллов добавить или снять';

  @override
  String get adjustPointsAmountHelp =>
      'Чтобы снять баллы, поставьте минус, например -20';

  @override
  String get adjustPointsInvalid => 'Укажите количество баллов и причину.';

  @override
  String get adjustPointsReason => 'Причина (её увидит пользователь)';

  @override
  String get adminContactsSubtitle =>
      'Ветеринары, организации и службы, которые видят пользователи';

  @override
  String get adminEmergenciesSubtitle =>
      'Сообщения об экстренных случаях с животными';

  @override
  String get alertEmergencyDescription =>
      'Животные рядом с вашим городом, которым срочно нужна помощь';

  @override
  String get alertEmergencyTitle => 'Экстренные случаи рядом';

  @override
  String get allContacts => 'Все';

  @override
  String get ambassadorLevels => 'Уровни посла';

  @override
  String get call112 => 'Позвонить 112';

  @override
  String get claim => 'Забрать';

  @override
  String get claimed => 'Получено';

  @override
  String get codeCopied => 'Код скопирован';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get contactActive => 'Показывать пользователям';

  @override
  String get contactActiveHelp =>
      'Выключите, чтобы скрыть контакт, не удаляя его.';

  @override
  String get contactAddress => 'Адрес';

  @override
  String get contactAreaKm => 'Зона работы (км)';

  @override
  String get contactAreaKmHelp =>
      'На каком расстоянии от адреса может помочь. Оставьте пустым, чтобы использовать значение из настроек экстренных случаев.';

  @override
  String get contactCity => 'Населённый пункт';

  @override
  String get contactHandles => 'С какими случаями работает';

  @override
  String get contactHandlesHelp =>
      'Оставьте всё выключенным, если работает со всеми видами.';

  @override
  String get contactHoursHint => 'Часы работы, например Пн–Пт 9:00–18:00';

  @override
  String get contactInactive => 'Скрыт';

  @override
  String get contactKindAssociation => 'Зоозащитная организация';

  @override
  String get contactKindOther => 'Другая служба';

  @override
  String get contactKindPublicService => 'Государственная ветслужба';

  @override
  String get contactKindVet => 'Ветеринар';

  @override
  String get contactMissingFields =>
      'Укажите название и поставьте метку на карте.';

  @override
  String get contactName => 'Название';

  @override
  String get contactNameHint => 'например, Ветклиника «Святой Франциск»';

  @override
  String get contactPhones => 'Телефоны';

  @override
  String get contactPhonesHint => 'Разделяйте номера запятыми';

  @override
  String get contactPlace => 'Где находится';

  @override
  String get contactRecommendedHelp =>
      'Показывается раньше более близких контактов при экстренном случае.';

  @override
  String get contactTestHelp =>
      'Заглушка для тестов. Показывается с пометкой ТЕСТ, никогда не проверяется и не получает писем.';

  @override
  String get contactType => 'Тип';

  @override
  String get contactVerifiedHelp =>
      'Только после согласия организации и проверки данных.';

  @override
  String get copyCode => 'Копировать';

  @override
  String get dailyActive => 'Активность сегодня';

  @override
  String get dailyCheckin => 'Ежедневная отметка';

  @override
  String get dailyRewards => 'Ежедневные награды';

  @override
  String get deleteContactTitle => 'Удалить этот контакт?';

  @override
  String get directions => 'Маршрут';

  @override
  String get editContact => 'Изменить контакт';

  @override
  String get emergencies => 'Экстренные случаи';

  @override
  String get emergenciesActive => 'Активные';

  @override
  String get emergenciesAll => 'Все';

  @override
  String get emergenciesNearYou => 'Рядом с вами';

  @override
  String get emergenciesSubtitle => 'Животные, которым срочно нужна помощь';

  @override
  String get emergencyAddPhotos => 'Добавьте фото';

  @override
  String get emergencyAddPhotosHint => 'Поможет другим найти и узнать животное';

  @override
  String get emergencyAllContacts => 'Все экстренные контакты';

  @override
  String get emergencyAlreadyReported => 'Вы уже сообщили об этом.';

  @override
  String get emergencyCallReporter => 'Позвонить тому, кто сообщил';

  @override
  String get emergencyClose => 'Закрыть';

  @override
  String get emergencyCloseTitle => 'Закрыть этот случай?';

  @override
  String get emergencyContacts => 'Экстренные контакты';

  @override
  String get emergencyDetails => 'Что происходит?';

  @override
  String get emergencyDetailsHint =>
      'например, Собаку сбила машина, лежит у дороги, дышит';

  @override
  String get emergencyDetailsRequired =>
      'Опишите ситуацию в нескольких словах.';

  @override
  String get emergencyDisclaimer =>
      'CodaMi — не экстренная служба. Если животное в непосредственной опасности, сначала позвоните 112 или ветеринару. Не полагайтесь только на уведомления приложения.';

  @override
  String get emergencyFalseAlarmTitle => 'Отметить как ложную тревогу?';

  @override
  String get emergencyFindingContacts => 'Ищем контакты рядом с этим местом…';

  @override
  String get emergencyHelpDone =>
      'Спасибо! Сообщившему передали, что вы идёте.';

  @override
  String get emergencyHelpMessage =>
      'Сообщивший узнает, что кто-то идёт на помощь. Идите, только если это безопасно для вас.';

  @override
  String get emergencyHelpTitle => 'Вы идёте на помощь?';

  @override
  String get emergencyImHelping => 'Я помогу';

  @override
  String get emergencyMarkFalseAlarm => 'Отметить как ложную тревогу';

  @override
  String get emergencyMarkResolved => 'Отметить как решённый';

  @override
  String get emergencyMissingFields =>
      'Выберите, что случилось и какое животное, опишите ситуацию и поставьте метку.';

  @override
  String get emergencyNoContacts =>
      'Для этого района пока нет контактов. Позвоните 112 или ветеринару.';

  @override
  String get emergencyPhoneHint =>
      'Увидят те, кто хочет помочь, чтобы позвонить вам.';

  @override
  String get emergencyPinHint =>
      'Передвиньте карту, чтобы поставить метку там, где животное.';

  @override
  String get emergencyPinned => 'Метка поставлена';

  @override
  String get emergencyReopen => 'Открыть снова';

  @override
  String get emergencyReportFalse => 'Пожаловаться на ложный случай';

  @override
  String get emergencyReportFalseDone => 'Спасибо, наша команда проверит.';

  @override
  String get emergencyReportFalseMessage =>
      'Наша команда проверит этот случай.';

  @override
  String get emergencyReportFalseTitle => 'Этот случай ложный?';

  @override
  String get emergencyResolveTitle => 'Отметить как решённый?';

  @override
  String get emergencyResolved => 'Отмечен как решённый';

  @override
  String get emergencySend => 'Отправить';

  @override
  String get emergencySendFailed =>
      'Не удалось отправить. Проверьте соединение и попробуйте снова или позвоните 112.';

  @override
  String get emergencySending => 'Отправка…';

  @override
  String get emergencySent =>
      'Отправлено. Людей поблизости уже оповещают. Вы также можете сразу позвонить контактам ниже.';

  @override
  String get emergencySettings => 'Настройки экстренных случаев';

  @override
  String get emergencySettingsSubtitle =>
      'Радиус оповещений и порядок контактов';

  @override
  String get emergencyStatusClosed => 'Закрыт';

  @override
  String get emergencyStatusFalseAlarm => 'Ложная тревога';

  @override
  String get emergencyStatusHelping => 'Помощь в пути';

  @override
  String get emergencyStatusOpen => 'Нужна помощь';

  @override
  String get emergencyStatusResolved => 'Решён';

  @override
  String get emergencySuggestedContacts => 'Кто может помочь';

  @override
  String get emergencySuggestedContactsHint =>
      'Сначала ближайшие подходящие контакты. Звоните им напрямую.';

  @override
  String get emergencyTypeAbandoned => 'Брошенное животное';

  @override
  String get emergencyTypeDanger => 'Животное в опасности';

  @override
  String get emergencyTypeInjured => 'Раненое животное';

  @override
  String get emergencyTypeIntervention => 'Запрос на помощь';

  @override
  String get emergencyTypeOther => 'Другой случай';

  @override
  String get emergencyTypeUrgentFound => 'Найдено, нужна срочная помощь';

  @override
  String get emergencyUnavailable => 'Этот случай больше недоступен.';

  @override
  String get emergencyWhatHappened => 'Что случилось?';

  @override
  String get emergencyWhere => 'Где животное?';

  @override
  String get emergencyWhereHint =>
      'Точное место показывается помощникам, чтобы они нашли животное.';

  @override
  String get emergencyYouAreHelping =>
      'Вы сообщили, что идёте на помощь. Спасибо!';

  @override
  String get emergencyYourPhone => 'Ваш телефон';

  @override
  String get flagBurst =>
      'Много друзей этого пользователя стали активными в один день';

  @override
  String get flagDeviceUsed =>
      'Этот телефон уже использовали для другого приглашения';

  @override
  String get flagSameDevice => 'Тот же телефон, что у пригласившего';

  @override
  String get haveInviteCode => 'Вас пригласил друг? Введите его код';

  @override
  String get invitePromptTitle => 'Вас пригласил друг?';

  @override
  String get invitePromptBody =>
      'Введите его код приглашения, чтобы друг получил награду за то, что привёл вас в CodaMi.';

  @override
  String invitePromptLater(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'Его можно добавить и позже в разделе Профиль → Пригласить друзей, в течение $days дней после регистрации.',
      few:
          'Его можно добавить и позже в разделе Профиль → Пригласить друзей, в течение $days дней после регистрации.',
      one:
          'Его можно добавить и позже в разделе Профиль → Пригласить друзей, в течение $days дня после регистрации.',
    );
    return '$_temp0';
  }

  @override
  String get inviteCodeLabel => 'Код приглашения';

  @override
  String get inviteCodeFromLink =>
      'Заполнено из вашей ссылки-приглашения. Нажмите «Применить», чтобы подтвердить.';

  @override
  String get inviteCodeFormat =>
      'Код приглашения состоит из 6 букв и цифр, например ABC234.';

  @override
  String get inviteCodeNotFound =>
      'Мы не нашли этот код. Уточните его у друга.';

  @override
  String get inviteCodeOwn =>
      'Это ваш собственный код. Поделитесь им с друзьями.';

  @override
  String inviteCodeTooLate(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'Код приглашения можно добавить только в первые $days дней после регистрации.',
      few:
          'Код приглашения можно добавить только в первые $days дня после регистрации.',
      one:
          'Код приглашения можно добавить только в первый $days день после регистрации.',
    );
    return '$_temp0';
  }

  @override
  String get inviteCodeTooManyTries =>
      'Сегодня слишком много неверных кодов. Попробуйте завтра.';

  @override
  String get howInvitesWork => 'Как это работает';

  @override
  String get inviteApproved => 'Приглашение одобрено';

  @override
  String get inviteCodeAlreadyUsed => 'Вы уже использовали код приглашения.';

  @override
  String get inviteCodeInvalid => 'Этот код недействителен.';

  @override
  String get inviteCodeNotAllowed =>
      'Этот код нельзя использовать: это ваш собственный код или с регистрации прошло слишком много времени.';

  @override
  String get inviteFriends => 'Пригласить друзей';

  @override
  String get inviteFriendsSubtitle => 'Станьте послом CodaMi';

  @override
  String get inviteIntro =>
      'Каждый новый пользователь CodaMi — ещё одна пара глаз для потерявшихся питомцев. Приглашайте друзей и станьте послом CodaMi.';

  @override
  String get inviteRejected => 'Приглашение отклонено';

  @override
  String get inviteStatusExpired => 'Не стал активным вовремя';

  @override
  String get inviteStatusPending => 'Зарегистрирован, ещё не активен';

  @override
  String get inviteStatusQualified => 'Активен — баллы получены';

  @override
  String get inviteStatusRejected => 'Не засчитано';

  @override
  String get inviteStatusReview => 'На проверке';

  @override
  String get inviteStep1 =>
      'Поделитесь кодом. Друг вводит его в разделе Профиль → Пригласить друзей после регистрации.';

  @override
  String get invitedFriends => 'Приглашённые друзья (активные)';

  @override
  String get invitesToReview => 'Приглашения на проверку';

  @override
  String get invitesToReviewSubtitle =>
      'Приглашения, задержанные антифрод-проверкой';

  @override
  String get levelAmbassador => 'Посол';

  @override
  String get levelBonus => 'Бонусные баллы';

  @override
  String get settingsActiveFriends => 'Активные друзья';

  @override
  String get levelChampion => 'Чемпион CodaMi';

  @override
  String get levelSuperAmbassador => 'Суперпосол';

  @override
  String get levelSupporter => 'Сторонник';

  @override
  String get myEmergencies => 'Мои';

  @override
  String get myPoints => 'Мои баллы';

  @override
  String get noActiveEmergencies => 'Экстренных случаев нет';

  @override
  String get noEmergenciesMessage =>
      'Здесь появляются экстренные случаи рядом с вашим городом.';

  @override
  String get noEmergenciesNearby => 'Рядом с вами экстренных случаев нет';

  @override
  String get noEmergencyContacts => 'Контактов пока нет';

  @override
  String get noEmergencyContactsAdmin =>
      'Добавьте ветеринаров, организации и службы или тестовые контакты, чтобы опробовать функцию.';

  @override
  String get noEmergencyContactsMessage =>
      'Контакты скоро появятся. В экстренной ситуации звоните 112 или ветеринару.';

  @override
  String get noInvitesToReview => 'Нечего проверять';

  @override
  String get noInvitesToReviewMessage =>
      'Здесь появляются подозрительные приглашения. Без вас ничего не отклоняется.';

  @override
  String get noInvitesYet =>
      'Приглашений пока нет. Поделитесь кодом, чтобы начать.';

  @override
  String get noLevelYet => 'Уровня пока нет';

  @override
  String get noMyEmergencies => 'Вы не сообщали об экстренных случаях';

  @override
  String get noPointsYet =>
      'Баллов пока нет. Заберите ежедневную награду, чтобы начать.';

  @override
  String get open24h => 'Круглосуточно';

  @override
  String get openMapFailed => 'Не удалось открыть карту.';

  @override
  String get photos => 'Фото';

  @override
  String get pointsAdjusted => 'Изменено командой CodaMi';

  @override
  String get pointsDailyActive => 'Активность сегодня';

  @override
  String get pointsDailyCheckin => 'Ежедневная отметка';

  @override
  String get pointsFriendJoined => 'Друг стал активным';

  @override
  String get pointsHistory => 'История';

  @override
  String get pointsLevelBonus => 'Бонус за новый уровень';

  @override
  String get pointsOther => 'Баллы';

  @override
  String get pointsSettings => 'Баллы и награды';

  @override
  String get pointsSettingsIntro =>
      'Изменения применяются сразу. Значения вне допустимых пределов заменяются стандартными.';

  @override
  String get pointsSettingsSubtitle =>
      'Ежедневные награды, приглашения и уровни';

  @override
  String get pointsStreakBonus => 'Бонус за серию';

  @override
  String get pointsWelcome => 'Приветственный бонус';

  @override
  String get recommendedContact => 'Рекомендуемый';

  @override
  String get reject => 'Отклонить';

  @override
  String get reportEmergency => 'Сообщить об экстренном случае';

  @override
  String get searchContacts => 'Поиск по названию или городу';

  @override
  String get settingsActiveMinutes =>
      'Минут использования для «Активность сегодня»';

  @override
  String get settingsAlertsNearby => 'Оповещения людям поблизости';

  @override
  String get settingsAutoCloseHours => 'Закрывать через (часов без новостей)';

  @override
  String get settingsAutoCloseHoursHelp =>
      'Открытые случаи закрываются сами по истечении этого времени.';

  @override
  String get settingsCodeEntryDays => 'Дней после регистрации для ввода кода';

  @override
  String get settingsContactsPriority => 'Приоритет контактов';

  @override
  String get settingsDefaultAreaKm => 'Стандартная зона (км)';

  @override
  String get settingsDefaultAreaKmHelp => 'Для контактов без своей зоны.';

  @override
  String get settingsEmailContacts => 'Оповещения контактам по email';

  @override
  String get settingsEmailContactsHelp =>
      'Отправляет письмо проверенным контактам. Сначала нужно настроить почтовый сервис.';

  @override
  String get settingsMaxPerDay => 'Активных друзей в день до проверки';

  @override
  String get settingsMaxPerDayHelp =>
      'Если больше за 24 часа, приглашение отправляется на проверку.';

  @override
  String get settingsMaxRecipients => 'Максимум оповещённых людей';

  @override
  String get settingsMaxSuggested => 'Предлагаемых контактов';

  @override
  String get settingsMinRecipients => 'Сколько людей оповестить';

  @override
  String get settingsMinRecipientsHelp =>
      'Берётся следующий круг, пока не наберётся столько людей.';

  @override
  String get settingsQualifyDays => 'Нужно активных дней';

  @override
  String get settingsQualifyWithinDays => 'В течение (дней после регистрации)';

  @override
  String get settingsReferralPoints => 'Баллов за каждого активного друга';

  @override
  String get settingsRings => 'Круги оповещения (км)';

  @override
  String get settingsRingsHelp =>
      'Через запятую, от меньшего, например 5, 10, 25';

  @override
  String get settingsSaved => 'Сохранено';

  @override
  String get settingsStreakDays => 'Дней для бонуса за серию';

  @override
  String get settingsWeight24h => 'Бонус за круглосуточную работу';

  @override
  String get settingsWeightHelp =>
      'Контакты получают эти бонусы и теряют баллы за каждый км расстояния. Первым идёт наибольший результат.';

  @override
  String get settingsWeightPerKm => 'Штраф за км';

  @override
  String get settingsWeightPerKmHelp =>
      'При 1 рекомендуемый контакт (20) идёт раньше другого, который ближе не более чем на 20 км.';

  @override
  String get settingsWeightRecommended => 'Бонус за рекомендацию';

  @override
  String get settingsWeightVerified => 'Бонус за проверку';

  @override
  String get settingsWelcomePoints => 'Баллы приглашённому другу';

  @override
  String get settingsWelcomePointsHelp =>
      'Начисляются при вводе кода. 0 отключает.';

  @override
  String get shareInvite => 'Поделиться';

  @override
  String get statActiveEmergencies => 'Активные экстренные случаи';

  @override
  String get testContactBadge => 'ТЕСТ — не настоящий контакт';

  @override
  String get topLevelReached => 'Вы достигли высшего уровня. Спасибо!';

  @override
  String get useCode => 'Применить';

  @override
  String get verifiedContact => 'Проверен';

  @override
  String get viewInvitee => 'Приглашённый';

  @override
  String get viewInviter => 'Пригласивший';

  @override
  String get yourInviteCode => 'Ваш код приглашения';

  @override
  String get yourInvites => 'Ваши приглашения';

  @override
  String get zeroTurnsOff => '0 отключает';

  @override
  String activeProgress(int done, int total) {
    return '$done из $total минут сегодня';
  }

  @override
  String claimedPoints(int points) {
    return '+$points баллов!';
  }

  @override
  String claimedWithBonus(int points, int bonus) {
    return '+$points баллов и бонус за серию +$bonus!';
  }

  @override
  String emergenciesNearYouCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count экстренных случая рядом с вами',
      many: '$count экстренных случаев рядом с вами',
      few: '$count экстренных случая рядом с вами',
      one: '$count экстренный случай рядом с вами',
    );
    return '$_temp0';
  }

  @override
  String emergencyAlertedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Оповещены $count человека поблизости',
      many: 'Оповещены $count человек поблизости',
      few: 'Оповещены $count человека поблизости',
      one: 'Оповещён $count человек поблизости',
      zero: 'Рядом пока никто не включил оповещения',
    );
    return '$_temp0';
  }

  @override
  String emergencyFalseReports(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count жалобы на ложный случай',
      many: '$count жалоб на ложный случай',
      few: '$count жалобы на ложный случай',
      one: '$count жалоба на ложный случай',
    );
    return '$_temp0';
  }

  @override
  String emergencyHelpersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count человека идут на помощь',
      many: '$count человек идут на помощь',
      few: '$count человека идут на помощь',
      one: '$count человек идёт на помощь',
    );
    return '$_temp0';
  }

  @override
  String inviteCodeAccepted(String name) {
    return 'Код принят. Вас пригласил(а) $name — добро пожаловать в CodaMi!';
  }

  @override
  String inviteShareText(String code, String link) {
    return 'Я пользуюсь CodaMi, чтобы помогать потерявшимся питомцам вернуться домой. Присоединяйся с моим кодом $code: $link';
  }

  @override
  String inviteStep2(int days, int within) {
    return 'Друг указывает свой город и пользуется приложением $days разных дней в течение $within дней после регистрации.';
  }

  @override
  String inviteStep3(int points) {
    return 'Вы получаете $points баллов и поднимаетесь по уровням посла.';
  }

  @override
  String kmAway(String km) {
    return 'в $km км';
  }

  @override
  String levelFriends(String level) {
    return '$level: активных друзей';
  }

  @override
  String levelRule(String level, int friends, int bonus) {
    return '$level · от $friends друзей · +$bonus';
  }

  @override
  String nextLevelHint(int count, String level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ещё $count активных друга до уровня «$level»',
      many: 'Ещё $count активных друзей до уровня «$level»',
      few: 'Ещё $count активных друга до уровня «$level»',
      one: 'Ещё $count активный друг до уровня «$level»',
    );
    return '$_temp0';
  }

  @override
  String plusPoints(int points) {
    return '+$points баллов';
  }

  @override
  String pointsTotal(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points балла',
      many: '$points баллов',
      few: '$points балла',
      one: '$points балл',
    );
    return '$_temp0';
  }

  @override
  String streakLine(int streak, int days, int bonus) {
    return 'Серия: $streak дн. · бонус +$bonus каждые $days дн.';
  }

  @override
  String get pointsFeedback => 'Отзыв отправлен';

  @override
  String get whatsNew => 'Что нового';

  @override
  String get whatsNewSubtitle => 'Изменения в каждой версии';

  @override
  String get whatsNewTitle => 'Что нового в CodaMi';

  @override
  String get whatsNewIntro => 'Вот что изменилось в последнем обновлении.';

  @override
  String whatsNewVersion(String version) {
    return 'Версия $version';
  }

  @override
  String get whatsNewSectionNew => 'Новое';

  @override
  String get whatsNewSectionImproved => 'Улучшено';

  @override
  String get whatsNewSectionFixed => 'Исправлено';

  @override
  String get whatsNewEmpty => 'Заметок об обновлениях пока нет.';

  @override
  String get whatsNewDone => 'Понятно';

  @override
  String get feedbackTitle => 'Как вам CodaMi?';

  @override
  String get feedbackBody =>
      'Ваш отзыв попадает прямо к команде CodaMi и помогает нам сделать приложение лучше.';

  @override
  String feedbackPointsOffer(int points) {
    return '+$points баллов за ваш первый отзыв';
  }

  @override
  String get feedbackStarsHint => 'Нажмите на звезду, чтобы оценить';

  @override
  String get feedbackCommentHint =>
      'Что вам нравится или что можно улучшить? (необязательно)';

  @override
  String get feedbackSend => 'Отправить отзыв';

  @override
  String get feedbackLater => 'Не сейчас';

  @override
  String get feedbackThanks => 'Спасибо за отзыв!';

  @override
  String feedbackThanksPoints(int points) {
    return 'Спасибо за отзыв! +$points баллов';
  }

  @override
  String get feedbackAlreadyToday =>
      'Вы уже отправили отзыв сегодня. Следующий можно отправить завтра.';

  @override
  String get sendFeedbackSubtitle => 'Расскажите команде, что вы думаете';

  @override
  String get rateCodaMi => 'Оценить CodaMi';

  @override
  String get rateCodaMiSubtitle => 'Оставьте отзыв в Google Play';

  @override
  String get adminFeedback => 'Отзывы';

  @override
  String get adminFeedbackSubtitle => 'Что пользователи думают о приложении';

  @override
  String get adminFeedbackEmpty => 'Отзывов пока нет.';

  @override
  String feedbackRatingsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count оценки',
      many: '$count оценок',
      few: '$count оценки',
      one: '$count оценка',
    );
    return '$_temp0';
  }

  @override
  String get feedbackNoComment => 'Без комментария';

  @override
  String get adminWhatsNewSubtitle =>
      'Заметки, которые пользователи видят после каждого обновления';

  @override
  String get releaseAdd => 'Добавить версию';

  @override
  String get releaseEdit => 'Изменить заметки';

  @override
  String get releaseVersion => 'Номер версии';

  @override
  String get releaseVersionHelp =>
      'Например, 1.1.0. Должен совпадать с названием версии приложения в магазине.';

  @override
  String get releaseVersionInvalid =>
      'Используйте цифры и точки, например 1.1.0.';

  @override
  String get releaseVersionExists => 'Для этой версии уже есть заметки.';

  @override
  String get releasePublishedHelp =>
      'Пользователи видят только опубликованные заметки.';

  @override
  String get releaseDraft => 'Черновик';

  @override
  String get releaseLinesHelp => 'Одно изменение на строку.';

  @override
  String get releaseLanguageHelp =>
      'Для незаполненных языков показываются заметки на английском.';

  @override
  String get releaseEnglishRequired =>
      'Сначала напишите заметки на английском: другие языки используют их по умолчанию.';

  @override
  String get releaseDeleteTitle => 'Удалить эти заметки?';

  @override
  String releaseDeleteBody(String version) {
    return 'Заметки к версии $version будут удалены для всех.';
  }

  @override
  String get releaseNone =>
      'Версий пока нет. Добавьте заметки к следующему обновлению.';

  @override
  String releaseThisApp(String version) {
    return 'Это приложение: версия $version';
  }

  @override
  String get feedbackAndReviews => 'Отзывы и оценки';

  @override
  String get settingsFeedbackPoints => 'Баллы за первый отзыв';

  @override
  String get settingsFeedbackAfterDays =>
      'Дней после регистрации до запроса отзыва';

  @override
  String get settingsReviewActiveDays => 'Дней использования до запроса';

  @override
  String get settingsReviewAfterDays =>
      'Дней после регистрации до окна оценки в магазине';

  @override
  String get settingsReviewEveryDays =>
      'Дней между запросами оценки в магазине';

  @override
  String get settingsReviewHelp =>
      'Окно оценки в магазине никогда не даёт баллов: Google Play и App Store это запрещают.';

  @override
  String get petitions => 'Петиции';

  @override
  String get petition => 'Петиция';

  @override
  String get petitionsSubtitle =>
      'Кампании в защиту животных, отобранные нашей командой';

  @override
  String get adminPetitionsSubtitle =>
      'Добавляйте, проверяйте и публикуйте петиции в защиту животных';

  @override
  String petitionsBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count петиции в защиту животных ждут подписи',
      many: '$count петиций в защиту животных ждут подписи',
      few: '$count петиции в защиту животных ждут подписи',
      one: '$count петиция в защиту животных ждёт подписи',
    );
    return '$_temp0';
  }

  @override
  String get petitionsIntro =>
      'Команда CodaMi проверяет каждую петицию, прежде чем она появится здесь. Вы читаете и подписываете её на исходном сайте.';

  @override
  String get petitionsEmpty =>
      'Петиций пока нет. Команда добавит сюда кампании в защиту животных.';

  @override
  String get petitionAdminEmpty =>
      'Здесь нет петиций. Нажмите «Добавить петицию», чтобы добавить петицию с Change.org, Care2, Avaaz или от проверенной организации.';

  @override
  String get petitionView => 'Открыть петицию';

  @override
  String get petitionSignOnSite => 'Прочитать и подписать на исходном сайте';

  @override
  String get petitionOpenFailed => 'Не удалось открыть страницу петиции.';

  @override
  String get petitionIssue => 'Проблема';

  @override
  String get petitionAction => 'Чего требует петиция';

  @override
  String get petitionWhy => 'Почему это важно для животных';

  @override
  String get petitionWhere => 'Исходная петиция';

  @override
  String petitionStartedOn(String date) {
    return 'Начата $date';
  }

  @override
  String get petitionDisclaimer =>
      'Эта петиция размещена на стороннем сайте. CodaMi не собирает подписи и не несёт ответственности за содержание исходной страницы.';

  @override
  String get petitionEndedNote =>
      'Эта кампания завершена. Исходную страницу всё ещё можно прочитать.';

  @override
  String get petitionUnavailableNote => 'Исходная петиция больше недоступна.';

  @override
  String get petitionTopicPets => 'Домашние животные';

  @override
  String get petitionTopicWildlife => 'Дикая природа';

  @override
  String get petitionTopicFarm => 'Сельскохозяйственные животные';

  @override
  String get petitionTopicTesting => 'Опыты на животных';

  @override
  String get petitionTopicEntertainment => 'Цирки и зоопарки';

  @override
  String get petitionTopicMarine => 'Морские обитатели';

  @override
  String get petitionTopicOther => 'Другое';

  @override
  String get petitionStatusActive => 'Активна';

  @override
  String get petitionStatusCompleted => 'Завершена';

  @override
  String get petitionStatusClosed => 'Закрыта';

  @override
  String get petitionStatusUnavailable => 'Больше недоступна';

  @override
  String get petitionReviewPending => 'На проверке';

  @override
  String get petitionReviewApproved => 'Одобрена';

  @override
  String get petitionReviewRejected => 'Отклонена';

  @override
  String get petitionAdd => 'Добавить петицию';

  @override
  String get petitionEdit => 'Изменить петицию';

  @override
  String get petitionSectionSource => 'Исходная петиция';

  @override
  String get petitionUrl => 'Ссылка на петицию';

  @override
  String get petitionUrlInvalid => 'Вставьте полную ссылку, начиная с https://';

  @override
  String get petitionTitle => 'Название';

  @override
  String get petitionSource => 'Платформа или организация';

  @override
  String get petitionCountry => 'Страна или регион';

  @override
  String get petitionCountryHelp =>
      'Оставьте пустым для международных кампаний.';

  @override
  String get petitionStartedOnPick => 'Дата начала петиции (необязательно)';

  @override
  String get petitionTopic => 'Тема';

  @override
  String get petitionSectionText => 'Наше описание';

  @override
  String get petitionOwnWordsHelp =>
      'Пишите своими словами. Не копируйте текст с исходной страницы.';

  @override
  String get petitionSummary => 'Краткое описание';

  @override
  String get petitionImage => 'Изображение';

  @override
  String get petitionImageAdd => 'Добавить изображение';

  @override
  String get petitionImageChange => 'Изменить изображение';

  @override
  String get petitionImageHelp =>
      'Необязательно. Без изображения на карточке показывается значок темы.';

  @override
  String get petitionImagePermission =>
      'У нас есть разрешение на использование этого изображения';

  @override
  String get petitionImagePermissionNeeded =>
      'Подтвердите, что у вас есть разрешение на использование изображения, или удалите его.';

  @override
  String get petitionImageTooBig =>
      'Изображение слишком большое. Выберите файл меньше 5 МБ.';

  @override
  String get petitionChecks => 'Проверка';

  @override
  String get petitionChecksHelp =>
      'Для одобрения или публикации нужны все четыре пункта.';

  @override
  String get petitionCheckExists =>
      'Исходная страница существует и открывается';

  @override
  String get petitionCheckGenuine =>
      'Речь идёт о реальной проблеме защиты животных';

  @override
  String get petitionCheckGoal => 'У петиции есть чёткая цель';

  @override
  String get petitionCheckHonest =>
      'Нет вводящих в заблуждение или мошеннических заявлений';

  @override
  String get petitionChecksNeeded =>
      'Отметьте все пункты проверки перед одобрением или публикацией.';

  @override
  String get petitionReview => 'Модерация';

  @override
  String get petitionReviewHelp =>
      'Пользователям показываются только опубликованные петиции.';

  @override
  String get petitionRejectReason => 'Причина (видна только администраторам)';

  @override
  String get petitionStatus => 'Статус петиции';

  @override
  String get petitionStatusHelp =>
      'Обновите его, когда кампания завершится или страница будет удалена.';

  @override
  String get petitionFixFields => 'Заполните поля, отмеченные красным.';

  @override
  String get petitionDeleteTitle => 'Удалить эту петицию?';

  @override
  String get petitionDeleteBody => 'Она будет удалена из приложения для всех.';

  @override
  String petitionAddedOn(String date) {
    return 'Добавлена $date';
  }

  @override
  String petitionPublishedOn(String date) {
    return 'Опубликована $date';
  }

  @override
  String petitionUpdatedOn(String date) {
    return 'Обновлена $date';
  }

  @override
  String get appUpdates => 'Обновления приложения';

  @override
  String get adminAppUpdatesSubtitle =>
      'Версии в магазинах и обязательные обновления';

  @override
  String get appUpdatesSubtitle => 'Версии в магазинах';

  @override
  String get appUpdatesIntro =>
      'Пользователи старой версии увидят сообщение об обновлении с описанием новой версии. Ниже минимальной версии приложением нельзя пользоваться, пока его не обновят. Для изменения новая сборка не нужна.';

  @override
  String appUpdatesThisPhone(String version) {
    return 'На этом телефоне версия $version';
  }

  @override
  String get appUpdatesAndroid => 'Android (Google Play)';

  @override
  String get appUpdatesIos => 'iPhone (App Store)';

  @override
  String get appUpdatesLatest => 'Последняя версия в магазине';

  @override
  String get appUpdatesLatestHelp =>
      'Укажите, когда обновление появится в магазине. Оставьте пустым, чтобы не показывать сообщение.';

  @override
  String get appUpdatesMinimum => 'Минимальная версия';

  @override
  String get appUpdatesMinimumHelp =>
      'Более старые версии должны обновиться перед использованием. Оставьте пустым, если ограничения нет.';

  @override
  String get appUpdatesStoreId => 'ID в App Store';

  @override
  String get appUpdatesStoreIdHelp =>
      'Число в ссылке App Store (apps.apple.com/app/id…). Нужно для кнопки «Обновить» на iPhone.';

  @override
  String appUpdatesNotesPublished(String version) {
    return 'Описание $version опубликовано и показывается с обновлением';
  }

  @override
  String appUpdatesNotesDraft(String version) {
    return 'Описание $version сохранено, но не опубликовано';
  }

  @override
  String appUpdatesNotesMissing(String version) {
    return 'Описания для $version пока нет';
  }

  @override
  String get appUpdatesBadVersion => 'Укажите версию вида 1.2.0';

  @override
  String get appUpdatesMinimumAbove =>
      'Минимальная версия не может быть выше последней';

  @override
  String get appUpdatesBadStoreId => 'ID в App Store состоит только из цифр';

  @override
  String get appUpdatesRequireTitle => 'Сделать обновление обязательным?';

  @override
  String appUpdatesRequireBody(String version) {
    return 'Все, у кого версия ниже $version, должны будут обновиться, чтобы пользоваться приложением.';
  }

  @override
  String get appUpdatesRequireConfirm => 'Сделать обязательным';

  @override
  String get updateAvailableTitle => 'Доступно обновление';

  @override
  String updateAvailableBody(String latest, String installed) {
    return 'Версия $latest CodaMi готова. У вас $installed.';
  }

  @override
  String get updateNow => 'Обновить';

  @override
  String get updateLater => 'Позже';

  @override
  String get updateRequiredTitle => 'Требуется обновление';

  @override
  String updateRequiredBody(String version) {
    return 'Эта версия CodaMi больше не поддерживается. Обновитесь до версии $version, чтобы продолжить.';
  }

  @override
  String updateBanner(String version) {
    return 'Доступна версия $version';
  }

  @override
  String get updateStoreFailed =>
      'Не удалось открыть магазин. Обновите CodaMi через приложение магазина.';

  @override
  String get rateCodaMiSubtitleIos => 'Оставьте отзыв в App Store';

  @override
  String get updateContinueAsAdmin => 'Продолжить как администратор';

  @override
  String get navShop => 'Магазин';

  @override
  String get shop => 'Магазин';

  @override
  String get adminShopSubtitle => 'Товары, бренды, поставщики и переключатель';

  @override
  String get shopSubtitle => 'Товары для ваших питомцев';

  @override
  String get shopSearchHint => 'Поиск товаров';

  @override
  String get shopEmpty => 'Товары скоро появятся. Загляните позже!';

  @override
  String get shopNoResults => 'Ничего не найдено.';

  @override
  String get shopInStock => 'В наличии';

  @override
  String get shopLowStock => 'Осталось мало';

  @override
  String get shopOutOfStock => 'Нет в наличии';

  @override
  String get shopComingSoon => 'Скоро в продаже';

  @override
  String get shopModelOwnStock => 'Свой склад';

  @override
  String get shopModelBrand => 'Бренд-партнёр';

  @override
  String get shopModelDropship => 'Дропшиппинг';

  @override
  String get shopModelAffiliate => 'Партнёрская ссылка';

  @override
  String get shopModelOwnStockHelp => 'CodaMi хранит товар и отправляет его.';

  @override
  String get shopModelBrandHelp =>
      'Бренд продаёт через CodaMi и сам отправляет заказ.';

  @override
  String get shopModelDropshipHelp =>
      'Поставщик отправляет заказ прямо покупателю.';

  @override
  String get shopModelAffiliateHelp =>
      'Покупка на сайте партнёра по нашей ссылке; CodaMi получает комиссию.';

  @override
  String shopBuyOn(String partner) {
    return 'Купить на $partner';
  }

  @override
  String shopAffiliateNote(String partner) {
    return 'Продаёт и отправляет $partner. CodaMi может получить комиссию с этой покупки.';
  }

  @override
  String shopPriceOnPartner(String partner) {
    return 'Цена на $partner';
  }

  @override
  String get shopAddToCart => 'В корзину';

  @override
  String get shopCheckoutSoon => 'Покупка в приложении скоро появится.';

  @override
  String get shopAllAnimals => 'Для всех животных';

  @override
  String get shopDescription => 'Описание';

  @override
  String get shopOpenFailed => 'Не удалось открыть ссылку.';

  @override
  String get shopPreviewOff =>
      'Предпросмотр: магазин выключен, пользователи его не видят.';

  @override
  String get shopAdminIntro =>
      'Управляйте магазином CodaMi. Пользователи видят его, только когда он включён.';

  @override
  String get shopOpenSwitch => 'Магазин открыт для пользователей';

  @override
  String get shopOnHelp => 'Включён: все видят вкладку «Магазин».';

  @override
  String get shopOffHelp =>
      'Выключен: пользователи не видят магазин. Админы могут его готовить.';

  @override
  String get shopTurnOnTitle => 'Открыть магазин?';

  @override
  String get shopTurnOnBody =>
      'Все пользователи сразу увидят вкладку «Магазин» и активные товары.';

  @override
  String get shopTurnOffTitle => 'Закрыть магазин?';

  @override
  String get shopTurnOffBody =>
      'Вкладка «Магазин» сразу исчезнет у всех. Товары и настройки сохранятся.';

  @override
  String get shopTurnOn => 'Открыть';

  @override
  String get shopTurnOff => 'Закрыть';

  @override
  String get shopSalesModels => 'Модели продаж';

  @override
  String get shopSalesModelsHelp =>
      'Отключение модели скрывает все её товары от пользователей.';

  @override
  String get shopCatalog => 'Каталог';

  @override
  String get shopProducts => 'Товары';

  @override
  String get shopCategories => 'Категории';

  @override
  String get shopBrands => 'Бренды';

  @override
  String get shopSuppliers => 'Поставщики';

  @override
  String get shopPreview => 'Предпросмотр магазина';

  @override
  String get shopPreviewSubtitle => 'Магазин глазами пользователей';

  @override
  String shopProductsCount(int active, int total) {
    return '$active активных · всего $total';
  }

  @override
  String get shopAddProduct => 'Добавить товар';

  @override
  String get shopEditProduct => 'Изменить товар';

  @override
  String get shopProductsEmpty => 'Товаров пока нет. Добавьте первый.';

  @override
  String get shopActive => 'Активен';

  @override
  String get shopHidden => 'Скрыт';

  @override
  String get shopNeedCategory =>
      'Сначала добавьте категорию (Магазин → Категории).';

  @override
  String get shopPhotos => 'Фото';

  @override
  String get shopPhotosHelp =>
      'До 6 фото. Первое — обложка; удерживайте и перетаскивайте, чтобы изменить порядок.';

  @override
  String get shopAddPhoto => 'Добавить фото';

  @override
  String get shopImageTooBig => 'Изображения должны быть меньше 5 МБ.';

  @override
  String get shopDetails => 'Подробности';

  @override
  String get shopName => 'Название';

  @override
  String get shopCategory => 'Категория';

  @override
  String get shopPickCategory => 'Выберите категорию';

  @override
  String get shopAnimals => 'Животные';

  @override
  String get shopAnimalsHelp =>
      'Если ничего не выбрано — для всех животных. Пользователи сначала видят товары для своих питомцев.';

  @override
  String get shopSalesModel => 'Модель продажи';

  @override
  String get shopPartnerName => 'Магазин-партнёр';

  @override
  String get shopAffiliateUrl => 'Партнёрская ссылка';

  @override
  String get shopBrand => 'Бренд';

  @override
  String get shopNoBrand => 'Без бренда';

  @override
  String get shopSupplier => 'Поставщик';

  @override
  String get shopNoSupplier => 'Без поставщика';

  @override
  String get shopPriceSection => 'Цена';

  @override
  String get shopPrice => 'Цена (€)';

  @override
  String get shopPriceAffiliateHelp =>
      'Необязательно: цены меняются на сайте партнёра.';

  @override
  String get shopPriceInvalid => 'Введите цену, например 12,90';

  @override
  String get shopCompareAt => 'Цена до скидки (€)';

  @override
  String get shopCompareAtHelp =>
      'Необязательно. Показывается зачёркнутой рядом с ценой.';

  @override
  String get shopCompareAtInvalid => 'Должна быть выше цены.';

  @override
  String get shopAvailability => 'Наличие';

  @override
  String get shopVisible => 'Видно пользователям';

  @override
  String get shopVisibleHelp => 'Скрытые товары видят только админы.';

  @override
  String get shopCategoryVisibleHelp =>
      'Если скрыть, категория и все её товары не видны пользователям.';

  @override
  String get shopBrandVisibleHelp =>
      'Если скрыть, все товары бренда не видны пользователям.';

  @override
  String get shopSupplierActiveHelp =>
      'Если выключить, все товары поставщика не видны пользователям.';

  @override
  String get shopDeleteProductTitle => 'Удалить этот товар?';

  @override
  String get shopDeleteProductBody =>
      'Товар удаляется из магазина вместе с фото. Это необратимо.';

  @override
  String shopDeleteTitle(String name) {
    return 'Удалить «$name»?';
  }

  @override
  String get shopDeleteBody => 'Это необратимо.';

  @override
  String get shopInUse =>
      'Используется товарами или подкатегориями, удалить нельзя. Скройте вместо этого.';

  @override
  String get shopFixFields => 'Проверьте поля, отмеченные красным.';

  @override
  String get shopLinkInvalid =>
      'Введите полную ссылку, начинающуюся с https://';

  @override
  String get shopAddCategory => 'Добавить категорию';

  @override
  String get shopEditCategory => 'Изменить категорию';

  @override
  String get shopAddStarting => 'Добавить базовые категории';

  @override
  String get shopStartingHelp =>
      'Начните с корма, аксессуаров, ухода, игрушек, лежанок, переносок, техники и прочего. Позже их можно изменить.';

  @override
  String get shopParent => 'Внутри категории';

  @override
  String get shopNoParent => 'Нет (основная категория)';

  @override
  String get shopIcon => 'Значок';

  @override
  String get shopOrder => 'Позиция';

  @override
  String get shopOrderHelp => 'Меньшие числа идут первыми.';

  @override
  String get shopCatFood => 'Корм';

  @override
  String get shopCatAccessories => 'Аксессуары';

  @override
  String get shopCatCare => 'Уход';

  @override
  String get shopCatToys => 'Игрушки';

  @override
  String get shopCatBeds => 'Лежанки';

  @override
  String get shopCatCarriers => 'Переноски';

  @override
  String get shopCatTech => 'Техника';

  @override
  String get shopCatOther => 'Другое';

  @override
  String get shopAddBrand => 'Добавить бренд';

  @override
  String get shopEditBrand => 'Изменить бренд';

  @override
  String get shopBrandsEmpty =>
      'Брендов пока нет. Они необязательны; добавьте, когда появятся партнёры.';

  @override
  String get shopWebsite => 'Сайт';

  @override
  String get shopLogo => 'Логотип';

  @override
  String get shopAddLogo => 'Выбрать логотип';

  @override
  String get shopAddSupplier => 'Добавить поставщика';

  @override
  String get shopEditSupplier => 'Изменить поставщика';

  @override
  String get shopSuppliersEmpty => 'Поставщиков пока нет.';

  @override
  String get shopSuppliersHelp =>
      'Поставщиков и их данные видят только админы. Отключение поставщика скрывает его товары.';

  @override
  String get shopContactName => 'Контактное лицо';

  @override
  String get shopEmail => 'Эл. почта';

  @override
  String get shopEmailInvalid => 'Введите корректный адрес эл. почты.';

  @override
  String get shopPhone => 'Телефон';

  @override
  String get shopOrderMethod => 'Как передаются заказы';

  @override
  String get shopOrderManual => 'Вручную';

  @override
  String get shopOrderManualHelp =>
      'Команда пересылает каждый заказ поставщику.';

  @override
  String get shopOrderEmail => 'Автоматическое письмо';

  @override
  String get shopOrderEmailHelp =>
      'Каждый оплаченный заказ отправляется поставщику по почте (с запуском оплаты).';

  @override
  String get shopNotes => 'Заметки (только админы)';
}
