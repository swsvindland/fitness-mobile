// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get bpTrack => 'Traccia della pressione sanguigna';

  @override
  String get settings => 'Impostazioni';

  @override
  String get about => 'Di';

  @override
  String get aboutPageCredits => 'Progettato e costruito da';

  @override
  String get aboutPageVersion => 'Versione';

  @override
  String get logOut => 'Disconnettersi';

  @override
  String get googleSignIn => 'Continua con Google';

  @override
  String get appleSignIn => 'Continua con Apple';

  @override
  String get anonSignIn => 'Continua senza account';

  @override
  String get checkIn => 'Registrare';

  @override
  String get systolic => 'Sistolico';

  @override
  String get diastolic => 'Diastolico';

  @override
  String get heartRate => 'Frequenza cardiaca';

  @override
  String get goBack => 'Torna indietro';

  @override
  String get formInputError => 'Inserisci una misura';

  @override
  String get submit => 'Invia';

  @override
  String get saving => 'Salvataggio...';

  @override
  String get deleteAccount => 'Eliminare l\'account';

  @override
  String get deleteAccountConfirm =>
      'Ciò eliminerà per sempre il tuo account e tutti i dati utente. Sei sicuro?';

  @override
  String get delete => 'Eliminare';

  @override
  String get cancel => 'Annulla';

  @override
  String get noHeartDate =>
      'Sembra che tu non abbia alcuna frequenza cardiaca. Fai clic sull\'icona più per iniziare.';

  @override
  String get noBloodPressureData =>
      'Sembra che tu non abbia dati sulla pressione sanguigna. Fai clic sull\'icona più per iniziare.';

  @override
  String get processingData => 'Elaborazione dei dati...';

  @override
  String get avgHeartRate => 'Frequenza cardiaca media';

  @override
  String get avgBloodPressure => 'Pressione sanguigna media';

  @override
  String get last30 => 'Ultimi 30 giorni';

  @override
  String get home => 'Casa';

  @override
  String get all => 'Tutto';
}
