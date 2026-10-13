// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get navHome => 'Start';

  @override
  String get navPets => 'Tiere';

  @override
  String get navProfile => 'Profil';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get notSet => 'Nicht festgelegt';

  @override
  String get soon => 'Bald';

  @override
  String comingSoon(String feature) {
    return '$feature kommt bald.';
  }

  @override
  String get profileTitle => 'Profil';

  @override
  String get myPets => 'Meine Tiere';

  @override
  String get myReports => 'Meine Meldungen';

  @override
  String get homeCity => 'Heimatstadt';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get chooseLanguage => 'Sprache wählen';

  @override
  String get language => 'Sprache';

  @override
  String get signOut => 'Abmelden';

  @override
  String get signOutTitle => 'Abmelden?';

  @override
  String get signOutMessage => 'Du kannst dich jederzeit wieder anmelden.';

  @override
  String get deleteAccount => 'Konto löschen';

  @override
  String get deleteAccountTitle => 'Konto löschen?';

  @override
  String get deleteAccountMessage =>
      'Dein Profil, deine Tiere, deine Meldungen und ihre Fotos werden endgültig gelöscht. Das kann nicht rückgängig gemacht werden.';

  @override
  String get deletingAccount => 'Konto wird gelöscht…';

  @override
  String get myReportsSubtitle => 'Halte deine Meldungen aktuell.';

  @override
  String get statTotal => 'Gesamt';

  @override
  String postedOn(String date) {
    return 'Veröffentlicht am $date';
  }

  @override
  String get reportActive => 'Aktiv';

  @override
  String get reportResolved => 'Erledigt';

  @override
  String get myReportsLoadError =>
      'Deine Meldungen konnten nicht geladen werden';

  @override
  String get checkConnection =>
      'Prüfe deine Verbindung und versuche es erneut.';

  @override
  String get noActiveReports => 'Keine aktiven Meldungen';

  @override
  String get noActiveReportsMessage =>
      'Hier erscheinen die Meldungen, die du für vermisste oder gefundene Tiere veröffentlichst.';

  @override
  String get reportAPet => 'Tier melden';

  @override
  String get nothingResolved => 'Noch nichts erledigt';

  @override
  String get nothingResolvedMessage =>
      'Wenn du eine Meldung als erledigt markierst, erscheint sie hier.';

  @override
  String get markAsFound => 'Als gefunden markieren';

  @override
  String get returnedToOwner => 'Dem Besitzer zurückgegeben';

  @override
  String get backHome => 'Wieder zu Hause';

  @override
  String get reunited => 'Wiedervereint';

  @override
  String get deleteReport => 'Meldung löschen';

  @override
  String resolveLostTitle(String petName) {
    return 'Ist $petName wieder zu Hause?';
  }

  @override
  String get resolveFoundTitle => 'Hast du den Besitzer gefunden?';

  @override
  String resolveLostMessage(String petName) {
    return 'Die Meldung wird unter \"Wieder zu Hause\" im Tab Gefunden angezeigt, damit die Nachbarn wissen, dass $petName in Sicherheit ist.';
  }

  @override
  String get resolveFoundMessage =>
      'Die Meldung wird unter \"Wiedervereint\" im Tab Gefunden angezeigt.';

  @override
  String get notYet => 'Noch nicht';

  @override
  String get yesResolved => 'Ja, erledigt';

  @override
  String get reportResolvedSuccess =>
      'Wunderbare Neuigkeiten! Meldung erledigt.';

  @override
  String get deleteReportTitle => 'Diese Meldung löschen?';

  @override
  String deleteOpenReportMessage(String petName) {
    return 'Sie verschwindet von der Karte und aus den Listen. Wenn $petName in Sicherheit ist, markiere die Meldung lieber als erledigt, damit die Nachbarn Bescheid wissen.';
  }

  @override
  String get deleteResolvedReportMessage =>
      'Sie wird von der Karte und aus der Liste \"Wieder zu Hause\" entfernt.';

  @override
  String get reportDeleted => 'Meldung gelöscht.';

  @override
  String get onboarding1Title => 'Jedes Tier verdient\nein ';

  @override
  String get onboarding1Highlight => 'Zuhause';

  @override
  String get onboarding1Body =>
      'CodaMi verbindet Nachbarn, damit vermisste Hunde und Katzen zu den Menschen zurückfinden, die sie lieben.';

  @override
  String get onboarding2Title => 'Melde ein Tier\nin ';

  @override
  String get onboarding2Highlight => 'Sekunden';

  @override
  String get onboarding2Body =>
      'Foto machen, Ort markieren und eine Vermisst- oder Fundmeldung veröffentlichen. Alle in der Nähe sehen sie sofort.';

  @override
  String get onboarding3Title => 'Sieh, wer\n';

  @override
  String get onboarding3Highlight => 'in der Nähe ist';

  @override
  String get onboarding3Body =>
      'Vermisste und gefundene Tiere um dich herum, live auf einer Karte – so weißt du immer, wo du suchen musst.';

  @override
  String get skip => 'Überspringen';

  @override
  String get getStarted => 'Los geht\'s';

  @override
  String get lost => 'Vermisst';

  @override
  String get found => 'Gefunden';

  @override
  String get you => 'Du';

  @override
  String get published => 'Veröffentlicht';

  @override
  String get onboardingSampleBreed => 'Golden Retriever · 3 Jahre';

  @override
  String get onboardingSamplePlace => 'Mailand · vor 2 Std.';

  @override
  String get validationNameRequired => 'Bitte gib deinen Namen ein';

  @override
  String get validationNameTooShort =>
      'Der Name muss mindestens 2 Zeichen haben';

  @override
  String get validationNameTooLong =>
      'Der Name muss kürzer als 50 Zeichen sein';

  @override
  String get validationNameInvalid =>
      'Der Name darf nur Buchstaben, Leerzeichen, Bindestriche und Apostrophe enthalten';

  @override
  String get validationEmailRequired => 'Bitte gib deine E-Mail-Adresse ein';

  @override
  String get validationEmailInvalid =>
      'Bitte gib eine gültige E-Mail-Adresse ein';

  @override
  String get validationPasswordRequired => 'Bitte gib dein Passwort ein';

  @override
  String get validationPasswordTooShort =>
      'Das Passwort muss mindestens 8 Zeichen lang sein';

  @override
  String get validationConfirmRequired => 'Bitte bestätige dein Passwort';

  @override
  String get validationPasswordsDontMatch =>
      'Die Passwörter stimmen nicht überein';

  @override
  String get spamNote =>
      'Keine E-Mail zum Zurücksetzen gefunden? Schau im Spam- oder Junk-Ordner nach, manchmal landet sie dort.';

  @override
  String get logIn => 'Anmelden';

  @override
  String get signUp => 'Registrieren';

  @override
  String get authResetSentTitle => 'Schau in dein Postfach';

  @override
  String get authResetSentSubtitle =>
      'Wir haben dir einen Link zum Zurücksetzen deines Passworts geschickt.';

  @override
  String get authLoginTitle => 'Willkommen zurück!';

  @override
  String get authLoginSubtitle =>
      'Melde dich an und hilf weiter, Tiere nach Hause zu bringen.';

  @override
  String get authSignupTitle => 'Werde Teil des Rudels';

  @override
  String get authSignupSubtitle =>
      'Erstelle ein Konto und hilf deiner Nachbarschaft.';

  @override
  String get authForgotTitle => 'Passwort vergessen?';

  @override
  String get authForgotSubtitle =>
      'Kein Problem, wir schicken dir einen Link per E-Mail.';

  @override
  String get fullName => 'Vollständiger Name';

  @override
  String get email => 'E-Mail';

  @override
  String get password => 'Passwort';

  @override
  String get confirmPassword => 'Passwort bestätigen';

  @override
  String get forgotPassword => 'Passwort vergessen?';

  @override
  String get createAccount => 'Konto erstellen';

  @override
  String get sendResetLink => 'Link senden';

  @override
  String get or => 'oder';

  @override
  String get continueWithGoogle => 'Weiter mit Google';

  @override
  String get continueWithApple => 'Weiter mit Apple';

  @override
  String get resetLinkSentTo => 'Wir haben einen Link gesendet an';

  @override
  String get backToLogIn => 'Zurück zur Anmeldung';

  @override
  String get sendAgain => 'Nichts erhalten? Erneut senden';

  @override
  String get errorOffline =>
      'Du bist offline. Prüfe deine Verbindung und versuche es erneut.';

  @override
  String get errorSessionExpired =>
      'Deine Sitzung ist abgelaufen. Bitte melde dich erneut an.';

  @override
  String get deleteAccountFailed =>
      'Dein Konto konnte nicht gelöscht werden. Bitte versuche es erneut.';

  @override
  String get authErrorGeneric =>
      'Etwas ist schiefgelaufen. Bitte versuche es erneut.';

  @override
  String get authErrorDisabled => 'Dieses Konto wurde deaktiviert.';

  @override
  String get authErrorWrongCredentials => 'E-Mail oder Passwort ist falsch.';

  @override
  String get authErrorEmailInUse =>
      'Mit dieser E-Mail gibt es bereits ein Konto. Versuche, dich anzumelden.';

  @override
  String get authErrorTooManyRequests =>
      'Zu viele Versuche. Warte kurz und versuche es erneut.';

  @override
  String get citySearchFailed =>
      'Stadtsuche fehlgeschlagen. Bitte versuche es erneut.';

  @override
  String get placeSearchFailed =>
      'Ortssuche fehlgeschlagen. Bitte versuche es erneut.';

  @override
  String get placeOutsideCity =>
      'Dieser Ort liegt außerhalb deiner Stadt. Bitte wähle einen Ort in der Stadt.';

  @override
  String get placeNotFound =>
      'Wir konnten diesen Ort nicht finden. Bitte wähle einen anderen.';

  @override
  String get citySearchOffline =>
      'Die Stadtsuche ist nicht erreichbar. Prüfe deine Verbindung und versuche es erneut.';

  @override
  String get searchCityHint => 'Suche deine Stadt, z. B. Mailand';

  @override
  String noCitiesFound(String query) {
    return 'Keine Städte für \"$query\" gefunden.';
  }

  @override
  String homeCityUpdated(String city) {
    return 'Heimatstadt geändert: $city.';
  }

  @override
  String get saveCityFailed =>
      'Deine Stadt konnte nicht gespeichert werden. Bitte versuche es erneut.';

  @override
  String get citySetupTitle => 'Wo ';

  @override
  String get citySetupHighlight => 'bist du?';

  @override
  String get cityEditTitle => 'Ändere deine ';

  @override
  String get cityEditHighlight => 'Stadt';

  @override
  String get citySetupBody =>
      'Wähle deine Stadt, damit wir dir vermisste und gefundene Tiere in der Nähe zeigen und dich informieren, wenn in deiner Gegend ein Tier verschwindet.';

  @override
  String get saveCity => 'Stadt speichern';

  @override
  String get continueLabel => 'Weiter';

  @override
  String get notYouSignOut => 'Nicht du? Abmelden';

  @override
  String greeting(String name) {
    return 'Hallo, $name!';
  }

  @override
  String get showPetsWithin => 'Tiere anzeigen im Umkreis von';

  @override
  String distanceFrom(String city) {
    return 'Entfernung von $city';
  }

  @override
  String get everywhere => 'Überall';

  @override
  String distanceKm(int km) {
    return '$km km';
  }

  @override
  String withinKm(int km) {
    return 'im Umkreis von $km km';
  }

  @override
  String get areaNotSet => 'Gebiet noch nicht festgelegt';

  @override
  String get reportPetSemantics => 'Vermisstes oder gefundenes Tier melden';

  @override
  String get map => 'Karte';

  @override
  String get locationServicesOff =>
      'Schalte die Ortungsdienste ein, um deinen Standort zu nutzen.';

  @override
  String get locationPermissionDenied =>
      'Erlaube den Standortzugriff in den Einstellungen, um deinen Standort zu nutzen.';

  @override
  String get locationFailed =>
      'Dein Standort konnte nicht ermittelt werden. Bitte versuche es erneut.';

  @override
  String get back => 'Zurück';

  @override
  String get fullScreen => 'Vollbild';

  @override
  String get loadingPets => 'Tiere werden geladen…';

  @override
  String get mapLoadFailed =>
      'Meldungen konnten nicht geladen werden. Prüfe deine Verbindung.';

  @override
  String get mapNoLost => 'Keine vermissten Tiere in diesem Gebiet';

  @override
  String get mapNoFound => 'Keine gefundenen Tiere in diesem Gebiet';

  @override
  String get mapNoPets =>
      'Keine vermissten oder gefundenen Tiere in diesem Gebiet';

  @override
  String get zoomIn => 'Vergrößern';

  @override
  String get zoomOut => 'Verkleinern';

  @override
  String get myLocation => 'Mein Standort';

  @override
  String get myCity => 'Meine Stadt';

  @override
  String get all => 'Alle';

  @override
  String get timeJustNow => 'Gerade eben';

  @override
  String timeMinutesAgo(int minutes) {
    return 'vor $minutes Min.';
  }

  @override
  String timeHoursAgo(int hours) {
    return 'vor $hours Std.';
  }

  @override
  String get timeYesterday => 'Gestern';

  @override
  String timeDaysAgo(int days) {
    return 'vor $days Tagen';
  }

  @override
  String notifLostTitle(String city) {
    return 'Tier vermisst in $city';
  }

  @override
  String notifLostBodyNear(String pet, String street, String city) {
    return '$pet wurde zuletzt in der Nähe von $street, $city gesehen. Halte die Augen offen!';
  }

  @override
  String notifLostBodyIn(String pet, String city) {
    return '$pet wurde zuletzt in $city gesehen. Halte die Augen offen!';
  }

  @override
  String notifFoundTitle(String city) {
    return 'Tier gefunden in $city';
  }

  @override
  String notifFoundBodyNear(String pet, String street, String city) {
    return '$pet wurde in der Nähe von $street, $city gefunden. Kennst du den Besitzer?';
  }

  @override
  String notifFoundBodyIn(String pet, String city) {
    return '$pet wurde in $city gefunden. Kennst du den Besitzer?';
  }

  @override
  String notifBackHomeTitle(String pet) {
    return '$pet ist wieder zu Hause';
  }

  @override
  String notifBackHomeBody(String pet, String city) {
    return 'Gute Nachrichten aus $city: $pet wurde gefunden. Danke für deine Hilfe!';
  }

  @override
  String notifReunitedTitle(String pet) {
    return '$pet ist wieder bei der Familie';
  }

  @override
  String notifReunitedBody(String city) {
    return 'Das in $city gefundene Tier ist wieder bei seiner Familie.';
  }

  @override
  String get notificationsTitle => 'Benachrichtigungen';

  @override
  String get markAllRead => 'Alle als gelesen markieren';

  @override
  String get notificationsLoadError =>
      'Benachrichtigungen konnten nicht geladen werden';

  @override
  String get allCaughtUp => 'Du bist auf dem neuesten Stand';

  @override
  String get notificationsEmpty =>
      'Wir sagen dir Bescheid, wenn in deiner Stadt ein Tier vermisst oder gefunden wird.';

  @override
  String get notificationsNew => 'Neu';

  @override
  String get notificationsEarlier => 'Früher';

  @override
  String get reportNotAvailable => 'Meldung nicht verfügbar';

  @override
  String get reportRemoved =>
      'Diese Meldung wurde von ihrem Ersteller entfernt.';

  @override
  String get reportsLoadError => 'Meldungen konnten nicht geladen werden';

  @override
  String get pullToRetry =>
      'Prüfe deine Verbindung und ziehe nach unten, um es erneut zu versuchen.';

  @override
  String get noLostNearby => 'Keine vermissten Tiere in der Nähe';

  @override
  String get noLostNearbyMessage =>
      'Gute Nachrichten! In deiner Gegend wurde noch kein Tier als vermisst gemeldet.';

  @override
  String get noFoundYet => 'Noch keine gefundenen Tiere';

  @override
  String get noFoundYetMessage =>
      'Tiere, die deine Nachbarn finden, erscheinen hier.';

  @override
  String get backHomeSection => 'Wieder zu Hause';

  @override
  String get backHomeSectionSubtitle =>
      'Tiere, die zu ihren Familien zurückgefunden haben.';

  @override
  String get loadMore => 'Mehr laden';

  @override
  String get speciesDog => 'Hund';

  @override
  String get speciesCat => 'Katze';

  @override
  String get speciesOther => 'Andere';

  @override
  String get sexMale => 'Männlich';

  @override
  String get sexFemale => 'Weiblich';

  @override
  String get sexUnknown => 'Unbekannt';

  @override
  String nearPlace(String street, String city) {
    return 'In der Nähe von $street, $city';
  }

  @override
  String get callFailed => 'Anruf konnte nicht gestartet werden.';

  @override
  String get whatsappFailed => 'WhatsApp konnte nicht geöffnet werden.';

  @override
  String get emailFailed => 'Deine E-Mail-App konnte nicht geöffnet werden.';

  @override
  String whatsappMessageLost(String pet) {
    return 'Hallo! Ich melde mich wegen des vermissten Tiers \"$pet\" auf CodaMi.';
  }

  @override
  String whatsappMessageFound(String pet) {
    return 'Hallo! Ich melde mich wegen des gefundenen Tiers \"$pet\" auf CodaMi.';
  }

  @override
  String emailSubjectLost(String pet) {
    return 'Wegen $pet (vermisstes Tier auf CodaMi)';
  }

  @override
  String emailSubjectFound(String pet) {
    return 'Wegen $pet (gefundenes Tier auf CodaMi)';
  }

  @override
  String shareTitleLost(String pet) {
    return 'TIER VERMISST: $pet';
  }

  @override
  String shareTitleFound(String pet) {
    return 'TIER GEFUNDEN: $pet';
  }

  @override
  String get shareFooter =>
      'Hast du dieses Tier gesehen? Öffne CodaMi, um Kontakt aufzunehmen.';

  @override
  String get lastSeen => 'Zuletzt gesehen';

  @override
  String get foundAt => 'Gefunden bei';

  @override
  String areaAbout(int meters) {
    return 'Gebiet von etwa $meters m';
  }

  @override
  String get when => 'Wann';

  @override
  String get postedBy => 'Veröffentlicht von';

  @override
  String get description => 'Beschreibung';

  @override
  String get call => 'Anrufen';

  @override
  String contactTitleLost(String pet) {
    return '$pet gesehen? Melde dich';
  }

  @override
  String get contactTitleFound => 'Ist das dein Tier? Melde dich';

  @override
  String get noContactShared => 'Es wurden keine Kontaktdaten angegeben.';

  @override
  String resolvedThanksLost(String pet) {
    return '$pet ist wieder zu Hause. Danke, dass du CodaMi nutzt!';
  }

  @override
  String get resolvedThanksFound =>
      'Dieses Tier ist wieder bei seiner Familie. Danke für deine Hilfe!';

  @override
  String get yourContactDetails => 'Deine Kontaktdaten';

  @override
  String markPetAsFound(String pet) {
    return '$pet als gefunden markieren';
  }

  @override
  String get markReturnedToOwner => 'Als zurückgegeben markieren';

  @override
  String get copiedToClipboard => 'In die Zwischenablage kopiert.';

  @override
  String get petSaveFailed =>
      'Dein Tier konnte nicht gespeichert werden. Bitte versuche es erneut.';

  @override
  String get petDeleteFailed =>
      'Dein Tier konnte nicht gelöscht werden. Bitte versuche es erneut.';

  @override
  String get errorPermission => 'Dazu hast du keine Berechtigung.';

  @override
  String get storageNotReady =>
      'Der Fotospeicher ist noch nicht eingerichtet. Bitte versuche es später erneut.';

  @override
  String get storageFull =>
      'Der Speicher ist gerade voll. Bitte versuche es später erneut.';

  @override
  String petAdded(String name) {
    return '$name wurde zu deinen Tieren hinzugefügt.';
  }

  @override
  String get petsLoadError => 'Deine Tiere konnten nicht geladen werden';

  @override
  String get noPetsYet => 'Noch keine Tiere';

  @override
  String get noPetsYetMessage =>
      'Füge jetzt deine Tiere hinzu, damit du sie in Sekunden melden kannst, falls sie verloren gehen.';

  @override
  String get addFirstPet => 'Erstes Tier hinzufügen';

  @override
  String get petsHeaderEmpty =>
      'Halte die Profile deiner Tiere bereit, nur für den Fall.';

  @override
  String petsHeaderCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Fellfreunde, bereit für den Notfall.',
      one: '1 Fellfreund, bereit für den Notfall.',
    );
    return '$_temp0';
  }

  @override
  String get addPet => 'Hinzufügen';

  @override
  String petUpdated(String name) {
    return '$name wurde aktualisiert.';
  }

  @override
  String removePetTitle(String name) {
    return '$name entfernen?';
  }

  @override
  String get removePetMessage =>
      'Das Profil und seine Fotos werden gelöscht. Das kann nicht rückgängig gemacht werden.';

  @override
  String get remove => 'Entfernen';

  @override
  String petRemoved(String name) {
    return '$name wurde entfernt.';
  }

  @override
  String get breed => 'Rasse';

  @override
  String get color => 'Farbe';

  @override
  String get age => 'Alter';

  @override
  String get sex => 'Geschlecht';

  @override
  String petAddedOn(String date) {
    return 'Hinzugefügt am $date';
  }

  @override
  String get distinctiveFeatures => 'Besondere Merkmale';

  @override
  String ifPetGoesMissing(String name) {
    return 'Falls $name einmal verschwindet';
  }

  @override
  String get ifPetGoesMissingBody =>
      'Veröffentliche mit diesem Profil in Sekunden eine Vermisstmeldung – die Nachbarn werden benachrichtigt.';

  @override
  String reportPetAsLost(String name) {
    return '$name als vermisst melden';
  }

  @override
  String get colorBlack => 'Schwarz';

  @override
  String get colorWhite => 'Weiß';

  @override
  String get colorBrown => 'Braun';

  @override
  String get colorGolden => 'Golden';

  @override
  String get colorGrey => 'Grau';

  @override
  String get colorCream => 'Creme';

  @override
  String get colorGinger => 'Rot';

  @override
  String get petPhotoRequired => 'Füge mindestens ein Foto deines Tiers hinzu.';

  @override
  String get petSpeciesRequired =>
      'Wähle, ob dein Tier ein Hund, eine Katze oder etwas anderes ist.';

  @override
  String get checkHighlightedFields => 'Bitte prüfe die markierten Felder.';

  @override
  String get signInToSave => 'Bitte melde dich erneut an, um zu speichern.';

  @override
  String get discardChangesTitle => 'Änderungen verwerfen?';

  @override
  String get discardPetChanges =>
      'Deine Änderungen an diesem Tier gehen verloren.';

  @override
  String get keepEditing => 'Weiter bearbeiten';

  @override
  String get discard => 'Verwerfen';

  @override
  String editPetTitle(String name) {
    return '$name bearbeiten';
  }

  @override
  String get newPet => 'Neues Tier';

  @override
  String get whatKindOfPet => 'Was für ein Tier?';

  @override
  String get name => 'Name';

  @override
  String get petNameHint => 'z. B. Luna';

  @override
  String get petNameRequired => 'Bitte gib den Namen deines Tiers ein';

  @override
  String get petNameTooLong => 'Der Name muss kürzer als 40 Zeichen sein';

  @override
  String get breedHint => 'z. B. Golden Retriever, Mischling';

  @override
  String get colorHint => 'z. B. Golden mit weißer Brust';

  @override
  String get ageHint => 'z. B. 3 Jahre, 8 Monate';

  @override
  String get featuresHint =>
      'Halsband, Mikrochip, Narben, Flecken… alles, woran man dein Tier erkennt.';

  @override
  String get saveChanges => 'Änderungen speichern';

  @override
  String get savePet => 'Tier speichern';

  @override
  String get cameraPermission =>
      'Bitte erlaube den Kamerazugriff in den Einstellungen.';

  @override
  String get photosPermission =>
      'Bitte erlaube den Fotozugriff in den Einstellungen.';

  @override
  String get cameraFailed => 'Die Kamera konnte nicht geöffnet werden.';

  @override
  String get galleryFailed => 'Die Galerie konnte nicht geöffnet werden.';

  @override
  String get optional => 'Optional';

  @override
  String get addPetPhotos => 'Fotos deines Tiers hinzufügen';

  @override
  String get addPetPhotosHint =>
      'Klare, aktuelle Fotos helfen beim Wiedererkennen';

  @override
  String get photoRequired => 'Mindestens ein Foto ist nötig';

  @override
  String get tapToMakeCover =>
      'Tippe auf ein Foto, um es als Titelbild zu verwenden.';

  @override
  String get cover => 'Titelbild';

  @override
  String uploadingPhotos(int percent) {
    return 'Fotos werden hochgeladen… $percent %';
  }

  @override
  String get saving => 'Wird gespeichert…';

  @override
  String get takePhoto => 'Foto aufnehmen';

  @override
  String get useCamera => 'Kamera verwenden';

  @override
  String get chooseFromGallery => 'Aus Galerie wählen';

  @override
  String get pickExistingPhoto => 'Vorhandenes Foto wählen';

  @override
  String get yourPet => 'dein Tier';

  @override
  String get unknownDog => 'Unbekannter Hund';

  @override
  String get unknownCat => 'Unbekannte Katze';

  @override
  String get unknownPet => 'Unbekanntes Tier';

  @override
  String get errorChooseType =>
      'Wähle, ob du ein Tier verloren oder gefunden hast.';

  @override
  String get errorPickPet => 'Wähle das vermisste Tier.';

  @override
  String get errorFoundPhoto => 'Füge mindestens ein Foto des Tiers hinzu.';

  @override
  String get errorFoundSpecies =>
      'Ist es ein Hund, eine Katze oder etwas anderes?';

  @override
  String get errorChooseCity => 'Wähle die Stadt, in der es passiert ist.';

  @override
  String get errorFutureDate => 'Das Datum darf nicht in der Zukunft liegen.';

  @override
  String get errorDescriptionShort =>
      'Füge eine kurze Beschreibung hinzu (mindestens 10 Zeichen).';

  @override
  String get errorContactRequired =>
      'Gib eine Telefonnummer oder E-Mail an, damit man dich erreichen kann.';

  @override
  String get errorPhoneInvalid => 'Bitte gib eine gültige Telefonnummer ein.';

  @override
  String get discardReportTitle => 'Diese Meldung verwerfen?';

  @override
  String get discardReportMessage =>
      'Was du bisher eingegeben hast, geht verloren.';

  @override
  String get signInToPublish =>
      'Bitte melde dich erneut an, um zu veröffentlichen.';

  @override
  String publishedLost(String pet) {
    return '$pet ist jetzt auf der Karte. Wir hoffen, dass es bald wieder zu Hause ist.';
  }

  @override
  String publishedFound(String pet) {
    return 'Danke! $pet ist jetzt auf der Karte.';
  }

  @override
  String get reportLostPetTitle => 'Vermisstes Tier melden';

  @override
  String get reportFoundPetTitle => 'Gefundenes Tier melden';

  @override
  String get newReport => 'Neue Meldung';

  @override
  String stepOf(int current, int total) {
    return '$current von $total';
  }

  @override
  String get publishReport => 'Meldung veröffentlichen';

  @override
  String get stepTypeTitle => 'Was ist passiert?';

  @override
  String get stepTypeSubtitle =>
      'Lass uns schnell die Menschen in der Nähe informieren.';

  @override
  String get stepFoundPetTitle => 'Erzähl uns von dem Tier';

  @override
  String get stepFoundPetSubtitle =>
      'Ein klares Foto ist der schnellste Weg, damit der Besitzer es erkennt.';

  @override
  String get addFoundPhotos => 'Fotos des Tiers hinzufügen';

  @override
  String get addFoundPhotosHint =>
      'Mach jetzt eins oder wähle eins aus deiner Galerie';

  @override
  String get whatKindOfAnimal => 'Was für ein Tier?';

  @override
  String get collarName => 'Name auf Halsband oder Marke';

  @override
  String get collarNameHint => 'Leer lassen, wenn du es nicht weißt';

  @override
  String get stepLostPetTitle => 'Welches Tier wird vermisst?';

  @override
  String get stepLostPetSubtitle =>
      'Wir verwenden sein Profil und seine Fotos, du musst nichts neu eingeben.';

  @override
  String get stepWhereFoundTitle => 'Wo hast du es gefunden?';

  @override
  String stepWhereLostTitle(String pet) {
    return 'Wo wurde $pet zuletzt gesehen?';
  }

  @override
  String get stepWhereSubtitle =>
      'Wähle die Stadt und markiere dann die Stelle auf der Karte. Andere sehen nur ein Gebiet von etwa 100 m, nie die genaue Adresse.';

  @override
  String get streetOrLandmark => 'Straße oder Orientierungspunkt';

  @override
  String get pinExactSpot => 'Genaue Stelle markieren';

  @override
  String spotHintFound(String pet) {
    return 'Verschiebe die Karte, bis die Markierung dort ist, wo du $pet gefunden hast.';
  }

  @override
  String spotHintLost(String pet) {
    return 'Verschiebe die Karte, bis die Markierung dort ist, wo $pet zuletzt gesehen wurde.';
  }

  @override
  String spotFarFromCity(int km, String city) {
    return 'Diese Stelle ist $km km von $city entfernt. Stimmt die Stadt?';
  }

  @override
  String spotPinned(int meters) {
    return 'Markiert. Andere sehen nur ein Gebiet von etwa $meters m darum herum, nie die genaue Stelle.';
  }

  @override
  String get timeHourAgo => 'Vor 1 Stunde';

  @override
  String get timeThisMorning => 'Heute Morgen';

  @override
  String get stepWhenFoundTitle => 'Wann hast du es gefunden?';

  @override
  String stepWhenLostTitle(String pet) {
    return 'Wann hast du $pet zuletzt gesehen?';
  }

  @override
  String get stepWhenSubtitle => 'Eine ungefähre Zeit reicht.';

  @override
  String get changeDate => 'Datum ändern';

  @override
  String get changeTime => 'Uhrzeit ändern';

  @override
  String get stepDetailsTitle => 'Gibt es noch etwas zu wissen?';

  @override
  String get stepDetailsSubtitle =>
      'Details helfen den Nachbarn, das Tier zu erkennen und dich schnell zu erreichen.';

  @override
  String descriptionHintLost(String pet) {
    return 'Farbe des Halsbands, Verhalten, wie $pet verschwunden ist…';
  }

  @override
  String get descriptionHintFound =>
      'Zustand, Halsband, Verhalten, wo genau du es gefunden hast…';

  @override
  String get howToReachYou => 'Wie kann man dich erreichen?';

  @override
  String get contactPrivacyNote =>
      'Nur auf der Meldungsseite sichtbar, nie in Listen.';

  @override
  String get phoneHint => 'Telefon, z. B. +39 333 123 4567';

  @override
  String get reachableOnWhatsapp => 'Über WhatsApp erreichbar';

  @override
  String get reachableOnWhatsappHint =>
      'Man kann dir an diese Nummer schreiben';

  @override
  String get stepReviewTitle => 'Bereit zum Veröffentlichen?';

  @override
  String get stepReviewSubtitle =>
      'So sehen Menschen in der Nähe deine Meldung.';

  @override
  String get iLostMyPet => 'Ich habe mein Tier verloren';

  @override
  String get iFoundAPet => 'Ich habe ein Tier gefunden';

  @override
  String get iLostMyPetHint =>
      'Informiere Menschen in der Nähe und erhalte Hilfe bei der Suche.';

  @override
  String get iFoundAPetHint =>
      'Hilf einem vermissten Tier, nach Hause zu finden.';

  @override
  String get addAPet => 'Tier hinzufügen';

  @override
  String get pleaseChooseCity => 'Bitte wähle eine Stadt';

  @override
  String noPlacesFound(String city, String query) {
    return 'Keine Orte in $city für \"$query\" gefunden.';
  }

  @override
  String searchStreetHint(String city) {
    return 'Suche in $city, z. B. Via Dante';
  }

  @override
  String get yourCity => 'deine Stadt';

  @override
  String get useMyLocation => 'Meinen Standort verwenden';

  @override
  String get publishFailed =>
      'Deine Meldung konnte nicht veröffentlicht werden. Bitte versuche es erneut.';

  @override
  String get updateReportFailed =>
      'Die Meldung konnte nicht aktualisiert werden. Bitte versuche es erneut.';

  @override
  String get deleteReportFailed =>
      'Die Meldung konnte nicht gelöscht werden. Bitte versuche es erneut.';

  @override
  String get privacyPolicy => 'Datenschutzerklärung';

  @override
  String get termsOfUse => 'Nutzungsbedingungen';

  @override
  String legalLastUpdated(String date) {
    return 'Zuletzt aktualisiert: $date';
  }

  @override
  String get deleteAccountPasswordPrompt =>
      'Gib zur Bestätigung dein Passwort ein.';

  @override
  String deleteAccountTypeConfirm(String word) {
    return 'Gib zur Bestätigung $word ein.';
  }

  @override
  String get wrongPassword => 'Falsches Passwort. Bitte versuche es erneut.';

  @override
  String get confirmPasswordAgain =>
      'Bitte bestätige zu deiner Sicherheit dein Passwort erneut.';

  @override
  String get contactUs => 'Kontakt';

  @override
  String get legalQuestions => 'Fragen zu diesem Dokument oder deinen Daten?';
}
