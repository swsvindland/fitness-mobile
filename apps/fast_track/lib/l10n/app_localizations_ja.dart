// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get fastTrack => 'Fasting Track';

  @override
  String get settings => '設定';

  @override
  String get about => 'について';

  @override
  String get aboutPageCredits => 'によって設計および構築されました';

  @override
  String get aboutPageVersion => 'バージョン';

  @override
  String get logOut => 'ログアウト';

  @override
  String get googleSignIn => 'Google を続ける';

  @override
  String get appleSignIn => 'アップルを使い続ける';

  @override
  String get anonSignIn => 'アカウントなしで続行する';

  @override
  String get checkIn => 'チェックイン';

  @override
  String get systolic => '収縮期';

  @override
  String get diastolic => '拡張期';

  @override
  String get heartRate => '心拍数';

  @override
  String get goBack => '戻る';

  @override
  String get formInputError => '寸法を入力してください';

  @override
  String get submit => '提出する';

  @override
  String get saving => '保存中...';

  @override
  String get deleteAccount => 'アカウントを削除する';

  @override
  String get deleteAccountConfirm =>
      'これにより、アカウントとすべてのユーザー データが永久に削除されます。本気ですか？';

  @override
  String get delete => '消去';

  @override
  String get cancel => 'キャンセル';

  @override
  String get noHeartDate => '心拍数がないようです。プラスアイコンをクリックして開始します。';

  @override
  String get noBloodPressureData => '血圧データがないようです。プラスアイコンをクリックして開始します。';

  @override
  String get processingData => 'データを処理中...';

  @override
  String get avgHeartRate => '平均心拍数';

  @override
  String get avgBloodPressure => '平均血圧';

  @override
  String get last30 => '過去 30 日間';

  @override
  String get home => '家';

  @override
  String get all => '全て';
}
