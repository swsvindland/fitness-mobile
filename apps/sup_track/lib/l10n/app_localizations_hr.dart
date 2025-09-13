// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get supTrack => 'Dodatak Track';

  @override
  String get settings => 'postavke';

  @override
  String get about => 'Oko';

  @override
  String get aboutPageCredits => 'Dizajnirao i izgradio';

  @override
  String get aboutPageVersion => 'Verzija';

  @override
  String get logOut => 'Odjavite se';

  @override
  String get googleSignIn => 'Nastavite s Googleom';

  @override
  String get appleSignIn => 'Nastavite s Appleom';

  @override
  String get anonSignIn => 'Nastavi bez računa';

  @override
  String get checkIn => 'Prijava';

  @override
  String get systolic => 'Sistolički';

  @override
  String get diastolic => 'dijastolički';

  @override
  String get heartRate => 'Brzina otkucaja srca';

  @override
  String get goBack => 'Idi natrag';

  @override
  String get formInputError => 'Unesite mjeru';

  @override
  String get submit => 'podnijeti';

  @override
  String get saving => 'Spremanje...';

  @override
  String get deleteAccount => 'Izbriši račun';

  @override
  String get deleteAccountConfirm =>
      'Ovo će zauvijek izbrisati vaš račun i sve korisničke podatke. Jesi li siguran?';

  @override
  String get delete => 'Izbrisati';

  @override
  String get cancel => 'Otkazati';

  @override
  String get noHeartDate =>
      'Čini se da nemate broj otkucaja srca. Za početak kliknite ikonu plusa.';

  @override
  String get noBloodPressureData =>
      'Čini se da nemate podataka o krvnom tlaku. Za početak kliknite ikonu plusa.';

  @override
  String get processingData => 'Obrada podataka...';

  @override
  String get avgHeartRate => 'Prosječna brzina otkucaja srca';

  @override
  String get avgBloodPressure => 'Prosječni krvni tlak';

  @override
  String get last30 => 'Posljednjih 30 dana';

  @override
  String get home => 'Dom';

  @override
  String get all => 'svi';

  @override
  String get search => 'traži';
}
