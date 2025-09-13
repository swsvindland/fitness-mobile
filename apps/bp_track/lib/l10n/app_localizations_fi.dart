// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get bpTrack => 'Verenpainerata';

  @override
  String get settings => 'asetukset';

  @override
  String get about => 'Noin';

  @override
  String get aboutPageCredits => 'Suunnitellut ja rakentanut';

  @override
  String get aboutPageVersion => 'Versio';

  @override
  String get logOut => 'Kirjautua ulos';

  @override
  String get googleSignIn => 'Jatka Googlella';

  @override
  String get appleSignIn => 'Jatka Applella';

  @override
  String get anonSignIn => 'Jatka ilman tiliä';

  @override
  String get checkIn => 'Ilmoittautua';

  @override
  String get systolic => 'Systolinen';

  @override
  String get diastolic => 'Diastolinen';

  @override
  String get heartRate => 'Syke';

  @override
  String get goBack => 'Mene takaisin';

  @override
  String get formInputError => 'Anna mitta';

  @override
  String get submit => 'Lähetä';

  @override
  String get saving => 'Tallentaa...';

  @override
  String get deleteAccount => 'Poista tili';

  @override
  String get deleteAccountConfirm =>
      'Tämä poistaa tilisi ja kaikki käyttäjätiedot pysyvästi. Oletko varma?';

  @override
  String get delete => 'Poistaa';

  @override
  String get cancel => 'Peruuttaa';

  @override
  String get noHeartDate =>
      'Sinulla ei näytä olevan sykettä. Aloita napsauttamalla plus-kuvaketta.';

  @override
  String get noBloodPressureData =>
      'Sinulla ei näytä olevan verenpainetietoja. Aloita napsauttamalla plus-kuvaketta.';

  @override
  String get processingData => 'Käsitellään tietoja...';

  @override
  String get avgHeartRate => 'Keskimääräinen syke';

  @override
  String get avgBloodPressure => 'Keskimääräinen verenpaine';

  @override
  String get last30 => 'Viimeiset 30 päivää';

  @override
  String get home => 'Koti';

  @override
  String get all => 'Kaikki';
}
