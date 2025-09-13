// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get fastTrack => 'Fasting Track';

  @override
  String get settings => 'Beállítások';

  @override
  String get about => 'Ról ről';

  @override
  String get aboutPageCredits => 'Tervezte és építette';

  @override
  String get aboutPageVersion => 'Változat';

  @override
  String get logOut => 'Kijelentkezés';

  @override
  String get googleSignIn => 'Folytassa a Google-lal';

  @override
  String get appleSignIn => 'Folytassa az Apple-lel';

  @override
  String get anonSignIn => 'Folytatás fiók nélkül';

  @override
  String get checkIn => 'Becsekkolás';

  @override
  String get systolic => 'Szisztolés';

  @override
  String get diastolic => 'Diasztolés';

  @override
  String get heartRate => 'Pulzus';

  @override
  String get goBack => 'menjen vissza';

  @override
  String get formInputError => 'Kérjük, adjon meg egy méretet';

  @override
  String get submit => 'Beküldés';

  @override
  String get saving => 'Megtakarítás...';

  @override
  String get deleteAccount => 'Fiók törlése';

  @override
  String get deleteAccountConfirm =>
      'Ezzel végleg törli a fiókját és az összes felhasználói adatot. biztos vagy ebben?';

  @override
  String get delete => 'Töröl';

  @override
  String get cancel => 'Megszünteti';

  @override
  String get noHeartDate =>
      'Úgy tűnik, nincs pulzusszáma. A kezdéshez kattintson a plusz ikonra.';

  @override
  String get noBloodPressureData =>
      'Úgy tűnik, nincs vérnyomásadata. A kezdéshez kattintson a plusz ikonra.';

  @override
  String get processingData => 'Adatok feldolgozása...';

  @override
  String get avgHeartRate => 'Átlagos pulzusszám';

  @override
  String get avgBloodPressure => 'Átlagos vérnyomás';

  @override
  String get last30 => 'Az elmúlt 30 nap';

  @override
  String get home => 'itthon';

  @override
  String get all => 'Minden';
}
