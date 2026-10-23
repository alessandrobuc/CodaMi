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

  @override
  String get helpSupport => 'Aiuto e assistenza';

  @override
  String get helpSupportSubtitle => 'Scrivici in chat o invia una richiesta';

  @override
  String get supportIntroTitle => 'Come possiamo aiutarti?';

  @override
  String get supportIntroMessage =>
      'Il nostro team risponde qui nell\'app. Riceverai una notifica quando rispondiamo.';

  @override
  String get supportStartChat => 'Avvia una chat dal vivo';

  @override
  String get supportStartChatOnline => 'Un operatore è online ora';

  @override
  String get supportChatOffline =>
      'Nessun operatore è online in questo momento. Invia una richiesta e ti risponderemo il prima possibile.';

  @override
  String get supportSendRequest => 'Invia una richiesta';

  @override
  String get supportSendRequestSubtitle => 'Di solito rispondiamo entro 24 ore';

  @override
  String get supportMyRequests => 'Le mie richieste';

  @override
  String get supportNoRequests => 'Ancora nessuna richiesta';

  @override
  String get supportNoRequestsMessage =>
      'Le tue conversazioni con l\'assistenza appariranno qui.';

  @override
  String get supportNewChat => 'Nuova chat dal vivo';

  @override
  String get supportNewRequest => 'Nuova richiesta';

  @override
  String get supportCategory => 'Argomento';

  @override
  String get categoryAccount => 'Account e accesso';

  @override
  String get categoryListing => 'Un annuncio di smarrimento o ritrovamento';

  @override
  String get categoryApp => 'Problema con l\'app';

  @override
  String get categoryOther => 'Altro';

  @override
  String get supportSubject => 'Oggetto';

  @override
  String get supportSubjectHint => 'In poche parole';

  @override
  String get supportSubjectTooShort => 'Scrivi almeno 3 caratteri';

  @override
  String get supportMessage => 'Messaggio';

  @override
  String get supportMessageHint => 'Raccontaci cosa è successo';

  @override
  String get supportMessageRequired => 'Scrivi un messaggio';

  @override
  String get supportSend => 'Invia';

  @override
  String get supportTooManyOpen =>
      'Hai già 3 richieste aperte. Continua in una di queste.';

  @override
  String get supportTypeMessage => 'Scrivi un messaggio…';

  @override
  String get supportTeam => 'Assistenza CodaMi';

  @override
  String get supportMarkSolved => 'Segna come risolta';

  @override
  String get supportMarkSolvedConfirm =>
      'Segnare questa richiesta come risolta? Puoi scrivere di nuovo se hai ancora bisogno di aiuto.';

  @override
  String get supportClosedNote =>
      'Questa richiesta è chiusa. Aprine una nuova se hai bisogno di altro aiuto.';

  @override
  String get supportResolvedNote =>
      'Segnata come risolta. Se scrivi di nuovo verrà riaperta.';

  @override
  String get supportWaitingNote =>
      'Grazie! Il nostro team ti risponderà qui a breve.';

  @override
  String get kindChat => 'Chat dal vivo';

  @override
  String get kindTicket => 'Richiesta';

  @override
  String get caseStatusOpen => 'Aperta';

  @override
  String get caseStatusInProgress => 'In lavorazione';

  @override
  String get caseStatusWaitingUser => 'In attesa di risposta';

  @override
  String get caseStatusResolved => 'Risolta';

  @override
  String get caseStatusClosed => 'Chiusa';

  @override
  String get filterUnanswered => 'Senza risposta';

  @override
  String get filterUnassigned => 'Non assegnate';

  @override
  String get filterMine => 'Mie';

  @override
  String get filterActive => 'Attive';

  @override
  String get filterDone => 'Concluse';

  @override
  String get supportSearchHint => 'Cerca CM-1042 o email';

  @override
  String get supportNoCases => 'Nessuna richiesta qui';

  @override
  String get supportNoCasesMessage =>
      'Non c\'è nulla in attesa in questo elenco.';

  @override
  String get supportTake => 'Prendi in carico';

  @override
  String get supportTakeToReply =>
      'Prendi in carico la richiesta per rispondere.';

  @override
  String get supportAlreadyTaken =>
      'Un altro operatore ha già preso in carico questa richiesta.';

  @override
  String get supportUnassigned => 'Non assegnata';

  @override
  String get supportReassign => 'Riassegna';

  @override
  String get supportAssignTo => 'Assegna a';

  @override
  String get supportBackToQueue => 'Rimetti in coda';

  @override
  String get supportChangeStatus => 'Cambia stato';

  @override
  String get supportChat => 'Chat';

  @override
  String get supportTimeline => 'Cronologia';

  @override
  String get supportDetails => 'Dettagli';

  @override
  String supportWaitingFor(String time) {
    return 'In attesa da $time';
  }

  @override
  String get supportOverdue => 'Risposta in ritardo';

  @override
  String get supportOpened => 'Aperta';

  @override
  String get supportTakenOver => 'Presa in carico';

  @override
  String get supportWaitToTake => 'Attesa prima della presa in carico';

  @override
  String get supportFirstReply => 'Prima risposta';

  @override
  String get supportAvgReply => 'Tempo medio di risposta';

  @override
  String get supportHandlingTime => 'Tempo dedicato';

  @override
  String get supportResolvedAt => 'Risolta';

  @override
  String get supportMessagesCount => 'Messaggi';

  @override
  String get supportOperator => 'Operatore';

  @override
  String get supportUserLabel => 'Utente';

  @override
  String eventCreated(String name) {
    return 'Aperta da $name';
  }

  @override
  String eventTaken(String name) {
    return 'Presa in carico da $name';
  }

  @override
  String eventReassigned(String from, String to) {
    return 'Riassegnata da $from a $to';
  }

  @override
  String eventStatus(String name, String status) {
    return '$name ha impostato lo stato su $status';
  }

  @override
  String get eventReopened => 'Riaperta dall\'utente';

  @override
  String get eventOverdue => 'Nessuna risposta entro il tempo limite';

  @override
  String get eventAutoClosed => 'Chiusa automaticamente';

  @override
  String get presenceOnline => 'Online';

  @override
  String get presenceAway => 'Assente';

  @override
  String get presenceOffline => 'Offline';

  @override
  String get presenceAvailable => 'Disponibile per la chat';

  @override
  String get presenceAvailableSubtitle =>
      'Gli utenti possono avviare una chat quando un operatore è online';

  @override
  String get supportOperators => 'Operatori';

  @override
  String get supportOperatorsSubtitle =>
      'Attività, richieste e tempi di risposta';

  @override
  String get operatorOpenCases => 'Richieste aperte';

  @override
  String get operatorTaken => 'Prese in carico';

  @override
  String get operatorResolved => 'Risolte';

  @override
  String get operatorReplies => 'Risposte';

  @override
  String get operatorAvgHandling => 'Tempo medio per richiesta';

  @override
  String operatorLastActive(String time) {
    return 'Ultima attività $time';
  }

  @override
  String get operatorCases => 'Richieste';

  @override
  String get noOperators =>
      'Ancora nessun operatore. Aggiungili in Staff di assistenza.';

  @override
  String get statUnassigned => 'Richieste non assegnate';

  @override
  String get statUnanswered => 'Richieste senza risposta';

  @override
  String get statOverdue => 'Risposte in ritardo';

  @override
  String get alertSupportTitle => 'Risposte dell\'assistenza';

  @override
  String get alertSupportDescription => 'Quando l\'assistenza CodaMi ti scrive';

  @override
  String durationSeconds(int n) {
    return '$n s';
  }

  @override
  String durationMinutes(int n) {
    return '$n min';
  }

  @override
  String durationHours(int h, int m) {
    return '$h h $m min';
  }

  @override
  String durationDays(int d, int h) {
    return '$d g $h h';
  }

  @override
  String get searchUsersHint => 'Cerca per nome o email';

  @override
  String get searchTooShort => 'Scrivi almeno 2 caratteri';

  @override
  String get pickStaffTitle => 'Scegli un utente';

  @override
  String get pickStaffHint =>
      'Tocca una persona per aggiungerla al team di assistenza.';

  @override
  String makeStaffTitle(String name) {
    return 'Rendere $name parte dell\'assistenza?';
  }

  @override
  String get makeStaffMessage =>
      'Vedrà la sezione di amministrazione e potrà rispondere a richieste e chat. Puoi rimuoverlo in qualsiasi momento.';

  @override
  String get makeStaff => 'Aggiungi al team';

  @override
  String get supportStaffSwitch => 'Staff di assistenza';

  @override
  String get supportStaffSwitchSubtitle => 'Può rispondere a richieste e chat';

  @override
  String staffRemoved(String name) {
    return '$name non fa più parte del team di assistenza.';
  }

  @override
  String get removeStaffCasesNote => 'Le sue richieste aperte tornano in coda.';

  @override
  String get pushOpen => 'Apri';

  @override
  String get chatToday => 'Oggi';

  @override
  String get chatLoadEarlier => 'Carica messaggi precedenti';

  @override
  String get supportPeople => 'Persone';

  @override
  String get supportTimes => 'Tempi';

  @override
  String get supportRequestInfo => 'Richiesta';

  @override
  String get supportType => 'Tipo';

  @override
  String get supportResolve => 'Segna come risolta';

  @override
  String ticketsWaiting(int count) {
    return '$count in attesa di risposta';
  }

  @override
  String get ticketsAllClear => 'Tutto in ordine';

  @override
  String get photoReviewHint =>
      'Foto bloccate dall\'IA. Restano nascoste finché non decidi tu.';

  @override
  String get reasonAdult => 'Nudità o contenuti sessuali';

  @override
  String get reasonRacy => 'Contenuti provocanti';

  @override
  String get reasonViolence => 'Violenza o sangue';

  @override
  String get likelihoodPossible => 'Possibile';

  @override
  String get likelihoodLikely => 'Probabile';

  @override
  String get likelihoodVeryLikely => 'Molto probabile';

  @override
  String get hiddenByAi => 'Nascosta dall\'IA';

  @override
  String get petPhoto => 'Foto dell\'animale';

  @override
  String get listingPhoto => 'Foto dell\'annuncio';

  @override
  String uploadedBy(String name) {
    return 'Di $name';
  }

  @override
  String get tapToView => 'Tocca per vedere';

  @override
  String get approvePhoto => 'Approva';

  @override
  String get removePhotoTitle => 'Rimuovere questa foto?';

  @override
  String get removePhotoMessage =>
      'Verrà rimossa dall\'animale o dall\'annuncio dell\'utente, che riceverà una spiegazione.';

  @override
  String get photoApproved => 'Foto approvata';

  @override
  String get photoRemovedDone => 'Foto rimossa';

  @override
  String get photoUnderReview =>
      'Il nostro team sta controllando una foto, che resta nascosta fino ad allora.';

  @override
  String get reportedTabPhotos => 'Foto IA';

  @override
  String get reportedTabReports => 'Segnalazioni';

  @override
  String get noPhotosToReview => 'Nessuna foto da controllare';

  @override
  String get noPhotosToReviewMessage =>
      'Qui compariranno le foto bloccate dall\'IA.';

  @override
  String get aFriend => 'Un amico';

  @override
  String get addContact => 'Aggiungi contatto';

  @override
  String get addTestContacts => 'Aggiungi contatti di prova';

  @override
  String get adjustPoints => 'Modifica punti';

  @override
  String get adjustPointsAmount => 'Punti da aggiungere o togliere';

  @override
  String get adjustPointsAmountHelp =>
      'Usa il segno meno per togliere punti, es. -20';

  @override
  String get adjustPointsInvalid => 'Inserisci un numero di punti e un motivo.';

  @override
  String get adjustPointsReason => 'Motivo (visibile all\'utente)';

  @override
  String get adminContactsSubtitle =>
      'Veterinari, associazioni e servizi mostrati agli utenti';

  @override
  String get adminEmergenciesSubtitle => 'Emergenze animali segnalate';

  @override
  String get alertEmergencyDescription =>
      'Animali che hanno bisogno di aiuto urgente vicino alla tua città';

  @override
  String get alertEmergencyTitle => 'Emergenze vicine';

  @override
  String get allContacts => 'Tutti';

  @override
  String get ambassadorLevels => 'Livelli ambasciatore';

  @override
  String get call112 => 'Chiama il 112';

  @override
  String get claim => 'Riscatta';

  @override
  String get claimed => 'Riscattato';

  @override
  String get codeCopied => 'Codice copiato';

  @override
  String get confirm => 'Conferma';

  @override
  String get contactActive => 'Visibile agli utenti';

  @override
  String get contactActiveHelp =>
      'Disattiva per nascondere il contatto senza eliminarlo.';

  @override
  String get contactAddress => 'Indirizzo';

  @override
  String get contactAreaKm => 'Zona coperta (km)';

  @override
  String get contactAreaKmHelp =>
      'Fino a che distanza dall\'indirizzo può intervenire. Lascia vuoto per usare il valore predefinito delle impostazioni emergenze.';

  @override
  String get contactCity => 'Comune';

  @override
  String get contactHandles => 'Emergenze che gestisce';

  @override
  String get contactHandlesHelp =>
      'Lascia tutto disattivato se gestisce ogni tipo.';

  @override
  String get contactHoursHint => 'Orari, es. Lun–Ven 9:00–18:00';

  @override
  String get contactInactive => 'Nascosto';

  @override
  String get contactKindAssociation =>
      'Associazione per la tutela degli animali';

  @override
  String get contactKindOther => 'Altro servizio';

  @override
  String get contactKindPublicService => 'Servizio veterinario pubblico';

  @override
  String get contactKindVet => 'Veterinario';

  @override
  String get contactMissingFields =>
      'Aggiungi un nome e posiziona il segnaposto sulla mappa.';

  @override
  String get contactName => 'Nome';

  @override
  String get contactNameHint => 'es. Clinica Veterinaria San Francesco';

  @override
  String get contactPhones => 'Numeri di telefono';

  @override
  String get contactPhonesHint => 'Separa i numeri con una virgola';

  @override
  String get contactPlace => 'Dove si trova';

  @override
  String get contactRecommendedHelp =>
      'Mostrato prima dei contatti più vicini quando viene segnalata un\'emergenza.';

  @override
  String get contactTestHelp =>
      'Segnaposto per i test. Mostrato con l\'etichetta PROVA, mai verificato né contattato via email.';

  @override
  String get contactType => 'Tipo';

  @override
  String get contactVerifiedHelp =>
      'Solo dopo che l\'organizzazione ha accettato di comparire e i dati sono stati controllati.';

  @override
  String get copyCode => 'Copia';

  @override
  String get dailyActive => 'Attivo oggi';

  @override
  String get dailyCheckin => 'Check-in giornaliero';

  @override
  String get dailyRewards => 'Premi giornalieri';

  @override
  String get deleteContactTitle => 'Eliminare questo contatto?';

  @override
  String get directions => 'Indicazioni';

  @override
  String get editContact => 'Modifica contatto';

  @override
  String get emergencies => 'Emergenze';

  @override
  String get emergenciesActive => 'Attive';

  @override
  String get emergenciesAll => 'Tutte';

  @override
  String get emergenciesNearYou => 'Vicino a te';

  @override
  String get emergenciesSubtitle =>
      'Animali che hanno bisogno di aiuto urgente';

  @override
  String get emergencyAddPhotos => 'Aggiungi una foto';

  @override
  String get emergencyAddPhotosHint =>
      'Aiuta gli altri a trovare e riconoscere l\'animale';

  @override
  String get emergencyAllContacts => 'Vedi tutti i contatti di emergenza';

  @override
  String get emergencyAlreadyReported => 'L\'hai già segnalata.';

  @override
  String get emergencyCallReporter => 'Chiama chi l\'ha segnalata';

  @override
  String get emergencyClose => 'Chiudi';

  @override
  String get emergencyCloseTitle => 'Chiudere questa emergenza?';

  @override
  String get emergencyContacts => 'Contatti di emergenza';

  @override
  String get emergencyDetails => 'Cosa sta succedendo?';

  @override
  String get emergencyDetailsHint =>
      'es. Cane investito, sul ciglio della strada, respira ancora';

  @override
  String get emergencyDetailsRequired =>
      'Descrivi la situazione in poche parole.';

  @override
  String get emergencyDisclaimer =>
      'CodaMi non è un servizio di emergenza. Se un animale è in pericolo immediato, chiama prima il 112 o un veterinario. Non affidarti solo alle notifiche dell\'app.';

  @override
  String get emergencyFalseAlarmTitle => 'Segnare come falso allarme?';

  @override
  String get emergencyFindingContacts =>
      'Ricerca dei contatti vicino a questo luogo…';

  @override
  String get emergencyHelpDone =>
      'Grazie! Chi l\'ha segnalata è stato avvisato.';

  @override
  String get emergencyHelpMessage =>
      'Chi l\'ha segnalata saprà che qualcuno sta arrivando. Vai solo se è sicuro per te.';

  @override
  String get emergencyHelpTitle => 'Vai ad aiutare?';

  @override
  String get emergencyImHelping => 'Vado ad aiutare';

  @override
  String get emergencyMarkFalseAlarm => 'Segna come falso allarme';

  @override
  String get emergencyMarkResolved => 'Segna come risolta';

  @override
  String get emergencyMissingFields =>
      'Scegli cosa è successo e l\'animale, descrivi la situazione e posiziona il segnaposto.';

  @override
  String get emergencyNoContacts =>
      'Non ci sono ancora contatti per questa zona. Chiama il 112 o un veterinario.';

  @override
  String get emergencyPhoneHint =>
      'Visibile a chi vuole aiutare, così può chiamarti.';

  @override
  String get emergencyPinHint =>
      'Sposta la mappa per mettere il segnaposto dove si trova l\'animale.';

  @override
  String get emergencyPinned => 'Segnaposto posizionato';

  @override
  String get emergencyReopen => 'Riapri';

  @override
  String get emergencyReportFalse => 'Segnala come falsa';

  @override
  String get emergencyReportFalseDone =>
      'Grazie, il nostro team la controllerà.';

  @override
  String get emergencyReportFalseMessage =>
      'Il nostro team controllerà questa emergenza.';

  @override
  String get emergencyReportFalseTitle => 'Questa emergenza è falsa?';

  @override
  String get emergencyResolveTitle => 'Segnare come risolta?';

  @override
  String get emergencyResolved => 'Segnata come risolta';

  @override
  String get emergencySend => 'Invia emergenza';

  @override
  String get emergencySendFailed =>
      'Impossibile inviare l\'emergenza. Controlla la connessione e riprova, oppure chiama il 112.';

  @override
  String get emergencySending => 'Invio in corso…';

  @override
  String get emergencySent =>
      'Emergenza inviata. Le persone vicine stanno ricevendo l\'avviso. Puoi anche chiamare direttamente i contatti qui sotto.';

  @override
  String get emergencySettings => 'Impostazioni emergenze';

  @override
  String get emergencySettingsSubtitle =>
      'Distanze degli avvisi e ordine dei contatti';

  @override
  String get emergencyStatusClosed => 'Chiusa';

  @override
  String get emergencyStatusFalseAlarm => 'Falso allarme';

  @override
  String get emergencyStatusHelping => 'Aiuto in arrivo';

  @override
  String get emergencyStatusOpen => 'Serve aiuto';

  @override
  String get emergencyStatusResolved => 'Risolta';

  @override
  String get emergencySuggestedContacts => 'Chi può aiutare';

  @override
  String get emergencySuggestedContactsHint =>
      'Prima i contatti adatti più vicini. Chiamali direttamente.';

  @override
  String get emergencyTypeAbandoned => 'Animale abbandonato';

  @override
  String get emergencyTypeDanger => 'Animale in pericolo';

  @override
  String get emergencyTypeInjured => 'Animale ferito';

  @override
  String get emergencyTypeIntervention => 'Richiesta di intervento';

  @override
  String get emergencyTypeOther => 'Altra emergenza';

  @override
  String get emergencyTypeUrgentFound => 'Trovato, cure urgenti';

  @override
  String get emergencyUnavailable => 'Questa emergenza non è più disponibile.';

  @override
  String get emergencyWhatHappened => 'Cosa è successo?';

  @override
  String get emergencyWhere => 'Dove si trova l\'animale?';

  @override
  String get emergencyWhereHint =>
      'Il luogo esatto viene condiviso, così chi aiuta può trovare l\'animale.';

  @override
  String get emergencyYouAreHelping => 'Hai detto che vai ad aiutare. Grazie!';

  @override
  String get emergencyYourPhone => 'Il tuo telefono';

  @override
  String get flagBurst =>
      'Molti amici di questo utente sono diventati attivi nello stesso giorno';

  @override
  String get flagDeviceUsed =>
      'Questo telefono è già stato usato per un altro invito';

  @override
  String get flagSameDevice =>
      'Stesso telefono della persona che l\'ha invitato';

  @override
  String get haveInviteCode =>
      'Ti ha invitato un amico? Inserisci il suo codice';

  @override
  String get invitePromptTitle => 'Ti ha invitato un amico?';

  @override
  String get invitePromptBody =>
      'Inserisci il suo codice invito, così il tuo amico riceve il merito di averti portato su CodaMi.';

  @override
  String invitePromptLater(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'Puoi aggiungerlo anche più tardi in Profilo → Invita amici, entro $days giorni dalla registrazione.',
      one: 'Puoi aggiungerlo anche più tardi oggi in Profilo → Invita amici.',
    );
    return '$_temp0';
  }

  @override
  String get inviteCodeLabel => 'Codice invito';

  @override
  String get inviteCodeFromLink =>
      'Inserito dal tuo link di invito. Tocca Usa per confermare.';

  @override
  String get inviteCodeFormat =>
      'I codici invito hanno 6 lettere e numeri, ad esempio ABC234.';

  @override
  String get inviteCodeNotFound =>
      'Non abbiamo trovato questo codice. Controllalo con il tuo amico.';

  @override
  String get inviteCodeOwn =>
      'Questo è il tuo codice. Condividilo con i tuoi amici.';

  @override
  String inviteCodeTooLate(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'I codici invito si possono aggiungere solo nei primi $days giorni dalla registrazione.',
      one:
          'I codici invito si possono aggiungere solo il giorno della registrazione.',
    );
    return '$_temp0';
  }

  @override
  String get inviteCodeTooManyTries =>
      'Troppi codici sbagliati oggi. Riprova domani.';

  @override
  String get howInvitesWork => 'Come funziona';

  @override
  String get inviteApproved => 'Invito approvato';

  @override
  String get inviteCodeAlreadyUsed => 'Hai già usato un codice invito.';

  @override
  String get inviteCodeInvalid => 'Questo codice non è valido.';

  @override
  String get inviteCodeNotAllowed =>
      'Questo codice non si può usare: è il tuo codice, oppure è passato troppo tempo dalla registrazione.';

  @override
  String get inviteFriends => 'Invita amici';

  @override
  String get inviteFriendsSubtitle => 'Diventa ambasciatore di CodaMi';

  @override
  String get inviteIntro =>
      'Ogni nuovo utente di CodaMi è un paio d\'occhi in più per gli animali smarriti. Invita i tuoi amici e diventa ambasciatore di CodaMi.';

  @override
  String get inviteRejected => 'Invito rifiutato';

  @override
  String get inviteStatusExpired => 'Non è diventato attivo in tempo';

  @override
  String get inviteStatusPending => 'Iscritto, non ancora attivo';

  @override
  String get inviteStatusQualified => 'Attivo – punti ottenuti';

  @override
  String get inviteStatusRejected => 'Non conteggiato';

  @override
  String get inviteStatusReview => 'In verifica';

  @override
  String get inviteStep1 =>
      'Condividi il tuo codice. Il tuo amico lo inserisce in Profilo → Invita amici dopo la registrazione.';

  @override
  String get invitedFriends => 'Amici invitati (attivi)';

  @override
  String get invitesToReview => 'Inviti da controllare';

  @override
  String get invitesToReviewSubtitle =>
      'Inviti fermati dai controlli antifrode';

  @override
  String get levelAmbassador => 'Ambasciatore';

  @override
  String get levelBonus => 'Punti bonus';

  @override
  String get settingsActiveFriends => 'Amici attivi';

  @override
  String get levelChampion => 'Campione CodaMi';

  @override
  String get levelSuperAmbassador => 'Super Ambasciatore';

  @override
  String get levelSupporter => 'Sostenitore';

  @override
  String get myEmergencies => 'Le mie';

  @override
  String get myPoints => 'I miei punti';

  @override
  String get noActiveEmergencies => 'Nessuna emergenza';

  @override
  String get noEmergenciesMessage =>
      'Qui compaiono le emergenze segnalate vicino alla tua città.';

  @override
  String get noEmergenciesNearby => 'Nessuna emergenza vicino a te';

  @override
  String get noEmergencyContacts => 'Ancora nessun contatto';

  @override
  String get noEmergencyContactsAdmin =>
      'Aggiungi veterinari, associazioni e servizi, oppure aggiungi contatti di prova per provare la funzione.';

  @override
  String get noEmergencyContactsMessage =>
      'I contatti verranno aggiunti presto. In caso di emergenza, chiama il 112 o un veterinario.';

  @override
  String get noInvitesToReview => 'Niente da controllare';

  @override
  String get noInvitesToReviewMessage =>
      'Qui compaiono gli inviti sospetti. Nessuno viene rifiutato senza di te.';

  @override
  String get noInvitesYet =>
      'Ancora nessun invito. Condividi il tuo codice per iniziare.';

  @override
  String get noLevelYet => 'Ancora nessun livello';

  @override
  String get noMyEmergencies => 'Non hai segnalato emergenze';

  @override
  String get noPointsYet =>
      'Ancora nessun punto. Riscatta il premio giornaliero per iniziare.';

  @override
  String get open24h => 'Aperto 24 ore su 24';

  @override
  String get openMapFailed => 'Impossibile aprire la mappa.';

  @override
  String get photos => 'Foto';

  @override
  String get pointsAdjusted => 'Modificato da CodaMi';

  @override
  String get pointsDailyActive => 'Attivo oggi';

  @override
  String get pointsDailyCheckin => 'Check-in giornaliero';

  @override
  String get pointsFriendJoined => 'Un amico è diventato attivo';

  @override
  String get pointsHistory => 'Cronologia';

  @override
  String get pointsLevelBonus => 'Bonus nuovo livello';

  @override
  String get pointsOther => 'Punti';

  @override
  String get pointsSettings => 'Punti e premi';

  @override
  String get pointsSettingsIntro =>
      'Le modifiche valgono subito. I valori fuori limite vengono sostituiti da quelli predefiniti.';

  @override
  String get pointsSettingsSubtitle => 'Premi giornalieri, inviti e livelli';

  @override
  String get pointsStreakBonus => 'Bonus serie';

  @override
  String get pointsWelcome => 'Bonus di benvenuto';

  @override
  String get recommendedContact => 'Consigliato';

  @override
  String get reject => 'Rifiuta';

  @override
  String get reportEmergency => 'Segnala un\'emergenza';

  @override
  String get searchContacts => 'Cerca per nome o comune';

  @override
  String get settingsActiveMinutes => 'Minuti di utilizzo per “Attivo oggi”';

  @override
  String get settingsAlertsNearby => 'Avvisi alle persone vicine';

  @override
  String get settingsAutoCloseHours => 'Chiudi dopo (ore senza aggiornamenti)';

  @override
  String get settingsAutoCloseHoursHelp =>
      'Le emergenze aperte si chiudono da sole dopo questo tempo.';

  @override
  String get settingsCodeEntryDays =>
      'Giorni dopo la registrazione per inserire un codice';

  @override
  String get settingsContactsPriority => 'Priorità dei contatti';

  @override
  String get settingsDefaultAreaKm => 'Zona coperta predefinita (km)';

  @override
  String get settingsDefaultAreaKmHelp =>
      'Usata per i contatti senza una zona propria.';

  @override
  String get settingsEmailContacts => 'Avvisi via email ai contatti';

  @override
  String get settingsEmailContactsHelp =>
      'Invia un\'email ai contatti verificati. Prima va configurato il servizio email.';

  @override
  String get settingsMaxPerDay =>
      'Amici attivi al giorno prima di un controllo';

  @override
  String get settingsMaxPerDayHelp =>
      'Oltre questo numero in 24 ore l\'invito va in verifica.';

  @override
  String get settingsMaxRecipients => 'Numero massimo di persone avvisate';

  @override
  String get settingsMaxSuggested => 'Contatti suggeriti';

  @override
  String get settingsMinRecipients => 'Persone da raggiungere';

  @override
  String get settingsMinRecipientsHelp =>
      'Si passa al cerchio successivo finché non si raggiunge questo numero di persone.';

  @override
  String get settingsQualifyDays => 'Giorni di attività richiesti';

  @override
  String get settingsQualifyWithinDays => 'Entro (giorni dalla registrazione)';

  @override
  String get settingsReferralPoints => 'Punti per ogni amico attivo';

  @override
  String get settingsRings => 'Cerchi di avviso (km)';

  @override
  String get settingsRingsHelp =>
      'Separati da virgola, dal più piccolo, es. 5, 10, 25';

  @override
  String get settingsSaved => 'Salvato';

  @override
  String get settingsStreakDays => 'Giorni per il bonus serie';

  @override
  String get settingsWeight24h => 'Bonus per aperto 24 ore';

  @override
  String get settingsWeightHelp =>
      'I contatti ricevono questi bonus e perdono punti per ogni km di distanza. Viene prima il punteggio più alto.';

  @override
  String get settingsWeightPerKm => 'Penalità per km';

  @override
  String get settingsWeightPerKmHelp =>
      'Con 1, un contatto consigliato (20) viene prima di uno fino a 20 km più vicino.';

  @override
  String get settingsWeightRecommended => 'Bonus per consigliato';

  @override
  String get settingsWeightVerified => 'Bonus per verificato';

  @override
  String get settingsWelcomePoints => 'Punti per l\'amico invitato';

  @override
  String get settingsWelcomePointsHelp =>
      'Assegnati quando inserisce un codice. 0 li disattiva.';

  @override
  String get shareInvite => 'Condividi';

  @override
  String get statActiveEmergencies => 'Emergenze attive';

  @override
  String get testContactBadge => 'PROVA – non è un contatto reale';

  @override
  String get topLevelReached => 'Hai raggiunto il livello più alto. Grazie!';

  @override
  String get useCode => 'Usa';

  @override
  String get verifiedContact => 'Verificato';

  @override
  String get viewInvitee => 'Utente invitato';

  @override
  String get viewInviter => 'Chi ha invitato';

  @override
  String get yourInviteCode => 'Il tuo codice invito';

  @override
  String get yourInvites => 'I tuoi inviti';

  @override
  String get zeroTurnsOff => '0 lo disattiva';

  @override
  String activeProgress(int done, int total) {
    return '$done di $total minuti oggi';
  }

  @override
  String claimedPoints(int points) {
    return '+$points punti!';
  }

  @override
  String claimedWithBonus(int points, int bonus) {
    return '+$points punti e un bonus serie di +$bonus!';
  }

  @override
  String emergenciesNearYouCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count emergenze animali vicino a te',
      one: '1 emergenza animale vicino a te',
    );
    return '$_temp0';
  }

  @override
  String emergencyAlertedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count persone vicine sono state avvisate',
      one: '1 persona vicina è stata avvisata',
      zero: 'Nessuno nelle vicinanze ha ancora gli avvisi attivi',
    );
    return '$_temp0';
  }

  @override
  String emergencyFalseReports(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Segnalata come falsa $count volte',
      one: 'Segnalata come falsa una volta',
    );
    return '$_temp0';
  }

  @override
  String emergencyHelpersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count persone stanno andando ad aiutare',
      one: '1 persona sta andando ad aiutare',
    );
    return '$_temp0';
  }

  @override
  String inviteCodeAccepted(String name) {
    return 'Codice accettato. Ti ha invitato $name: benvenuto su CodaMi!';
  }

  @override
  String inviteShareText(String code, String link) {
    return 'Uso CodaMi per aiutare gli animali smarriti a tornare a casa. Unisciti con il mio codice invito $code: $link';
  }

  @override
  String inviteStep2(int days, int within) {
    return 'Imposta la sua città e usa l\'app in $days giorni diversi entro $within giorni dalla registrazione.';
  }

  @override
  String inviteStep3(int points) {
    return 'Ricevi $points punti e sali di livello come ambasciatore.';
  }

  @override
  String kmAway(String km) {
    return 'a $km km';
  }

  @override
  String levelFriends(String level) {
    return '$level: amici attivi';
  }

  @override
  String levelRule(String level, int friends, int bonus) {
    return '$level · $friends+ amici · +$bonus';
  }

  @override
  String nextLevelHint(int count, String level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ancora $count amici attivi per diventare $level',
      one: 'Ancora 1 amico attivo per diventare $level',
    );
    return '$_temp0';
  }

  @override
  String plusPoints(int points) {
    return '+$points punti';
  }

  @override
  String pointsTotal(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points punti',
      one: '1 punto',
    );
    return '$_temp0';
  }

  @override
  String streakLine(int streak, int days, int bonus) {
    return 'Serie di $streak giorni · bonus di +$bonus ogni $days giorni';
  }

  @override
  String get pointsFeedback => 'Feedback inviato';

  @override
  String get whatsNew => 'Novità';

  @override
  String get whatsNewSubtitle => 'Le modifiche di ogni versione';

  @override
  String get whatsNewTitle => 'Novità di CodaMi';

  @override
  String get whatsNewIntro =>
      'Ecco cosa è cambiato con l\'ultimo aggiornamento.';

  @override
  String whatsNewVersion(String version) {
    return 'Versione $version';
  }

  @override
  String get whatsNewSectionNew => 'Nuovo';

  @override
  String get whatsNewSectionImproved => 'Migliorato';

  @override
  String get whatsNewSectionFixed => 'Corretto';

  @override
  String get whatsNewEmpty => 'Ancora nessuna nota di aggiornamento.';

  @override
  String get whatsNewDone => 'Ho capito';

  @override
  String get feedbackTitle => 'Ti piace CodaMi?';

  @override
  String get feedbackBody =>
      'Il tuo feedback arriva direttamente al team di CodaMi e ci aiuta a migliorare l\'app.';

  @override
  String feedbackPointsOffer(int points) {
    return '+$points punti per il tuo primo feedback';
  }

  @override
  String get feedbackStarsHint => 'Tocca una stella per votare';

  @override
  String get feedbackCommentHint =>
      'Cosa ti piace o cosa si potrebbe migliorare? (facoltativo)';

  @override
  String get feedbackSend => 'Invia feedback';

  @override
  String get feedbackLater => 'Non ora';

  @override
  String get feedbackThanks => 'Grazie per il tuo feedback!';

  @override
  String feedbackThanksPoints(int points) {
    return 'Grazie per il tuo feedback! +$points punti';
  }

  @override
  String get feedbackAlreadyToday =>
      'Hai già inviato un feedback oggi. Potrai inviarne un altro domani.';

  @override
  String get sendFeedbackSubtitle => 'Di\' al team cosa ne pensi';

  @override
  String get rateCodaMi => 'Valuta CodaMi';

  @override
  String get rateCodaMiSubtitle => 'Lascia una recensione su Google Play';

  @override
  String get adminFeedback => 'Feedback';

  @override
  String get adminFeedbackSubtitle => 'Cosa pensano gli utenti dell\'app';

  @override
  String get adminFeedbackEmpty => 'Ancora nessun feedback.';

  @override
  String feedbackRatingsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count valutazioni',
      one: '1 valutazione',
    );
    return '$_temp0';
  }

  @override
  String get feedbackNoComment => 'Nessun commento';

  @override
  String get adminWhatsNewSubtitle =>
      'Note mostrate agli utenti dopo ogni aggiornamento';

  @override
  String get releaseAdd => 'Aggiungi versione';

  @override
  String get releaseEdit => 'Modifica note';

  @override
  String get releaseVersion => 'Numero di versione';

  @override
  String get releaseVersionHelp =>
      'Ad esempio 1.1.0. Deve corrispondere al nome della versione dell\'app nello store.';

  @override
  String get releaseVersionInvalid => 'Usa numeri e punti, ad esempio 1.1.0.';

  @override
  String get releaseVersionExists => 'Questa versione ha già delle note.';

  @override
  String get releasePublishedHelp =>
      'Gli utenti vedono solo le note pubblicate.';

  @override
  String get releaseDraft => 'Bozza';

  @override
  String get releaseLinesHelp => 'Una modifica per riga.';

  @override
  String get releaseLanguageHelp =>
      'Le lingue lasciate vuote mostrano le note in inglese.';

  @override
  String get releaseEnglishRequired =>
      'Scrivi prima le note in inglese: le altre lingue usano quelle come riserva.';

  @override
  String get releaseDeleteTitle => 'Eliminare queste note?';

  @override
  String releaseDeleteBody(String version) {
    return 'Le note della versione $version verranno rimosse per tutti.';
  }

  @override
  String get releaseNone =>
      'Ancora nessuna versione. Aggiungi le note del prossimo aggiornamento.';

  @override
  String releaseThisApp(String version) {
    return 'Questa app: versione $version';
  }

  @override
  String get feedbackAndReviews => 'Feedback e recensioni';

  @override
  String get settingsFeedbackPoints => 'Punti per il primo feedback';

  @override
  String get settingsFeedbackAfterDays =>
      'Giorni dalla registrazione prima di chiedere un feedback';

  @override
  String get settingsReviewActiveDays => 'Giorni di utilizzo prima di chiedere';

  @override
  String get settingsReviewAfterDays =>
      'Giorni dalla registrazione prima della finestra di valutazione dello store';

  @override
  String get settingsReviewEveryDays =>
      'Giorni tra una richiesta di valutazione dello store e l\'altra';

  @override
  String get settingsReviewHelp =>
      'La finestra di valutazione dello store non dà mai punti: Google Play e l\'App Store non lo consentono.';
}
