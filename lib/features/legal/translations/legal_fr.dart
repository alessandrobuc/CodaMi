import '../legal_content.dart';

const privacyFr = [
  LegalSection(
    "Qui sommes-nous",
    "CodaMi aide les voisins à retrouver les animaux perdus et à ramener les animaux trouvés à leur famille. Le responsable du traitement est CodaMi. Vous pouvez nous contacter à tout moment grâce au bouton en bas de cette page.",
  ),
  LegalSection(
    "Les données que nous collectons",
    "• Compte : votre nom, votre adresse e-mail et votre mot de passe. Les mots de passe sont gérés par Firebase Authentication et nous ne les voyons jamais. Si vous vous connectez avec Google ou Apple, nous recevons d'eux votre nom, votre e-mail et votre photo de profil.\n"
        "• Profil : votre ville, la langue choisie et, si vous l'ajoutez à un signalement, votre numéro de téléphone.\n"
        "• Animaux : les informations que vous saisissez (nom, espèce, race, couleur, sexe, âge, signes distinctifs) et leurs photos.\n"
        "• Signalements : informations sur l'animal, photos, description, date et heure, la zone où l'animal a été perdu ou trouvé, et les coordonnées que vous choisissez d'afficher.\n"
        "• Notifications : un identifiant de l'appareil pour vous envoyer des alertes et la liste des alertes reçues.\n"
        "• Position : uniquement lorsque vous touchez « Utiliser ma position » ou « Ma position ». Elle sert sur votre téléphone à placer le repère et n'est pas enregistrée séparément.",
  ),
  LegalSection(
    "Comment nous protégeons les positions",
    "Avant l'enregistrement d'un signalement, la position est déplacée vers un point aléatoire dans un rayon d'environ 100 m et les numéros de rue sont retirés des noms de rues. Les autres ne voient qu'une zone d'environ 100 m, jamais votre adresse exacte.",
  ),
  LegalSection(
    "Pourquoi nous utilisons vos données",
    "• Pour faire fonctionner CodaMi : créer votre compte, afficher les signalements sur la carte et dans les listes, et permettre aux personnes de se contacter au sujet d'un animal (exécution de notre accord avec vous).\n"
        "• Pour vous envoyer des alertes lorsqu'un animal est perdu ou trouvé dans votre ville. Vous pouvez les désactiver dans les réglages de votre téléphone.\n"
        "• Pour assurer la sécurité de CodaMi et prévenir les abus (notre intérêt légitime).\n"
        "• Pour respecter la loi lorsque c'est nécessaire.",
  ),
  LegalSection(
    "Qui peut voir vos données",
    "• Les signalements sont visibles par tous les utilisateurs connectés de CodaMi : informations sur l'animal, photos, description, zone approximative, votre nom et les coordonnées que vous avez choisi de partager.\n"
        "• Les profils de vos animaux, votre adresse e-mail et votre ville sont privés.\n"
        "• Nous ne vendons pas vos données et n'affichons pas de publicité.",
  ),
  LegalSection(
    "Prestataires de services",
    "Nous utilisons Google Firebase (Authentication, Cloud Firestore, Cloud Storage, Cloud Functions et Cloud Messaging) pour stocker les données et envoyer les notifications, et Google Maps Platform pour les cartes et la recherche de lieux. La connexion avec Google et avec Apple est fournie par Google et Apple. Ces prestataires traitent les données pour notre compte. Certains traitements peuvent avoir lieu hors de l'Union européenne, encadrés par les clauses contractuelles types de la Commission européenne.",
  ),
  LegalSection(
    "Durée de conservation",
    "Nous conservons vos données tant que votre compte existe. Les signalements restent visibles jusqu'à ce que vous les supprimiez ou supprimiez votre compte. Lorsque vous supprimez votre compte, votre profil, vos animaux, signalements, photos et identifiants sont effacés de nos systèmes.",
  ),
  LegalSection(
    "Vos droits",
    "Conformément au RGPD, vous pouvez accéder à vos données, les rectifier ou les effacer, limiter leur utilisation ou vous y opposer, en recevoir une copie et retirer votre consentement à tout moment. Écrivez-nous grâce au bouton en bas de cette page. Vous pouvez également introduire une réclamation auprès de l'autorité italienne de protection des données (Garante per la protezione dei dati personali, www.garanteprivacy.it).",
  ),
  LegalSection(
    "Supprimer votre compte",
    "Vous pouvez supprimer votre compte à tout moment dans l'application : Profil → Supprimer le compte. Votre profil, vos animaux, signalements, photos et identifiants sont alors définitivement supprimés.",
  ),
  LegalSection(
    "Enfants",
    "CodaMi n'est pas destinée aux enfants de moins de 14 ans. Si nous apprenons qu'un enfant de moins de 14 ans a créé un compte, nous le supprimerons.",
  ),
  LegalSection(
    "Sécurité",
    "Les données transitent par des connexions chiffrées. Des règles d'accès garantissent que vous seul pouvez modifier vos animaux et vos signalements, et que seuls les utilisateurs connectés peuvent voir les signalements.",
  ),
  LegalSection(
    "Modifications de cette politique",
    "Si nous apportons des modifications importantes, nous vous en informerons dans l'application avant leur entrée en vigueur.",
  ),
];

const termsFr = [
  LegalSection(
    "À propos de CodaMi",
    "CodaMi est une application communautaire gratuite qui aide les gens à signaler des animaux perdus et trouvés et à se mettre en relation. En créant un compte, vous acceptez ces conditions.",
  ),
  LegalSection(
    "Votre compte",
    "• Vous devez avoir au moins 14 ans.\n"
        "• Fournissez des informations exactes et gardez votre mot de passe en sécurité.\n"
        "• Vous êtes responsable de ce qui se passe sur votre compte.",
  ),
  LegalSection(
    "Signalements et photos",
    "• Publiez uniquement des signalements véridiques concernant des animaux réellement perdus ou trouvés.\n"
        "• Ne mettez en ligne que des photos que vous avez prises ou que vous avez le droit d'utiliser.\n"
        "• Tenez vos signalements à jour et marquez-les comme résolus lorsque l'animal est en sécurité.\n"
        "• N'indiquez pas de données personnelles d'autres personnes ni d'adresses exactes de domicile.",
  ),
  LegalSection(
    "Ce qui est interdit",
    "• Les signalements faux, trompeurs ou en double.\n"
        "• Vendre, acheter ou donner des animaux.\n"
        "• Le spam, la publicité, les arnaques ou les demandes d'argent.\n"
        "• Le harcèlement, les menaces, les discours haineux ou les contenus offensants.\n"
        "• Utiliser les coordonnées de quelqu'un à d'autres fins que d'aider son animal.\n"
        "• Copier automatiquement les données de CodaMi ou tenter d'en contourner la sécurité.",
  ),
  LegalSection(
    "Rencontres et restitution des animaux",
    "CodaMi ne vérifie ni les utilisateurs ni les informations qu'ils partagent. Rencontrez-vous dans des lieux publics, demandez une preuve de propriété (photos, carnet de santé, puce électronique) avant de remettre un animal, et contactez la police ou les autorités locales si quelque chose vous semble suspect. Tout accord ou rendez-vous se fait entre vous et l'autre personne.",
  ),
  LegalSection(
    "Votre contenu",
    "Vous restez propriétaire des photos et des textes que vous publiez. Vous nous autorisez à les stocker et à les afficher dans CodaMi pour que l'application fonctionne. Lorsque vous supprimez un signalement ou votre compte, nous cessons d'afficher ce contenu.",
  ),
  LegalSection(
    "Modération",
    "Nous pouvons retirer des contenus ou suspendre des comptes qui enfreignent ces conditions ou mettent en danger des personnes ou des animaux.",
  ),
  LegalSection(
    "Absence de garantie",
    "Nous faisons tout pour que CodaMi reste disponible et exacte, mais elle est fournie « en l'état ». Nous ne pouvons pas garantir qu'un animal sera retrouvé ni que les informations partagées par les utilisateurs sont exactes.",
  ),
  LegalSection(
    "Responsabilité",
    "Dans les limites permises par la loi, nous ne sommes pas responsables des dommages indirects ni du comportement des autres utilisateurs. Rien dans ces conditions ne limite vos droits de consommateur prévus par le droit italien et européen.",
  ),
  LegalSection(
    "Supprimer votre compte",
    "Vous pouvez cesser d'utiliser CodaMi et supprimer votre compte à tout moment : Profil → Supprimer le compte.",
  ),
  LegalSection(
    "Modifications de ces conditions",
    "Si nous apportons des modifications importantes, nous vous en informerons dans l'application avant leur entrée en vigueur.",
  ),
  LegalSection(
    "Droit applicable et contact",
    "Ces conditions sont régies par le droit italien. Si vous êtes un consommateur, vous pouvez aussi saisir les tribunaux de votre lieu de résidence. Des questions ? Écrivez-nous grâce au bouton en bas de cette page.",
  ),
];
