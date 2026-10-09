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
  String get language => 'Lingua';

  @override
  String get phoneLanguage => 'Lingua del telefono';

  @override
  String get phoneLanguageHint => 'Usa le impostazioni del telefono';

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
}
