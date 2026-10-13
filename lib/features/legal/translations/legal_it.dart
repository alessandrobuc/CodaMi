import '../legal_content.dart';

const privacyIt = [
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

const termsIt = [
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
