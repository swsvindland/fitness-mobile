// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get supTrack => 'Supplement Track';

  @override
  String get settings => 'Settings';

  @override
  String get about => 'About';

  @override
  String get aboutPageCredits => 'Designed and Built by';

  @override
  String get aboutPageVersion => 'Version';

  @override
  String get logOut => 'Log Out';

  @override
  String get googleSignIn => 'Continue with Google';

  @override
  String get appleSignIn => 'Continue with Apple';

  @override
  String get anonSignIn => 'Continue without Account';

  @override
  String get checkIn => 'Check In';

  @override
  String get systolic => 'Systolic';

  @override
  String get diastolic => 'Diastolic';

  @override
  String get heartRate => 'Heart Rate';

  @override
  String get goBack => 'Go Back';

  @override
  String get formInputError => 'Please enter a measurement';

  @override
  String get submit => 'Submit';

  @override
  String get saving => 'Saving...';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountConfirm =>
      'This will delete your account and all user data forever. Are you sure?';

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get noHeartDate =>
      'Looks like you have no heart rates. Click the plus icon to get started.';

  @override
  String get noBloodPressureData =>
      'Looks like you have no blood pressure data. Click the plus icon to get started.';

  @override
  String get processingData => 'Processing Data...';

  @override
  String get avgHeartRate => 'Average Heart Rate';

  @override
  String get avgBloodPressure => 'Average Blood Pressure';

  @override
  String get last30 => 'Last 30 Days';

  @override
  String get home => 'Home';

  @override
  String get all => 'All';

  @override
  String get search => 'Search';
}
