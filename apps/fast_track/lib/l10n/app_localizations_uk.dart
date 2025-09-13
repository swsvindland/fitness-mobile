// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get fastTrack => 'Fasting Track';

  @override
  String get settings => 'Налаштування';

  @override
  String get about => 'про';

  @override
  String get aboutPageCredits => 'Розроблено та побудовано';

  @override
  String get aboutPageVersion => 'Версія';

  @override
  String get logOut => 'Вийти';

  @override
  String get googleSignIn => 'Продовжуйте з Google';

  @override
  String get appleSignIn => 'Продовжуйте з Apple';

  @override
  String get anonSignIn => 'Продовжити без облікового запису';

  @override
  String get checkIn => 'Перевірь';

  @override
  String get systolic => 'Систолічний';

  @override
  String get diastolic => 'діастолічний';

  @override
  String get heartRate => 'Пульс';

  @override
  String get goBack => 'Повертайся';

  @override
  String get formInputError => 'Введіть вимірювання';

  @override
  String get submit => 'Надіслати';

  @override
  String get saving => 'Збереження...';

  @override
  String get deleteAccount => 'Видалити аккаунт';

  @override
  String get deleteAccountConfirm =>
      'Це назавжди видалить ваш обліковий запис і всі дані користувача. Ти впевнений?';

  @override
  String get delete => 'Видалити';

  @override
  String get cancel => 'Скасувати';

  @override
  String get noHeartDate =>
      'Здається, у вас немає пульсу. Натисніть значок плюса, щоб почати.';

  @override
  String get noBloodPressureData =>
      'Схоже, у вас немає даних про артеріальний тиск. Натисніть значок плюса, щоб почати.';

  @override
  String get processingData => 'Обробка даних...';

  @override
  String get avgHeartRate => 'Середня ЧСС';

  @override
  String get avgBloodPressure => 'Середній артеріальний тиск';

  @override
  String get last30 => 'Останні 30 днів';

  @override
  String get home => 'додому';

  @override
  String get all => 'всі';
}
