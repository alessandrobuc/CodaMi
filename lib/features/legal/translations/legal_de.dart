import '../legal_content.dart';

const privacyDe = [
  LegalSection(
    "Wer wir sind",
    "CodaMi hilft Nachbarn, verlorene Haustiere wiederzufinden und gefundene Tiere zu ihren Familien zurückzubringen. Verantwortlicher für die Datenverarbeitung ist CodaMi. Du kannst uns jederzeit über die Schaltfläche unten auf dieser Seite kontaktieren.",
  ),
  LegalSection(
    "Welche Daten wir erheben",
    "• Konto: dein Name, deine E-Mail-Adresse und dein Passwort. Passwörter werden von Firebase Authentication verwaltet und wir sehen sie nie. Wenn du dich mit Google oder Apple anmeldest, erhalten wir von dort deinen Namen, deine E-Mail-Adresse und dein Profilfoto.\n"
        "• Profil: deine Stadt, deine gewählte Sprache und, falls du sie zu einer Meldung hinzufügst, deine Telefonnummer.\n"
        "• Haustiere: die Angaben, die du machst (Name, Tierart, Rasse, Farbe, Geschlecht, Alter, besondere Merkmale), und ihre Fotos.\n"
        "• Meldungen: Angaben zum Tier, Fotos, Beschreibung, Datum und Uhrzeit, das Gebiet, in dem das Tier verloren oder gefunden wurde, und die Kontaktdaten, die du anzeigen möchtest.\n"
        "• Benachrichtigungen: ein Gerätetoken, damit wir Hinweise an dein Telefon senden können, und die Liste der erhaltenen Hinweise.\n"
        "• Standort: nur wenn du auf „Meinen Standort verwenden“ oder „Mein Standort“ tippst. Er wird auf deinem Telefon verwendet, um die Markierung zu setzen, und nicht separat gespeichert.",
  ),
  LegalSection(
    "Wie wir Standorte schützen",
    "Bevor eine Meldung gespeichert wird, wird der Standort an einen zufälligen Punkt im Umkreis von etwa 100 m verschoben und Hausnummern werden aus Straßennamen entfernt. Andere sehen nur ein Gebiet von etwa 100 m, nie deine genaue Adresse.",
  ),
  LegalSection(
    "Wofür wir deine Daten verwenden",
    "• Um CodaMi zu betreiben: dein Konto erstellen, Meldungen auf der Karte und in Listen anzeigen und Menschen ermöglichen, sich wegen eines Tieres zu kontaktieren (Erfüllung unseres Vertrags mit dir).\n"
        "• Um dir Hinweise zu senden, wenn in deiner Stadt ein Tier verloren oder gefunden wird. Du kannst sie in den Einstellungen deines Telefons deaktivieren.\n"
        "• Um CodaMi sicher zu halten und Missbrauch zu verhindern (unser berechtigtes Interesse).\n"
        "• Um gesetzliche Pflichten zu erfüllen, wenn erforderlich.",
  ),
  LegalSection(
    "Wer deine Daten sehen kann",
    "• Meldungen sind für alle angemeldeten CodaMi-Nutzer sichtbar: Angaben zum Tier, Fotos, Beschreibung, ungefähres Gebiet, dein Name und die Kontaktdaten, die du teilen möchtest.\n"
        "• Die Profile deiner Haustiere, deine E-Mail-Adresse und deine Stadt sind privat.\n"
        "• Wir verkaufen deine Daten nicht und zeigen keine Werbung.",
  ),
  LegalSection(
    "Dienstleister",
    "Wir nutzen Google Firebase (Authentication, Cloud Firestore, Cloud Storage, Cloud Functions und Cloud Messaging), um Daten zu speichern und Benachrichtigungen zu senden, sowie die Google Maps Platform für Karten und Ortssuche. Die Anmeldung mit Google und mit Apple wird von Google und Apple bereitgestellt. Diese Anbieter verarbeiten Daten in unserem Auftrag. Ein Teil der Verarbeitung kann außerhalb der Europäischen Union stattfinden und ist durch die Standardvertragsklauseln der Europäischen Kommission geschützt.",
  ),
  LegalSection(
    "Wie lange wir sie speichern",
    "Wir speichern deine Daten, solange dein Konto besteht. Meldungen bleiben sichtbar, bis du sie oder dein Konto löschst. Wenn du dein Konto löschst, werden dein Profil, deine Haustiere, Meldungen, Fotos und Anmeldedaten aus unseren Systemen gelöscht.",
  ),
  LegalSection(
    "Deine Rechte",
    "Nach der DSGVO kannst du auf deine Daten zugreifen, sie berichtigen oder löschen lassen, ihre Verarbeitung einschränken oder ihr widersprechen, eine Kopie erhalten und deine Einwilligung jederzeit widerrufen. Schreib uns über die Schaltfläche unten auf dieser Seite. Du kannst dich auch bei der italienischen Datenschutzbehörde beschweren (Garante per la protezione dei dati personali, www.garanteprivacy.it).",
  ),
  LegalSection(
    "Konto löschen",
    "Du kannst dein Konto jederzeit in der App löschen: Profil → Konto löschen. Dadurch werden dein Profil, deine Haustiere, Meldungen, Fotos und Anmeldedaten dauerhaft entfernt.",
  ),
  LegalSection(
    "Kinder",
    "CodaMi ist nicht für Kinder unter 14 Jahren bestimmt. Wenn wir erfahren, dass ein Kind unter 14 Jahren ein Konto erstellt hat, löschen wir es.",
  ),
  LegalSection(
    "Sicherheit",
    "Daten werden über verschlüsselte Verbindungen übertragen. Zugriffsregeln stellen sicher, dass nur du deine eigenen Haustiere und Meldungen ändern kannst und nur angemeldete Nutzer Meldungen sehen können.",
  ),
  LegalSection(
    "Änderungen dieser Datenschutzerklärung",
    "Wenn wir wichtige Änderungen vornehmen, informieren wir dich in der App, bevor sie in Kraft treten.",
  ),
];

const termsDe = [
  LegalSection(
    "Über CodaMi",
    "CodaMi ist eine kostenlose Community-App, mit der Menschen verlorene und gefundene Haustiere melden und miteinander in Kontakt treten können. Mit der Erstellung eines Kontos akzeptierst du diese Bedingungen.",
  ),
  LegalSection(
    "Dein Konto",
    "• Du musst mindestens 14 Jahre alt sein.\n"
        "• Mach korrekte Angaben und halte dein Passwort geheim.\n"
        "• Du bist für alles verantwortlich, was über dein Konto geschieht.",
  ),
  LegalSection(
    "Meldungen und Fotos",
    "• Veröffentliche nur wahre Meldungen über tatsächlich verlorene oder gefundene Tiere.\n"
        "• Lade nur Fotos hoch, die du selbst gemacht hast oder verwenden darfst.\n"
        "• Halte deine Meldungen aktuell und markiere sie als erledigt, wenn das Tier in Sicherheit ist.\n"
        "• Gib keine persönlichen Daten anderer Personen oder genaue Wohnadressen an.",
  ),
  LegalSection(
    "Was nicht erlaubt ist",
    "• Falsche, irreführende oder doppelte Meldungen.\n"
        "• Verkauf, Kauf oder Abgabe von Tieren.\n"
        "• Spam, Werbung, Betrug oder Geldforderungen.\n"
        "• Belästigung, Drohungen, Hassrede oder anstößige Inhalte.\n"
        "• Die Kontaktdaten anderer für etwas anderes zu nutzen, als ihrem Tier zu helfen.\n"
        "• Daten von CodaMi automatisiert zu kopieren oder zu versuchen, die Sicherheit zu umgehen.",
  ),
  LegalSection(
    "Treffen und Rückgabe von Tieren",
    "CodaMi überprüft weder Nutzer noch die von ihnen geteilten Informationen. Trefft euch an öffentlichen Orten, verlange einen Eigentumsnachweis (Fotos, Impfpass, Mikrochip), bevor du ein Tier übergibst, und wende dich an die Polizei oder die örtlichen Behörden, wenn dir etwas seltsam vorkommt. Jede Vereinbarung oder jedes Treffen findet zwischen dir und der anderen Person statt.",
  ),
  LegalSection(
    "Deine Inhalte",
    "Die Fotos und Texte, die du veröffentlichst, bleiben dein Eigentum. Du erlaubst uns, sie in CodaMi zu speichern und anzuzeigen, damit die App funktioniert. Wenn du eine Meldung oder dein Konto löschst, zeigen wir diese Inhalte nicht mehr an.",
  ),
  LegalSection(
    "Moderation",
    "Wir können Inhalte entfernen oder Konten sperren, die gegen diese Bedingungen verstoßen oder Menschen oder Tiere gefährden.",
  ),
  LegalSection(
    "Keine Garantie",
    "Wir setzen uns dafür ein, dass CodaMi verfügbar und korrekt ist, doch die App wird „wie besehen“ bereitgestellt. Wir können nicht garantieren, dass ein Tier gefunden wird oder dass von Nutzern geteilte Informationen richtig sind.",
  ),
  LegalSection(
    "Haftung",
    "Soweit gesetzlich zulässig, haften wir nicht für mittelbare Schäden oder für das Verhalten anderer Nutzer. Nichts in diesen Bedingungen schränkt deine Rechte als Verbraucher nach italienischem und EU-Recht ein.",
  ),
  LegalSection(
    "Konto löschen",
    "Du kannst CodaMi jederzeit nicht mehr nutzen und dein Konto löschen: Profil → Konto löschen.",
  ),
  LegalSection(
    "Änderungen dieser Bedingungen",
    "Wenn wir wichtige Änderungen vornehmen, informieren wir dich in der App, bevor sie in Kraft treten.",
  ),
  LegalSection(
    "Recht und Kontakt",
    "Diese Bedingungen unterliegen italienischem Recht. Als Verbraucher kannst du dich auch an die Gerichte deines Wohnorts wenden. Fragen? Schreib uns über die Schaltfläche unten auf dieser Seite.",
  ),
];
