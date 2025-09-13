// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get supTrack => 'المسار التكميلي';

  @override
  String get settings => 'إعدادات';

  @override
  String get about => 'عن';

  @override
  String get aboutPageCredits => 'تم تصميمه وبنائه بواسطة';

  @override
  String get aboutPageVersion => 'إصدار';

  @override
  String get logOut => 'تسجيل خروج';

  @override
  String get googleSignIn => 'تواصل مع جوجل';

  @override
  String get appleSignIn => 'تواصل مع أبل';

  @override
  String get anonSignIn => 'الاستمرار بدون حساب';

  @override
  String get checkIn => 'تحقق في';

  @override
  String get systolic => 'الانقباضي';

  @override
  String get diastolic => 'الانبساطي';

  @override
  String get heartRate => 'معدل ضربات القلب';

  @override
  String get goBack => 'عُد';

  @override
  String get formInputError => 'الرجاء إدخال القياس';

  @override
  String get submit => 'يُقدِّم';

  @override
  String get saving => 'إنقاذ...';

  @override
  String get deleteAccount => 'حذف الحساب';

  @override
  String get deleteAccountConfirm =>
      'سيؤدي هذا إلى حذف حسابك وجميع بيانات المستخدم إلى الأبد. هل أنت متأكد؟';

  @override
  String get delete => 'يمسح';

  @override
  String get cancel => 'يلغي';

  @override
  String get noHeartDate =>
      'يبدو أنه ليس لديك معدل ضربات القلب. انقر على أيقونة علامة الجمع للبدء.';

  @override
  String get noBloodPressureData =>
      'يبدو أنه ليس لديك بيانات عن ضغط الدم. انقر على أيقونة علامة الجمع للبدء.';

  @override
  String get processingData => 'معالجة البيانات...';

  @override
  String get avgHeartRate => 'متوسط معدل ضربات القلب';

  @override
  String get avgBloodPressure => 'متوسط ضغط الدم';

  @override
  String get last30 => 'آخر 30 يومًا';

  @override
  String get home => 'بيت';

  @override
  String get all => 'الجميع';

  @override
  String get search => 'يبحث';
}
