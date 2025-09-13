// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get supTrack => 'Tilleggsspor';

  @override
  String get settings => 'Innstillinger';

  @override
  String get about => 'Om';

  @override
  String get aboutPageCredits => 'Designet og bygget av';

  @override
  String get aboutPageVersion => 'Versjon';

  @override
  String get logOut => 'Logg ut';

  @override
  String get googleSignIn => 'Fortsett med Google';

  @override
  String get appleSignIn => 'Fortsett med Apple';

  @override
  String get anonSignIn => 'Fortsett uten konto';

  @override
  String get checkIn => 'Sjekk inn';

  @override
  String get systolic => 'Systolisk';

  @override
  String get diastolic => 'Diastolisk';

  @override
  String get heartRate => 'Puls';

  @override
  String get goBack => 'Gå tilbake';

  @override
  String get formInputError => 'Vennligst skriv inn en måling';

  @override
  String get submit => 'Sende inn';

  @override
  String get saving => 'Lagrer...';

  @override
  String get deleteAccount => 'Slett konto';

  @override
  String get deleteAccountConfirm =>
      'Dette vil slette kontoen din og alle brukerdata for alltid. Er du sikker?';

  @override
  String get delete => 'Slett';

  @override
  String get cancel => 'Avbryt';

  @override
  String get noHeartDate =>
      'Det ser ut til at du ikke har noen puls. Klikk på plussikonet for å komme i gang.';

  @override
  String get noBloodPressureData =>
      'Det ser ut til at du ikke har noen blodtrykksdata. Klikk på plussikonet for å komme i gang.';

  @override
  String get processingData => 'Behandler data...';

  @override
  String get avgHeartRate => 'Gjennomsnittlig hjertefrekvens';

  @override
  String get avgBloodPressure => 'Gjennomsnittlig blodtrykk';

  @override
  String get last30 => 'Siste 30 dager';

  @override
  String get home => 'Hjem';

  @override
  String get all => 'Alle';

  @override
  String get search => 'Søk';
}
