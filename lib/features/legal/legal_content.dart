import 'translations/legal_ar.dart';
import 'translations/legal_de.dart';
import 'translations/legal_en.dart';
import 'translations/legal_es.dart';
import 'translations/legal_fr.dart';
import 'translations/legal_hi.dart';
import 'translations/legal_it.dart';
import 'translations/legal_pt.dart';
import 'translations/legal_ru.dart';
import 'translations/legal_zh.dart';

// Opened by the contact button; never shown in the text.
const legalEmail = '[support@email]';

final legalUpdated = DateTime(2026, 10, 12);

enum LegalDocument { privacy, terms }

class LegalSection {
  final String heading;
  final String body;

  const LegalSection(this.heading, this.body);
}

List<LegalSection> legalSections(LegalDocument doc, String languageCode) {
  final (privacy, terms) = switch (languageCode) {
    'it' => (privacyIt, termsIt),
    'de' => (privacyDe, termsDe),
    'es' => (privacyEs, termsEs),
    'fr' => (privacyFr, termsFr),
    'pt' => (privacyPt, termsPt),
    'ru' => (privacyRu, termsRu),
    'zh' => (privacyZh, termsZh),
    'ar' => (privacyAr, termsAr),
    'hi' => (privacyHi, termsHi),
    _ => (privacyEn, termsEn),
  };
  return doc == LegalDocument.privacy ? privacy : terms;
}
