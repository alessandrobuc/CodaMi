// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get navHome => 'Accueil';

  @override
  String get navPets => 'Animaux';

  @override
  String get navProfile => 'Profil';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get notSet => 'Non définie';

  @override
  String get soon => 'Bientôt';

  @override
  String comingSoon(String feature) {
    return '$feature arrive bientôt.';
  }

  @override
  String get profileTitle => 'Profil';

  @override
  String get myPets => 'Mes animaux';

  @override
  String get myReports => 'Mes signalements';

  @override
  String get homeCity => 'Ville';

  @override
  String get notifications => 'Notifications';

  @override
  String get chooseLanguage => 'Choisissez votre langue';

  @override
  String get language => 'Langue';

  @override
  String get signOut => 'Se déconnecter';

  @override
  String get signOutTitle => 'Se déconnecter ?';

  @override
  String get signOutMessage => 'Vous pouvez vous reconnecter à tout moment.';

  @override
  String get deleteAccount => 'Supprimer le compte';

  @override
  String get deleteAccountTitle => 'Supprimer votre compte ?';

  @override
  String get deleteAccountMessage =>
      'Votre profil, vos animaux, vos signalements et leurs photos seront supprimés définitivement. Cette action est irréversible.';

  @override
  String get deletingAccount => 'Suppression du compte…';

  @override
  String get myReportsSubtitle => 'Gardez vos signalements à jour.';

  @override
  String get statTotal => 'Total';

  @override
  String postedOn(String date) {
    return 'Publié le $date';
  }

  @override
  String get reportActive => 'Actifs';

  @override
  String get reportResolved => 'Résolus';

  @override
  String get myReportsLoadError => 'Impossible de charger vos signalements';

  @override
  String get checkConnection => 'Vérifiez votre connexion et réessayez.';

  @override
  String get noActiveReports => 'Aucun signalement actif';

  @override
  String get noActiveReportsMessage =>
      'Les signalements que vous publiez pour des animaux perdus ou trouvés apparaîtront ici.';

  @override
  String get reportAPet => 'Signaler un animal';

  @override
  String get nothingResolved => 'Aucun signalement résolu pour l\'instant';

  @override
  String get nothingResolvedMessage =>
      'Quand vous marquez un signalement comme résolu, il apparaît ici.';

  @override
  String get markAsFound => 'Marquer comme retrouvé';

  @override
  String get returnedToOwner => 'Rendu à son propriétaire';

  @override
  String get backHome => 'De retour à la maison';

  @override
  String get reunited => 'Réuni';

  @override
  String get deleteReport => 'Supprimer le signalement';

  @override
  String resolveLostTitle(String petName) {
    return '$petName est rentré ?';
  }

  @override
  String get resolveFoundTitle => 'Avez-vous trouvé le propriétaire ?';

  @override
  String resolveLostMessage(String petName) {
    return 'Le signalement passera dans \"De retour à la maison\" de l\'onglet Trouvés, pour que les voisins sachent que $petName est en sécurité.';
  }

  @override
  String get resolveFoundMessage =>
      'Le signalement passera dans \"Réunis\" de l\'onglet Trouvés.';

  @override
  String get notYet => 'Pas encore';

  @override
  String get yesResolved => 'Oui, résolu';

  @override
  String get reportResolvedSuccess =>
      'Excellente nouvelle ! Signalement résolu.';

  @override
  String get deleteReportTitle => 'Supprimer ce signalement ?';

  @override
  String deleteOpenReportMessage(String petName) {
    return 'Il disparaîtra de la carte et des listes. Si $petName est en sécurité, marquez plutôt le signalement comme résolu pour prévenir les voisins.';
  }

  @override
  String get deleteResolvedReportMessage =>
      'Il sera retiré de la carte et de la liste \"De retour à la maison\".';

  @override
  String get reportDeleted => 'Signalement supprimé.';

  @override
  String get onboarding1Title => 'Chaque animal mérite\nde ';

  @override
  String get onboarding1Highlight => 'rentrer chez lui';

  @override
  String get onboarding1Body =>
      'CodaMi rassemble les voisins pour que les chiens et chats perdus retrouvent ceux qui les aiment.';

  @override
  String get onboarding2Title => 'Signalez un animal\nen ';

  @override
  String get onboarding2Highlight => 'quelques secondes';

  @override
  String get onboarding2Body =>
      'Prenez une photo, indiquez le lieu et publiez un signalement de perte ou de découverte. Tout le monde à proximité le voit aussitôt.';

  @override
  String get onboarding3Title => 'Voyez qui est\n';

  @override
  String get onboarding3Highlight => 'près de vous';

  @override
  String get onboarding3Body =>
      'Les animaux perdus et trouvés autour de vous, en direct sur une seule carte, pour toujours savoir où chercher.';

  @override
  String get skip => 'Passer';

  @override
  String get getStarted => 'Commencer';

  @override
  String get lost => 'Perdu';

  @override
  String get found => 'Trouvé';

  @override
  String get you => 'Vous';

  @override
  String get published => 'Publié';

  @override
  String get onboardingSampleBreed => 'Golden Retriever · 3 ans';

  @override
  String get onboardingSamplePlace => 'Milan · il y a 2 h';

  @override
  String get validationNameRequired => 'Saisissez votre nom';

  @override
  String get validationNameTooShort =>
      'Le nom doit contenir au moins 2 caractères';

  @override
  String get validationNameTooLong =>
      'Le nom doit contenir moins de 50 caractères';

  @override
  String get validationNameInvalid =>
      'Le nom ne peut contenir que des lettres, des espaces, des tirets et des apostrophes';

  @override
  String get validationEmailRequired => 'Saisissez votre e-mail';

  @override
  String get validationEmailInvalid => 'Saisissez une adresse e-mail valide';

  @override
  String get validationPasswordRequired => 'Saisissez votre mot de passe';

  @override
  String get validationPasswordTooShort =>
      'Le mot de passe doit contenir au moins 8 caractères';

  @override
  String get validationConfirmRequired => 'Confirmez votre mot de passe';

  @override
  String get validationPasswordsDontMatch =>
      'Les mots de passe ne correspondent pas';

  @override
  String get spamNote =>
      'Vous ne trouvez pas l\'e-mail de réinitialisation ? Vérifiez le dossier Spam ou Courrier indésirable, il y arrive parfois.';

  @override
  String get logIn => 'Connexion';

  @override
  String get signUp => 'Inscription';

  @override
  String get authResetSentTitle => 'Consultez votre boîte mail';

  @override
  String get authResetSentSubtitle =>
      'Nous vous avons envoyé un lien pour réinitialiser votre mot de passe.';

  @override
  String get authLoginTitle => 'Bon retour !';

  @override
  String get authLoginSubtitle =>
      'Connectez-vous pour continuer à aider les animaux à rentrer chez eux.';

  @override
  String get authSignupTitle => 'Rejoignez la meute';

  @override
  String get authSignupSubtitle => 'Créez un compte et aidez votre quartier.';

  @override
  String get authForgotTitle => 'Mot de passe oublié ?';

  @override
  String get authForgotSubtitle =>
      'Pas de souci, nous vous enverrons un lien de réinitialisation par e-mail.';

  @override
  String get fullName => 'Nom complet';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Mot de passe';

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get sendResetLink => 'Envoyer le lien';

  @override
  String get or => 'ou';

  @override
  String get continueWithGoogle => 'Continuer avec Google';

  @override
  String get continueWithApple => 'Continuer avec Apple';

  @override
  String get resetLinkSentTo => 'Nous avons envoyé un lien à';

  @override
  String get backToLogIn => 'Retour à la connexion';

  @override
  String get sendAgain => 'Rien reçu ? Renvoyer';

  @override
  String get errorOffline =>
      'Vous êtes hors ligne. Vérifiez votre connexion et réessayez.';

  @override
  String get errorSessionExpired => 'Votre session a expiré. Reconnectez-vous.';

  @override
  String get deleteAccountFailed =>
      'Impossible de supprimer votre compte. Réessayez.';

  @override
  String get authErrorGeneric => 'Une erreur s\'est produite. Réessayez.';

  @override
  String get authErrorDisabled => 'Ce compte a été désactivé.';

  @override
  String get authErrorWrongCredentials => 'E-mail ou mot de passe incorrect.';

  @override
  String get authErrorEmailInUse =>
      'Un compte existe déjà avec cet e-mail. Essayez de vous connecter.';

  @override
  String get authErrorTooManyRequests =>
      'Trop de tentatives. Patientez un instant et réessayez.';

  @override
  String get citySearchFailed => 'La recherche de ville a échoué. Réessayez.';

  @override
  String get placeSearchFailed => 'La recherche du lieu a échoué. Réessayez.';

  @override
  String get placeOutsideCity =>
      'Ce lieu est en dehors de votre ville. Choisissez-en un dans la ville.';

  @override
  String get placeNotFound =>
      'Nous n\'avons pas trouvé ce lieu. Choisissez-en un autre.';

  @override
  String get citySearchOffline =>
      'Impossible d\'accéder à la recherche de villes. Vérifiez votre connexion et réessayez.';

  @override
  String get searchCityHint => 'Cherchez votre ville, ex. Milan';

  @override
  String noCitiesFound(String query) {
    return 'Aucune ville trouvée pour \"$query\".';
  }

  @override
  String homeCityUpdated(String city) {
    return 'Ville mise à jour : $city.';
  }

  @override
  String get saveCityFailed =>
      'Impossible d\'enregistrer votre ville. Réessayez.';

  @override
  String get citySetupTitle => 'Où ';

  @override
  String get citySetupHighlight => 'êtes-vous ?';

  @override
  String get cityEditTitle => 'Changez de ';

  @override
  String get cityEditHighlight => 'ville';

  @override
  String get citySetupBody =>
      'Choisissez votre ville pour voir les animaux perdus et trouvés près de chez vous et être prévenu quand un animal disparaît dans votre quartier.';

  @override
  String get saveCity => 'Enregistrer la ville';

  @override
  String get continueLabel => 'Continuer';

  @override
  String get notYouSignOut => 'Ce n\'est pas vous ? Se déconnecter';

  @override
  String greeting(String name) {
    return 'Bonjour, $name !';
  }

  @override
  String get showPetsWithin => 'Afficher les animaux dans un rayon de';

  @override
  String distanceFrom(String city) {
    return 'Distance depuis $city';
  }

  @override
  String get everywhere => 'Partout';

  @override
  String distanceKm(int km) {
    return '$km km';
  }

  @override
  String withinKm(int km) {
    return 'à moins de $km km';
  }

  @override
  String get areaNotSet => 'Zone non définie';

  @override
  String get reportPetSemantics => 'Signaler un animal perdu ou trouvé';

  @override
  String get map => 'Carte';

  @override
  String get locationServicesOff =>
      'Activez la localisation pour utiliser votre position.';

  @override
  String get locationPermissionDenied =>
      'Autorisez l\'accès à la position dans les Réglages pour utiliser votre position.';

  @override
  String get locationFailed =>
      'Impossible d\'obtenir votre position. Réessayez.';

  @override
  String get back => 'Retour';

  @override
  String get fullScreen => 'Plein écran';

  @override
  String get loadingPets => 'Chargement des animaux…';

  @override
  String get mapLoadFailed =>
      'Impossible de charger les signalements. Vérifiez votre connexion.';

  @override
  String get mapNoLost => 'Aucun animal perdu dans cette zone';

  @override
  String get mapNoFound => 'Aucun animal trouvé dans cette zone';

  @override
  String get mapNoPets => 'Aucun animal perdu ou trouvé dans cette zone';

  @override
  String get zoomIn => 'Zoom avant';

  @override
  String get zoomOut => 'Zoom arrière';

  @override
  String get myLocation => 'Ma position';

  @override
  String get myCity => 'Ma ville';

  @override
  String get all => 'Tous';

  @override
  String get timeJustNow => 'À l\'instant';

  @override
  String timeMinutesAgo(int minutes) {
    return 'il y a $minutes min';
  }

  @override
  String timeHoursAgo(int hours) {
    return 'il y a $hours h';
  }

  @override
  String get timeYesterday => 'Hier';

  @override
  String timeDaysAgo(int days) {
    return 'il y a $days jours';
  }

  @override
  String notifLostTitle(String city) {
    return 'Animal perdu à $city';
  }

  @override
  String notifLostBodyNear(String pet, String street, String city) {
    return '$pet a été vu pour la dernière fois près de $street, $city. Ouvrez l\'œil !';
  }

  @override
  String notifLostBodyIn(String pet, String city) {
    return '$pet a été vu pour la dernière fois à $city. Ouvrez l\'œil !';
  }

  @override
  String notifFoundTitle(String city) {
    return 'Animal trouvé à $city';
  }

  @override
  String notifFoundBodyNear(String pet, String street, String city) {
    return '$pet a été trouvé près de $street, $city. Connaissez-vous son propriétaire ?';
  }

  @override
  String notifFoundBodyIn(String pet, String city) {
    return '$pet a été trouvé à $city. Connaissez-vous son propriétaire ?';
  }

  @override
  String notifBackHomeTitle(String pet) {
    return '$pet est rentré à la maison';
  }

  @override
  String notifBackHomeBody(String pet, String city) {
    return 'Bonne nouvelle de $city : $pet a été retrouvé. Merci pour votre aide !';
  }

  @override
  String notifReunitedTitle(String pet) {
    return '$pet a retrouvé sa famille';
  }

  @override
  String notifReunitedBody(String city) {
    return 'L\'animal trouvé à $city est de retour dans sa famille.';
  }

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get markAllRead => 'Tout marquer comme lu';

  @override
  String get notificationsLoadError =>
      'Impossible de charger les notifications';

  @override
  String get allCaughtUp => 'Vous êtes à jour';

  @override
  String get notificationsEmpty =>
      'Nous vous préviendrons quand un animal sera perdu ou trouvé dans votre ville.';

  @override
  String get notificationsNew => 'Nouvelles';

  @override
  String get notificationsEarlier => 'Plus anciennes';

  @override
  String get reportNotAvailable => 'Signalement indisponible';

  @override
  String get reportRemoved => 'Ce signalement a été supprimé par son auteur.';

  @override
  String get reportsLoadError => 'Impossible de charger les signalements';

  @override
  String get pullToRetry =>
      'Vérifiez votre connexion et tirez vers le bas pour réessayer.';

  @override
  String get noLostNearby => 'Aucun animal perdu à proximité';

  @override
  String get noLostNearbyMessage =>
      'Bonne nouvelle ! Personne n\'a signalé d\'animal perdu dans votre zone.';

  @override
  String get noFoundYet => 'Aucun animal trouvé pour l\'instant';

  @override
  String get noFoundYetMessage =>
      'Les animaux trouvés par vos voisins apparaîtront ici.';

  @override
  String get backHomeSection => 'De retour à la maison';

  @override
  String get backHomeSectionSubtitle =>
      'Des animaux qui ont retrouvé leur famille.';

  @override
  String get loadMore => 'Charger plus';

  @override
  String get speciesDog => 'Chien';

  @override
  String get speciesCat => 'Chat';

  @override
  String get speciesOther => 'Autre';

  @override
  String get sexMale => 'Mâle';

  @override
  String get sexFemale => 'Femelle';

  @override
  String get sexUnknown => 'Je ne sais pas';

  @override
  String nearPlace(String street, String city) {
    return 'Près de $street, $city';
  }

  @override
  String get callFailed => 'Impossible de lancer l\'appel.';

  @override
  String get whatsappFailed => 'Impossible d\'ouvrir WhatsApp.';

  @override
  String get emailFailed => 'Impossible d\'ouvrir votre app de messagerie.';

  @override
  String whatsappMessageLost(String pet) {
    return 'Bonjour ! Je vous contacte au sujet de l\'animal perdu \"$pet\" sur CodaMi.';
  }

  @override
  String whatsappMessageFound(String pet) {
    return 'Bonjour ! Je vous contacte au sujet de l\'animal trouvé \"$pet\" sur CodaMi.';
  }

  @override
  String emailSubjectLost(String pet) {
    return 'À propos de $pet (animal perdu sur CodaMi)';
  }

  @override
  String emailSubjectFound(String pet) {
    return 'À propos de $pet (animal trouvé sur CodaMi)';
  }

  @override
  String shareTitleLost(String pet) {
    return 'ANIMAL PERDU : $pet';
  }

  @override
  String shareTitleFound(String pet) {
    return 'ANIMAL TROUVÉ : $pet';
  }

  @override
  String get shareFooter =>
      'Vous avez vu cet animal ? Ouvrez CodaMi pour prendre contact.';

  @override
  String get lastSeen => 'Vu pour la dernière fois';

  @override
  String get foundAt => 'Trouvé à';

  @override
  String areaAbout(int meters) {
    return 'zone d\'environ $meters m';
  }

  @override
  String get when => 'Quand';

  @override
  String get postedBy => 'Publié par';

  @override
  String get description => 'Description';

  @override
  String get call => 'Appeler';

  @override
  String contactTitleLost(String pet) {
    return 'Vous avez vu $pet ? Prenez contact';
  }

  @override
  String get contactTitleFound => 'C\'est votre animal ? Prenez contact';

  @override
  String get noContactShared => 'Aucune coordonnée n\'a été partagée.';

  @override
  String resolvedThanksLost(String pet) {
    return '$pet est rentré à la maison. Merci d\'utiliser CodaMi !';
  }

  @override
  String get resolvedThanksFound =>
      'Cet animal a retrouvé sa famille. Merci pour votre aide !';

  @override
  String get yourContactDetails => 'Vos coordonnées';

  @override
  String markPetAsFound(String pet) {
    return 'Marquer $pet comme retrouvé';
  }

  @override
  String get markReturnedToOwner => 'Marquer comme rendu au propriétaire';

  @override
  String get copiedToClipboard => 'Copié dans le presse-papiers.';

  @override
  String get petSaveFailed =>
      'Impossible d\'enregistrer votre animal. Réessayez.';

  @override
  String get petDeleteFailed =>
      'Impossible de supprimer votre animal. Réessayez.';

  @override
  String get errorPermission =>
      'Vous n\'avez pas l\'autorisation de faire cela.';

  @override
  String get storageNotReady =>
      'Le stockage des photos n\'est pas encore prêt. Réessayez plus tard.';

  @override
  String get storageFull =>
      'Le stockage est plein pour le moment. Réessayez plus tard.';

  @override
  String petAdded(String name) {
    return '$name a été ajouté à vos animaux.';
  }

  @override
  String get petsLoadError => 'Impossible de charger vos animaux';

  @override
  String get noPetsYet => 'Aucun animal pour l\'instant';

  @override
  String get noPetsYetMessage =>
      'Ajoutez vos animaux maintenant pour pouvoir les signaler en quelques secondes s\'ils se perdent.';

  @override
  String get addFirstPet => 'Ajoutez votre premier animal';

  @override
  String get petsHeaderEmpty =>
      'Gardez les profils de vos animaux prêts, au cas où.';

  @override
  String petsHeaderCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count compagnons à quatre pattes, prêts en cas de besoin.',
      one: '1 compagnon à quatre pattes, prêt en cas de besoin.',
    );
    return '$_temp0';
  }

  @override
  String get addPet => 'Ajouter';

  @override
  String petUpdated(String name) {
    return '$name a été mis à jour.';
  }

  @override
  String removePetTitle(String name) {
    return 'Supprimer $name ?';
  }

  @override
  String get removePetMessage =>
      'Le profil et ses photos seront supprimés. Cette action est irréversible.';

  @override
  String get remove => 'Supprimer';

  @override
  String petRemoved(String name) {
    return '$name a été supprimé.';
  }

  @override
  String get breed => 'Race';

  @override
  String get color => 'Couleur';

  @override
  String get age => 'Âge';

  @override
  String get sex => 'Sexe';

  @override
  String petAddedOn(String date) {
    return 'Ajouté le $date';
  }

  @override
  String get distinctiveFeatures => 'Signes distinctifs';

  @override
  String ifPetGoesMissing(String name) {
    return 'Si $name se perd un jour';
  }

  @override
  String get ifPetGoesMissingBody =>
      'Publiez un signalement de perte avec ce profil en quelques secondes : les voisins seront prévenus.';

  @override
  String reportPetAsLost(String name) {
    return 'Signaler $name comme perdu';
  }

  @override
  String get colorBlack => 'Noir';

  @override
  String get colorWhite => 'Blanc';

  @override
  String get colorBrown => 'Marron';

  @override
  String get colorGolden => 'Doré';

  @override
  String get colorGrey => 'Gris';

  @override
  String get colorCream => 'Crème';

  @override
  String get colorGinger => 'Roux';

  @override
  String get petPhotoRequired => 'Ajoutez au moins une photo de votre animal.';

  @override
  String get petSpeciesRequired =>
      'Indiquez si votre animal est un chien, un chat ou autre.';

  @override
  String get checkHighlightedFields => 'Vérifiez les champs signalés.';

  @override
  String get signInToSave => 'Reconnectez-vous pour enregistrer.';

  @override
  String get discardChangesTitle => 'Abandonner les modifications ?';

  @override
  String get discardPetChanges =>
      'Les modifications de cet animal seront perdues.';

  @override
  String get keepEditing => 'Continuer';

  @override
  String get discard => 'Abandonner';

  @override
  String editPetTitle(String name) {
    return 'Modifier $name';
  }

  @override
  String get newPet => 'Nouvel animal';

  @override
  String get whatKindOfPet => 'Quel type d\'animal ?';

  @override
  String get name => 'Nom';

  @override
  String get petNameHint => 'ex. Luna';

  @override
  String get petNameRequired => 'Saisissez le nom de votre animal';

  @override
  String get petNameTooLong => 'Le nom doit contenir moins de 40 caractères';

  @override
  String get breedHint => 'ex. Golden Retriever, Croisé';

  @override
  String get colorHint => 'ex. Doré avec le poitrail blanc';

  @override
  String get ageHint => 'ex. 3 ans, 8 mois';

  @override
  String get featuresHint =>
      'Collier, puce, cicatrices, taches… tout ce qui aide à reconnaître votre animal.';

  @override
  String get saveChanges => 'Enregistrer';

  @override
  String get savePet => 'Enregistrer l\'animal';

  @override
  String get cameraPermission =>
      'Autorisez l\'accès à l\'appareil photo dans les Réglages.';

  @override
  String get photosPermission =>
      'Autorisez l\'accès aux photos dans les Réglages.';

  @override
  String get cameraFailed => 'Impossible d\'ouvrir l\'appareil photo.';

  @override
  String get galleryFailed => 'Impossible d\'ouvrir la galerie.';

  @override
  String get optional => 'Facultatif';

  @override
  String get addPetPhotos => 'Ajoutez des photos de votre animal';

  @override
  String get addPetPhotosHint =>
      'Des photos nettes et récentes aident à le reconnaître';

  @override
  String get photoRequired => 'Au moins une photo est requise';

  @override
  String get tapToMakeCover => 'Touchez une photo pour en faire la couverture.';

  @override
  String get cover => 'Couverture';

  @override
  String uploadingPhotos(int percent) {
    return 'Envoi des photos… $percent %';
  }

  @override
  String get saving => 'Enregistrement…';

  @override
  String get takePhoto => 'Prendre une photo';

  @override
  String get useCamera => 'Utiliser l\'appareil photo';

  @override
  String get chooseFromGallery => 'Choisir dans la galerie';

  @override
  String get pickExistingPhoto => 'Choisir une photo existante';

  @override
  String get yourPet => 'votre animal';

  @override
  String get unknownDog => 'Chien inconnu';

  @override
  String get unknownCat => 'Chat inconnu';

  @override
  String get unknownPet => 'Animal inconnu';

  @override
  String get errorChooseType =>
      'Indiquez si vous avez perdu ou trouvé un animal.';

  @override
  String get errorPickPet => 'Choisissez l\'animal perdu.';

  @override
  String get errorFoundPhoto => 'Ajoutez au moins une photo de l\'animal.';

  @override
  String get errorFoundSpecies => 'Est-ce un chien, un chat ou autre ?';

  @override
  String get errorChooseCity => 'Choisissez la ville où cela s\'est passé.';

  @override
  String get errorFutureDate => 'La date ne peut pas être dans le futur.';

  @override
  String get errorDescriptionShort =>
      'Ajoutez une courte description (au moins 10 caractères).';

  @override
  String get errorContactRequired =>
      'Ajoutez un téléphone ou un e-mail pour qu\'on puisse vous joindre.';

  @override
  String get errorPhoneInvalid => 'Saisissez un numéro de téléphone valide.';

  @override
  String get discardReportTitle => 'Abandonner ce signalement ?';

  @override
  String get discardReportMessage => 'Ce que vous avez saisi sera perdu.';

  @override
  String get signInToPublish => 'Reconnectez-vous pour publier.';

  @override
  String publishedLost(String pet) {
    return '$pet est maintenant sur la carte. Nous espérons qu\'il rentrera vite.';
  }

  @override
  String publishedFound(String pet) {
    return 'Merci ! $pet est maintenant sur la carte.';
  }

  @override
  String get reportLostPetTitle => 'Signaler un animal perdu';

  @override
  String get reportFoundPetTitle => 'Signaler un animal trouvé';

  @override
  String get newReport => 'Nouveau signalement';

  @override
  String stepOf(int current, int total) {
    return '$current sur $total';
  }

  @override
  String get publishReport => 'Publier le signalement';

  @override
  String get stepTypeTitle => 'Que s\'est-il passé ?';

  @override
  String get stepTypeSubtitle => 'Faisons passer le mot autour de vous, vite.';

  @override
  String get stepFoundPetTitle => 'Parlez-nous de l\'animal';

  @override
  String get stepFoundPetSubtitle =>
      'Une photo nette est le moyen le plus rapide pour que le propriétaire le reconnaisse.';

  @override
  String get addFoundPhotos => 'Ajoutez des photos de l\'animal';

  @override
  String get addFoundPhotosHint =>
      'Prenez-en une maintenant ou choisissez-en une dans la galerie';

  @override
  String get whatKindOfAnimal => 'Quel type d\'animal ?';

  @override
  String get collarName => 'Nom sur le collier ou la médaille';

  @override
  String get collarNameHint => 'Laissez vide si vous ne savez pas';

  @override
  String get stepLostPetTitle => 'Quel animal a disparu ?';

  @override
  String get stepLostPetSubtitle =>
      'Nous utiliserons son profil et ses photos, vous n\'aurez rien à ressaisir.';

  @override
  String get stepWhereFoundTitle => 'Où l\'avez-vous trouvé ?';

  @override
  String stepWhereLostTitle(String pet) {
    return 'Où $pet a-t-il été vu pour la dernière fois ?';
  }

  @override
  String get stepWhereSubtitle =>
      'Choisissez la ville, puis placez le repère sur la carte. Les autres ne voient qu\'une zone d\'environ 100 m, jamais l\'adresse exacte.';

  @override
  String get streetOrLandmark => 'Rue ou point de repère';

  @override
  String get pinExactSpot => 'Placez le repère exact';

  @override
  String spotHintFound(String pet) {
    return 'Déplacez la carte pour placer le repère là où vous avez trouvé $pet.';
  }

  @override
  String spotHintLost(String pet) {
    return 'Déplacez la carte pour placer le repère là où $pet a été vu pour la dernière fois.';
  }

  @override
  String spotFarFromCity(int km, String city) {
    return 'Ce point est à $km km de $city. La ville est-elle correcte ?';
  }

  @override
  String spotPinned(int meters) {
    return 'C\'est noté. Les autres ne voient qu\'une zone d\'environ $meters m autour, jamais le point exact.';
  }

  @override
  String get timeHourAgo => 'Il y a 1 heure';

  @override
  String get timeThisMorning => 'Ce matin';

  @override
  String get stepWhenFoundTitle => 'Quand l\'avez-vous trouvé ?';

  @override
  String stepWhenLostTitle(String pet) {
    return 'Quand avez-vous vu $pet pour la dernière fois ?';
  }

  @override
  String get stepWhenSubtitle => 'Une heure approximative suffit.';

  @override
  String get changeDate => 'Changer la date';

  @override
  String get changeTime => 'Changer l\'heure';

  @override
  String get stepDetailsTitle => 'Autre chose à savoir ?';

  @override
  String get stepDetailsSubtitle =>
      'Les détails aident les voisins à reconnaître l\'animal et à vous joindre rapidement.';

  @override
  String descriptionHintLost(String pet) {
    return 'Couleur du collier, caractère, comment $pet a disparu…';
  }

  @override
  String get descriptionHintFound =>
      'État, collier, comportement, où exactement vous l\'avez trouvé…';

  @override
  String get howToReachYou => 'Comment vous joindre ?';

  @override
  String get contactPrivacyNote =>
      'Affiché uniquement sur la page du signalement, jamais dans les listes.';

  @override
  String get phoneHint => 'Téléphone, ex. +39 333 123 4567';

  @override
  String get reachableOnWhatsapp => 'Joignable sur WhatsApp';

  @override
  String get reachableOnWhatsappHint => 'On peut vous écrire à ce numéro';

  @override
  String get stepReviewTitle => 'Prêt à publier ?';

  @override
  String get stepReviewSubtitle =>
      'Voici comment votre signalement apparaîtra aux personnes proches.';

  @override
  String get iLostMyPet => 'J\'ai perdu mon animal';

  @override
  String get iFoundAPet => 'J\'ai trouvé un animal';

  @override
  String get iLostMyPetHint =>
      'Alertez les gens autour de vous et faites-vous aider.';

  @override
  String get iFoundAPetHint => 'Aidez un animal perdu à rentrer chez lui.';

  @override
  String get addAPet => 'Ajouter un animal';

  @override
  String get pleaseChooseCity => 'Choisissez une ville';

  @override
  String noPlacesFound(String city, String query) {
    return 'Aucun lieu trouvé à $city pour \"$query\".';
  }

  @override
  String searchStreetHint(String city) {
    return 'Cherchez à $city, ex. Via Dante';
  }

  @override
  String get yourCity => 'votre ville';

  @override
  String get useMyLocation => 'Utiliser ma position';

  @override
  String get publishFailed =>
      'Impossible de publier votre signalement. Réessayez.';

  @override
  String get updateReportFailed =>
      'Impossible de mettre à jour le signalement. Réessayez.';

  @override
  String get deleteReportFailed =>
      'Impossible de supprimer le signalement. Réessayez.';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get termsOfUse => 'Conditions d\'utilisation';

  @override
  String legalLastUpdated(String date) {
    return 'Dernière mise à jour : $date';
  }

  @override
  String get deleteAccountPasswordPrompt =>
      'Saisissez votre mot de passe pour confirmer.';

  @override
  String deleteAccountTypeConfirm(String word) {
    return 'Tapez $word pour confirmer.';
  }

  @override
  String get wrongPassword => 'Mot de passe incorrect. Réessayez.';

  @override
  String get confirmPasswordAgain =>
      'Pour votre sécurité, confirmez à nouveau votre mot de passe.';

  @override
  String get contactUs => 'Nous contacter';

  @override
  String get legalQuestions => 'Des questions sur ce document ou vos données ?';

  @override
  String get languageChangeLater =>
      'Vous pourrez la modifier à tout moment dans votre profil.';

  @override
  String get reward => 'Récompense';

  @override
  String get rewardHint => 'Montant en euros';

  @override
  String get rewardNote =>
      'La récompense est un accord privé entre le propriétaire et la personne qui trouve l\'animal. CodaMi ne garantit ni ne traite aucun paiement.';

  @override
  String rewardAmount(String amount) {
    return 'Récompense $amount';
  }

  @override
  String get adminPanel => 'Panneau d\'administration';

  @override
  String get roleAdmin => 'Administrateur';

  @override
  String get roleSupport => 'Support';

  @override
  String get supportStaff => 'Équipe support';

  @override
  String get supportStaffSubtitle =>
      'Les personnes qui répondent aux demandes d\'assistance';

  @override
  String get adminUsers => 'Utilisateurs';

  @override
  String get adminListings => 'Annonces';

  @override
  String get adminReportedContent => 'Contenus signalés';

  @override
  String get adminTickets => 'Demandes d\'assistance';

  @override
  String get adminVideos => 'Vidéos';

  @override
  String get addSupportStaff => 'Ajouter au support';

  @override
  String get addSupportStaffHint =>
      'Saisissez l\'email d\'un compte CodaMi existant.';

  @override
  String get userNotFound => 'Aucun compte CodaMi n\'utilise cet email.';

  @override
  String get alreadyStaff => 'Cette personne fait déjà partie de l\'équipe.';

  @override
  String staffAdded(String name) {
    return '$name fait désormais partie de l\'équipe support.';
  }

  @override
  String removeStaffTitle(String name) {
    return 'Retirer $name ?';
  }

  @override
  String get removeStaffMessage =>
      'Cette personne n\'aura plus accès au panneau d\'administration.';

  @override
  String get noSupportStaff =>
      'Personne dans l\'équipe support pour l\'instant.';

  @override
  String get add => 'Ajouter';

  @override
  String get actionFailed => 'Une erreur s\'est produite. Veuillez réessayer.';

  @override
  String get adminDashboard => 'Tableau de bord';

  @override
  String get adminMore => 'Plus';

  @override
  String get adminReportedShort => 'Signalés';

  @override
  String get adminTicketsShort => 'Demandes';

  @override
  String get adminSectionSoon => 'Cette section arrive bientôt.';

  @override
  String get statUsers => 'Utilisateurs inscrits';

  @override
  String get statOpenLost => 'Perdus en cours';

  @override
  String get statOpenFound => 'Trouvés en cours';

  @override
  String get statBackHome => 'Animaux rentrés à la maison';

  @override
  String get flagListing => 'Signaler l\'annonce';

  @override
  String get flagTitle => 'Pourquoi signalez-vous cette annonce ?';

  @override
  String get flagHint =>
      'Notre équipe va l\'examiner. Le propriétaire ne saura pas qui l\'a signalée.';

  @override
  String get flagReasonSpam => 'Spam ou publicité';

  @override
  String get flagReasonScam => 'Arnaque ou fraude';

  @override
  String get flagReasonInappropriate => 'Contenu inapproprié';

  @override
  String get flagReasonWrongInfo => 'Informations fausses ou trompeuses';

  @override
  String get flagReasonOther => 'Autre chose';

  @override
  String get flagNoteHint => 'Ajouter des détails (facultatif)';

  @override
  String get flagSubmit => 'Envoyer le signalement';

  @override
  String get flagSent => 'Merci. Notre équipe va examiner cette annonce.';

  @override
  String get alreadyFlagged => 'Vous avez déjà signalé cette annonce.';

  @override
  String blockUser(String name) {
    return 'Bloquer $name';
  }

  @override
  String blockUserTitle(String name) {
    return 'Bloquer $name ?';
  }

  @override
  String get blockUserMessage =>
      'Vous ne verrez plus ses annonces et ne recevrez plus d\'alertes à leur sujet. Vous pouvez le débloquer dans Profil → Utilisateurs bloqués.';

  @override
  String get block => 'Bloquer';

  @override
  String userBlocked(String name) {
    return '$name est bloqué.';
  }

  @override
  String get blockedUsers => 'Utilisateurs bloqués';

  @override
  String get noBlockedUsers => 'Vous n\'avez bloqué personne.';

  @override
  String get unblock => 'Débloquer';

  @override
  String userUnblocked(String name) {
    return '$name est débloqué.';
  }

  @override
  String get unknownUser => 'Utilisateur inconnu';

  @override
  String get hiddenListing => 'Masquée';

  @override
  String get hiddenListingNotice =>
      'Cette annonce a été masquée par l\'équipe CodaMi et n\'est plus publique.';

  @override
  String get moderation => 'Modération';

  @override
  String get noFlagsOnListing => 'Personne n\'a signalé cette annonce.';

  @override
  String flagCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Signalée $count fois',
      one: 'Signalée une fois',
    );
    return '$_temp0';
  }

  @override
  String get dismissFlags => 'Ignorer les signalements';

  @override
  String get flagsDismissed => 'Signalements ignorés.';

  @override
  String get hideListing => 'Masquer l\'annonce';

  @override
  String get restoreListing => 'Rétablir l\'annonce';

  @override
  String get listingHidden =>
      'Annonce masquée. Seul le propriétaire peut encore la voir.';

  @override
  String get listingRestored => 'Annonce rétablie.';

  @override
  String get deleteListing => 'Supprimer l\'annonce';

  @override
  String get deleteListingTitle => 'Supprimer cette annonce ?';

  @override
  String get deleteListingMessage =>
      'L\'annonce et ses photos sont supprimées pour tout le monde. Action irréversible.';

  @override
  String get listingDeleted => 'Annonce supprimée.';

  @override
  String get listingUnavailable => 'Annonce plus disponible';

  @override
  String get noReportedContent => 'Aucun signalement';

  @override
  String get noReportedContentMessage =>
      'Les annonces signalées par les utilisateurs apparaîtront ici.';

  @override
  String get filterOpen => 'Ouvertes';

  @override
  String get filterResolved => 'Résolues';

  @override
  String get filterHidden => 'Masquées';

  @override
  String get noListings => 'Aucune annonce';

  @override
  String get tryAnotherFilter => 'Essayez un autre filtre.';

  @override
  String get adminUsersSubtitle => 'Voir, désactiver ou supprimer des comptes';

  @override
  String get searchByEmail => 'Rechercher par e-mail';

  @override
  String get noUsersFound => 'Aucun utilisateur trouvé.';

  @override
  String get roleUser => 'Utilisateur';

  @override
  String get userDisabled => 'Désactivé';

  @override
  String get phone => 'Téléphone';

  @override
  String get memberSince => 'Membre depuis';

  @override
  String get disableAccount => 'Désactiver le compte';

  @override
  String get enableAccount => 'Réactiver le compte';

  @override
  String disableUserTitle(String name) {
    return 'Désactiver le compte de $name ?';
  }

  @override
  String get disableUserMessage =>
      'Il sera déconnecté et ne pourra plus se connecter. Ses annonces ouvertes sont masquées jusqu\'à la réactivation du compte.';

  @override
  String get accountDisabled => 'Compte désactivé.';

  @override
  String get accountEnabled => 'Compte réactivé.';

  @override
  String deleteUserTitle(String name) {
    return 'Supprimer le compte de $name ?';
  }

  @override
  String get deleteUserMessage =>
      'Supprime définitivement son profil, ses animaux, ses annonces et ses photos. Action irréversible.';

  @override
  String get userDeleted => 'Compte supprimé.';

  @override
  String get save => 'Enregistrer';

  @override
  String get requiredField => 'Obligatoire';

  @override
  String get notificationSettingsIntro =>
      'Choisissez les alertes que vous recevez et donnez à chacune son propre son, pour savoir ce qui se passe avant même de regarder.';

  @override
  String get notificationSound => 'Son';

  @override
  String get alertLostTitle => 'Animaux perdus à proximité';

  @override
  String get alertLostDescription =>
      'Quand un animal disparaît dans votre ville';

  @override
  String get alertFoundTitle => 'Animaux trouvés à proximité';

  @override
  String get alertFoundDescription =>
      'Quand quelqu\'un trouve un animal dans votre ville';

  @override
  String get alertResolvedTitle => 'Belles histoires';

  @override
  String get alertResolvedDescription =>
      'Quand un animal perdu ou trouvé rentre à la maison';

  @override
  String get soundDefault => 'Son par défaut du téléphone';

  @override
  String get soundSilent => 'Silencieux';

  @override
  String get soundChime => 'Carillon';

  @override
  String get soundBell => 'Cloche';

  @override
  String get soundBright => 'Vif';

  @override
  String get soundSoft => 'Doux';

  @override
  String get soundCustom => 'Son personnalisé';

  @override
  String get soundFromPhone => 'Sonneries et tonalités du téléphone';

  @override
  String get soundFromFile => 'Musique ou fichier audio';

  @override
  String get soundIosNote =>
      'Sur iPhone, les sons de notification doivent venir de l\'app : choisissez l\'un des sons ci-dessus.';

  @override
  String get soundPickFailed =>
      'Impossible d\'utiliser ce son. Essayez-en un autre.';

  @override
  String get videosForYou => 'Vidéos pour vous';

  @override
  String get videosForYourPets => 'Choisies pour vos animaux';

  @override
  String get videosGeneral => 'Bien-être animal et soins responsables';

  @override
  String get videosShuffle => 'Voir d\'autres vidéos';

  @override
  String get videoMotivational => 'Motivation';

  @override
  String get videoEducational => 'Apprendre';

  @override
  String get videoTagGeneral => 'Pour tous';

  @override
  String get videoLoadError =>
      'Impossible de lire cette vidéo pour le moment. Réessayez plus tard.';

  @override
  String get adminVideosSubtitle => 'Ajouter et gérer les vidéos';

  @override
  String get addVideo => 'Ajouter une vidéo';

  @override
  String get editVideo => 'Modifier la vidéo';

  @override
  String get noVideosYet =>
      'Aucune vidéo pour l\'instant. Ajoutez la première avec le bouton ci-dessous.';

  @override
  String get deleteVideoTitle => 'Supprimer cette vidéo ?';

  @override
  String get deleteVideoMessage =>
      'Elle sera retirée de l\'app pour tout le monde. Cette action est irréversible.';

  @override
  String get videoHidden => 'Masquée';

  @override
  String get allLanguages => 'Toutes les langues';

  @override
  String get chooseVideo => 'Choisir une vidéo';

  @override
  String get chooseVideoHint =>
      'Depuis votre galerie, jusqu\'à 200 Mo. Les vidéos courtes (moins de 2 minutes) sont idéales.';

  @override
  String get videoTitle => 'Titre';

  @override
  String get videoType => 'Type';

  @override
  String get videoAnimals => 'Animaux';

  @override
  String get videoAnimalsHint =>
      'Choisissez les animaux concernés par la vidéo. Choisissez « Pour tous » pour les vidéos générales montrées à tout le monde.';

  @override
  String get videoVisible => 'Visible dans l\'app';

  @override
  String get videoVisibleHint =>
      'Les vidéos masquées ne sont visibles que par les administrateurs.';

  @override
  String get videoTooLarge =>
      'Cette vidéo dépasse 200 Mo. Choisissez-en une plus courte.';

  @override
  String get videoSaved => 'Vidéo enregistrée.';

  @override
  String uploadingProgress(int percent) {
    return 'Envoi… $percent %';
  }

  @override
  String get navVideos => 'Vidéos';

  @override
  String get videosEmptyTitle => 'Les vidéos arrivent bientôt';

  @override
  String get videosEmptyMessage =>
      'Bientôt, vous trouverez ici de courtes vidéos pour prendre soin de vos animaux.';

  @override
  String get moreVideos => 'Plus de vidéos';

  @override
  String get videoWatched => 'Vue';

  @override
  String get videoBack10 => 'Reculer de 10 secondes';

  @override
  String get videoForward10 => 'Avancer de 10 secondes';

  @override
  String get videoFullscreen => 'Plein écran';

  @override
  String get videoExitFullscreen => 'Quitter le plein écran';

  @override
  String get videoRetry => 'Réessayer';

  @override
  String get videoDeleted => 'Vidéo supprimée.';

  @override
  String get noVideosYetTitle => 'Aucune vidéo';

  @override
  String get videoVisibleShort => 'Visibles';

  @override
  String get play => 'Lire';

  @override
  String get edit => 'Modifier';

  @override
  String get change => 'Changer';

  @override
  String get videoSectionFile => 'Vidéo';

  @override
  String get videoSectionDetails => 'Détails';

  @override
  String get videoSectionAudience => 'Qui la voit';

  @override
  String get videoCover => 'Image de couverture';

  @override
  String get videoCoverHint =>
      'Facultative. Affichée sur la carte de la vidéo.';

  @override
  String get videoMotivationalHint =>
      'Histoires inspirantes et moments heureux';

  @override
  String get videoEducationalHint => 'Conseils et tutoriels pour les maîtres';

  @override
  String get uploadVideo => 'Envoyer la vidéo';

  @override
  String get helpSupport => 'Aide et assistance';

  @override
  String get helpSupportSubtitle => 'Discutez avec nous ou envoyez une demande';

  @override
  String get supportIntroTitle => 'Comment pouvons-nous vous aider ?';

  @override
  String get supportIntroMessage =>
      'Notre équipe répond ici, dans l\'app. Vous recevrez une notification à chaque réponse.';

  @override
  String get supportStartChat => 'Démarrer un chat en direct';

  @override
  String get supportStartChatOnline => 'Un opérateur est en ligne';

  @override
  String get supportChatOffline =>
      'Aucun opérateur n\'est en ligne pour le moment. Envoyez une demande et nous répondrons dès que possible.';

  @override
  String get supportSendRequest => 'Envoyer une demande';

  @override
  String get supportSendRequestSubtitle =>
      'Nous répondons généralement sous 24 heures';

  @override
  String get supportMyRequests => 'Mes demandes';

  @override
  String get supportNoRequests => 'Aucune demande pour l\'instant';

  @override
  String get supportNoRequestsMessage =>
      'Vos échanges avec l\'assistance apparaîtront ici.';

  @override
  String get supportNewChat => 'Nouveau chat en direct';

  @override
  String get supportNewRequest => 'Nouvelle demande';

  @override
  String get supportCategory => 'Sujet';

  @override
  String get categoryAccount => 'Compte et connexion';

  @override
  String get categoryListing => 'Une annonce de perte ou de découverte';

  @override
  String get categoryApp => 'Problème avec l\'app';

  @override
  String get categoryOther => 'Autre chose';

  @override
  String get supportSubject => 'Objet';

  @override
  String get supportSubjectHint => 'En quelques mots';

  @override
  String get supportSubjectTooShort => 'Écrivez au moins 3 caractères';

  @override
  String get supportMessage => 'Message';

  @override
  String get supportMessageHint => 'Dites-nous ce qui s\'est passé';

  @override
  String get supportMessageRequired => 'Écrivez un message';

  @override
  String get supportSend => 'Envoyer';

  @override
  String get supportTooManyOpen =>
      'Vous avez déjà 3 demandes ouvertes. Continuez dans l\'une d\'elles.';

  @override
  String get supportTypeMessage => 'Écrivez un message…';

  @override
  String get supportTeam => 'Assistance CodaMi';

  @override
  String get supportMarkSolved => 'Marquer comme résolue';

  @override
  String get supportMarkSolvedConfirm =>
      'Marquer cette demande comme résolue ? Vous pourrez réécrire si besoin.';

  @override
  String get supportClosedNote =>
      'Cette demande est fermée. Ouvrez-en une nouvelle si besoin.';

  @override
  String get supportResolvedNote =>
      'Marquée comme résolue. Un nouveau message la rouvre.';

  @override
  String get supportWaitingNote =>
      'Merci ! Notre équipe vous répondra ici bientôt.';

  @override
  String get kindChat => 'Chat en direct';

  @override
  String get kindTicket => 'Demande';

  @override
  String get caseStatusOpen => 'Ouverte';

  @override
  String get caseStatusInProgress => 'En cours';

  @override
  String get caseStatusWaitingUser => 'En attente de réponse';

  @override
  String get caseStatusResolved => 'Résolue';

  @override
  String get caseStatusClosed => 'Fermée';

  @override
  String get filterUnanswered => 'Sans réponse';

  @override
  String get filterUnassigned => 'Non attribuées';

  @override
  String get filterMine => 'Les miennes';

  @override
  String get filterActive => 'Actives';

  @override
  String get filterDone => 'Terminées';

  @override
  String get supportSearchHint => 'Rechercher CM-1042 ou e-mail';

  @override
  String get supportNoCases => 'Aucune demande ici';

  @override
  String get supportNoCasesMessage => 'Rien n\'attend dans cette liste.';

  @override
  String get supportTake => 'Prendre en charge';

  @override
  String get supportTakeToReply => 'Prenez la demande en charge pour répondre.';

  @override
  String get supportAlreadyTaken =>
      'Un autre opérateur a déjà pris cette demande.';

  @override
  String get supportUnassigned => 'Non attribuée';

  @override
  String get supportReassign => 'Réattribuer';

  @override
  String get supportAssignTo => 'Attribuer à';

  @override
  String get supportBackToQueue => 'Remettre dans la file';

  @override
  String get supportChangeStatus => 'Changer le statut';

  @override
  String get supportChat => 'Chat';

  @override
  String get supportTimeline => 'Historique';

  @override
  String get supportDetails => 'Détails';

  @override
  String supportWaitingFor(String time) {
    return 'En attente depuis $time';
  }

  @override
  String get supportOverdue => 'Réponse en retard';

  @override
  String get supportOpened => 'Ouverte';

  @override
  String get supportTakenOver => 'Prise en charge';

  @override
  String get supportWaitToTake => 'Attente avant prise en charge';

  @override
  String get supportFirstReply => 'Première réponse';

  @override
  String get supportAvgReply => 'Temps de réponse moyen';

  @override
  String get supportHandlingTime => 'Temps passé';

  @override
  String get supportResolvedAt => 'Résolue';

  @override
  String get supportMessagesCount => 'Messages';

  @override
  String get supportOperator => 'Opérateur';

  @override
  String get supportUserLabel => 'Utilisateur';

  @override
  String eventCreated(String name) {
    return 'Ouverte par $name';
  }

  @override
  String eventTaken(String name) {
    return 'Prise en charge par $name';
  }

  @override
  String eventReassigned(String from, String to) {
    return 'Réattribuée de $from à $to';
  }

  @override
  String eventStatus(String name, String status) {
    return '$name a changé le statut en $status';
  }

  @override
  String get eventReopened => 'Rouverte par l\'utilisateur';

  @override
  String get eventOverdue => 'Pas de réponse dans le délai';

  @override
  String get eventAutoClosed => 'Fermée automatiquement';

  @override
  String get presenceOnline => 'En ligne';

  @override
  String get presenceAway => 'Absent';

  @override
  String get presenceOffline => 'Hors ligne';

  @override
  String get presenceAvailable => 'Disponible pour le chat';

  @override
  String get presenceAvailableSubtitle =>
      'Les utilisateurs peuvent démarrer un chat quand un opérateur est en ligne';

  @override
  String get supportOperators => 'Opérateurs';

  @override
  String get supportOperatorsSubtitle =>
      'Activité, demandes et temps de réponse';

  @override
  String get operatorOpenCases => 'Demandes ouvertes';

  @override
  String get operatorTaken => 'Prises en charge';

  @override
  String get operatorResolved => 'Résolues';

  @override
  String get operatorReplies => 'Réponses';

  @override
  String get operatorAvgHandling => 'Temps moyen par demande';

  @override
  String operatorLastActive(String time) {
    return 'Dernière activité $time';
  }

  @override
  String get operatorCases => 'Demandes';

  @override
  String get noOperators =>
      'Pas encore d\'opérateurs. Ajoutez-les dans Équipe d\'assistance.';

  @override
  String get statUnassigned => 'Demandes non attribuées';

  @override
  String get statUnanswered => 'Demandes sans réponse';

  @override
  String get statOverdue => 'Réponses en retard';

  @override
  String get alertSupportTitle => 'Réponses de l\'assistance';

  @override
  String get alertSupportDescription => 'Quand l\'assistance CodaMi vous écrit';

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
    return '$d j $h h';
  }

  @override
  String get searchUsersHint => 'Rechercher par nom ou e-mail';

  @override
  String get searchTooShort => 'Saisissez au moins 2 caractères';

  @override
  String get pickStaffTitle => 'Choisir un utilisateur';

  @override
  String get pickStaffHint =>
      'Touchez une personne pour l\'ajouter à l\'équipe d\'assistance.';

  @override
  String makeStaffTitle(String name) {
    return 'Ajouter $name à l\'équipe d\'assistance ?';
  }

  @override
  String get makeStaffMessage =>
      'Cette personne verra l\'espace d\'administration et pourra répondre aux demandes et aux chats. Vous pouvez la retirer à tout moment.';

  @override
  String get makeStaff => 'Ajouter à l\'équipe';

  @override
  String get supportStaffSwitch => 'Équipe d\'assistance';

  @override
  String get supportStaffSwitchSubtitle =>
      'Peut répondre aux demandes et aux chats';

  @override
  String staffRemoved(String name) {
    return '$name ne fait plus partie de l\'équipe d\'assistance.';
  }

  @override
  String get removeStaffCasesNote =>
      'Ses demandes ouvertes retournent dans la file.';

  @override
  String get pushOpen => 'Ouvrir';

  @override
  String get chatToday => 'Aujourd\'hui';

  @override
  String get chatLoadEarlier => 'Charger les messages précédents';

  @override
  String get supportPeople => 'Personnes';

  @override
  String get supportTimes => 'Délais';

  @override
  String get supportRequestInfo => 'Demande';

  @override
  String get supportType => 'Type';

  @override
  String get supportResolve => 'Marquer comme résolue';

  @override
  String ticketsWaiting(int count) {
    return '$count en attente de réponse';
  }

  @override
  String get ticketsAllClear => 'Tout est à jour';

  @override
  String get photoReviewHint =>
      'Photos retenues par l\'IA. Elles restent masquées jusqu\'à votre décision.';

  @override
  String get reasonAdult => 'Nudité ou contenu sexuel';

  @override
  String get reasonRacy => 'Contenu suggestif';

  @override
  String get reasonViolence => 'Violence ou sang';

  @override
  String get likelihoodPossible => 'Possible';

  @override
  String get likelihoodLikely => 'Probable';

  @override
  String get likelihoodVeryLikely => 'Très probable';

  @override
  String get hiddenByAi => 'Masquée par l\'IA';

  @override
  String get petPhoto => 'Photo de l\'animal';

  @override
  String get listingPhoto => 'Photo de l\'annonce';

  @override
  String uploadedBy(String name) {
    return 'Par $name';
  }

  @override
  String get tapToView => 'Touchez pour voir';

  @override
  String get approvePhoto => 'Approuver';

  @override
  String get removePhotoTitle => 'Supprimer cette photo ?';

  @override
  String get removePhotoMessage =>
      'Elle sera retirée de l\'animal ou de l\'annonce de l\'utilisateur, qui en sera informé.';

  @override
  String get photoApproved => 'Photo approuvée';

  @override
  String get photoRemovedDone => 'Photo supprimée';

  @override
  String get photoUnderReview =>
      'Notre équipe vérifie une photo, qui reste masquée d\'ici là.';

  @override
  String get reportedTabPhotos => 'Photos IA';

  @override
  String get reportedTabReports => 'Signalements';

  @override
  String get noPhotosToReview => 'Aucune photo à vérifier';

  @override
  String get noPhotosToReviewMessage =>
      'Les photos retenues par l\'IA apparaîtront ici.';

  @override
  String get aFriend => 'Un ami';

  @override
  String get addContact => 'Ajouter un contact';

  @override
  String get addTestContacts => 'Ajouter des contacts de test';

  @override
  String get adjustPoints => 'Ajuster les points';

  @override
  String get adjustPointsAmount => 'Points à ajouter ou retirer';

  @override
  String get adjustPointsAmountHelp =>
      'Utilisez le signe moins pour retirer des points, ex. -20';

  @override
  String get adjustPointsInvalid =>
      'Saisissez un nombre de points et un motif.';

  @override
  String get adjustPointsReason => 'Motif (visible par l\'utilisateur)';

  @override
  String get adminContactsSubtitle =>
      'Vétérinaires, associations et services affichés aux utilisateurs';

  @override
  String get adminEmergenciesSubtitle => 'Urgences animales signalées';

  @override
  String get alertEmergencyDescription =>
      'Animaux ayant besoin d\'aide urgente près de votre ville';

  @override
  String get alertEmergencyTitle => 'Urgences à proximité';

  @override
  String get allContacts => 'Tous';

  @override
  String get ambassadorLevels => 'Niveaux d\'ambassadeur';

  @override
  String get call112 => 'Appeler le 112';

  @override
  String get claim => 'Récupérer';

  @override
  String get claimed => 'Récupéré';

  @override
  String get codeCopied => 'Code copié';

  @override
  String get confirm => 'Confirmer';

  @override
  String get contactActive => 'Visible par les utilisateurs';

  @override
  String get contactActiveHelp =>
      'Désactivez pour masquer ce contact sans le supprimer.';

  @override
  String get contactAddress => 'Adresse';

  @override
  String get contactAreaKm => 'Zone couverte (km)';

  @override
  String get contactAreaKmHelp =>
      'Jusqu\'à quelle distance de son adresse il peut aider. Laissez vide pour utiliser la valeur par défaut des réglages d\'urgence.';

  @override
  String get contactCity => 'Commune';

  @override
  String get contactHandles => 'Urgences prises en charge';

  @override
  String get contactHandlesHelp =>
      'Laissez tout désactivé s\'il prend en charge tous les types.';

  @override
  String get contactHoursHint => 'Horaires, ex. Lun–Ven 9:00–18:00';

  @override
  String get contactInactive => 'Masqué';

  @override
  String get contactKindAssociation => 'Association de protection animale';

  @override
  String get contactKindOther => 'Autre service';

  @override
  String get contactKindPublicService => 'Service vétérinaire public';

  @override
  String get contactKindVet => 'Vétérinaire';

  @override
  String get contactMissingFields =>
      'Ajoutez un nom et placez le repère sur la carte.';

  @override
  String get contactName => 'Nom';

  @override
  String get contactNameHint => 'ex. Clinique vétérinaire Saint-François';

  @override
  String get contactPhones => 'Numéros de téléphone';

  @override
  String get contactPhonesHint => 'Séparez les numéros par des virgules';

  @override
  String get contactPlace => 'Où il se trouve';

  @override
  String get contactRecommendedHelp =>
      'Affiché avant des contacts plus proches lorsqu\'une urgence est signalée.';

  @override
  String get contactTestHelp =>
      'Contact fictif pour les tests. Affiché avec l\'étiquette TEST, jamais vérifié ni contacté par email.';

  @override
  String get contactType => 'Type';

  @override
  String get contactVerifiedHelp =>
      'Seulement après que l\'organisation a accepté d\'être listée et que les informations ont été vérifiées.';

  @override
  String get copyCode => 'Copier';

  @override
  String get dailyActive => 'Actif aujourd\'hui';

  @override
  String get dailyCheckin => 'Présence du jour';

  @override
  String get dailyRewards => 'Récompenses du jour';

  @override
  String get deleteContactTitle => 'Supprimer ce contact ?';

  @override
  String get directions => 'Itinéraire';

  @override
  String get editContact => 'Modifier le contact';

  @override
  String get emergencies => 'Urgences';

  @override
  String get emergenciesActive => 'Actives';

  @override
  String get emergenciesAll => 'Toutes';

  @override
  String get emergenciesNearYou => 'Près de vous';

  @override
  String get emergenciesSubtitle => 'Animaux ayant besoin d\'aide urgente';

  @override
  String get emergencyAddPhotos => 'Ajouter une photo';

  @override
  String get emergencyAddPhotosHint =>
      'Aide les autres à trouver et reconnaître l\'animal';

  @override
  String get emergencyAllContacts => 'Voir tous les contacts d\'urgence';

  @override
  String get emergencyAlreadyReported => 'Vous l\'avez déjà signalée.';

  @override
  String get emergencyCallReporter => 'Appeler la personne qui l\'a signalée';

  @override
  String get emergencyClose => 'Fermer';

  @override
  String get emergencyCloseTitle => 'Fermer cette urgence ?';

  @override
  String get emergencyContacts => 'Contacts d\'urgence';

  @override
  String get emergencyDetails => 'Que se passe-t-il ?';

  @override
  String get emergencyDetailsHint =>
      'ex. Chien percuté par une voiture, au bord de la route, respire encore';

  @override
  String get emergencyDetailsRequired =>
      'Décrivez la situation en quelques mots.';

  @override
  String get emergencyDisclaimer =>
      'CodaMi n\'est pas un service d\'urgence. Si un animal est en danger immédiat, appelez d\'abord le 112 ou un vétérinaire. Ne comptez pas uniquement sur les notifications de l\'app.';

  @override
  String get emergencyFalseAlarmTitle => 'Marquer comme fausse alerte ?';

  @override
  String get emergencyFindingContacts =>
      'Recherche de contacts près de ce lieu…';

  @override
  String get emergencyHelpDone =>
      'Merci ! La personne qui l\'a signalée a été prévenue.';

  @override
  String get emergencyHelpMessage =>
      'La personne qui l\'a signalée saura que quelqu\'un arrive. N\'y allez que si c\'est sans danger pour vous.';

  @override
  String get emergencyHelpTitle => 'Allez-vous aider ?';

  @override
  String get emergencyImHelping => 'Je vais aider';

  @override
  String get emergencyMarkFalseAlarm => 'Marquer comme fausse alerte';

  @override
  String get emergencyMarkResolved => 'Marquer comme résolue';

  @override
  String get emergencyMissingFields =>
      'Choisissez ce qui s\'est passé et l\'animal, décrivez la situation et placez le repère.';

  @override
  String get emergencyNoContacts =>
      'Pas encore de contacts pour cette zone. Appelez le 112 ou un vétérinaire.';

  @override
  String get emergencyPhoneHint =>
      'Visible par les personnes qui veulent aider, pour qu\'elles puissent vous appeler.';

  @override
  String get emergencyPinHint =>
      'Déplacez la carte pour placer le repère là où se trouve l\'animal.';

  @override
  String get emergencyPinned => 'Repère placé';

  @override
  String get emergencyReopen => 'Rouvrir';

  @override
  String get emergencyReportFalse => 'Signaler comme fausse';

  @override
  String get emergencyReportFalseDone => 'Merci, notre équipe va vérifier.';

  @override
  String get emergencyReportFalseMessage =>
      'Notre équipe vérifiera cette urgence.';

  @override
  String get emergencyReportFalseTitle => 'Cette urgence est-elle fausse ?';

  @override
  String get emergencyResolveTitle => 'Marquer comme résolue ?';

  @override
  String get emergencyResolved => 'Marquée comme résolue';

  @override
  String get emergencySend => 'Envoyer l\'urgence';

  @override
  String get emergencySendFailed =>
      'Impossible d\'envoyer l\'urgence. Vérifiez votre connexion et réessayez, ou appelez le 112.';

  @override
  String get emergencySending => 'Envoi…';

  @override
  String get emergencySent =>
      'Urgence envoyée. Les personnes à proximité sont alertées. Vous pouvez aussi appeler directement les contacts ci-dessous.';

  @override
  String get emergencySettings => 'Réglages des urgences';

  @override
  String get emergencySettingsSubtitle =>
      'Distances des alertes et ordre des contacts';

  @override
  String get emergencyStatusClosed => 'Fermée';

  @override
  String get emergencyStatusFalseAlarm => 'Fausse alerte';

  @override
  String get emergencyStatusHelping => 'Aide en route';

  @override
  String get emergencyStatusOpen => 'Besoin d\'aide';

  @override
  String get emergencyStatusResolved => 'Résolue';

  @override
  String get emergencySuggestedContacts => 'Qui peut aider';

  @override
  String get emergencySuggestedContactsHint =>
      'Les contacts adaptés les plus proches en premier. Appelez-les directement.';

  @override
  String get emergencyTypeAbandoned => 'Animal abandonné';

  @override
  String get emergencyTypeDanger => 'Animal en danger';

  @override
  String get emergencyTypeInjured => 'Animal blessé';

  @override
  String get emergencyTypeIntervention => 'Demande d\'intervention';

  @override
  String get emergencyTypeOther => 'Autre urgence';

  @override
  String get emergencyTypeUrgentFound => 'Trouvé, soins urgents';

  @override
  String get emergencyUnavailable => 'Cette urgence n\'est plus disponible.';

  @override
  String get emergencyWhatHappened => 'Que s\'est-il passé ?';

  @override
  String get emergencyWhere => 'Où est l\'animal ?';

  @override
  String get emergencyWhereHint =>
      'Le lieu exact est partagé pour que les personnes qui aident puissent trouver l\'animal.';

  @override
  String get emergencyYouAreHelping =>
      'Vous avez indiqué que vous allez aider. Merci !';

  @override
  String get emergencyYourPhone => 'Votre téléphone';

  @override
  String get flagBurst =>
      'De nombreux amis de cet utilisateur sont devenus actifs le même jour';

  @override
  String get flagDeviceUsed =>
      'Ce téléphone a déjà servi pour une autre invitation';

  @override
  String get flagSameDevice => 'Même téléphone que la personne qui l\'a invité';

  @override
  String get haveInviteCode => 'Un ami vous a invité ? Saisissez son code';

  @override
  String get invitePromptTitle => 'Un ami t\'a invité ?';

  @override
  String get invitePromptBody =>
      'Saisis son code d\'invitation pour que ton ami soit récompensé de t\'avoir fait découvrir CodaMi.';

  @override
  String invitePromptLater(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'Tu peux aussi l\'ajouter plus tard dans Profil → Inviter des amis, dans les $days jours suivant ton inscription.',
      one:
          'Tu peux aussi l\'ajouter plus tard aujourd\'hui dans Profil → Inviter des amis.',
    );
    return '$_temp0';
  }

  @override
  String get inviteCodeLabel => 'Code d\'invitation';

  @override
  String get inviteCodeFromLink =>
      'Rempli depuis ton lien d\'invitation. Appuie sur Utiliser pour confirmer.';

  @override
  String get inviteCodeFormat =>
      'Les codes d\'invitation comportent 6 lettres et chiffres, comme ABC234.';

  @override
  String get inviteCodeNotFound =>
      'Nous n\'avons pas trouvé ce code. Vérifie-le avec ton ami.';

  @override
  String get inviteCodeOwn =>
      'C\'est ton propre code. Partage-le plutôt avec tes amis.';

  @override
  String inviteCodeTooLate(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'Les codes d\'invitation ne peuvent être ajoutés que dans les $days premiers jours après l\'inscription.',
      one:
          'Les codes d\'invitation ne peuvent être ajoutés que le jour de l\'inscription.',
    );
    return '$_temp0';
  }

  @override
  String get inviteCodeTooManyTries =>
      'Trop de codes erronés aujourd\'hui. Réessaie demain.';

  @override
  String get howInvitesWork => 'Comment ça marche';

  @override
  String get inviteApproved => 'Invitation approuvée';

  @override
  String get inviteCodeAlreadyUsed =>
      'Vous avez déjà utilisé un code d\'invitation.';

  @override
  String get inviteCodeInvalid => 'Ce code n\'est pas valide.';

  @override
  String get inviteCodeNotAllowed =>
      'Ce code ne peut pas être utilisé : c\'est votre propre code, ou votre inscription est trop ancienne.';

  @override
  String get inviteFriends => 'Inviter des amis';

  @override
  String get inviteFriendsSubtitle => 'Devenez ambassadeur CodaMi';

  @override
  String get inviteIntro =>
      'Chaque nouvel utilisateur de CodaMi, c\'est une paire d\'yeux de plus pour les animaux perdus. Invitez vos amis et devenez ambassadeur CodaMi.';

  @override
  String get inviteRejected => 'Invitation refusée';

  @override
  String get inviteStatusExpired => 'Pas devenu actif à temps';

  @override
  String get inviteStatusPending => 'Inscrit, pas encore actif';

  @override
  String get inviteStatusQualified => 'Actif – points gagnés';

  @override
  String get inviteStatusRejected => 'Non comptabilisé';

  @override
  String get inviteStatusReview => 'En vérification';

  @override
  String get inviteStep1 =>
      'Partagez votre code. Votre ami le saisit dans Profil → Inviter des amis après son inscription.';

  @override
  String get invitedFriends => 'Amis invités (actifs)';

  @override
  String get invitesToReview => 'Invitations à vérifier';

  @override
  String get invitesToReviewSubtitle =>
      'Invitations retenues par les contrôles anti-fraude';

  @override
  String get levelAmbassador => 'Ambassadeur';

  @override
  String get levelBonus => 'Points bonus';

  @override
  String get settingsActiveFriends => 'Amis actifs';

  @override
  String get levelChampion => 'Champion CodaMi';

  @override
  String get levelSuperAmbassador => 'Super Ambassadeur';

  @override
  String get levelSupporter => 'Soutien';

  @override
  String get myEmergencies => 'Les miennes';

  @override
  String get myPoints => 'Mes points';

  @override
  String get noActiveEmergencies => 'Aucune urgence';

  @override
  String get noEmergenciesMessage =>
      'Les urgences signalées près de votre ville apparaissent ici.';

  @override
  String get noEmergenciesNearby => 'Aucune urgence près de vous';

  @override
  String get noEmergencyContacts => 'Pas encore de contacts';

  @override
  String get noEmergencyContactsAdmin =>
      'Ajoutez des vétérinaires, associations et services, ou des contacts de test pour essayer la fonction.';

  @override
  String get noEmergencyContactsMessage =>
      'Des contacts seront bientôt ajoutés. En cas d\'urgence, appelez le 112 ou un vétérinaire.';

  @override
  String get noInvitesToReview => 'Rien à vérifier';

  @override
  String get noInvitesToReviewMessage =>
      'Les invitations suspectes apparaissent ici. Aucune n\'est refusée sans vous.';

  @override
  String get noInvitesYet =>
      'Pas encore d\'invitations. Partagez votre code pour commencer.';

  @override
  String get noLevelYet => 'Pas encore de niveau';

  @override
  String get noMyEmergencies => 'Vous n\'avez signalé aucune urgence';

  @override
  String get noPointsYet =>
      'Pas encore de points. Récupérez votre récompense du jour pour commencer.';

  @override
  String get open24h => 'Ouvert 24 h/24';

  @override
  String get openMapFailed => 'Impossible d\'ouvrir la carte.';

  @override
  String get photos => 'Photos';

  @override
  String get pointsAdjusted => 'Ajusté par CodaMi';

  @override
  String get pointsDailyActive => 'Actif aujourd\'hui';

  @override
  String get pointsDailyCheckin => 'Présence du jour';

  @override
  String get pointsFriendJoined => 'Un ami est devenu actif';

  @override
  String get pointsHistory => 'Historique';

  @override
  String get pointsLevelBonus => 'Bonus de nouveau niveau';

  @override
  String get pointsOther => 'Points';

  @override
  String get pointsSettings => 'Points et récompenses';

  @override
  String get pointsSettingsIntro =>
      'Les changements s\'appliquent immédiatement. Les valeurs hors limites sont remplacées par les valeurs par défaut.';

  @override
  String get pointsSettingsSubtitle =>
      'Récompenses du jour, invitations et niveaux';

  @override
  String get pointsStreakBonus => 'Bonus de série';

  @override
  String get pointsWelcome => 'Bonus de bienvenue';

  @override
  String get recommendedContact => 'Recommandé';

  @override
  String get reject => 'Refuser';

  @override
  String get reportEmergency => 'Signaler une urgence';

  @override
  String get searchContacts => 'Rechercher par nom ou commune';

  @override
  String get settingsActiveMinutes =>
      'Minutes d\'utilisation pour « Actif aujourd\'hui »';

  @override
  String get settingsAlertsNearby => 'Alertes aux personnes à proximité';

  @override
  String get settingsAutoCloseHours => 'Fermer après (heures sans nouvelles)';

  @override
  String get settingsAutoCloseHoursHelp =>
      'Les urgences ouvertes se ferment seules après ce délai.';

  @override
  String get settingsCodeEntryDays =>
      'Jours après l\'inscription pour saisir un code';

  @override
  String get settingsContactsPriority => 'Priorité des contacts';

  @override
  String get settingsDefaultAreaKm => 'Zone couverte par défaut (km)';

  @override
  String get settingsDefaultAreaKmHelp =>
      'Utilisée pour les contacts sans zone propre.';

  @override
  String get settingsEmailContacts => 'Alertes par email aux contacts';

  @override
  String get settingsEmailContactsHelp =>
      'Envoie un email aux contacts vérifiés. Le service d\'email doit d\'abord être configuré.';

  @override
  String get settingsMaxPerDay => 'Amis actifs par jour avant vérification';

  @override
  String get settingsMaxPerDayHelp =>
      'Au-delà en 24 heures, l\'invitation part en vérification.';

  @override
  String get settingsMaxRecipients => 'Nombre maximal de personnes alertées';

  @override
  String get settingsMaxSuggested => 'Contacts suggérés';

  @override
  String get settingsMinRecipients => 'Personnes à atteindre';

  @override
  String get settingsMinRecipientsHelp =>
      'Le cercle suivant est utilisé jusqu\'à atteindre ce nombre de personnes.';

  @override
  String get settingsQualifyDays => 'Jours d\'activité nécessaires';

  @override
  String get settingsQualifyWithinDays =>
      'Dans un délai de (jours après l\'inscription)';

  @override
  String get settingsReferralPoints => 'Points par ami actif';

  @override
  String get settingsRings => 'Cercles d\'alerte (km)';

  @override
  String get settingsRingsHelp =>
      'Séparés par des virgules, du plus petit au plus grand, ex. 5, 10, 25';

  @override
  String get settingsSaved => 'Enregistré';

  @override
  String get settingsStreakDays => 'Jours pour un bonus de série';

  @override
  String get settingsWeight24h => 'Bonus pour ouvert 24 h/24';

  @override
  String get settingsWeightHelp =>
      'Les contacts reçoivent ces bonus et perdent des points par km de distance. Le score le plus élevé passe en premier.';

  @override
  String get settingsWeightPerKm => 'Pénalité par km';

  @override
  String get settingsWeightPerKmHelp =>
      'Avec 1, un contact recommandé (20) passe avant un autre jusqu\'à 20 km plus proche.';

  @override
  String get settingsWeightRecommended => 'Bonus pour recommandé';

  @override
  String get settingsWeightVerified => 'Bonus pour vérifié';

  @override
  String get settingsWelcomePoints => 'Points pour l\'ami invité';

  @override
  String get settingsWelcomePointsHelp =>
      'Attribués quand il saisit un code. 0 désactive.';

  @override
  String get shareInvite => 'Partager';

  @override
  String get statActiveEmergencies => 'Urgences actives';

  @override
  String get testContactBadge => 'TEST – pas un vrai contact';

  @override
  String get topLevelReached =>
      'Vous avez atteint le niveau le plus élevé. Merci !';

  @override
  String get useCode => 'Utiliser';

  @override
  String get verifiedContact => 'Vérifié';

  @override
  String get viewInvitee => 'Utilisateur invité';

  @override
  String get viewInviter => 'Parrain';

  @override
  String get yourInviteCode => 'Votre code d\'invitation';

  @override
  String get yourInvites => 'Vos invitations';

  @override
  String get zeroTurnsOff => '0 désactive';

  @override
  String activeProgress(int done, int total) {
    return '$done sur $total minutes aujourd\'hui';
  }

  @override
  String claimedPoints(int points) {
    return '+$points points !';
  }

  @override
  String claimedWithBonus(int points, int bonus) {
    return '+$points points et un bonus de série de +$bonus !';
  }

  @override
  String emergenciesNearYouCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count urgences animales près de vous',
      one: '1 urgence animale près de vous',
    );
    return '$_temp0';
  }

  @override
  String emergencyAlertedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count personnes à proximité ont été alertées',
      one: '1 personne à proximité a été alertée',
      zero: 'Personne à proximité n\'a encore activé les alertes',
    );
    return '$_temp0';
  }

  @override
  String emergencyFalseReports(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Signalée comme fausse $count fois',
      one: 'Signalée comme fausse une fois',
    );
    return '$_temp0';
  }

  @override
  String emergencyHelpersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count personnes vont aider',
      one: '1 personne va aider',
    );
    return '$_temp0';
  }

  @override
  String inviteCodeAccepted(String name) {
    return 'Code accepté. $name vous a invité : bienvenue sur CodaMi !';
  }

  @override
  String inviteShareText(String code, String link) {
    return 'J\'utilise CodaMi pour aider les animaux perdus à rentrer chez eux. Rejoins-moi avec mon code d\'invitation $code : $link';
  }

  @override
  String inviteStep2(int days, int within) {
    return 'Il indique sa ville et utilise l\'app $days jours différents dans les $within jours suivant son inscription.';
  }

  @override
  String inviteStep3(int points) {
    return 'Vous recevez $points points et montez dans les niveaux d\'ambassadeur.';
  }

  @override
  String kmAway(String km) {
    return 'à $km km';
  }

  @override
  String levelFriends(String level) {
    return '$level : amis actifs';
  }

  @override
  String levelRule(String level, int friends, int bonus) {
    return '$level · $friends+ amis · +$bonus';
  }

  @override
  String nextLevelHint(int count, String level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Encore $count amis actifs pour devenir $level',
      one: 'Encore 1 ami actif pour devenir $level',
    );
    return '$_temp0';
  }

  @override
  String plusPoints(int points) {
    return '+$points points';
  }

  @override
  String pointsTotal(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points points',
      one: '1 point',
    );
    return '$_temp0';
  }

  @override
  String streakLine(int streak, int days, int bonus) {
    return 'Série de $streak jours · bonus de +$bonus tous les $days jours';
  }

  @override
  String get pointsFeedback => 'Avis envoyé';

  @override
  String get whatsNew => 'Nouveautés';

  @override
  String get whatsNewSubtitle => 'Les changements de chaque version';

  @override
  String get whatsNewTitle => 'Nouveautés de CodaMi';

  @override
  String get whatsNewIntro =>
      'Voici ce qui a changé avec la dernière mise à jour.';

  @override
  String whatsNewVersion(String version) {
    return 'Version $version';
  }

  @override
  String get whatsNewSectionNew => 'Nouveau';

  @override
  String get whatsNewSectionImproved => 'Amélioré';

  @override
  String get whatsNewSectionFixed => 'Corrigé';

  @override
  String get whatsNewEmpty => 'Pas encore de notes de mise à jour.';

  @override
  String get whatsNewDone => 'J\'ai compris';

  @override
  String get feedbackTitle => 'Que pensez-vous de CodaMi ?';

  @override
  String get feedbackBody =>
      'Votre avis est transmis directement à l\'équipe CodaMi et nous aide à améliorer l\'app.';

  @override
  String feedbackPointsOffer(int points) {
    return '+$points points pour votre premier avis';
  }

  @override
  String get feedbackStarsHint => 'Touchez une étoile pour noter';

  @override
  String get feedbackCommentHint =>
      'Qu\'est-ce qui vous plaît, ou que pourrait-on améliorer ? (facultatif)';

  @override
  String get feedbackSend => 'Envoyer l\'avis';

  @override
  String get feedbackLater => 'Plus tard';

  @override
  String get feedbackThanks => 'Merci pour votre avis !';

  @override
  String feedbackThanksPoints(int points) {
    return 'Merci pour votre avis ! +$points points';
  }

  @override
  String get feedbackAlreadyToday =>
      'Vous avez déjà envoyé un avis aujourd\'hui. Vous pourrez en envoyer un autre demain.';

  @override
  String get sendFeedbackSubtitle => 'Dites à l\'équipe ce que vous en pensez';

  @override
  String get rateCodaMi => 'Noter CodaMi';

  @override
  String get rateCodaMiSubtitle => 'Laissez un avis sur Google Play';

  @override
  String get adminFeedback => 'Avis';

  @override
  String get adminFeedbackSubtitle =>
      'Ce que les utilisateurs pensent de l\'app';

  @override
  String get adminFeedbackEmpty => 'Pas encore d\'avis.';

  @override
  String feedbackRatingsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count notes',
      one: '1 note',
    );
    return '$_temp0';
  }

  @override
  String get feedbackNoComment => 'Aucun commentaire';

  @override
  String get adminWhatsNewSubtitle =>
      'Notes affichées aux utilisateurs après chaque mise à jour';

  @override
  String get releaseAdd => 'Ajouter une version';

  @override
  String get releaseEdit => 'Modifier les notes';

  @override
  String get releaseVersion => 'Numéro de version';

  @override
  String get releaseVersionHelp =>
      'Par exemple 1.1.0. Il doit correspondre au nom de version de l\'app dans le store.';

  @override
  String get releaseVersionInvalid =>
      'Utilisez des chiffres et des points, par exemple 1.1.0.';

  @override
  String get releaseVersionExists => 'Cette version a déjà des notes.';

  @override
  String get releasePublishedHelp =>
      'Les utilisateurs ne voient que les notes publiées.';

  @override
  String get releaseDraft => 'Brouillon';

  @override
  String get releaseLinesHelp => 'Un changement par ligne.';

  @override
  String get releaseLanguageHelp =>
      'Les langues laissées vides affichent les notes en anglais.';

  @override
  String get releaseEnglishRequired =>
      'Rédigez d\'abord les notes en anglais : les autres langues s\'appuient sur elles par défaut.';

  @override
  String get releaseDeleteTitle => 'Supprimer ces notes ?';

  @override
  String releaseDeleteBody(String version) {
    return 'Les notes de la version $version seront supprimées pour tout le monde.';
  }

  @override
  String get releaseNone =>
      'Pas encore de version. Ajoutez les notes de votre prochaine mise à jour.';

  @override
  String releaseThisApp(String version) {
    return 'Cette app : version $version';
  }

  @override
  String get feedbackAndReviews => 'Avis et évaluations';

  @override
  String get settingsFeedbackPoints => 'Points pour le premier avis';

  @override
  String get settingsFeedbackAfterDays =>
      'Jours après l\'inscription avant de demander un avis';

  @override
  String get settingsReviewActiveDays =>
      'Jours d\'utilisation avant de demander';

  @override
  String get settingsReviewAfterDays =>
      'Jours après l\'inscription avant la fenêtre de notation du store';

  @override
  String get settingsReviewEveryDays =>
      'Jours entre deux demandes de notation du store';

  @override
  String get settingsReviewHelp =>
      'La fenêtre de notation du store ne donne jamais de points : Google Play et l\'App Store ne l\'autorisent pas.';

  @override
  String get petitions => 'Pétitions';

  @override
  String get petition => 'Pétition';

  @override
  String get petitionsSubtitle =>
      'Campagnes pour le bien-être animal choisies par notre équipe';

  @override
  String get adminPetitionsSubtitle =>
      'Ajoutez, vérifiez et publiez des pétitions pour le bien-être animal';

  @override
  String petitionsBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pétitions pour le bien-être animal à signer',
      one: '1 pétition pour le bien-être animal à signer',
    );
    return '$_temp0';
  }

  @override
  String get petitionsIntro =>
      'L\'équipe CodaMi vérifie chaque pétition avant qu\'elle n\'apparaisse ici. Vous la lisez et la signez sur le site d\'origine.';

  @override
  String get petitionsEmpty =>
      'Aucune pétition pour le moment. L\'équipe ajoutera ici des campagnes pour le bien-être animal.';

  @override
  String get petitionAdminEmpty =>
      'Aucune pétition ici. Touchez Ajouter une pétition pour en ajouter une depuis Change.org, Care2, Avaaz ou une organisation de confiance.';

  @override
  String get petitionView => 'Voir la pétition';

  @override
  String get petitionSignOnSite => 'Lire et signer sur le site d\'origine';

  @override
  String get petitionOpenFailed =>
      'Impossible d\'ouvrir la page de la pétition.';

  @override
  String get petitionIssue => 'Le problème';

  @override
  String get petitionAction => 'Ce que demande la pétition';

  @override
  String get petitionWhy => 'Pourquoi c\'est important pour les animaux';

  @override
  String get petitionWhere => 'Pétition d\'origine';

  @override
  String petitionStartedOn(String date) {
    return 'Lancée le $date';
  }

  @override
  String get petitionDisclaimer =>
      'Cette pétition est hébergée sur un site externe. CodaMi ne collecte pas de signatures et n\'est pas responsable du contenu de la page d\'origine.';

  @override
  String get petitionEndedNote =>
      'Cette campagne est terminée. Vous pouvez toujours lire la page d\'origine.';

  @override
  String get petitionUnavailableNote =>
      'La pétition d\'origine n\'est plus disponible.';

  @override
  String get petitionTopicPets => 'Animaux de compagnie';

  @override
  String get petitionTopicWildlife => 'Faune sauvage';

  @override
  String get petitionTopicFarm => 'Animaux d\'élevage';

  @override
  String get petitionTopicTesting => 'Expérimentation animale';

  @override
  String get petitionTopicEntertainment => 'Cirques et zoos';

  @override
  String get petitionTopicMarine => 'Vie marine';

  @override
  String get petitionTopicOther => 'Autre';

  @override
  String get petitionStatusActive => 'Active';

  @override
  String get petitionStatusCompleted => 'Terminée';

  @override
  String get petitionStatusClosed => 'Fermée';

  @override
  String get petitionStatusUnavailable => 'Plus disponible';

  @override
  String get petitionReviewPending => 'À vérifier';

  @override
  String get petitionReviewApproved => 'Approuvée';

  @override
  String get petitionReviewRejected => 'Refusée';

  @override
  String get petitionAdd => 'Ajouter une pétition';

  @override
  String get petitionEdit => 'Modifier la pétition';

  @override
  String get petitionSectionSource => 'Pétition d\'origine';

  @override
  String get petitionUrl => 'Lien de la pétition';

  @override
  String get petitionUrlInvalid =>
      'Collez le lien complet, commençant par https://';

  @override
  String get petitionTitle => 'Titre';

  @override
  String get petitionSource => 'Plateforme ou organisation';

  @override
  String get petitionCountry => 'Pays ou région';

  @override
  String get petitionCountryHelp =>
      'Laissez vide pour les campagnes internationales.';

  @override
  String get petitionStartedOnPick =>
      'Date de lancement de la pétition (facultatif)';

  @override
  String get petitionTopic => 'Sujet';

  @override
  String get petitionSectionText => 'Notre description';

  @override
  String get petitionOwnWordsHelp =>
      'Rédigez avec vos propres mots. Ne copiez pas le texte de la page d\'origine.';

  @override
  String get petitionSummary => 'Résumé court';

  @override
  String get petitionImage => 'Image';

  @override
  String get petitionImageAdd => 'Ajouter une image';

  @override
  String get petitionImageChange => 'Changer l\'image';

  @override
  String get petitionImageHelp =>
      'Facultatif. Sans image, la carte affiche l\'icône du sujet.';

  @override
  String get petitionImagePermission =>
      'Nous avons l\'autorisation d\'utiliser cette image';

  @override
  String get petitionImagePermissionNeeded =>
      'Confirmez que vous avez l\'autorisation d\'utiliser l\'image, ou retirez-la.';

  @override
  String get petitionImageTooBig =>
      'L\'image est trop lourde. Choisissez-en une de moins de 5 Mo.';

  @override
  String get petitionChecks => 'Vérification';

  @override
  String get petitionChecksHelp =>
      'Les quatre sont nécessaires pour approuver ou publier.';

  @override
  String get petitionCheckExists => 'La page d\'origine existe et s\'ouvre';

  @override
  String get petitionCheckGenuine =>
      'Elle porte sur un vrai problème de bien-être animal';

  @override
  String get petitionCheckGoal => 'Elle a un objectif clair';

  @override
  String get petitionCheckHonest =>
      'Aucune affirmation trompeuse ou frauduleuse';

  @override
  String get petitionChecksNeeded =>
      'Cochez toutes les vérifications avant d\'approuver ou de publier.';

  @override
  String get petitionReview => 'Validation';

  @override
  String get petitionReviewHelp =>
      'Seules les pétitions publiées sont visibles par les utilisateurs.';

  @override
  String get petitionRejectReason =>
      'Motif (visible uniquement par les administrateurs)';

  @override
  String get petitionStatus => 'Statut de la pétition';

  @override
  String get petitionStatusHelp =>
      'Mettez-le à jour quand la campagne se termine ou que la page est supprimée.';

  @override
  String get petitionFixFields => 'Remplissez les champs signalés en rouge.';

  @override
  String get petitionDeleteTitle => 'Supprimer cette pétition ?';

  @override
  String get petitionDeleteBody =>
      'Elle sera retirée de l\'app pour tout le monde.';

  @override
  String petitionAddedOn(String date) {
    return 'Ajoutée le $date';
  }

  @override
  String petitionPublishedOn(String date) {
    return 'Publiée le $date';
  }

  @override
  String petitionUpdatedOn(String date) {
    return 'Mise à jour le $date';
  }

  @override
  String get appUpdates => 'Mises à jour de l\'app';

  @override
  String get adminAppUpdatesSubtitle =>
      'Versions dans les stores et mises à jour obligatoires';

  @override
  String get appUpdatesSubtitle => 'Versions dans les stores';

  @override
  String get appUpdatesIntro =>
      'Les utilisateurs d\'une ancienne version voient un message de mise à jour avec les nouveautés de la dernière version. En dessous de la version minimale, l\'app ne peut pas être utilisée avant la mise à jour. Aucune nouvelle build n\'est nécessaire pour les modifier.';

  @override
  String appUpdatesThisPhone(String version) {
    return 'Ce téléphone a la version $version';
  }

  @override
  String get appUpdatesAndroid => 'Android (Google Play)';

  @override
  String get appUpdatesIos => 'iPhone (App Store)';

  @override
  String get appUpdatesLatest => 'Dernière version dans le store';

  @override
  String get appUpdatesLatestHelp =>
      'À renseigner une fois la mise à jour disponible dans le store. Laissez vide pour n\'afficher aucun message.';

  @override
  String get appUpdatesMinimum => 'Version minimale';

  @override
  String get appUpdatesMinimumHelp =>
      'Les versions plus anciennes doivent être mises à jour avant d\'utiliser l\'app. Laissez vide pour aucune.';

  @override
  String get appUpdatesStoreId => 'Identifiant App Store';

  @override
  String get appUpdatesStoreIdHelp =>
      'Le numéro dans le lien App Store (apps.apple.com/app/id…). Nécessaire pour le bouton Mettre à jour sur iPhone.';

  @override
  String appUpdatesNotesPublished(String version) {
    return 'Les nouveautés de la $version sont publiées et affichées avec la mise à jour';
  }

  @override
  String appUpdatesNotesDraft(String version) {
    return 'Les nouveautés de la $version sont enregistrées mais pas publiées';
  }

  @override
  String appUpdatesNotesMissing(String version) {
    return 'Aucune nouveauté rédigée pour la $version';
  }

  @override
  String get appUpdatesBadVersion => 'Utilisez une version comme 1.2.0';

  @override
  String get appUpdatesMinimumAbove =>
      'La version minimale ne peut pas dépasser la dernière version';

  @override
  String get appUpdatesBadStoreId =>
      'L\'identifiant App Store ne contient que des chiffres';

  @override
  String get appUpdatesRequireTitle => 'Rendre la mise à jour obligatoire ?';

  @override
  String appUpdatesRequireBody(String version) {
    return 'Tous ceux qui ont une version inférieure à la $version devront mettre à jour avant d\'utiliser l\'app.';
  }

  @override
  String get appUpdatesRequireConfirm => 'Rendre obligatoire';

  @override
  String get updateAvailableTitle => 'Mise à jour disponible';

  @override
  String updateAvailableBody(String latest, String installed) {
    return 'La version $latest de CodaMi est prête. Vous avez la $installed.';
  }

  @override
  String get updateNow => 'Mettre à jour';

  @override
  String get updateLater => 'Plus tard';

  @override
  String get updateRequiredTitle => 'Mise à jour requise';

  @override
  String updateRequiredBody(String version) {
    return 'Cette version de CodaMi n\'est plus prise en charge. Passez à la version $version pour continuer à utiliser l\'app.';
  }

  @override
  String updateBanner(String version) {
    return 'La version $version est disponible';
  }

  @override
  String get updateStoreFailed =>
      'Impossible d\'ouvrir le store. Mettez CodaMi à jour depuis l\'app du store.';

  @override
  String get rateCodaMiSubtitleIos => 'Laisser un avis sur l\'App Store';

  @override
  String get updateContinueAsAdmin => 'Continuer en tant qu\'admin';

  @override
  String get navShop => 'Boutique';

  @override
  String get shop => 'Boutique';

  @override
  String get adminShopSubtitle =>
      'Produits, marques, fournisseurs et interrupteur';

  @override
  String get shopSubtitle => 'Des produits pour vos animaux';

  @override
  String get shopSearchHint => 'Rechercher des produits';

  @override
  String get shopEmpty => 'Les produits arrivent bientôt. Revenez plus tard !';

  @override
  String get shopNoResults => 'Aucun produit ne correspond.';

  @override
  String get shopInStock => 'En stock';

  @override
  String get shopLowStock => 'Plus que quelques-uns';

  @override
  String get shopOutOfStock => 'En rupture';

  @override
  String get shopComingSoon => 'Bientôt disponible';

  @override
  String get shopModelOwnStock => 'Notre stock';

  @override
  String get shopModelBrand => 'Marque partenaire';

  @override
  String get shopModelDropship => 'Dropshipping';

  @override
  String get shopModelAffiliate => 'Lien d\'affiliation';

  @override
  String get shopModelOwnStockHelp => 'CodaMi stocke et expédie le produit.';

  @override
  String get shopModelBrandHelp =>
      'La marque vend via CodaMi et expédie la commande.';

  @override
  String get shopModelDropshipHelp =>
      'Un fournisseur expédie directement au client.';

  @override
  String get shopModelAffiliateHelp =>
      'Acheté sur le site du partenaire via notre lien ; CodaMi touche une commission.';

  @override
  String shopBuyOn(String partner) {
    return 'Acheter sur $partner';
  }

  @override
  String shopAffiliateNote(String partner) {
    return 'Vendu et expédié par $partner. CodaMi peut toucher une commission sur cet achat.';
  }

  @override
  String shopPriceOnPartner(String partner) {
    return 'Prix sur $partner';
  }

  @override
  String get shopAddToCart => 'Ajouter au panier';

  @override
  String get shopCheckoutSoon => 'L\'achat dans l\'app arrive bientôt.';

  @override
  String get shopAllAnimals => 'Pour tous les animaux';

  @override
  String get shopDescription => 'Description';

  @override
  String get shopOpenFailed => 'Impossible d\'ouvrir le lien.';

  @override
  String get shopPreviewOff =>
      'Aperçu : la boutique est fermée, les utilisateurs ne la voient pas.';

  @override
  String get shopAdminIntro =>
      'Gérez la boutique CodaMi. Les utilisateurs ne la voient que si elle est ouverte.';

  @override
  String get shopOpenSwitch => 'Boutique ouverte aux utilisateurs';

  @override
  String get shopOnHelp => 'Activée : tout le monde voit l\'onglet Boutique.';

  @override
  String get shopOffHelp =>
      'Désactivée : les utilisateurs ne la voient pas. Les admins peuvent la préparer.';

  @override
  String get shopTurnOnTitle => 'Ouvrir la boutique ?';

  @override
  String get shopTurnOnBody =>
      'Tous les utilisateurs verront aussitôt l\'onglet Boutique et les produits actifs.';

  @override
  String get shopTurnOffTitle => 'Fermer la boutique ?';

  @override
  String get shopTurnOffBody =>
      'L\'onglet Boutique disparaît aussitôt pour tous. Produits et réglages sont conservés.';

  @override
  String get shopTurnOn => 'Ouvrir';

  @override
  String get shopTurnOff => 'Fermer';

  @override
  String get shopSalesModels => 'Modes de vente';

  @override
  String get shopSalesModelsHelp =>
      'Désactiver un mode masque tous ses produits aux utilisateurs.';

  @override
  String get shopCatalog => 'Catalogue';

  @override
  String get shopProducts => 'Produits';

  @override
  String get shopCategories => 'Catégories';

  @override
  String get shopBrands => 'Marques';

  @override
  String get shopSuppliers => 'Fournisseurs';

  @override
  String get shopPreview => 'Aperçu de la boutique';

  @override
  String get shopPreviewSubtitle => 'Voir la boutique comme les utilisateurs';

  @override
  String shopProductsCount(int active, int total) {
    return '$active actifs · $total au total';
  }

  @override
  String get shopAddProduct => 'Ajouter un produit';

  @override
  String get shopEditProduct => 'Modifier le produit';

  @override
  String get shopProductsEmpty => 'Aucun produit. Ajoutez le premier.';

  @override
  String get shopActive => 'Actif';

  @override
  String get shopHidden => 'Masqué';

  @override
  String get shopNeedCategory =>
      'Ajoutez d\'abord une catégorie (Boutique → Catégories).';

  @override
  String get shopPhotos => 'Photos';

  @override
  String get shopPhotosHelp =>
      'Jusqu\'à 6 photos. La première est la couverture ; maintenez et glissez pour réordonner.';

  @override
  String get shopAddPhoto => 'Ajouter';

  @override
  String get shopImageTooBig => 'Les images doivent faire moins de 5 Mo.';

  @override
  String get shopDetails => 'Détails';

  @override
  String get shopName => 'Nom';

  @override
  String get shopCategory => 'Catégorie';

  @override
  String get shopPickCategory => 'Choisissez une catégorie';

  @override
  String get shopAnimals => 'Animaux';

  @override
  String get shopAnimalsHelp =>
      'Aucune sélection = pour tous les animaux. Les utilisateurs voient d\'abord les produits pour leurs animaux.';

  @override
  String get shopSalesModel => 'Mode de vente';

  @override
  String get shopPartnerName => 'Boutique partenaire';

  @override
  String get shopAffiliateUrl => 'Lien d\'affiliation';

  @override
  String get shopBrand => 'Marque';

  @override
  String get shopNoBrand => 'Aucune marque';

  @override
  String get shopSupplier => 'Fournisseur';

  @override
  String get shopNoSupplier => 'Aucun fournisseur';

  @override
  String get shopPriceSection => 'Prix';

  @override
  String get shopPrice => 'Prix (€)';

  @override
  String get shopPriceAffiliateHelp =>
      'Facultatif : les prix changent sur le site du partenaire.';

  @override
  String get shopPriceInvalid => 'Saisissez un prix, par exemple 12,90';

  @override
  String get shopCompareAt => 'Prix avant remise (€)';

  @override
  String get shopCompareAtHelp => 'Facultatif. Affiché barré à côté du prix.';

  @override
  String get shopCompareAtInvalid => 'Doit être supérieur au prix.';

  @override
  String get shopAvailability => 'Disponibilité';

  @override
  String get shopVisible => 'Visible par les utilisateurs';

  @override
  String get shopVisibleHelp =>
      'Les produits masqués ne sont visibles que par les admins.';

  @override
  String get shopCategoryVisibleHelp =>
      'Masquée, la catégorie et tous ses produits sont invisibles.';

  @override
  String get shopBrandVisibleHelp =>
      'Masquée, tous les produits de la marque sont invisibles.';

  @override
  String get shopSupplierActiveHelp =>
      'Désactivé, tous les produits de ce fournisseur sont invisibles.';

  @override
  String get shopDeleteProductTitle => 'Supprimer ce produit ?';

  @override
  String get shopDeleteProductBody =>
      'Il est retiré de la boutique avec ses photos. Action irréversible.';

  @override
  String shopDeleteTitle(String name) {
    return 'Supprimer $name ?';
  }

  @override
  String get shopDeleteBody => 'Action irréversible.';

  @override
  String get shopInUse =>
      'Encore utilisé par des produits ou sous-catégories : impossible de supprimer. Masquez-le plutôt.';

  @override
  String get shopFixFields => 'Vérifiez les champs en rouge.';

  @override
  String get shopLinkInvalid =>
      'Saisissez un lien complet commençant par https://';

  @override
  String get shopAddCategory => 'Ajouter une catégorie';

  @override
  String get shopEditCategory => 'Modifier la catégorie';

  @override
  String get shopAddStarting => 'Ajouter les catégories de départ';

  @override
  String get shopStartingHelp =>
      'Commencez avec nourriture, accessoires, soins, jouets, couchages, transport, tech et autres. Modifiables plus tard.';

  @override
  String get shopParent => 'Dans la catégorie';

  @override
  String get shopNoParent => 'Aucune (catégorie principale)';

  @override
  String get shopIcon => 'Icône';

  @override
  String get shopOrder => 'Position';

  @override
  String get shopOrderHelp => 'Les petits nombres passent en premier.';

  @override
  String get shopCatFood => 'Alimentation';

  @override
  String get shopCatAccessories => 'Accessoires';

  @override
  String get shopCatCare => 'Soins';

  @override
  String get shopCatToys => 'Jouets';

  @override
  String get shopCatBeds => 'Couchages';

  @override
  String get shopCatCarriers => 'Sacs de transport';

  @override
  String get shopCatTech => 'Tech';

  @override
  String get shopCatOther => 'Autres';

  @override
  String get shopAddBrand => 'Ajouter une marque';

  @override
  String get shopEditBrand => 'Modifier la marque';

  @override
  String get shopBrandsEmpty =>
      'Aucune marque. Elles sont facultatives ; ajoutez-les avec vos partenaires.';

  @override
  String get shopWebsite => 'Site web';

  @override
  String get shopLogo => 'Logo';

  @override
  String get shopAddLogo => 'Choisir un logo';

  @override
  String get shopAddSupplier => 'Ajouter un fournisseur';

  @override
  String get shopEditSupplier => 'Modifier le fournisseur';

  @override
  String get shopSuppliersEmpty => 'Aucun fournisseur.';

  @override
  String get shopSuppliersHelp =>
      'Seuls les admins voient les fournisseurs et leurs coordonnées. Désactiver un fournisseur masque ses produits.';

  @override
  String get shopContactName => 'Contact';

  @override
  String get shopEmail => 'E-mail';

  @override
  String get shopEmailInvalid => 'Saisissez une adresse e-mail valide.';

  @override
  String get shopPhone => 'Téléphone';

  @override
  String get shopOrderMethod => 'Transmission des commandes';

  @override
  String get shopOrderManual => 'Manuellement';

  @override
  String get shopOrderManualHelp =>
      'L\'équipe transmet chaque commande au fournisseur.';

  @override
  String get shopOrderEmail => 'E-mail automatique';

  @override
  String get shopOrderEmailHelp =>
      'Chaque commande payée est envoyée par e-mail au fournisseur (avec le paiement).';

  @override
  String get shopNotes => 'Notes (admins uniquement)';
}
