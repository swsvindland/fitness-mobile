// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get bpTrack => 'Трек артериального давления';

  @override
  String get settings => 'Настройки';

  @override
  String get about => 'О';

  @override
  String get aboutPageCredits => 'Спроектировано и построено';

  @override
  String get aboutPageVersion => 'Версия';

  @override
  String get logOut => 'Выйти';

  @override
  String get googleSignIn => 'Продолжить с Google';

  @override
  String get appleSignIn => 'Продолжить с Apple';

  @override
  String get anonSignIn => 'Продолжить без учетной записи';

  @override
  String get checkIn => 'Регистрироваться';

  @override
  String get systolic => 'Систолический';

  @override
  String get diastolic => 'Диастолический';

  @override
  String get heartRate => 'Частота сердцебиения';

  @override
  String get goBack => 'Возвращаться';

  @override
  String get formInputError => 'Пожалуйста, введите размер';

  @override
  String get submit => 'Представлять на рассмотрение';

  @override
  String get saving => 'Сохранение...';

  @override
  String get deleteAccount => 'Удалить аккаунт';

  @override
  String get deleteAccountConfirm =>
      'Это приведет к удалению вашей учетной записи и всех пользовательских данных навсегда. Вы уверены?';

  @override
  String get delete => 'Удалить';

  @override
  String get cancel => 'Отмена';

  @override
  String get noHeartDate =>
      'Похоже, у вас нет сердечного ритма. Нажмите значок плюса, чтобы начать.';

  @override
  String get noBloodPressureData =>
      'Похоже, у вас нет данных о артериальном давлении. Нажмите значок плюса, чтобы начать.';

  @override
  String get processingData => 'Обработка данных...';

  @override
  String get avgHeartRate => 'Средняя частота сердечных сокращений';

  @override
  String get avgBloodPressure => 'Среднее артериальное давление';

  @override
  String get last30 => 'Последние 30 дней';

  @override
  String get home => 'Дом';

  @override
  String get all => 'Все';
}
