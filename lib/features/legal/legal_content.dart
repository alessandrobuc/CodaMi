// Opened by the contact button; never shown in the text.
const legalEmail = '[support@email]';

final legalUpdated = DateTime(2026, 10, 12);

enum LegalDocument { privacy, terms }

class LegalSection {
  final String heading;
  final String body;

  const LegalSection(this.heading, this.body);
}

// Only English and Italian are written; other languages show English.
List<LegalSection> legalSections(LegalDocument doc, String languageCode) {
  final italian = languageCode == 'it';
  return switch (doc) {
    LegalDocument.privacy => italian ? _privacyIt : _privacyEn,
    LegalDocument.terms => italian ? _termsIt : _termsEn,
  };
}

const _privacyEn = [
  LegalSection(
    "Who we are",
    "CodaMi helps neighbours find lost pets and reunite found pets with their families. The data controller is CodaMi. You can contact us at any time with the button at the bottom of this page.",
  ),
  LegalSection(
    "What data we collect",
    "• Account: your name, email address and password. Passwords are handled by Firebase Authentication and we never see them. If you sign in with Google or Apple, we receive your name, email and profile photo from them.\n"
        "• Profile: your home city, your chosen language and, if you add one to a report, your phone number.\n"
        "• Pets: the details you enter (name, species, breed, colour, sex, age, distinctive features) and their photos.\n"
        "• Reports: pet details, photos, description, date and time, the area where the pet was lost or found, and the contact details you choose to show.\n"
        "• Notifications: a device token so we can send alerts to your phone, and the list of alerts you received.\n"
        "• Location: only when you tap \"Use my location\" or \"My location\". It is used on your phone to place the pin and is not stored on its own.",
  ),
  LegalSection(
    "How we protect locations",
    "Before a report is saved, the location is moved to a random point within about 100 m and house numbers are removed from street names. Other people only see an area of about 100 m, never your exact address.",
  ),
  LegalSection(
    "Why we use your data",
    "• To run CodaMi: create your account, show reports on the map and in lists, and let people contact each other about a pet (performance of our agreement with you).\n"
        "• To send alerts when a pet is lost or found in your city. You can turn these off in your phone settings.\n"
        "• To keep CodaMi safe and prevent abuse (our legitimate interest).\n"
        "• To comply with the law when required.",
  ),
  LegalSection(
    "Who can see your data",
    "• Reports are visible to all signed-in CodaMi users: pet details, photos, description, approximate area, your name and the contact details you chose to share.\n"
        "• Your pets' profiles, your email address and your home city are private.\n"
        "• We do not sell your data and we do not show advertising.",
  ),
  LegalSection(
    "Service providers",
    "We use Google Firebase (Authentication, Cloud Firestore, Cloud Storage, Cloud Functions and Cloud Messaging) to store data and send notifications, and Google Maps Platform for maps and place search. Sign in with Google and Sign in with Apple are provided by Google and Apple. These providers process data on our behalf. Some processing may take place outside the European Union, protected by the European Commission's Standard Contractual Clauses.",
  ),
  LegalSection(
    "How long we keep it",
    "We keep your data while your account exists. Reports stay visible until you delete them or your account. When you delete your account, your profile, pets, reports, photos and login are deleted from our systems.",
  ),
  LegalSection(
    "Your rights",
    "Under the GDPR you can access, correct or delete your data, restrict or object to its use, receive a copy of it, and withdraw consent at any time. Write to us with the button at the bottom of this page. You can also complain to the Italian data protection authority (Garante per la protezione dei dati personali, www.garanteprivacy.it).",
  ),
  LegalSection(
    "Deleting your account",
    "You can delete your account at any time in the app: Profile → Delete account. This permanently removes your profile, pets, reports, photos and login.",
  ),
  LegalSection(
    "Children",
    "CodaMi is not intended for children under 14. If we learn that a child under 14 has created an account, we will delete it.",
  ),
  LegalSection(
    "Security",
    "Data is sent over encrypted connections. Access rules make sure only you can change your own pets and reports, and only signed-in users can see reports.",
  ),
  LegalSection(
    "Changes to this policy",
    "If we make important changes, we will tell you in the app before they take effect.",
  ),
];

const _privacyIt = [
  LegalSection(
    "Chi siamo",
    "CodaMi aiuta i vicini a ritrovare gli animali smarriti e a riportare a casa quelli trovati. Il titolare del trattamento è CodaMi. Puoi contattarci in qualsiasi momento con il pulsante in fondo a questa pagina.",
  ),
  LegalSection(
    "Quali dati raccogliamo",
    "• Account: nome, indirizzo email e password. Le password sono gestite da Firebase Authentication e non le vediamo mai. Se accedi con Google o Apple, riceviamo da loro nome, email e foto del profilo.\n"
        "• Profilo: la tua città, la lingua scelta e, se lo aggiungi a una segnalazione, il tuo numero di telefono.\n"
        "• Animali: i dati che inserisci (nome, specie, razza, colore, sesso, età, segni particolari) e le loro foto.\n"
        "• Segnalazioni: dati dell'animale, foto, descrizione, data e ora, la zona in cui è stato smarrito o trovato e i contatti che scegli di mostrare.\n"
        "• Notifiche: un identificativo del dispositivo per inviarti gli avvisi e l'elenco degli avvisi ricevuti.\n"
        "• Posizione: solo quando tocchi \"Usa la mia posizione\" o \"La mia posizione\". Viene usata sul telefono per posizionare il segnaposto e non viene salvata da sola.",
  ),
  LegalSection(
    "Come proteggiamo le posizioni",
    "Prima di salvare una segnalazione, la posizione viene spostata in un punto casuale entro circa 100 m e i numeri civici vengono rimossi dai nomi delle vie. Gli altri vedono solo una zona di circa 100 m, mai il tuo indirizzo esatto.",
  ),
  LegalSection(
    "Perché usiamo i tuoi dati",
    "• Per far funzionare CodaMi: creare il tuo account, mostrare le segnalazioni sulla mappa e negli elenchi e permettere alle persone di contattarsi per un animale (esecuzione del contratto con te).\n"
        "• Per inviarti avvisi quando un animale viene smarrito o trovato nella tua città. Puoi disattivarli nelle impostazioni del telefono.\n"
        "• Per mantenere CodaMi sicura e prevenire abusi (nostro legittimo interesse).\n"
        "• Per adempiere agli obblighi di legge, quando necessario.",
  ),
  LegalSection(
    "Chi può vedere i tuoi dati",
    "• Le segnalazioni sono visibili a tutti gli utenti registrati di CodaMi: dati dell'animale, foto, descrizione, zona approssimativa, il tuo nome e i contatti che hai scelto di condividere.\n"
        "• I profili dei tuoi animali, il tuo indirizzo email e la tua città sono privati.\n"
        "• Non vendiamo i tuoi dati e non mostriamo pubblicità.",
  ),
  LegalSection(
    "Fornitori di servizi",
    "Usiamo Google Firebase (Authentication, Cloud Firestore, Cloud Storage, Cloud Functions e Cloud Messaging) per conservare i dati e inviare notifiche, e Google Maps Platform per mappe e ricerca dei luoghi. L'accesso con Google e con Apple è fornito da Google e Apple. Questi fornitori trattano i dati per nostro conto. Alcuni trattamenti possono avvenire fuori dall'Unione europea, tutelati dalle Clausole contrattuali tipo della Commissione europea.",
  ),
  LegalSection(
    "Per quanto tempo li conserviamo",
    "Conserviamo i tuoi dati finché esiste il tuo account. Le segnalazioni restano visibili finché non le elimini tu o elimini l'account. Quando elimini l'account, profilo, animali, segnalazioni, foto e credenziali di accesso vengono cancellati dai nostri sistemi.",
  ),
  LegalSection(
    "I tuoi diritti",
    "In base al GDPR puoi accedere ai tuoi dati, correggerli o cancellarli, limitarne o opporti al loro uso, riceverne una copia e revocare il consenso in qualsiasi momento. Scrivici con il pulsante in fondo a questa pagina. Puoi anche presentare reclamo al Garante per la protezione dei dati personali (www.garanteprivacy.it).",
  ),
  LegalSection(
    "Eliminare l'account",
    "Puoi eliminare il tuo account in qualsiasi momento dall'app: Profilo → Elimina account. Verranno rimossi per sempre profilo, animali, segnalazioni, foto e credenziali di accesso.",
  ),
  LegalSection(
    "Minori",
    "CodaMi non è destinata ai minori di 14 anni. Se scopriamo che un minore di 14 anni ha creato un account, lo elimineremo.",
  ),
  LegalSection(
    "Sicurezza",
    "I dati viaggiano su connessioni cifrate. Le regole di accesso garantiscono che solo tu possa modificare i tuoi animali e le tue segnalazioni e che solo gli utenti registrati possano vedere le segnalazioni.",
  ),
  LegalSection(
    "Modifiche a questa informativa",
    "Se apportiamo modifiche importanti, te lo comunicheremo nell'app prima che entrino in vigore.",
  ),
];

const _termsEn = [
  LegalSection(
    "About CodaMi",
    "CodaMi is a free community app that helps people report lost and found pets and get in touch with each other. By creating an account you accept these terms.",
  ),
  LegalSection(
    "Your account",
    "• You must be at least 14 years old.\n"
        "• Give accurate information and keep your password safe.\n"
        "• You are responsible for what happens on your account.",
  ),
  LegalSection(
    "Reports and photos",
    "• Only publish true reports about real lost or found pets.\n"
        "• Only upload photos you took or have the right to use.\n"
        "• Keep your reports up to date and mark them as resolved when the pet is safe.\n"
        "• Do not include other people's personal details or exact home addresses.",
  ),
  LegalSection(
    "What is not allowed",
    "• False, misleading or duplicate reports.\n"
        "• Selling, buying or giving away animals.\n"
        "• Spam, advertising, scams or requests for money.\n"
        "• Harassment, threats, hate speech or offensive content.\n"
        "• Using someone's contact details for anything other than helping their pet.\n"
        "• Copying data from CodaMi automatically or trying to break its security.",
  ),
  LegalSection(
    "Meeting people and returning pets",
    "CodaMi does not verify users or the information they share. Meet in public places, ask for proof of ownership (photos, vet records, microchip) before handing over a pet, and contact the police or local authorities if something seems wrong. Any agreement or meeting is between you and the other person.",
  ),
  LegalSection(
    "Your content",
    "You keep ownership of the photos and text you publish. You allow us to store and show them in CodaMi so the app can work. When you delete a report or your account, we stop showing that content.",
  ),
  LegalSection(
    "Moderation",
    "We may remove content or suspend accounts that break these terms or put people or animals at risk.",
  ),
  LegalSection(
    "No guarantees",
    "We work hard to keep CodaMi available and accurate, but it is provided \"as is\". We cannot guarantee that a pet will be found or that information shared by users is correct.",
  ),
  LegalSection(
    "Liability",
    "To the extent allowed by law, we are not liable for indirect losses or for the behaviour of other users. Nothing in these terms limits your rights as a consumer under Italian and EU law.",
  ),
  LegalSection(
    "Deleting your account",
    "You can stop using CodaMi and delete your account at any time: Profile → Delete account.",
  ),
  LegalSection(
    "Changes to these terms",
    "If we make important changes, we will tell you in the app before they take effect.",
  ),
  LegalSection(
    "Law and contact",
    "These terms are governed by Italian law. If you are a consumer, you can also use the courts of the place where you live. Questions? Write to us with the button at the bottom of this page.",
  ),
];

const _termsIt = [
  LegalSection(
    "Cos'è CodaMi",
    "CodaMi è un'app gratuita della comunità che aiuta le persone a segnalare animali smarriti e trovati e a mettersi in contatto. Creando un account accetti questi termini.",
  ),
  LegalSection(
    "Il tuo account",
    "• Devi avere almeno 14 anni.\n"
        "• Fornisci informazioni corrette e custodisci la tua password.\n"
        "• Sei responsabile di ciò che avviene con il tuo account.",
  ),
  LegalSection(
    "Segnalazioni e foto",
    "• Pubblica solo segnalazioni vere su animali realmente smarriti o trovati.\n"
        "• Carica solo foto scattate da te o che hai il diritto di usare.\n"
        "• Tieni aggiornate le tue segnalazioni e contrassegnale come risolte quando l'animale è al sicuro.\n"
        "• Non inserire dati personali di altre persone o indirizzi di casa esatti.",
  ),
  LegalSection(
    "Cosa non è consentito",
    "• Segnalazioni false, ingannevoli o duplicate.\n"
        "• Vendere, comprare o cedere animali.\n"
        "• Spam, pubblicità, truffe o richieste di denaro.\n"
        "• Molestie, minacce, incitamento all'odio o contenuti offensivi.\n"
        "• Usare i contatti di qualcuno per scopi diversi dall'aiutare il suo animale.\n"
        "• Copiare automaticamente i dati di CodaMi o tentare di violarne la sicurezza.",
  ),
  LegalSection(
    "Incontri e restituzione degli animali",
    "CodaMi non verifica gli utenti né le informazioni che condividono. Incontratevi in luoghi pubblici, chiedi una prova della proprietà (foto, libretto del veterinario, microchip) prima di consegnare un animale e contatta le forze dell'ordine o le autorità locali se qualcosa non ti convince. Ogni accordo o incontro avviene tra te e l'altra persona.",
  ),
  LegalSection(
    "I tuoi contenuti",
    "Le foto e i testi che pubblichi restano tuoi. Ci autorizzi a conservarli e mostrarli in CodaMi per far funzionare l'app. Quando elimini una segnalazione o l'account, smettiamo di mostrare quei contenuti.",
  ),
  LegalSection(
    "Moderazione",
    "Possiamo rimuovere contenuti o sospendere account che violano questi termini o mettono a rischio persone o animali.",
  ),
  LegalSection(
    "Nessuna garanzia",
    "Ci impegniamo a mantenere CodaMi disponibile e accurata, ma è fornita \"così com'è\". Non possiamo garantire che un animale venga ritrovato o che le informazioni condivise dagli utenti siano corrette.",
  ),
  LegalSection(
    "Responsabilità",
    "Nei limiti consentiti dalla legge, non siamo responsabili per danni indiretti o per il comportamento di altri utenti. Nulla in questi termini limita i tuoi diritti di consumatore previsti dalla legge italiana ed europea.",
  ),
  LegalSection(
    "Eliminare l'account",
    "Puoi smettere di usare CodaMi ed eliminare il tuo account in qualsiasi momento: Profilo → Elimina account.",
  ),
  LegalSection(
    "Modifiche a questi termini",
    "Se apportiamo modifiche importanti, te lo comunicheremo nell'app prima che entrino in vigore.",
  ),
  LegalSection(
    "Legge applicabile e contatti",
    "Questi termini sono regolati dalla legge italiana. Se sei un consumatore, puoi rivolgerti anche al giudice del luogo in cui risiedi. Domande? Scrivici con il pulsante in fondo a questa pagina.",
  ),
];
