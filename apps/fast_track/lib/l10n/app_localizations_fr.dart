// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get fastTrack => 'Fasting Track';

  @override
  String get settings => 'Paramètres';

  @override
  String get about => 'À propos';

  @override
  String get aboutPageCredits => 'Conçu et construit par';

  @override
  String get aboutPageVersion => 'Version';

  @override
  String get logOut => 'Se déconnecter';

  @override
  String get googleSignIn => 'Continuer avec Google';

  @override
  String get appleSignIn => 'Continuer avec Apple';

  @override
  String get anonSignIn => 'Continuer sans compte';

  @override
  String get checkIn => 'Enregistrement';

  @override
  String get systolic => 'Systolique';

  @override
  String get diastolic => 'Diastolique';

  @override
  String get heartRate => 'Rythme cardiaque';

  @override
  String get goBack => 'Retourner';

  @override
  String get formInputError => 'Veuillez entrer une mesure';

  @override
  String get submit => 'Soumettre';

  @override
  String get saving => 'Économie...';

  @override
  String get deleteAccount => 'Supprimer le compte';

  @override
  String get deleteAccountConfirm =>
      'Cela supprimera définitivement votre compte et toutes les données utilisateur. Es-tu sûr?';

  @override
  String get delete => 'Supprimer';

  @override
  String get cancel => 'Annuler';

  @override
  String get noHeartDate =>
      'On dirait que vous n\'avez pas de fréquence cardiaque. Cliquez sur l\'icône plus pour commencer.';

  @override
  String get noBloodPressureData =>
      'On dirait que vous n\'avez aucune donnée sur votre tension artérielle. Cliquez sur l\'icône plus pour commencer.';

  @override
  String get processingData => 'Données en cours...';

  @override
  String get avgHeartRate => 'Fréquence cardiaque moyenne';

  @override
  String get avgBloodPressure => 'Pression artérielle moyenne';

  @override
  String get last30 => 'Les 30 derniers jours';

  @override
  String get home => 'Maison';

  @override
  String get all => 'Tous';
}
