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

  @override
  String get languageChangeLater =>
      'Du kannst sie jederzeit in deinem Profil ändern.';

  @override
  String get reward => 'Finderlohn';

  @override
  String get rewardHint => 'Betrag in Euro';

  @override
  String get rewardNote =>
      'Der Finderlohn ist eine private Vereinbarung zwischen Besitzer und Finder. CodaMi garantiert oder verarbeitet keine Zahlungen.';

  @override
  String rewardAmount(String amount) {
    return 'Finderlohn $amount';
  }

  @override
  String get adminPanel => 'Admin-Bereich';

  @override
  String get roleAdmin => 'Administrator';

  @override
  String get roleSupport => 'Support';

  @override
  String get supportStaff => 'Support-Team';

  @override
  String get supportStaffSubtitle =>
      'Personen, die Support-Anfragen beantworten';

  @override
  String get adminUsers => 'Nutzer';

  @override
  String get adminListings => 'Anzeigen';

  @override
  String get adminReportedContent => 'Gemeldete Inhalte';

  @override
  String get adminTickets => 'Support-Anfragen';

  @override
  String get adminVideos => 'Videos';

  @override
  String get addSupportStaff => 'Zum Support hinzufügen';

  @override
  String get addSupportStaffHint =>
      'Gib die E-Mail eines bestehenden CodaMi-Kontos ein.';

  @override
  String get userNotFound => 'Kein CodaMi-Konto verwendet diese E-Mail.';

  @override
  String get alreadyStaff => 'Diese Person ist bereits im Team.';

  @override
  String staffAdded(String name) {
    return '$name ist jetzt im Support-Team.';
  }

  @override
  String removeStaffTitle(String name) {
    return '$name entfernen?';
  }

  @override
  String get removeStaffMessage =>
      'Die Person hat dann keinen Zugriff mehr auf den Admin-Bereich.';

  @override
  String get noSupportStaff => 'Noch niemand im Support-Team.';

  @override
  String get add => 'Hinzufügen';

  @override
  String get actionFailed =>
      'Etwas ist schiefgelaufen. Bitte versuche es erneut.';

  @override
  String get adminDashboard => 'Übersicht';

  @override
  String get adminMore => 'Mehr';

  @override
  String get adminReportedShort => 'Gemeldet';

  @override
  String get adminTicketsShort => 'Anfragen';

  @override
  String get adminSectionSoon => 'Dieser Bereich kommt bald.';

  @override
  String get statUsers => 'Registrierte Nutzer';

  @override
  String get statOpenLost => 'Offene Vermisstmeldungen';

  @override
  String get statOpenFound => 'Offene Fundmeldungen';

  @override
  String get statBackHome => 'Wieder zu Hause';

  @override
  String get flagListing => 'Anzeige melden';

  @override
  String get flagTitle => 'Warum meldest du diese Anzeige?';

  @override
  String get flagHint =>
      'Unser Team prüft sie. Der Besitzer erfährt nicht, wer sie gemeldet hat.';

  @override
  String get flagReasonSpam => 'Spam oder Werbung';

  @override
  String get flagReasonScam => 'Betrug';

  @override
  String get flagReasonInappropriate => 'Unangemessener Inhalt';

  @override
  String get flagReasonWrongInfo => 'Falsche oder irreführende Angaben';

  @override
  String get flagReasonOther => 'Etwas anderes';

  @override
  String get flagNoteHint => 'Details hinzufügen (optional)';

  @override
  String get flagSubmit => 'Meldung senden';

  @override
  String get flagSent => 'Danke. Unser Team prüft diese Anzeige.';

  @override
  String get alreadyFlagged => 'Du hast diese Anzeige bereits gemeldet.';

  @override
  String blockUser(String name) {
    return '$name blockieren';
  }

  @override
  String blockUserTitle(String name) {
    return '$name blockieren?';
  }

  @override
  String get blockUserMessage =>
      'Du siehst keine Anzeigen dieser Person mehr und bekommst keine Hinweise dazu. Du kannst sie unter Profil → Blockierte Nutzer wieder freigeben.';

  @override
  String get block => 'Blockieren';

  @override
  String userBlocked(String name) {
    return '$name ist blockiert.';
  }

  @override
  String get blockedUsers => 'Blockierte Nutzer';

  @override
  String get noBlockedUsers => 'Du hast niemanden blockiert.';

  @override
  String get unblock => 'Freigeben';

  @override
  String userUnblocked(String name) {
    return '$name ist nicht mehr blockiert.';
  }

  @override
  String get unknownUser => 'Unbekannter Nutzer';

  @override
  String get hiddenListing => 'Ausgeblendet';

  @override
  String get hiddenListingNotice =>
      'Diese Anzeige wurde vom CodaMi-Team ausgeblendet und ist nicht mehr öffentlich.';

  @override
  String get moderation => 'Moderation';

  @override
  String get noFlagsOnListing => 'Niemand hat diese Anzeige gemeldet.';

  @override
  String flagCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count-mal gemeldet',
      one: 'Einmal gemeldet',
    );
    return '$_temp0';
  }

  @override
  String get dismissFlags => 'Meldungen verwerfen';

  @override
  String get flagsDismissed => 'Meldungen verworfen.';

  @override
  String get hideListing => 'Anzeige ausblenden';

  @override
  String get restoreListing => 'Anzeige wiederherstellen';

  @override
  String get listingHidden =>
      'Anzeige ausgeblendet. Nur der Besitzer kann sie noch sehen.';

  @override
  String get listingRestored => 'Anzeige wiederhergestellt.';

  @override
  String get deleteListing => 'Anzeige löschen';

  @override
  String get deleteListingTitle => 'Diese Anzeige löschen?';

  @override
  String get deleteListingMessage =>
      'Die Anzeige und ihre Fotos werden für alle gelöscht. Das kann nicht rückgängig gemacht werden.';

  @override
  String get listingDeleted => 'Anzeige gelöscht.';

  @override
  String get listingUnavailable => 'Anzeige nicht mehr verfügbar';

  @override
  String get noReportedContent => 'Keine Meldungen';

  @override
  String get noReportedContentMessage =>
      'Von Nutzern gemeldete Anzeigen erscheinen hier.';

  @override
  String get filterOpen => 'Offen';

  @override
  String get filterResolved => 'Erledigt';

  @override
  String get filterHidden => 'Ausgeblendet';

  @override
  String get noListings => 'Keine Anzeigen';

  @override
  String get tryAnotherFilter => 'Probiere einen anderen Filter.';

  @override
  String get adminUsersSubtitle => 'Konten ansehen, sperren oder löschen';

  @override
  String get searchByEmail => 'Nach E-Mail suchen';

  @override
  String get noUsersFound => 'Keine Nutzer gefunden.';

  @override
  String get roleUser => 'Nutzer';

  @override
  String get userDisabled => 'Gesperrt';

  @override
  String get phone => 'Telefon';

  @override
  String get memberSince => 'Mitglied seit';

  @override
  String get disableAccount => 'Konto sperren';

  @override
  String get enableAccount => 'Konto entsperren';

  @override
  String disableUserTitle(String name) {
    return 'Konto von $name sperren?';
  }

  @override
  String get disableUserMessage =>
      'Die Person wird abgemeldet und kann sich nicht mehr anmelden. Ihre offenen Anzeigen bleiben ausgeblendet, bis das Konto entsperrt wird.';

  @override
  String get accountDisabled => 'Konto gesperrt.';

  @override
  String get accountEnabled => 'Konto entsperrt.';

  @override
  String deleteUserTitle(String name) {
    return 'Konto von $name löschen?';
  }

  @override
  String get deleteUserMessage =>
      'Profil, Haustiere, Anzeigen und Fotos werden endgültig gelöscht. Das kann nicht rückgängig gemacht werden.';

  @override
  String get userDeleted => 'Konto gelöscht.';

  @override
  String get save => 'Speichern';

  @override
  String get requiredField => 'Pflichtfeld';

  @override
  String get notificationSettingsIntro =>
      'Wähle, welche Hinweise du bekommst, und gib jedem einen eigenen Ton, damit du schon vorher weißt, worum es geht.';

  @override
  String get notificationSound => 'Ton';

  @override
  String get alertLostTitle => 'Vermisste Tiere in der Nähe';

  @override
  String get alertLostDescription =>
      'Wenn in deiner Stadt ein Tier verschwindet';

  @override
  String get alertFoundTitle => 'Gefundene Tiere in der Nähe';

  @override
  String get alertFoundDescription =>
      'Wenn jemand in deiner Stadt ein Tier findet';

  @override
  String get alertResolvedTitle => 'Happy Ends';

  @override
  String get alertResolvedDescription =>
      'Wenn ein vermisstes oder gefundenes Tier wieder zu Hause ist';

  @override
  String get soundDefault => 'Standardton des Handys';

  @override
  String get soundSilent => 'Lautlos';

  @override
  String get soundChime => 'Glockenspiel';

  @override
  String get soundBell => 'Glocke';

  @override
  String get soundBright => 'Hell';

  @override
  String get soundSoft => 'Sanft';

  @override
  String get soundCustom => 'Eigener Ton';

  @override
  String get soundFromPhone => 'Klingeltöne und Töne des Handys';

  @override
  String get soundFromFile => 'Musik oder Audiodatei';

  @override
  String get soundIosNote =>
      'Auf dem iPhone müssen Mitteilungstöne aus der App kommen. Wähle einen der Töne oben.';

  @override
  String get soundPickFailed =>
      'Dieser Ton kann nicht verwendet werden. Bitte wähle einen anderen.';

  @override
  String get videosForYou => 'Videos für dich';

  @override
  String get videosForYourPets => 'Passend zu deinen Tieren';

  @override
  String get videosGeneral => 'Tierschutz und verantwortungsvolle Tierhaltung';

  @override
  String get videosShuffle => 'Andere Videos zeigen';

  @override
  String get videoMotivational => 'Motivation';

  @override
  String get videoEducational => 'Lernen';

  @override
  String get videoTagGeneral => 'Für alle';

  @override
  String get videoLoadError =>
      'Dieses Video kann gerade nicht abgespielt werden. Bitte versuche es später noch einmal.';

  @override
  String get adminVideosSubtitle => 'Videos hochladen und verwalten';

  @override
  String get addVideo => 'Video hinzufügen';

  @override
  String get editVideo => 'Video bearbeiten';

  @override
  String get noVideosYet =>
      'Noch keine Videos. Füge das erste mit dem Button unten hinzu.';

  @override
  String get deleteVideoTitle => 'Dieses Video löschen?';

  @override
  String get deleteVideoMessage =>
      'Es wird für alle aus der App entfernt. Das kann nicht rückgängig gemacht werden.';

  @override
  String get videoHidden => 'Ausgeblendet';

  @override
  String get allLanguages => 'Alle Sprachen';

  @override
  String get chooseVideo => 'Video auswählen';

  @override
  String get chooseVideoHint =>
      'Aus deiner Galerie, bis 200 MB. Kurze Videos (unter 2 Minuten) eignen sich am besten.';

  @override
  String get videoTitle => 'Titel';

  @override
  String get videoType => 'Art';

  @override
  String get videoAnimals => 'Tiere';

  @override
  String get videoAnimalsHint =>
      'Wähle die Tiere, um die es im Video geht. Wähle „Für alle“ für allgemeine Videos, die alle sehen.';

  @override
  String get videoVisible => 'In der App sichtbar';

  @override
  String get videoVisibleHint => 'Ausgeblendete Videos sehen nur Admins.';

  @override
  String get videoTooLarge =>
      'Das Video ist größer als 200 MB. Bitte wähle ein kürzeres.';

  @override
  String get videoSaved => 'Video gespeichert.';

  @override
  String uploadingProgress(int percent) {
    return 'Wird hochgeladen… $percent %';
  }

  @override
  String get navVideos => 'Videos';

  @override
  String get videosEmptyTitle => 'Videos sind unterwegs';

  @override
  String get videosEmptyMessage =>
      'Bald findest du hier kurze Videos rund um die Pflege deiner Tiere.';

  @override
  String get moreVideos => 'Weitere Videos';

  @override
  String get videoWatched => 'Angesehen';

  @override
  String get videoBack10 => '10 Sekunden zurück';

  @override
  String get videoForward10 => '10 Sekunden vor';

  @override
  String get videoFullscreen => 'Vollbild';

  @override
  String get videoExitFullscreen => 'Vollbild beenden';

  @override
  String get videoRetry => 'Erneut versuchen';

  @override
  String get videoDeleted => 'Video gelöscht.';

  @override
  String get noVideosYetTitle => 'Noch keine Videos';

  @override
  String get videoVisibleShort => 'Sichtbar';

  @override
  String get play => 'Abspielen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get change => 'Ändern';

  @override
  String get videoSectionFile => 'Video';

  @override
  String get videoSectionDetails => 'Details';

  @override
  String get videoSectionAudience => 'Wer es sieht';

  @override
  String get videoCover => 'Titelbild';

  @override
  String get videoCoverHint => 'Optional. Erscheint auf der Videokarte.';

  @override
  String get videoMotivationalHint =>
      'Inspirierende Geschichten und schöne Momente';

  @override
  String get videoEducationalHint => 'Tipps und Anleitungen für Halter';

  @override
  String get uploadVideo => 'Video hochladen';

  @override
  String get helpSupport => 'Hilfe & Support';

  @override
  String get helpSupportSubtitle => 'Chatte mit uns oder sende eine Anfrage';

  @override
  String get supportIntroTitle => 'Wie können wir helfen?';

  @override
  String get supportIntroMessage =>
      'Unser Team antwortet hier in der App. Du bekommst eine Benachrichtigung, wenn wir antworten.';

  @override
  String get supportStartChat => 'Live-Chat starten';

  @override
  String get supportStartChatOnline => 'Ein Mitarbeiter ist gerade online';

  @override
  String get supportChatOffline =>
      'Gerade ist niemand online. Sende eine Anfrage und wir antworten so schnell wie möglich.';

  @override
  String get supportSendRequest => 'Anfrage senden';

  @override
  String get supportSendRequestSubtitle =>
      'Wir antworten meist innerhalb von 24 Stunden';

  @override
  String get supportMyRequests => 'Meine Anfragen';

  @override
  String get supportNoRequests => 'Noch keine Anfragen';

  @override
  String get supportNoRequestsMessage =>
      'Deine Gespräche mit dem Support erscheinen hier.';

  @override
  String get supportNewChat => 'Neuer Live-Chat';

  @override
  String get supportNewRequest => 'Neue Anfrage';

  @override
  String get supportCategory => 'Thema';

  @override
  String get categoryAccount => 'Konto und Anmeldung';

  @override
  String get categoryListing => 'Eine Verloren- oder Gefunden-Meldung';

  @override
  String get categoryApp => 'Problem mit der App';

  @override
  String get categoryOther => 'Etwas anderes';

  @override
  String get supportSubject => 'Betreff';

  @override
  String get supportSubjectHint => 'In wenigen Worten';

  @override
  String get supportSubjectTooShort => 'Bitte mindestens 3 Zeichen eingeben';

  @override
  String get supportMessage => 'Nachricht';

  @override
  String get supportMessageHint => 'Erzähl uns, was passiert ist';

  @override
  String get supportMessageRequired => 'Bitte schreibe eine Nachricht';

  @override
  String get supportSend => 'Senden';

  @override
  String get supportTooManyOpen =>
      'Du hast bereits 3 offene Anfragen. Bitte schreibe in einer davon weiter.';

  @override
  String get supportTypeMessage => 'Nachricht schreiben…';

  @override
  String get supportTeam => 'CodaMi-Support';

  @override
  String get supportMarkSolved => 'Als gelöst markieren';

  @override
  String get supportMarkSolvedConfirm =>
      'Diese Anfrage als gelöst markieren? Du kannst jederzeit wieder schreiben.';

  @override
  String get supportClosedNote =>
      'Diese Anfrage ist geschlossen. Starte eine neue, wenn du weitere Hilfe brauchst.';

  @override
  String get supportResolvedNote =>
      'Als gelöst markiert. Eine neue Nachricht öffnet sie wieder.';

  @override
  String get supportWaitingNote => 'Danke! Unser Team antwortet dir hier bald.';

  @override
  String get kindChat => 'Live-Chat';

  @override
  String get kindTicket => 'Anfrage';

  @override
  String get caseStatusOpen => 'Offen';

  @override
  String get caseStatusInProgress => 'In Bearbeitung';

  @override
  String get caseStatusWaitingUser => 'Wartet auf Antwort';

  @override
  String get caseStatusResolved => 'Gelöst';

  @override
  String get caseStatusClosed => 'Geschlossen';

  @override
  String get filterUnanswered => 'Unbeantwortet';

  @override
  String get filterUnassigned => 'Nicht zugewiesen';

  @override
  String get filterMine => 'Meine';

  @override
  String get filterActive => 'Aktiv';

  @override
  String get filterDone => 'Erledigt';

  @override
  String get supportSearchHint => 'CM-1042 oder E-Mail suchen';

  @override
  String get supportNoCases => 'Keine Anfragen hier';

  @override
  String get supportNoCasesMessage => 'In dieser Liste wartet nichts.';

  @override
  String get supportTake => 'Übernehmen';

  @override
  String get supportTakeToReply => 'Übernimm die Anfrage, um zu antworten.';

  @override
  String get supportAlreadyTaken =>
      'Ein anderer Mitarbeiter hat diese Anfrage bereits übernommen.';

  @override
  String get supportUnassigned => 'Nicht zugewiesen';

  @override
  String get supportReassign => 'Neu zuweisen';

  @override
  String get supportAssignTo => 'Zuweisen an';

  @override
  String get supportBackToQueue => 'Zurück in die Warteschlange';

  @override
  String get supportChangeStatus => 'Status ändern';

  @override
  String get supportChat => 'Chat';

  @override
  String get supportTimeline => 'Verlauf';

  @override
  String get supportDetails => 'Details';

  @override
  String supportWaitingFor(String time) {
    return 'Wartet seit $time';
  }

  @override
  String get supportOverdue => 'Antwort überfällig';

  @override
  String get supportOpened => 'Geöffnet';

  @override
  String get supportTakenOver => 'Übernommen';

  @override
  String get supportWaitToTake => 'Wartezeit bis Übernahme';

  @override
  String get supportFirstReply => 'Erste Antwort';

  @override
  String get supportAvgReply => 'Durchschnittliche Antwortzeit';

  @override
  String get supportHandlingTime => 'Bearbeitungszeit';

  @override
  String get supportResolvedAt => 'Gelöst';

  @override
  String get supportMessagesCount => 'Nachrichten';

  @override
  String get supportOperator => 'Mitarbeiter';

  @override
  String get supportUserLabel => 'Nutzer';

  @override
  String eventCreated(String name) {
    return 'Geöffnet von $name';
  }

  @override
  String eventTaken(String name) {
    return 'Übernommen von $name';
  }

  @override
  String eventReassigned(String from, String to) {
    return 'Neu zugewiesen von $from an $to';
  }

  @override
  String eventStatus(String name, String status) {
    return '$name hat den Status auf $status gesetzt';
  }

  @override
  String get eventReopened => 'Vom Nutzer wieder geöffnet';

  @override
  String get eventOverdue => 'Keine Antwort innerhalb der Frist';

  @override
  String get eventAutoClosed => 'Automatisch geschlossen';

  @override
  String get presenceOnline => 'Online';

  @override
  String get presenceAway => 'Abwesend';

  @override
  String get presenceOffline => 'Offline';

  @override
  String get presenceAvailable => 'Für Live-Chat verfügbar';

  @override
  String get presenceAvailableSubtitle =>
      'Nutzer können einen Live-Chat starten, solange jemand online ist';

  @override
  String get supportOperators => 'Mitarbeiter';

  @override
  String get supportOperatorsSubtitle => 'Aktivität, Fälle und Antwortzeiten';

  @override
  String get operatorOpenCases => 'Offene Fälle';

  @override
  String get operatorTaken => 'Übernommen';

  @override
  String get operatorResolved => 'Gelöst';

  @override
  String get operatorReplies => 'Antworten';

  @override
  String get operatorAvgHandling => 'Durchschnittliche Zeit pro Fall';

  @override
  String operatorLastActive(String time) {
    return 'Zuletzt aktiv $time';
  }

  @override
  String get operatorCases => 'Fälle';

  @override
  String get noOperators =>
      'Noch keine Mitarbeiter. Füge sie unter Support-Team hinzu.';

  @override
  String get statUnassigned => 'Nicht zugewiesene Anfragen';

  @override
  String get statUnanswered => 'Unbeantwortete Anfragen';

  @override
  String get statOverdue => 'Überfällige Antworten';

  @override
  String get alertSupportTitle => 'Support-Antworten';

  @override
  String get alertSupportDescription => 'Wenn der CodaMi-Support dir schreibt';

  @override
  String durationSeconds(int n) {
    return '$n Sek.';
  }

  @override
  String durationMinutes(int n) {
    return '$n Min.';
  }

  @override
  String durationHours(int h, int m) {
    return '$h Std. $m Min.';
  }

  @override
  String durationDays(int d, int h) {
    return '$d T. $h Std.';
  }

  @override
  String get searchUsersHint => 'Nach Name oder E-Mail suchen';

  @override
  String get searchTooShort => 'Mindestens 2 Zeichen eingeben';

  @override
  String get pickStaffTitle => 'Nutzer auswählen';

  @override
  String get pickStaffHint =>
      'Tippe auf eine Person, um sie zum Support-Team hinzuzufügen.';

  @override
  String makeStaffTitle(String name) {
    return '$name zum Support-Team hinzufügen?';
  }

  @override
  String get makeStaffMessage =>
      'Die Person sieht den Admin-Bereich und kann Anfragen und Chats beantworten. Du kannst sie jederzeit entfernen.';

  @override
  String get makeStaff => 'Zum Team hinzufügen';

  @override
  String get supportStaffSwitch => 'Support-Team';

  @override
  String get supportStaffSwitchSubtitle =>
      'Kann Anfragen und Chats beantworten';

  @override
  String staffRemoved(String name) {
    return '$name ist nicht mehr im Support-Team.';
  }

  @override
  String get removeStaffCasesNote =>
      'Offene Fälle gehen zurück in die Warteschlange.';

  @override
  String get pushOpen => 'Öffnen';

  @override
  String get chatToday => 'Heute';

  @override
  String get chatLoadEarlier => 'Ältere Nachrichten laden';

  @override
  String get supportPeople => 'Personen';

  @override
  String get supportTimes => 'Zeiten';

  @override
  String get supportRequestInfo => 'Anfrage';

  @override
  String get supportType => 'Art';

  @override
  String get supportResolve => 'Als gelöst markieren';

  @override
  String ticketsWaiting(int count) {
    return '$count warten auf Antwort';
  }

  @override
  String get ticketsAllClear => 'Alles erledigt';

  @override
  String get photoReviewHint =>
      'Von der KI zurückgehaltene Fotos. Sie bleiben ausgeblendet, bis du entscheidest.';

  @override
  String get reasonAdult => 'Nacktheit oder sexuelle Inhalte';

  @override
  String get reasonRacy => 'Anzügliche Inhalte';

  @override
  String get reasonViolence => 'Gewalt oder Blut';

  @override
  String get likelihoodPossible => 'Möglich';

  @override
  String get likelihoodLikely => 'Wahrscheinlich';

  @override
  String get likelihoodVeryLikely => 'Sehr wahrscheinlich';

  @override
  String get hiddenByAi => 'Von der KI ausgeblendet';

  @override
  String get petPhoto => 'Tierfoto';

  @override
  String get listingPhoto => 'Foto der Anzeige';

  @override
  String uploadedBy(String name) {
    return 'Von $name';
  }

  @override
  String get tapToView => 'Zum Ansehen tippen';

  @override
  String get approvePhoto => 'Freigeben';

  @override
  String get removePhotoTitle => 'Dieses Foto entfernen?';

  @override
  String get removePhotoMessage =>
      'Es wird aus dem Tier oder der Anzeige des Nutzers entfernt, und der Nutzer erfährt den Grund.';

  @override
  String get photoApproved => 'Foto freigegeben';

  @override
  String get photoRemovedDone => 'Foto entfernt';

  @override
  String get photoUnderReview =>
      'Unser Team prüft gerade ein Foto. Bis dahin ist es ausgeblendet.';

  @override
  String get reportedTabPhotos => 'KI-Fotos';

  @override
  String get reportedTabReports => 'Nutzermeldungen';

  @override
  String get noPhotosToReview => 'Keine Fotos zu prüfen';

  @override
  String get noPhotosToReviewMessage =>
      'Hier erscheinen Fotos, die die KI zurückhält.';

  @override
  String get aFriend => 'Ein Freund';

  @override
  String get addContact => 'Kontakt hinzufügen';

  @override
  String get addTestContacts => 'Testkontakte hinzufügen';

  @override
  String get adjustPoints => 'Punkte anpassen';

  @override
  String get adjustPointsAmount => 'Punkte hinzufügen oder abziehen';

  @override
  String get adjustPointsAmountHelp =>
      'Mit Minuszeichen Punkte abziehen, z. B. -20';

  @override
  String get adjustPointsInvalid => 'Gib eine Punktzahl und einen Grund ein.';

  @override
  String get adjustPointsReason => 'Grund (für den Nutzer sichtbar)';

  @override
  String get adminContactsSubtitle =>
      'Tierärzte, Vereine und Dienste, die Nutzer sehen';

  @override
  String get adminEmergenciesSubtitle => 'Gemeldete Tier-Notfälle';

  @override
  String get alertEmergencyDescription =>
      'Tiere in deiner Stadt, die dringend Hilfe brauchen';

  @override
  String get alertEmergencyTitle => 'Notfälle in der Nähe';

  @override
  String get allContacts => 'Alle';

  @override
  String get ambassadorLevels => 'Botschafter-Stufen';

  @override
  String get call112 => '112 anrufen';

  @override
  String get claim => 'Abholen';

  @override
  String get claimed => 'Abgeholt';

  @override
  String get codeCopied => 'Code kopiert';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get contactActive => 'Für Nutzer sichtbar';

  @override
  String get contactActiveHelp =>
      'Ausschalten, um den Kontakt zu verbergen, ohne ihn zu löschen.';

  @override
  String get contactAddress => 'Adresse';

  @override
  String get contactAreaKm => 'Abgedecktes Gebiet (km)';

  @override
  String get contactAreaKmHelp =>
      'Wie weit von der Adresse entfernt er helfen kann. Leer lassen, um den Standardwert aus den Notfall-Einstellungen zu nutzen.';

  @override
  String get contactCity => 'Ort';

  @override
  String get contactHandles => 'Notfälle, die er übernimmt';

  @override
  String get contactHandlesHelp =>
      'Alles aus lassen, wenn er jede Art übernimmt.';

  @override
  String get contactHoursHint => 'Öffnungszeiten, z. B. Mo–Fr 9:00–18:00';

  @override
  String get contactInactive => 'Verborgen';

  @override
  String get contactKindAssociation => 'Tierschutzverein';

  @override
  String get contactKindOther => 'Anderer Dienst';

  @override
  String get contactKindPublicService => 'Öffentlicher Veterinärdienst';

  @override
  String get contactKindVet => 'Tierarzt';

  @override
  String get contactMissingFields =>
      'Gib einen Namen ein und setze die Markierung auf der Karte.';

  @override
  String get contactName => 'Name';

  @override
  String get contactNameHint => 'z. B. Tierklinik St. Franziskus';

  @override
  String get contactPhones => 'Telefonnummern';

  @override
  String get contactPhonesHint => 'Nummern mit Kommas trennen';

  @override
  String get contactPlace => 'Wo er ist';

  @override
  String get contactRecommendedHelp =>
      'Wird bei einem Notfall vor näheren Kontakten angezeigt.';

  @override
  String get contactTestHelp =>
      'Platzhalter zum Testen. Mit TEST-Kennzeichnung angezeigt, nie verifiziert oder per E-Mail kontaktiert.';

  @override
  String get contactType => 'Art';

  @override
  String get contactVerifiedHelp =>
      'Erst wenn die Organisation der Aufnahme zugestimmt hat und die Angaben geprüft wurden.';

  @override
  String get copyCode => 'Kopieren';

  @override
  String get dailyActive => 'Heute aktiv';

  @override
  String get dailyCheckin => 'Täglicher Check-in';

  @override
  String get dailyRewards => 'Tägliche Belohnungen';

  @override
  String get deleteContactTitle => 'Diesen Kontakt löschen?';

  @override
  String get directions => 'Route';

  @override
  String get editContact => 'Kontakt bearbeiten';

  @override
  String get emergencies => 'Notfälle';

  @override
  String get emergenciesActive => 'Aktiv';

  @override
  String get emergenciesAll => 'Alle';

  @override
  String get emergenciesNearYou => 'In deiner Nähe';

  @override
  String get emergenciesSubtitle => 'Tiere, die dringend Hilfe brauchen';

  @override
  String get emergencyAddPhotos => 'Foto hinzufügen';

  @override
  String get emergencyAddPhotosHint =>
      'Hilft anderen, das Tier zu finden und zu erkennen';

  @override
  String get emergencyAllContacts => 'Alle Notfallkontakte ansehen';

  @override
  String get emergencyAlreadyReported => 'Du hast das bereits gemeldet.';

  @override
  String get emergencyCallReporter => 'Die meldende Person anrufen';

  @override
  String get emergencyClose => 'Schließen';

  @override
  String get emergencyCloseTitle => 'Diesen Notfall schließen?';

  @override
  String get emergencyContacts => 'Notfallkontakte';

  @override
  String get emergencyDetails => 'Was passiert gerade?';

  @override
  String get emergencyDetailsHint =>
      'z. B. Hund angefahren, liegt am Straßenrand, atmet noch';

  @override
  String get emergencyDetailsRequired =>
      'Beschreibe die Lage in wenigen Worten.';

  @override
  String get emergencyDisclaimer =>
      'CodaMi ist kein Notdienst. Ist ein Tier in unmittelbarer Gefahr, ruf zuerst die 112 oder einen Tierarzt an. Verlass dich nicht nur auf die Benachrichtigungen der App.';

  @override
  String get emergencyFalseAlarmTitle => 'Als Fehlalarm markieren?';

  @override
  String get emergencyFindingContacts => 'Kontakte in der Nähe werden gesucht…';

  @override
  String get emergencyHelpDone =>
      'Danke! Die meldende Person wurde informiert.';

  @override
  String get emergencyHelpMessage =>
      'Die meldende Person erfährt, dass jemand kommt. Geh nur hin, wenn es für dich sicher ist.';

  @override
  String get emergencyHelpTitle => 'Hilfst du?';

  @override
  String get emergencyImHelping => 'Ich helfe';

  @override
  String get emergencyMarkFalseAlarm => 'Als Fehlalarm markieren';

  @override
  String get emergencyMarkResolved => 'Als gelöst markieren';

  @override
  String get emergencyMissingFields =>
      'Wähle, was passiert ist und welches Tier, beschreibe die Lage und setze die Markierung.';

  @override
  String get emergencyNoContacts =>
      'Für dieses Gebiet gibt es noch keine Kontakte. Ruf die 112 oder einen Tierarzt an.';

  @override
  String get emergencyPhoneHint =>
      'Für Helfer sichtbar, damit sie dich anrufen können.';

  @override
  String get emergencyPinHint =>
      'Verschiebe die Karte, um die Markierung dorthin zu setzen, wo das Tier ist.';

  @override
  String get emergencyPinned => 'Markierung gesetzt';

  @override
  String get emergencyReopen => 'Wieder öffnen';

  @override
  String get emergencyReportFalse => 'Als falsch melden';

  @override
  String get emergencyReportFalseDone => 'Danke, unser Team prüft das.';

  @override
  String get emergencyReportFalseMessage => 'Unser Team prüft diesen Notfall.';

  @override
  String get emergencyReportFalseTitle => 'Ist dieser Notfall falsch?';

  @override
  String get emergencyResolveTitle => 'Als gelöst markieren?';

  @override
  String get emergencyResolved => 'Als gelöst markiert';

  @override
  String get emergencySend => 'Notfall senden';

  @override
  String get emergencySendFailed =>
      'Der Notfall konnte nicht gesendet werden. Prüfe deine Verbindung und versuch es erneut, oder ruf die 112 an.';

  @override
  String get emergencySending => 'Wird gesendet…';

  @override
  String get emergencySent =>
      'Notfall gesendet. Menschen in der Nähe werden benachrichtigt. Du kannst auch die Kontakte unten direkt anrufen.';

  @override
  String get emergencySettings => 'Notfall-Einstellungen';

  @override
  String get emergencySettingsSubtitle =>
      'Entfernungen der Benachrichtigungen und Reihenfolge der Kontakte';

  @override
  String get emergencyStatusClosed => 'Geschlossen';

  @override
  String get emergencyStatusFalseAlarm => 'Fehlalarm';

  @override
  String get emergencyStatusHelping => 'Hilfe unterwegs';

  @override
  String get emergencyStatusOpen => 'Braucht Hilfe';

  @override
  String get emergencyStatusResolved => 'Gelöst';

  @override
  String get emergencySuggestedContacts => 'Wer helfen kann';

  @override
  String get emergencySuggestedContactsHint =>
      'Die nächsten passenden Kontakte zuerst. Ruf sie direkt an.';

  @override
  String get emergencyTypeAbandoned => 'Ausgesetztes Tier';

  @override
  String get emergencyTypeDanger => 'Tier in Gefahr';

  @override
  String get emergencyTypeInjured => 'Verletztes Tier';

  @override
  String get emergencyTypeIntervention => 'Bitte um Einsatz';

  @override
  String get emergencyTypeOther => 'Anderer Notfall';

  @override
  String get emergencyTypeUrgentFound => 'Gefunden, braucht dringend Hilfe';

  @override
  String get emergencyUnavailable => 'Dieser Notfall ist nicht mehr verfügbar.';

  @override
  String get emergencyWhatHappened => 'Was ist passiert?';

  @override
  String get emergencyWhere => 'Wo ist das Tier?';

  @override
  String get emergencyWhereHint =>
      'Der genaue Ort wird geteilt, damit Helfer das Tier finden.';

  @override
  String get emergencyYouAreHelping => 'Du hast gesagt, dass du hilfst. Danke!';

  @override
  String get emergencyYourPhone => 'Deine Telefonnummer';

  @override
  String get flagBurst =>
      'Viele Freunde dieses Nutzers wurden am selben Tag aktiv';

  @override
  String get flagDeviceUsed =>
      'Dieses Handy wurde schon für eine andere Einladung genutzt';

  @override
  String get flagSameDevice => 'Gleiches Handy wie die einladende Person';

  @override
  String get haveInviteCode =>
      'Hat dich ein Freund eingeladen? Gib seinen Code ein';

  @override
  String get invitePromptTitle => 'Hat dich ein Freund eingeladen?';

  @override
  String get invitePromptBody =>
      'Gib seinen Einladungscode ein, damit dein Freund dafür belohnt wird, dass er dich zu CodaMi gebracht hat.';

  @override
  String invitePromptLater(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'Du kannst ihn auch später unter Profil → Freunde einladen eingeben, innerhalb von $days Tagen nach der Anmeldung.',
      one:
          'Du kannst ihn auch heute noch unter Profil → Freunde einladen eingeben.',
    );
    return '$_temp0';
  }

  @override
  String get inviteCodeLabel => 'Einladungscode';

  @override
  String get inviteCodeFromLink =>
      'Aus deinem Einladungslink übernommen. Tippe auf Einlösen, um zu bestätigen.';

  @override
  String get inviteCodeFormat =>
      'Einladungscodes haben 6 Buchstaben und Zahlen, z. B. ABC234.';

  @override
  String get inviteCodeNotFound =>
      'Wir konnten diesen Code nicht finden. Prüfe ihn mit deinem Freund.';

  @override
  String get inviteCodeOwn =>
      'Das ist dein eigener Code. Teile ihn lieber mit deinen Freunden.';

  @override
  String inviteCodeTooLate(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'Einladungscodes können nur in den ersten $days Tagen nach der Anmeldung eingegeben werden.',
      one: 'Einladungscodes können nur am Tag der Anmeldung eingegeben werden.',
    );
    return '$_temp0';
  }

  @override
  String get inviteCodeTooManyTries =>
      'Heute zu viele falsche Codes. Versuche es morgen noch einmal.';

  @override
  String get howInvitesWork => 'So funktioniert\'s';

  @override
  String get inviteApproved => 'Einladung bestätigt';

  @override
  String get inviteCodeAlreadyUsed =>
      'Du hast bereits einen Einladungscode verwendet.';

  @override
  String get inviteCodeInvalid => 'Dieser Code ist ungültig.';

  @override
  String get inviteCodeNotAllowed =>
      'Dieser Code kann nicht verwendet werden: Es ist dein eigener Code, oder deine Anmeldung liegt zu lange zurück.';

  @override
  String get inviteFriends => 'Freunde einladen';

  @override
  String get inviteFriendsSubtitle => 'Werde CodaMi-Botschafter';

  @override
  String get inviteIntro =>
      'Jeder neue CodaMi-Nutzer ist ein weiteres Augenpaar für vermisste Tiere. Lade deine Freunde ein und werde CodaMi-Botschafter.';

  @override
  String get inviteRejected => 'Einladung abgelehnt';

  @override
  String get inviteStatusExpired => 'Nicht rechtzeitig aktiv geworden';

  @override
  String get inviteStatusPending => 'Angemeldet, noch nicht aktiv';

  @override
  String get inviteStatusQualified => 'Aktiv – Punkte erhalten';

  @override
  String get inviteStatusRejected => 'Nicht gezählt';

  @override
  String get inviteStatusReview => 'Wird geprüft';

  @override
  String get inviteStep1 =>
      'Teile deinen Code. Dein Freund gibt ihn nach der Anmeldung unter Profil → Freunde einladen ein.';

  @override
  String get invitedFriends => 'Eingeladene Freunde (aktiv)';

  @override
  String get invitesToReview => 'Einladungen prüfen';

  @override
  String get invitesToReviewSubtitle =>
      'Von der Betrugsprüfung angehaltene Einladungen';

  @override
  String get levelAmbassador => 'Botschafter';

  @override
  String get levelBonus => 'Bonuspunkte';

  @override
  String get settingsActiveFriends => 'Aktive Freunde';

  @override
  String get levelChampion => 'CodaMi-Champion';

  @override
  String get levelSuperAmbassador => 'Super-Botschafter';

  @override
  String get levelSupporter => 'Unterstützer';

  @override
  String get myEmergencies => 'Meine';

  @override
  String get myPoints => 'Meine Punkte';

  @override
  String get noActiveEmergencies => 'Keine Notfälle';

  @override
  String get noEmergenciesMessage =>
      'Hier erscheinen Notfälle, die in der Nähe deiner Stadt gemeldet werden.';

  @override
  String get noEmergenciesNearby => 'Keine Notfälle in deiner Nähe';

  @override
  String get noEmergencyContacts => 'Noch keine Kontakte';

  @override
  String get noEmergencyContactsAdmin =>
      'Füge Tierärzte, Vereine und Dienste hinzu, oder Testkontakte, um die Funktion auszuprobieren.';

  @override
  String get noEmergencyContactsMessage =>
      'Kontakte werden bald hinzugefügt. Ruf im Notfall die 112 oder einen Tierarzt an.';

  @override
  String get noInvitesToReview => 'Nichts zu prüfen';

  @override
  String get noInvitesToReviewMessage =>
      'Verdächtige Einladungen erscheinen hier. Nichts wird ohne dich abgelehnt.';

  @override
  String get noInvitesYet =>
      'Noch keine Einladungen. Teile deinen Code, um zu starten.';

  @override
  String get noLevelYet => 'Noch keine Stufe';

  @override
  String get noMyEmergencies => 'Du hast keine Notfälle gemeldet';

  @override
  String get noPointsYet =>
      'Noch keine Punkte. Hol dir deine tägliche Belohnung, um zu starten.';

  @override
  String get open24h => '24 Stunden geöffnet';

  @override
  String get openMapFailed => 'Die Karte konnte nicht geöffnet werden.';

  @override
  String get photos => 'Fotos';

  @override
  String get pointsAdjusted => 'Von CodaMi angepasst';

  @override
  String get pointsDailyActive => 'Heute aktiv';

  @override
  String get pointsDailyCheckin => 'Täglicher Check-in';

  @override
  String get pointsFriendJoined => 'Ein Freund wurde aktiv';

  @override
  String get pointsHistory => 'Verlauf';

  @override
  String get pointsLevelBonus => 'Bonus für neue Stufe';

  @override
  String get pointsOther => 'Punkte';

  @override
  String get pointsSettings => 'Punkte und Belohnungen';

  @override
  String get pointsSettingsIntro =>
      'Änderungen gelten sofort. Werte außerhalb des Bereichs werden durch die Standardwerte ersetzt.';

  @override
  String get pointsSettingsSubtitle =>
      'Tägliche Belohnungen, Einladungen und Stufen';

  @override
  String get pointsStreakBonus => 'Serienbonus';

  @override
  String get pointsWelcome => 'Willkommensbonus';

  @override
  String get recommendedContact => 'Empfohlen';

  @override
  String get reject => 'Ablehnen';

  @override
  String get reportEmergency => 'Notfall melden';

  @override
  String get searchContacts => 'Nach Name oder Ort suchen';

  @override
  String get settingsActiveMinutes => 'Nutzungsminuten für „Heute aktiv“';

  @override
  String get settingsAlertsNearby =>
      'Benachrichtigungen an Menschen in der Nähe';

  @override
  String get settingsAutoCloseHours =>
      'Schließen nach (Stunden ohne Neuigkeiten)';

  @override
  String get settingsAutoCloseHoursHelp =>
      'Offene Notfälle schließen sich nach dieser Zeit von selbst.';

  @override
  String get settingsCodeEntryDays =>
      'Tage nach der Anmeldung für die Code-Eingabe';

  @override
  String get settingsContactsPriority => 'Priorität der Kontakte';

  @override
  String get settingsDefaultAreaKm => 'Standardgebiet (km)';

  @override
  String get settingsDefaultAreaKmHelp => 'Für Kontakte ohne eigenes Gebiet.';

  @override
  String get settingsEmailContacts => 'E-Mail-Benachrichtigungen an Kontakte';

  @override
  String get settingsEmailContactsHelp =>
      'Sendet eine E-Mail an verifizierte Kontakte. Der E-Mail-Dienst muss zuerst eingerichtet werden.';

  @override
  String get settingsMaxPerDay => 'Aktive Freunde pro Tag vor einer Prüfung';

  @override
  String get settingsMaxPerDayHelp =>
      'Mehr innerhalb von 24 Stunden schickt die Einladung zur Prüfung.';

  @override
  String get settingsMaxRecipients => 'Höchstens benachrichtigte Personen';

  @override
  String get settingsMaxSuggested => 'Vorgeschlagene Kontakte';

  @override
  String get settingsMinRecipients => 'Zu erreichende Personen';

  @override
  String get settingsMinRecipientsHelp =>
      'Der nächste Kreis wird genutzt, bis so viele Personen erreicht sind.';

  @override
  String get settingsQualifyDays => 'Benötigte aktive Tage';

  @override
  String get settingsQualifyWithinDays =>
      'Innerhalb von (Tagen nach Anmeldung)';

  @override
  String get settingsReferralPoints => 'Punkte pro aktivem Freund';

  @override
  String get settingsRings => 'Benachrichtigungskreise (km)';

  @override
  String get settingsRingsHelp =>
      'Mit Kommas getrennt, vom kleinsten an, z. B. 5, 10, 25';

  @override
  String get settingsSaved => 'Gespeichert';

  @override
  String get settingsStreakDays => 'Tage für den Serienbonus';

  @override
  String get settingsWeight24h => 'Bonus für 24 Stunden geöffnet';

  @override
  String get settingsWeightHelp =>
      'Kontakte erhalten diese Boni und verlieren Punkte pro km Entfernung. Die höchste Punktzahl kommt zuerst.';

  @override
  String get settingsWeightPerKm => 'Abzug pro km';

  @override
  String get settingsWeightPerKmHelp =>
      'Mit 1 kommt ein empfohlener Kontakt (20) vor einem bis zu 20 km näheren.';

  @override
  String get settingsWeightRecommended => 'Bonus für empfohlen';

  @override
  String get settingsWeightVerified => 'Bonus für verifiziert';

  @override
  String get settingsWelcomePoints => 'Punkte für den eingeladenen Freund';

  @override
  String get settingsWelcomePointsHelp =>
      'Gibt es bei der Eingabe eines Codes. 0 schaltet sie aus.';

  @override
  String get shareInvite => 'Teilen';

  @override
  String get statActiveEmergencies => 'Aktive Notfälle';

  @override
  String get testContactBadge => 'TEST – kein echter Kontakt';

  @override
  String get topLevelReached => 'Du hast die höchste Stufe erreicht. Danke!';

  @override
  String get useCode => 'Einlösen';

  @override
  String get verifiedContact => 'Verifiziert';

  @override
  String get viewInvitee => 'Eingeladener Nutzer';

  @override
  String get viewInviter => 'Einladende Person';

  @override
  String get yourInviteCode => 'Dein Einladungscode';

  @override
  String get yourInvites => 'Deine Einladungen';

  @override
  String get zeroTurnsOff => '0 schaltet es aus';

  @override
  String activeProgress(int done, int total) {
    return '$done von $total Minuten heute';
  }

  @override
  String claimedPoints(int points) {
    return '+$points Punkte!';
  }

  @override
  String claimedWithBonus(int points, int bonus) {
    return '+$points Punkte und +$bonus Serienbonus!';
  }

  @override
  String emergenciesNearYouCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tier-Notfälle in deiner Nähe',
      one: '1 Tier-Notfall in deiner Nähe',
    );
    return '$_temp0';
  }

  @override
  String emergencyAlertedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Personen in der Nähe wurden benachrichtigt',
      one: '1 Person in der Nähe wurde benachrichtigt',
      zero: 'In der Nähe hat noch niemand Benachrichtigungen aktiviert',
    );
    return '$_temp0';
  }

  @override
  String emergencyFalseReports(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count-mal als falsch gemeldet',
      one: 'Einmal als falsch gemeldet',
    );
    return '$_temp0';
  }

  @override
  String emergencyHelpersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Personen helfen',
      one: '1 Person hilft',
    );
    return '$_temp0';
  }

  @override
  String inviteCodeAccepted(String name) {
    return 'Code angenommen. $name hat dich eingeladen – willkommen bei CodaMi!';
  }

  @override
  String inviteShareText(String code, String link) {
    return 'Ich nutze CodaMi, damit vermisste Tiere wieder nach Hause finden. Mach mit, mit meinem Einladungscode $code: $link';
  }

  @override
  String inviteStep2(int days, int within) {
    return 'Er gibt seine Stadt an und nutzt die App an $days verschiedenen Tagen innerhalb von $within Tagen nach der Anmeldung.';
  }

  @override
  String inviteStep3(int points) {
    return 'Du bekommst $points Punkte und steigst in den Botschafter-Stufen auf.';
  }

  @override
  String kmAway(String km) {
    return '$km km entfernt';
  }

  @override
  String levelFriends(String level) {
    return '$level: aktive Freunde';
  }

  @override
  String levelRule(String level, int friends, int bonus) {
    return '$level · ab $friends Freunden · +$bonus';
  }

  @override
  String nextLevelHint(int count, String level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Noch $count aktive Freunde bis $level',
      one: 'Noch 1 aktiver Freund bis $level',
    );
    return '$_temp0';
  }

  @override
  String plusPoints(int points) {
    return '+$points Punkte';
  }

  @override
  String pointsTotal(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points Punkte',
      one: '1 Punkt',
    );
    return '$_temp0';
  }

  @override
  String streakLine(int streak, int days, int bonus) {
    return '$streak-Tage-Serie · +$bonus Bonus alle $days Tage';
  }

  @override
  String get pointsFeedback => 'Feedback gesendet';

  @override
  String get whatsNew => 'Neuigkeiten';

  @override
  String get whatsNewSubtitle => 'Änderungen in jeder Version';

  @override
  String get whatsNewTitle => 'Neu in CodaMi';

  @override
  String get whatsNewIntro => 'Das hat sich mit dem letzten Update geändert.';

  @override
  String whatsNewVersion(String version) {
    return 'Version $version';
  }

  @override
  String get whatsNewSectionNew => 'Neu';

  @override
  String get whatsNewSectionImproved => 'Verbessert';

  @override
  String get whatsNewSectionFixed => 'Behoben';

  @override
  String get whatsNewEmpty => 'Noch keine Update-Hinweise.';

  @override
  String get whatsNewDone => 'Verstanden';

  @override
  String get feedbackTitle => 'Wie gefällt dir CodaMi?';

  @override
  String get feedbackBody =>
      'Dein Feedback geht direkt an das CodaMi-Team und hilft uns, die App besser zu machen.';

  @override
  String feedbackPointsOffer(int points) {
    return '+$points Punkte für dein erstes Feedback';
  }

  @override
  String get feedbackStarsHint => 'Tippe auf einen Stern, um zu bewerten';

  @override
  String get feedbackCommentHint =>
      'Was gefällt dir, oder was könnte besser sein? (optional)';

  @override
  String get feedbackSend => 'Feedback senden';

  @override
  String get feedbackLater => 'Nicht jetzt';

  @override
  String get feedbackThanks => 'Danke für dein Feedback!';

  @override
  String feedbackThanksPoints(int points) {
    return 'Danke für dein Feedback! +$points Punkte';
  }

  @override
  String get feedbackAlreadyToday =>
      'Du hast heute schon Feedback gesendet. Morgen kannst du wieder welches senden.';

  @override
  String get sendFeedbackSubtitle => 'Sag dem Team, was du denkst';

  @override
  String get rateCodaMi => 'CodaMi bewerten';

  @override
  String get rateCodaMiSubtitle => 'Hinterlasse eine Bewertung bei Google Play';

  @override
  String get adminFeedback => 'Feedback';

  @override
  String get adminFeedbackSubtitle => 'Was Nutzer von der App halten';

  @override
  String get adminFeedbackEmpty => 'Noch kein Feedback.';

  @override
  String feedbackRatingsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Bewertungen',
      one: '1 Bewertung',
    );
    return '$_temp0';
  }

  @override
  String get feedbackNoComment => 'Kein Kommentar';

  @override
  String get adminWhatsNewSubtitle =>
      'Hinweise, die Nutzer nach jedem Update sehen';

  @override
  String get releaseAdd => 'Version hinzufügen';

  @override
  String get releaseEdit => 'Hinweise bearbeiten';

  @override
  String get releaseVersion => 'Versionsnummer';

  @override
  String get releaseVersionHelp =>
      'Zum Beispiel 1.1.0. Sie muss mit dem Versionsnamen der App im Store übereinstimmen.';

  @override
  String get releaseVersionInvalid =>
      'Verwende Zahlen und Punkte, zum Beispiel 1.1.0.';

  @override
  String get releaseVersionExists =>
      'Für diese Version gibt es schon Hinweise.';

  @override
  String get releasePublishedHelp =>
      'Nutzer sehen nur veröffentlichte Hinweise.';

  @override
  String get releaseDraft => 'Entwurf';

  @override
  String get releaseLinesHelp => 'Eine Änderung pro Zeile.';

  @override
  String get releaseLanguageHelp =>
      'Leer gelassene Sprachen zeigen die englischen Hinweise.';

  @override
  String get releaseEnglishRequired =>
      'Schreibe zuerst die englischen Hinweise: Andere Sprachen greifen darauf zurück.';

  @override
  String get releaseDeleteTitle => 'Diese Hinweise löschen?';

  @override
  String releaseDeleteBody(String version) {
    return 'Die Hinweise für Version $version werden für alle entfernt.';
  }

  @override
  String get releaseNone =>
      'Noch keine Versionen. Füge die Hinweise für dein nächstes Update hinzu.';

  @override
  String releaseThisApp(String version) {
    return 'Diese App: Version $version';
  }

  @override
  String get feedbackAndReviews => 'Feedback und Bewertungen';

  @override
  String get settingsFeedbackPoints => 'Punkte für das erste Feedback';

  @override
  String get settingsFeedbackAfterDays =>
      'Tage nach der Registrierung, bevor um Feedback gebeten wird';

  @override
  String get settingsReviewActiveDays => 'Nutzungstage vor der Anfrage';

  @override
  String get settingsReviewAfterDays =>
      'Tage nach der Registrierung bis zum Store-Bewertungsfenster';

  @override
  String get settingsReviewEveryDays =>
      'Tage zwischen Store-Bewertungsanfragen';

  @override
  String get settingsReviewHelp =>
      'Das Store-Bewertungsfenster gibt nie Punkte: Google Play und der App Store erlauben das nicht.';

  @override
  String get petitions => 'Petitionen';

  @override
  String get petition => 'Petition';

  @override
  String get petitionsSubtitle =>
      'Tierschutzkampagnen, ausgewählt von unserem Team';

  @override
  String get adminPetitionsSubtitle =>
      'Tierschutzpetitionen hinzufügen, prüfen und veröffentlichen';

  @override
  String petitionsBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tierschutzpetitionen zum Unterschreiben',
      one: '1 Tierschutzpetition zum Unterschreiben',
    );
    return '$_temp0';
  }

  @override
  String get petitionsIntro =>
      'Das CodaMi-Team prüft jede Petition, bevor sie hier erscheint. Du liest und unterschreibst sie auf der Originalseite.';

  @override
  String get petitionsEmpty =>
      'Noch keine Petitionen. Das Team fügt hier Tierschutzkampagnen hinzu.';

  @override
  String get petitionAdminEmpty =>
      'Hier gibt es keine Petitionen. Tippe auf Petition hinzufügen, um eine von Change.org, Care2, Avaaz oder einer vertrauenswürdigen Organisation hinzuzufügen.';

  @override
  String get petitionView => 'Petition ansehen';

  @override
  String get petitionSignOnSite =>
      'Auf der Originalseite lesen und unterschreiben';

  @override
  String get petitionOpenFailed =>
      'Die Petitionsseite konnte nicht geöffnet werden.';

  @override
  String get petitionIssue => 'Das Problem';

  @override
  String get petitionAction => 'Was die Petition fordert';

  @override
  String get petitionWhy => 'Warum es für Tiere wichtig ist';

  @override
  String get petitionWhere => 'Originalpetition';

  @override
  String petitionStartedOn(String date) {
    return 'Gestartet am $date';
  }

  @override
  String get petitionDisclaimer =>
      'Diese Petition wird auf einer externen Website gehostet. CodaMi sammelt keine Unterschriften und ist nicht für den Inhalt der Originalseite verantwortlich.';

  @override
  String get petitionEndedNote =>
      'Diese Kampagne ist beendet. Du kannst die Originalseite trotzdem lesen.';

  @override
  String get petitionUnavailableNote =>
      'Die Originalpetition ist nicht mehr verfügbar.';

  @override
  String get petitionTopicPets => 'Haustiere';

  @override
  String get petitionTopicWildlife => 'Wildtiere';

  @override
  String get petitionTopicFarm => 'Nutztiere';

  @override
  String get petitionTopicTesting => 'Tierversuche';

  @override
  String get petitionTopicEntertainment => 'Zirkusse und Zoos';

  @override
  String get petitionTopicMarine => 'Meerestiere';

  @override
  String get petitionTopicOther => 'Sonstiges';

  @override
  String get petitionStatusActive => 'Aktiv';

  @override
  String get petitionStatusCompleted => 'Abgeschlossen';

  @override
  String get petitionStatusClosed => 'Geschlossen';

  @override
  String get petitionStatusUnavailable => 'Nicht mehr verfügbar';

  @override
  String get petitionReviewPending => 'Zu prüfen';

  @override
  String get petitionReviewApproved => 'Freigegeben';

  @override
  String get petitionReviewRejected => 'Abgelehnt';

  @override
  String get petitionAdd => 'Petition hinzufügen';

  @override
  String get petitionEdit => 'Petition bearbeiten';

  @override
  String get petitionSectionSource => 'Originalpetition';

  @override
  String get petitionUrl => 'Link zur Petition';

  @override
  String get petitionUrlInvalid =>
      'Füge den vollständigen Link ein, beginnend mit https://';

  @override
  String get petitionTitle => 'Titel';

  @override
  String get petitionSource => 'Plattform oder Organisation';

  @override
  String get petitionCountry => 'Land oder Region';

  @override
  String get petitionCountryHelp => 'Für internationale Kampagnen leer lassen.';

  @override
  String get petitionStartedOnPick => 'Startdatum der Petition (optional)';

  @override
  String get petitionTopic => 'Thema';

  @override
  String get petitionSectionText => 'Unsere Beschreibung';

  @override
  String get petitionOwnWordsHelp =>
      'Schreib in eigenen Worten. Kopiere keinen Text von der Originalseite.';

  @override
  String get petitionSummary => 'Kurze Zusammenfassung';

  @override
  String get petitionImage => 'Bild';

  @override
  String get petitionImageAdd => 'Bild hinzufügen';

  @override
  String get petitionImageChange => 'Bild ändern';

  @override
  String get petitionImageHelp =>
      'Optional. Ohne Bild zeigt die Karte das Themensymbol.';

  @override
  String get petitionImagePermission => 'Wir dürfen dieses Bild verwenden';

  @override
  String get petitionImagePermissionNeeded =>
      'Bestätige, dass du das Bild verwenden darfst, oder entferne es.';

  @override
  String get petitionImageTooBig =>
      'Das Bild ist zu groß. Wähle eines unter 5 MB.';

  @override
  String get petitionChecks => 'Überprüfung';

  @override
  String get petitionChecksHelp =>
      'Alle vier sind zum Freigeben oder Veröffentlichen nötig.';

  @override
  String get petitionCheckExists =>
      'Die Originalseite existiert und lässt sich öffnen';

  @override
  String get petitionCheckGenuine => 'Es geht um ein echtes Tierschutzanliegen';

  @override
  String get petitionCheckGoal => 'Sie hat ein klares Ziel';

  @override
  String get petitionCheckHonest =>
      'Keine irreführenden oder betrügerischen Behauptungen';

  @override
  String get petitionChecksNeeded =>
      'Hake alle Prüfpunkte ab, bevor du freigibst oder veröffentlichst.';

  @override
  String get petitionReview => 'Freigabe';

  @override
  String get petitionReviewHelp =>
      'Nur veröffentlichte Petitionen werden Nutzern angezeigt.';

  @override
  String get petitionRejectReason => 'Grund (nur für Admins sichtbar)';

  @override
  String get petitionStatus => 'Status der Petition';

  @override
  String get petitionStatusHelp =>
      'Aktualisiere ihn, wenn die Kampagne endet oder die Seite entfernt wird.';

  @override
  String get petitionFixFields => 'Fülle die rot markierten Felder aus.';

  @override
  String get petitionDeleteTitle => 'Diese Petition löschen?';

  @override
  String get petitionDeleteBody => 'Sie wird für alle aus der App entfernt.';

  @override
  String petitionAddedOn(String date) {
    return 'Hinzugefügt am $date';
  }

  @override
  String petitionPublishedOn(String date) {
    return 'Veröffentlicht am $date';
  }

  @override
  String petitionUpdatedOn(String date) {
    return 'Aktualisiert am $date';
  }
}
