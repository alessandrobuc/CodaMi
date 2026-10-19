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
}
