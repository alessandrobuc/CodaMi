// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get navHome => 'Home';

  @override
  String get navPets => 'Animali';

  @override
  String get navProfile => 'Profilo';

  @override
  String get cancel => 'Annulla';

  @override
  String get delete => 'Elimina';

  @override
  String get notSet => 'Non impostata';

  @override
  String get soon => 'Presto';

  @override
  String comingSoon(String feature) {
    return '$feature arriverà presto.';
  }

  @override
  String get profileTitle => 'Profilo';

  @override
  String get myPets => 'I miei animali';

  @override
  String get myReports => 'Le mie segnalazioni';

  @override
  String get homeCity => 'Città';

  @override
  String get notifications => 'Notifiche';

  @override
  String get chooseLanguage => 'Scegli la lingua';

  @override
  String get language => 'Lingua';

  @override
  String get signOut => 'Esci';

  @override
  String get signOutTitle => 'Vuoi uscire?';

  @override
  String get signOutMessage => 'Puoi accedere di nuovo in qualsiasi momento.';

  @override
  String get deleteAccount => 'Elimina account';

  @override
  String get deleteAccountTitle => 'Eliminare il tuo account?';

  @override
  String get deleteAccountMessage =>
      'Verranno eliminati per sempre il tuo profilo, i tuoi animali, le tue segnalazioni e le relative foto. L\'operazione non può essere annullata.';

  @override
  String get deletingAccount => 'Eliminazione dell\'account in corso…';

  @override
  String get myReportsSubtitle => 'Tieni aggiornate le tue segnalazioni.';

  @override
  String get statTotal => 'Totale';

  @override
  String postedOn(String date) {
    return 'Pubblicata il $date';
  }

  @override
  String get reportActive => 'Attive';

  @override
  String get reportResolved => 'Risolte';

  @override
  String get myReportsLoadError => 'Impossibile caricare le tue segnalazioni';

  @override
  String get checkConnection => 'Controlla la connessione e riprova.';

  @override
  String get noActiveReports => 'Nessuna segnalazione attiva';

  @override
  String get noActiveReportsMessage =>
      'Qui troverai le segnalazioni che pubblichi per animali smarriti o trovati.';

  @override
  String get reportAPet => 'Segnala un animale';

  @override
  String get nothingResolved => 'Ancora nessuna segnalazione risolta';

  @override
  String get nothingResolvedMessage =>
      'Quando segni una segnalazione come risolta, comparirà qui.';

  @override
  String get markAsFound => 'Segna come ritrovato';

  @override
  String get returnedToOwner => 'Restituito al proprietario';

  @override
  String get backHome => 'Tornato a casa';

  @override
  String get reunited => 'Riunito';

  @override
  String get deleteReport => 'Elimina segnalazione';

  @override
  String resolveLostTitle(String petName) {
    return '$petName è tornato a casa?';
  }

  @override
  String get resolveFoundTitle => 'Hai trovato il proprietario?';

  @override
  String resolveLostMessage(String petName) {
    return 'La segnalazione passerà in \"Tornati a casa\" nella scheda Trovati, così i vicini sapranno che $petName è al sicuro.';
  }

  @override
  String get resolveFoundMessage =>
      'La segnalazione passerà in \"Riuniti\" nella scheda Trovati.';

  @override
  String get notYet => 'Non ancora';

  @override
  String get yesResolved => 'Sì, risolto';

  @override
  String get reportResolvedSuccess =>
      'Che bella notizia! Segnalazione risolta.';

  @override
  String get deleteReportTitle => 'Eliminare questa segnalazione?';

  @override
  String deleteOpenReportMessage(String petName) {
    return 'Sparirà dalla mappa e dagli elenchi. Se $petName è al sicuro, segna invece la segnalazione come risolta, così i vicini lo sapranno.';
  }

  @override
  String get deleteResolvedReportMessage =>
      'Verrà rimossa dalla mappa e dall\'elenco \"Tornati a casa\".';

  @override
  String get reportDeleted => 'Segnalazione eliminata.';

  @override
  String get onboarding1Title => 'Ogni animale merita\ndi ';

  @override
  String get onboarding1Highlight => 'tornare a casa';

  @override
  String get onboarding1Body =>
      'CodaMi unisce i vicini perché cani e gatti smarriti ritrovino la strada verso chi li ama.';

  @override
  String get onboarding2Title => 'Segnala un animale\nin ';

  @override
  String get onboarding2Highlight => 'pochi secondi';

  @override
  String get onboarding2Body =>
      'Scatta una foto, indica il luogo e pubblica la segnalazione di smarrimento o ritrovamento. Chi è vicino la vede subito.';

  @override
  String get onboarding3Title => 'Guarda chi è\n';

  @override
  String get onboarding3Highlight => 'vicino a te';

  @override
  String get onboarding3Body =>
      'Animali smarriti e trovati intorno a te, in tempo reale su un\'unica mappa, così sai sempre dove cercare.';

  @override
  String get skip => 'Salta';

  @override
  String get getStarted => 'Inizia';

  @override
  String get lost => 'Smarrito';

  @override
  String get found => 'Trovato';

  @override
  String get you => 'Tu';

  @override
  String get published => 'Pubblicata';

  @override
  String get onboardingSampleBreed => 'Golden Retriever · 3 anni';

  @override
  String get onboardingSamplePlace => 'Milano · 2 h fa';

  @override
  String get validationNameRequired => 'Inserisci il tuo nome';

  @override
  String get validationNameTooShort => 'Il nome deve avere almeno 2 caratteri';

  @override
  String get validationNameTooLong => 'Il nome deve avere meno di 50 caratteri';

  @override
  String get validationNameInvalid =>
      'Il nome può contenere solo lettere, spazi, trattini e apostrofi';

  @override
  String get validationEmailRequired => 'Inserisci la tua email';

  @override
  String get validationEmailInvalid => 'Inserisci un indirizzo email valido';

  @override
  String get validationPasswordRequired => 'Inserisci la password';

  @override
  String get validationPasswordTooShort =>
      'La password deve avere almeno 8 caratteri';

  @override
  String get validationConfirmRequired => 'Conferma la password';

  @override
  String get validationPasswordsDontMatch => 'Le password non coincidono';

  @override
  String get spamNote =>
      'Non trovi l\'email per reimpostare la password? Controlla la cartella Spam o Posta indesiderata: a volte finisce lì.';

  @override
  String get logIn => 'Accedi';

  @override
  String get signUp => 'Registrati';

  @override
  String get authResetSentTitle => 'Controlla la posta';

  @override
  String get authResetSentSubtitle =>
      'Ti abbiamo inviato un link per reimpostare la password.';

  @override
  String get authLoginTitle => 'Bentornato!';

  @override
  String get authLoginSubtitle =>
      'Accedi per continuare ad aiutare gli animali a tornare a casa.';

  @override
  String get authSignupTitle => 'Unisciti al branco';

  @override
  String get authSignupSubtitle => 'Crea un account e aiuta il tuo quartiere.';

  @override
  String get authForgotTitle => 'Password dimenticata?';

  @override
  String get authForgotSubtitle =>
      'Nessun problema, ti inviamo un link via email per reimpostarla.';

  @override
  String get fullName => 'Nome e cognome';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Conferma password';

  @override
  String get forgotPassword => 'Password dimenticata?';

  @override
  String get createAccount => 'Crea account';

  @override
  String get sendResetLink => 'Invia link';

  @override
  String get or => 'oppure';

  @override
  String get continueWithGoogle => 'Continua con Google';

  @override
  String get continueWithApple => 'Continua con Apple';

  @override
  String get resetLinkSentTo => 'Abbiamo inviato un link a';

  @override
  String get backToLogIn => 'Torna all\'accesso';

  @override
  String get sendAgain => 'Non l\'hai ricevuta? Invia di nuovo';

  @override
  String get errorOffline => 'Sei offline. Controlla la connessione e riprova.';

  @override
  String get errorSessionExpired => 'La sessione è scaduta. Accedi di nuovo.';

  @override
  String get deleteAccountFailed =>
      'Impossibile eliminare l\'account. Riprova.';

  @override
  String get authErrorGeneric => 'Qualcosa è andato storto. Riprova.';

  @override
  String get authErrorDisabled => 'Questo account è stato disattivato.';

  @override
  String get authErrorWrongCredentials => 'Email o password errate.';

  @override
  String get authErrorEmailInUse =>
      'Esiste già un account con questa email. Prova ad accedere.';

  @override
  String get authErrorTooManyRequests =>
      'Troppi tentativi. Attendi un momento e riprova.';

  @override
  String get citySearchFailed => 'Ricerca della città non riuscita. Riprova.';

  @override
  String get placeSearchFailed => 'Ricerca del luogo non riuscita. Riprova.';

  @override
  String get placeOutsideCity =>
      'Quel luogo è fuori dalla tua città. Scegline uno in città.';

  @override
  String get placeNotFound =>
      'Non abbiamo trovato quel luogo. Scegline un altro.';

  @override
  String get citySearchOffline =>
      'Impossibile raggiungere la ricerca delle città. Controlla la connessione e riprova.';

  @override
  String get searchCityHint => 'Cerca la tua città, es. Milano';

  @override
  String noCitiesFound(String query) {
    return 'Nessuna città trovata per \"$query\".';
  }

  @override
  String homeCityUpdated(String city) {
    return 'Città aggiornata: $city.';
  }

  @override
  String get saveCityFailed => 'Impossibile salvare la città. Riprova.';

  @override
  String get citySetupTitle => 'Dove ';

  @override
  String get citySetupHighlight => 'ti trovi?';

  @override
  String get cityEditTitle => 'Cambia la tua ';

  @override
  String get cityEditHighlight => 'città';

  @override
  String get citySetupBody =>
      'Scegli la tua città: ti mostreremo gli animali smarriti e trovati vicino a te e ti avviseremo quando un animale scompare nella tua zona.';

  @override
  String get saveCity => 'Salva città';

  @override
  String get continueLabel => 'Continua';

  @override
  String get notYouSignOut => 'Non sei tu? Esci';

  @override
  String greeting(String name) {
    return 'Ciao, $name!';
  }

  @override
  String get showPetsWithin => 'Mostra animali entro';

  @override
  String distanceFrom(String city) {
    return 'Distanza da $city';
  }

  @override
  String get everywhere => 'Ovunque';

  @override
  String distanceKm(int km) {
    return '$km km';
  }

  @override
  String withinKm(int km) {
    return 'entro $km km';
  }

  @override
  String get areaNotSet => 'Zona non ancora impostata';

  @override
  String get reportPetSemantics => 'Segnala un animale smarrito o trovato';

  @override
  String get map => 'Mappa';

  @override
  String get locationServicesOff =>
      'Attiva la localizzazione per usare la tua posizione.';

  @override
  String get locationPermissionDenied =>
      'Consenti l\'accesso alla posizione nelle Impostazioni per usare la tua posizione.';

  @override
  String get locationFailed =>
      'Impossibile rilevare la tua posizione. Riprova.';

  @override
  String get back => 'Indietro';

  @override
  String get fullScreen => 'Schermo intero';

  @override
  String get loadingPets => 'Caricamento animali…';

  @override
  String get mapLoadFailed =>
      'Impossibile caricare le segnalazioni. Controlla la connessione.';

  @override
  String get mapNoLost => 'Nessun animale smarrito in questa zona';

  @override
  String get mapNoFound => 'Nessun animale trovato in questa zona';

  @override
  String get mapNoPets => 'Nessun animale smarrito o trovato in questa zona';

  @override
  String get zoomIn => 'Ingrandisci';

  @override
  String get zoomOut => 'Riduci';

  @override
  String get myLocation => 'La mia posizione';

  @override
  String get myCity => 'La mia città';

  @override
  String get all => 'Tutti';

  @override
  String get timeJustNow => 'Adesso';

  @override
  String timeMinutesAgo(int minutes) {
    return '$minutes min fa';
  }

  @override
  String timeHoursAgo(int hours) {
    return '$hours h fa';
  }

  @override
  String get timeYesterday => 'Ieri';

  @override
  String timeDaysAgo(int days) {
    return '$days giorni fa';
  }

  @override
  String notifLostTitle(String city) {
    return 'Animale smarrito a $city';
  }

  @override
  String notifLostBodyNear(String pet, String street, String city) {
    return '$pet è stato visto l\'ultima volta vicino a $street, $city. Tieni gli occhi aperti!';
  }

  @override
  String notifLostBodyIn(String pet, String city) {
    return '$pet è stato visto l\'ultima volta a $city. Tieni gli occhi aperti!';
  }

  @override
  String notifFoundTitle(String city) {
    return 'Animale trovato a $city';
  }

  @override
  String notifFoundBodyNear(String pet, String street, String city) {
    return '$pet è stato trovato vicino a $street, $city. Conosci il proprietario?';
  }

  @override
  String notifFoundBodyIn(String pet, String city) {
    return '$pet è stato trovato a $city. Conosci il proprietario?';
  }

  @override
  String notifBackHomeTitle(String pet) {
    return '$pet è tornato a casa';
  }

  @override
  String notifBackHomeBody(String pet, String city) {
    return 'Buone notizie da $city: $pet è stato ritrovato. Grazie per l\'aiuto!';
  }

  @override
  String notifReunitedTitle(String pet) {
    return '$pet è di nuovo con la sua famiglia';
  }

  @override
  String notifReunitedBody(String city) {
    return 'L\'animale trovato a $city è tornato dalla sua famiglia.';
  }

  @override
  String get notificationsTitle => 'Notifiche';

  @override
  String get markAllRead => 'Segna tutte come lette';

  @override
  String get notificationsLoadError => 'Impossibile caricare le notifiche';

  @override
  String get allCaughtUp => 'Sei aggiornato';

  @override
  String get notificationsEmpty =>
      'Ti avviseremo quando un animale viene smarrito o trovato nella tua città.';

  @override
  String get notificationsNew => 'Nuove';

  @override
  String get notificationsEarlier => 'Precedenti';

  @override
  String get reportNotAvailable => 'Segnalazione non disponibile';

  @override
  String get reportRemoved =>
      'Questa segnalazione è stata rimossa dal suo autore.';

  @override
  String get reportsLoadError => 'Impossibile caricare le segnalazioni';

  @override
  String get pullToRetry =>
      'Controlla la connessione e trascina verso il basso per riprovare.';

  @override
  String get noLostNearby => 'Nessun animale smarrito qui vicino';

  @override
  String get noLostNearbyMessage =>
      'Buone notizie! Nessuno ha ancora segnalato un animale smarrito nella tua zona.';

  @override
  String get noFoundYet => 'Ancora nessun animale trovato';

  @override
  String get noFoundYetMessage =>
      'Gli animali trovati dai tuoi vicini compariranno qui.';

  @override
  String get backHomeSection => 'Tornati a casa';

  @override
  String get backHomeSectionSubtitle =>
      'Animali che hanno ritrovato la strada verso la loro famiglia.';

  @override
  String get loadMore => 'Carica altri';

  @override
  String get speciesDog => 'Cane';

  @override
  String get speciesCat => 'Gatto';

  @override
  String get speciesOther => 'Altro';

  @override
  String get sexMale => 'Maschio';

  @override
  String get sexFemale => 'Femmina';

  @override
  String get sexUnknown => 'Non so';

  @override
  String nearPlace(String street, String city) {
    return 'Vicino a $street, $city';
  }

  @override
  String get callFailed => 'Impossibile avviare la chiamata.';

  @override
  String get whatsappFailed => 'Impossibile aprire WhatsApp.';

  @override
  String get emailFailed => 'Impossibile aprire l\'app email.';

  @override
  String whatsappMessageLost(String pet) {
    return 'Ciao! Ti contatto per l\'animale smarrito \"$pet\" su CodaMi.';
  }

  @override
  String whatsappMessageFound(String pet) {
    return 'Ciao! Ti contatto per l\'animale trovato \"$pet\" su CodaMi.';
  }

  @override
  String emailSubjectLost(String pet) {
    return 'Riguardo a $pet (animale smarrito su CodaMi)';
  }

  @override
  String emailSubjectFound(String pet) {
    return 'Riguardo a $pet (animale trovato su CodaMi)';
  }

  @override
  String shareTitleLost(String pet) {
    return 'ANIMALE SMARRITO: $pet';
  }

  @override
  String shareTitleFound(String pet) {
    return 'ANIMALE TROVATO: $pet';
  }

  @override
  String get shareFooter =>
      'Hai visto questo animale? Apri CodaMi per metterti in contatto.';

  @override
  String get lastSeen => 'Visto l\'ultima volta';

  @override
  String get foundAt => 'Trovato a';

  @override
  String areaAbout(int meters) {
    return 'zona di circa $meters m';
  }

  @override
  String get when => 'Quando';

  @override
  String get postedBy => 'Pubblicato da';

  @override
  String get description => 'Descrizione';

  @override
  String get call => 'Chiama';

  @override
  String contactTitleLost(String pet) {
    return 'Hai visto $pet? Mettiti in contatto';
  }

  @override
  String get contactTitleFound => 'È il tuo animale? Mettiti in contatto';

  @override
  String get noContactShared => 'Non sono stati condivisi contatti.';

  @override
  String resolvedThanksLost(String pet) {
    return '$pet è tornato a casa. Grazie per aver usato CodaMi!';
  }

  @override
  String get resolvedThanksFound =>
      'Questo animale è tornato dalla sua famiglia. Grazie per l\'aiuto!';

  @override
  String get yourContactDetails => 'I tuoi contatti';

  @override
  String markPetAsFound(String pet) {
    return 'Segna $pet come ritrovato';
  }

  @override
  String get markReturnedToOwner => 'Segna come restituito al proprietario';

  @override
  String get copiedToClipboard => 'Copiato negli appunti.';

  @override
  String get petSaveFailed => 'Impossibile salvare l\'animale. Riprova.';

  @override
  String get petDeleteFailed => 'Impossibile eliminare l\'animale. Riprova.';

  @override
  String get errorPermission => 'Non hai il permesso di farlo.';

  @override
  String get storageNotReady =>
      'L\'archivio foto non è ancora pronto. Riprova più tardi.';

  @override
  String get storageFull =>
      'L\'archivio è pieno in questo momento. Riprova più tardi.';

  @override
  String petAdded(String name) {
    return '$name è stato aggiunto ai tuoi animali.';
  }

  @override
  String get petsLoadError => 'Impossibile caricare i tuoi animali';

  @override
  String get noPetsYet => 'Ancora nessun animale';

  @override
  String get noPetsYetMessage =>
      'Aggiungi ora i tuoi animali, così potrai segnalarli in pochi secondi se dovessero smarrirsi.';

  @override
  String get addFirstPet => 'Aggiungi il tuo primo animale';

  @override
  String get petsHeaderEmpty =>
      'Tieni pronti i profili dei tuoi animali, non si sa mai.';

  @override
  String petsHeaderCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count amici a quattro zampe, pronti per ogni evenienza.',
      one: '1 amico a quattro zampe, pronto per ogni evenienza.',
    );
    return '$_temp0';
  }

  @override
  String get addPet => 'Aggiungi';

  @override
  String petUpdated(String name) {
    return '$name è stato aggiornato.';
  }

  @override
  String removePetTitle(String name) {
    return 'Rimuovere $name?';
  }

  @override
  String get removePetMessage =>
      'Verranno eliminati il profilo e le sue foto. L\'operazione non può essere annullata.';

  @override
  String get remove => 'Rimuovi';

  @override
  String petRemoved(String name) {
    return '$name è stato rimosso.';
  }

  @override
  String get breed => 'Razza';

  @override
  String get color => 'Colore';

  @override
  String get age => 'Età';

  @override
  String get sex => 'Sesso';

  @override
  String petAddedOn(String date) {
    return 'Aggiunto il $date';
  }

  @override
  String get distinctiveFeatures => 'Segni particolari';

  @override
  String ifPetGoesMissing(String name) {
    return 'Se $name dovesse smarrirsi';
  }

  @override
  String get ifPetGoesMissingBody =>
      'Pubblica una segnalazione di smarrimento con questo profilo in pochi secondi e i vicini verranno avvisati.';

  @override
  String reportPetAsLost(String name) {
    return 'Segnala $name come smarrito';
  }

  @override
  String get colorBlack => 'Nero';

  @override
  String get colorWhite => 'Bianco';

  @override
  String get colorBrown => 'Marrone';

  @override
  String get colorGolden => 'Dorato';

  @override
  String get colorGrey => 'Grigio';

  @override
  String get colorCream => 'Crema';

  @override
  String get colorGinger => 'Rosso';

  @override
  String get petPhotoRequired => 'Aggiungi almeno una foto del tuo animale.';

  @override
  String get petSpeciesRequired =>
      'Indica se il tuo animale è un cane, un gatto o altro.';

  @override
  String get checkHighlightedFields => 'Controlla i campi evidenziati.';

  @override
  String get signInToSave => 'Accedi di nuovo per salvare.';

  @override
  String get discardChangesTitle => 'Annullare le modifiche?';

  @override
  String get discardPetChanges =>
      'Le modifiche a questo animale andranno perse.';

  @override
  String get keepEditing => 'Continua a modificare';

  @override
  String get discard => 'Annulla modifiche';

  @override
  String editPetTitle(String name) {
    return 'Modifica $name';
  }

  @override
  String get newPet => 'Nuovo animale';

  @override
  String get whatKindOfPet => 'Che animale è?';

  @override
  String get name => 'Nome';

  @override
  String get petNameHint => 'es. Luna';

  @override
  String get petNameRequired => 'Inserisci il nome del tuo animale';

  @override
  String get petNameTooLong => 'Il nome deve avere meno di 40 caratteri';

  @override
  String get breedHint => 'es. Golden Retriever, Meticcio';

  @override
  String get colorHint => 'es. Dorato con petto bianco';

  @override
  String get ageHint => 'es. 3 anni, 8 mesi';

  @override
  String get featuresHint =>
      'Collare, microchip, cicatrici, macchie… tutto ciò che aiuta a riconoscere il tuo animale.';

  @override
  String get saveChanges => 'Salva modifiche';

  @override
  String get savePet => 'Salva animale';

  @override
  String get cameraPermission =>
      'Consenti l\'accesso alla fotocamera nelle Impostazioni.';

  @override
  String get photosPermission =>
      'Consenti l\'accesso alle foto nelle Impostazioni.';

  @override
  String get cameraFailed => 'Impossibile aprire la fotocamera.';

  @override
  String get galleryFailed => 'Impossibile aprire la galleria.';

  @override
  String get optional => 'Facoltativo';

  @override
  String get addPetPhotos => 'Aggiungi foto del tuo animale';

  @override
  String get addPetPhotosHint => 'Foto chiare e recenti aiutano a riconoscerlo';

  @override
  String get photoRequired => 'Serve almeno una foto';

  @override
  String get tapToMakeCover => 'Tocca una foto per renderla la copertina.';

  @override
  String get cover => 'Copertina';

  @override
  String uploadingPhotos(int percent) {
    return 'Caricamento foto… $percent%';
  }

  @override
  String get saving => 'Salvataggio…';

  @override
  String get takePhoto => 'Scatta una foto';

  @override
  String get useCamera => 'Usa la fotocamera';

  @override
  String get chooseFromGallery => 'Scegli dalla galleria';

  @override
  String get pickExistingPhoto => 'Scegli una foto esistente';

  @override
  String get yourPet => 'il tuo animale';

  @override
  String get unknownDog => 'Cane sconosciuto';

  @override
  String get unknownCat => 'Gatto sconosciuto';

  @override
  String get unknownPet => 'Animale sconosciuto';

  @override
  String get errorChooseType => 'Indica se hai smarrito o trovato un animale.';

  @override
  String get errorPickPet => 'Scegli l\'animale smarrito.';

  @override
  String get errorFoundPhoto => 'Aggiungi almeno una foto dell\'animale.';

  @override
  String get errorFoundSpecies => 'È un cane, un gatto o altro?';

  @override
  String get errorChooseCity => 'Scegli la città in cui è successo.';

  @override
  String get errorFutureDate => 'La data non può essere nel futuro.';

  @override
  String get errorDescriptionShort =>
      'Aggiungi una breve descrizione (almeno 10 caratteri).';

  @override
  String get errorContactRequired =>
      'Aggiungi un numero di telefono o un\'email per essere contattato.';

  @override
  String get errorPhoneInvalid => 'Inserisci un numero di telefono valido.';

  @override
  String get discardReportTitle => 'Annullare questa segnalazione?';

  @override
  String get discardReportMessage =>
      'Quello che hai inserito finora andrà perso.';

  @override
  String get signInToPublish => 'Accedi di nuovo per pubblicare.';

  @override
  String publishedLost(String pet) {
    return '$pet ora è sulla mappa. Speriamo che torni presto a casa.';
  }

  @override
  String publishedFound(String pet) {
    return 'Grazie! $pet ora è sulla mappa.';
  }

  @override
  String get reportLostPetTitle => 'Segnala un animale smarrito';

  @override
  String get reportFoundPetTitle => 'Segnala un animale trovato';

  @override
  String get newReport => 'Nuova segnalazione';

  @override
  String stepOf(int current, int total) {
    return '$current di $total';
  }

  @override
  String get publishReport => 'Pubblica segnalazione';

  @override
  String get stepTypeTitle => 'Cosa è successo?';

  @override
  String get stepTypeSubtitle =>
      'Facciamo girare subito la voce tra chi è vicino.';

  @override
  String get stepFoundPetTitle => 'Parlaci dell\'animale';

  @override
  String get stepFoundPetSubtitle =>
      'Una foto chiara è il modo più veloce perché il proprietario lo riconosca.';

  @override
  String get addFoundPhotos => 'Aggiungi foto dell\'animale';

  @override
  String get addFoundPhotosHint =>
      'Scattane una ora o scegline una dalla galleria';

  @override
  String get whatKindOfAnimal => 'Che animale è?';

  @override
  String get collarName => 'Nome sul collare o sulla medaglietta';

  @override
  String get collarNameHint => 'Lascia vuoto se non lo sai';

  @override
  String get stepLostPetTitle => 'Quale animale si è smarrito?';

  @override
  String get stepLostPetSubtitle =>
      'Useremo il suo profilo e le sue foto, così non dovrai riscrivere nulla.';

  @override
  String get stepWhereFoundTitle => 'Dove l\'hai trovato?';

  @override
  String stepWhereLostTitle(String pet) {
    return 'Dove è stato visto $pet l\'ultima volta?';
  }

  @override
  String get stepWhereSubtitle =>
      'Scegli la città, poi indica il punto sulla mappa. Gli altri vedono solo una zona di circa 100 m, mai l\'indirizzo esatto.';

  @override
  String get streetOrLandmark => 'Via o punto di riferimento';

  @override
  String get pinExactSpot => 'Indica il punto esatto';

  @override
  String spotHintFound(String pet) {
    return 'Sposta la mappa finché il segnaposto è dove hai trovato $pet.';
  }

  @override
  String spotHintLost(String pet) {
    return 'Sposta la mappa finché il segnaposto è dove $pet è stato visto l\'ultima volta.';
  }

  @override
  String spotFarFromCity(int km, String city) {
    return 'Questo punto è a $km km da $city. La città è giusta?';
  }

  @override
  String spotPinned(int meters) {
    return 'Fatto. Gli altri vedono solo una zona di circa $meters m intorno, mai il punto esatto.';
  }

  @override
  String get timeHourAgo => '1 ora fa';

  @override
  String get timeThisMorning => 'Stamattina';

  @override
  String get stepWhenFoundTitle => 'Quando l\'hai trovato?';

  @override
  String stepWhenLostTitle(String pet) {
    return 'Quando hai visto $pet l\'ultima volta?';
  }

  @override
  String get stepWhenSubtitle => 'Va bene anche un orario approssimativo.';

  @override
  String get changeDate => 'Cambia data';

  @override
  String get changeTime => 'Cambia ora';

  @override
  String get stepDetailsTitle => 'C\'è altro da sapere?';

  @override
  String get stepDetailsSubtitle =>
      'I dettagli aiutano i vicini a riconoscere l\'animale e a contattarti in fretta.';

  @override
  String descriptionHintLost(String pet) {
    return 'Colore del collare, carattere, come si è smarrito $pet…';
  }

  @override
  String get descriptionHintFound =>
      'Condizioni, collare, comportamento, dove l\'hai trovato esattamente…';

  @override
  String get howToReachYou => 'Come possono contattarti?';

  @override
  String get contactPrivacyNote =>
      'Visibile solo nella pagina della segnalazione, mai negli elenchi.';

  @override
  String get phoneHint => 'Telefono, es. +39 333 123 4567';

  @override
  String get reachableOnWhatsapp => 'Disponibile su WhatsApp';

  @override
  String get reachableOnWhatsappHint =>
      'Le persone possono scriverti a questo numero';

  @override
  String get stepReviewTitle => 'Pronto per pubblicare?';

  @override
  String get stepReviewSubtitle =>
      'Ecco come vedranno la tua segnalazione le persone vicine.';

  @override
  String get iLostMyPet => 'Ho smarrito il mio animale';

  @override
  String get iFoundAPet => 'Ho trovato un animale';

  @override
  String get iLostMyPetHint =>
      'Avvisa chi è vicino e fatti aiutare nella ricerca.';

  @override
  String get iFoundAPetHint => 'Aiuta un animale smarrito a tornare a casa.';

  @override
  String get addAPet => 'Aggiungi un animale';

  @override
  String get pleaseChooseCity => 'Scegli una città';

  @override
  String noPlacesFound(String city, String query) {
    return 'Nessun luogo trovato a $city per \"$query\".';
  }

  @override
  String searchStreetHint(String city) {
    return 'Cerca a $city, es. Via Dante';
  }

  @override
  String get yourCity => 'la tua città';

  @override
  String get useMyLocation => 'Usa la mia posizione';

  @override
  String get publishFailed =>
      'Impossibile pubblicare la segnalazione. Riprova.';

  @override
  String get updateReportFailed =>
      'Impossibile aggiornare la segnalazione. Riprova.';

  @override
  String get deleteReportFailed =>
      'Impossibile eliminare la segnalazione. Riprova.';

  @override
  String get privacyPolicy => 'Informativa sulla privacy';

  @override
  String get termsOfUse => 'Termini di utilizzo';

  @override
  String legalLastUpdated(String date) {
    return 'Ultimo aggiornamento: $date';
  }

  @override
  String get deleteAccountPasswordPrompt =>
      'Inserisci la password per confermare.';

  @override
  String deleteAccountTypeConfirm(String word) {
    return 'Scrivi $word per confermare.';
  }

  @override
  String get wrongPassword => 'Password errata. Riprova.';

  @override
  String get confirmPasswordAgain =>
      'Per sicurezza, conferma di nuovo la password.';

  @override
  String get contactUs => 'Contattaci';

  @override
  String get legalQuestions => 'Domande su questo documento o sui tuoi dati?';

  @override
  String get languageChangeLater =>
      'Puoi cambiarla quando vuoi dal tuo profilo.';

  @override
  String get reward => 'Ricompensa';

  @override
  String get rewardHint => 'Importo in euro';

  @override
  String get rewardNote =>
      'La ricompensa è un accordo privato tra il proprietario e chi trova l\'animale. CodaMi non garantisce né gestisce alcun pagamento.';

  @override
  String rewardAmount(String amount) {
    return 'Ricompensa $amount';
  }

  @override
  String get adminPanel => 'Pannello admin';

  @override
  String get roleAdmin => 'Amministratore';

  @override
  String get roleSupport => 'Supporto';

  @override
  String get supportStaff => 'Team di supporto';

  @override
  String get supportStaffSubtitle =>
      'Le persone che rispondono alle richieste di supporto';

  @override
  String get adminUsers => 'Utenti';

  @override
  String get adminListings => 'Annunci';

  @override
  String get adminReportedContent => 'Contenuti segnalati';

  @override
  String get adminTickets => 'Richieste di supporto';

  @override
  String get adminVideos => 'Video';

  @override
  String get addSupportStaff => 'Aggiungi al supporto';

  @override
  String get addSupportStaffHint =>
      'Inserisci l\'email di un account CodaMi esistente.';

  @override
  String get userNotFound => 'Nessun account CodaMi usa questa email.';

  @override
  String get alreadyStaff => 'Questa persona fa già parte del team.';

  @override
  String staffAdded(String name) {
    return '$name ora fa parte del team di supporto.';
  }

  @override
  String removeStaffTitle(String name) {
    return 'Rimuovere $name?';
  }

  @override
  String get removeStaffMessage => 'Non avrà più accesso al pannello admin.';

  @override
  String get noSupportStaff => 'Ancora nessuno nel team di supporto.';

  @override
  String get add => 'Aggiungi';

  @override
  String get actionFailed => 'Qualcosa è andato storto. Riprova.';

  @override
  String get adminDashboard => 'Dashboard';

  @override
  String get adminMore => 'Altro';

  @override
  String get adminReportedShort => 'Segnalati';

  @override
  String get adminTicketsShort => 'Richieste';

  @override
  String get adminSectionSoon => 'Questa sezione arriverà presto.';

  @override
  String get statUsers => 'Utenti registrati';

  @override
  String get statOpenLost => 'Smarriti aperti';

  @override
  String get statOpenFound => 'Ritrovati aperti';

  @override
  String get statBackHome => 'Animali tornati a casa';

  @override
  String get flagListing => 'Segnala annuncio';

  @override
  String get flagTitle => 'Perché segnali questo annuncio?';

  @override
  String get flagHint =>
      'Il nostro team lo controllerà. Il proprietario non saprà chi l\'ha segnalato.';

  @override
  String get flagReasonSpam => 'Spam o pubblicità';

  @override
  String get flagReasonScam => 'Truffa o frode';

  @override
  String get flagReasonInappropriate => 'Contenuto inappropriato';

  @override
  String get flagReasonWrongInfo => 'Informazioni false o ingannevoli';

  @override
  String get flagReasonOther => 'Altro';

  @override
  String get flagNoteHint => 'Aggiungi dettagli (facoltativo)';

  @override
  String get flagSubmit => 'Invia segnalazione';

  @override
  String get flagSent => 'Grazie. Il nostro team controllerà questo annuncio.';

  @override
  String get alreadyFlagged => 'Hai già segnalato questo annuncio.';

  @override
  String blockUser(String name) {
    return 'Blocca $name';
  }

  @override
  String blockUserTitle(String name) {
    return 'Bloccare $name?';
  }

  @override
  String get blockUserMessage =>
      'Non vedrai più i suoi annunci né riceverai avvisi su di essi. Puoi sbloccarlo in Profilo → Utenti bloccati.';

  @override
  String get block => 'Blocca';

  @override
  String userBlocked(String name) {
    return '$name è stato bloccato.';
  }

  @override
  String get blockedUsers => 'Utenti bloccati';

  @override
  String get noBlockedUsers => 'Non hai bloccato nessuno.';

  @override
  String get unblock => 'Sblocca';

  @override
  String userUnblocked(String name) {
    return '$name è stato sbloccato.';
  }

  @override
  String get unknownUser => 'Utente sconosciuto';

  @override
  String get hiddenListing => 'Nascosto';

  @override
  String get hiddenListingNotice =>
      'Questo annuncio è stato nascosto dal team di CodaMi e non è più pubblico.';

  @override
  String get moderation => 'Moderazione';

  @override
  String get noFlagsOnListing => 'Nessuno ha segnalato questo annuncio.';

  @override
  String flagCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Segnalato $count volte',
      one: 'Segnalato una volta',
    );
    return '$_temp0';
  }

  @override
  String get dismissFlags => 'Ignora segnalazioni';

  @override
  String get flagsDismissed => 'Segnalazioni ignorate.';

  @override
  String get hideListing => 'Nascondi annuncio';

  @override
  String get restoreListing => 'Ripristina annuncio';

  @override
  String get listingHidden =>
      'Annuncio nascosto. Solo il proprietario può ancora vederlo.';

  @override
  String get listingRestored => 'Annuncio ripristinato.';

  @override
  String get deleteListing => 'Elimina annuncio';

  @override
  String get deleteListingTitle => 'Eliminare questo annuncio?';

  @override
  String get deleteListingMessage =>
      'L\'annuncio e le sue foto vengono eliminati per tutti. L\'azione non può essere annullata.';

  @override
  String get listingDeleted => 'Annuncio eliminato.';

  @override
  String get listingUnavailable => 'Annuncio non più disponibile';

  @override
  String get noReportedContent => 'Nessuna segnalazione';

  @override
  String get noReportedContentMessage =>
      'Gli annunci segnalati dagli utenti appariranno qui.';

  @override
  String get filterOpen => 'Aperti';

  @override
  String get filterResolved => 'Risolti';

  @override
  String get filterHidden => 'Nascosti';

  @override
  String get noListings => 'Nessun annuncio';

  @override
  String get tryAnotherFilter => 'Prova un altro filtro.';

  @override
  String get adminUsersSubtitle => 'Visualizza, disattiva o elimina account';

  @override
  String get searchByEmail => 'Cerca per email';

  @override
  String get noUsersFound => 'Nessun utente trovato.';

  @override
  String get roleUser => 'Utente';

  @override
  String get userDisabled => 'Disattivato';

  @override
  String get phone => 'Telefono';

  @override
  String get memberSince => 'Iscritto dal';

  @override
  String get disableAccount => 'Disattiva account';

  @override
  String get enableAccount => 'Riattiva account';

  @override
  String disableUserTitle(String name) {
    return 'Disattivare l\'account di $name?';
  }

  @override
  String get disableUserMessage =>
      'Verrà disconnesso e non potrà accedere. I suoi annunci aperti resteranno nascosti finché l\'account non sarà riattivato.';

  @override
  String get accountDisabled => 'Account disattivato.';

  @override
  String get accountEnabled => 'Account riattivato.';

  @override
  String deleteUserTitle(String name) {
    return 'Eliminare l\'account di $name?';
  }

  @override
  String get deleteUserMessage =>
      'Elimina definitivamente profilo, animali, annunci e foto. L\'azione non può essere annullata.';

  @override
  String get userDeleted => 'Account eliminato.';

  @override
  String get save => 'Salva';

  @override
  String get requiredField => 'Obbligatorio';

  @override
  String get notificationSettingsIntro =>
      'Scegli quali avvisi ricevere e dai a ognuno un suono diverso, così capisci cosa è successo prima ancora di guardare.';

  @override
  String get notificationSound => 'Suono';

  @override
  String get alertLostTitle => 'Animali smarriti vicino a te';

  @override
  String get alertLostDescription =>
      'Quando un animale si smarrisce nella tua città';

  @override
  String get alertFoundTitle => 'Animali trovati vicino a te';

  @override
  String get alertFoundDescription =>
      'Quando qualcuno trova un animale nella tua città';

  @override
  String get alertResolvedTitle => 'Lieto fine';

  @override
  String get alertResolvedDescription =>
      'Quando un animale smarrito o trovato torna a casa';

  @override
  String get soundDefault => 'Predefinito del telefono';

  @override
  String get soundSilent => 'Silenzioso';

  @override
  String get soundChime => 'Rintocco';

  @override
  String get soundBell => 'Campana';

  @override
  String get soundBright => 'Brillante';

  @override
  String get soundSoft => 'Delicato';

  @override
  String get soundCustom => 'Suono personalizzato';

  @override
  String get soundFromPhone => 'Suonerie e toni del telefono';

  @override
  String get soundFromFile => 'Musica o file audio';

  @override
  String get soundIosNote =>
      'Su iPhone i suoni delle notifiche devono provenire dall\'app: scegli uno dei suoni qui sopra.';

  @override
  String get soundPickFailed =>
      'Impossibile usare questo suono. Prova con un altro.';

  @override
  String get videosForYou => 'Video per te';

  @override
  String get videosForYourPets => 'Scelti per i tuoi animali';

  @override
  String get videosGeneral => 'Benessere animale e cura responsabile';

  @override
  String get videosShuffle => 'Mostra altri video';

  @override
  String get videoMotivational => 'Motivazione';

  @override
  String get videoEducational => 'Impara';

  @override
  String get videoTagGeneral => 'Per tutti';

  @override
  String get videoLoadError =>
      'Al momento non è possibile riprodurre il video. Riprova più tardi.';

  @override
  String get adminVideosSubtitle => 'Carica e gestisci i video';

  @override
  String get addVideo => 'Aggiungi video';

  @override
  String get editVideo => 'Modifica video';

  @override
  String get noVideosYet =>
      'Ancora nessun video. Aggiungi il primo con il pulsante qui sotto.';

  @override
  String get deleteVideoTitle => 'Eliminare questo video?';

  @override
  String get deleteVideoMessage =>
      'Verrà rimosso dall\'app per tutti. L\'azione non può essere annullata.';

  @override
  String get videoHidden => 'Nascosto';

  @override
  String get allLanguages => 'Tutte le lingue';

  @override
  String get chooseVideo => 'Scegli un video';

  @override
  String get chooseVideoHint =>
      'Dalla galleria, fino a 200 MB. I video brevi (meno di 2 minuti) funzionano meglio.';

  @override
  String get videoTitle => 'Titolo';

  @override
  String get videoType => 'Tipo';

  @override
  String get videoAnimals => 'Animali';

  @override
  String get videoAnimalsHint =>
      'Scegli gli animali di cui parla il video. Scegli \"Per tutti\" per i video generali mostrati a tutti.';

  @override
  String get videoVisible => 'Visibile nell\'app';

  @override
  String get videoVisibleHint =>
      'I video nascosti sono visibili solo agli amministratori.';

  @override
  String get videoTooLarge =>
      'Il video supera i 200 MB. Scegline uno più breve.';

  @override
  String get videoSaved => 'Video salvato.';

  @override
  String uploadingProgress(int percent) {
    return 'Caricamento… $percent%';
  }

  @override
  String get navVideos => 'Video';

  @override
  String get videosEmptyTitle => 'I video stanno arrivando';

  @override
  String get videosEmptyMessage =>
      'Presto qui troverai brevi video su come prenderti cura dei tuoi animali.';

  @override
  String get moreVideos => 'Altri video';

  @override
  String get videoWatched => 'Visto';

  @override
  String get videoBack10 => 'Indietro di 10 secondi';

  @override
  String get videoForward10 => 'Avanti di 10 secondi';

  @override
  String get videoFullscreen => 'Schermo intero';

  @override
  String get videoExitFullscreen => 'Esci da schermo intero';

  @override
  String get videoRetry => 'Riprova';

  @override
  String get videoDeleted => 'Video eliminato.';

  @override
  String get noVideosYetTitle => 'Ancora nessun video';

  @override
  String get videoVisibleShort => 'Visibili';

  @override
  String get play => 'Riproduci';

  @override
  String get edit => 'Modifica';

  @override
  String get change => 'Cambia';

  @override
  String get videoSectionFile => 'Video';

  @override
  String get videoSectionDetails => 'Dettagli';

  @override
  String get videoSectionAudience => 'Chi lo vede';

  @override
  String get videoCover => 'Copertina';

  @override
  String get videoCoverHint => 'Facoltativa. Appare sulla scheda del video.';

  @override
  String get videoMotivationalHint => 'Storie che ispirano e momenti felici';

  @override
  String get videoEducationalHint => 'Consigli e guide per chi ha animali';

  @override
  String get uploadVideo => 'Carica video';
}
