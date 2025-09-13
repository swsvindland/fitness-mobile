// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get bpTrack => '血压追踪';

  @override
  String get settings => '设置';

  @override
  String get about => '关于';

  @override
  String get aboutPageCredits => '设计和建造';

  @override
  String get aboutPageVersion => '版本';

  @override
  String get logOut => '登出';

  @override
  String get googleSignIn => '继续使用谷歌';

  @override
  String get appleSignIn => '继续使用苹果';

  @override
  String get anonSignIn => '无需帐户即可继续';

  @override
  String get checkIn => '报到';

  @override
  String get systolic => '收缩压';

  @override
  String get diastolic => '舒张压';

  @override
  String get heartRate => '心率';

  @override
  String get goBack => '回去';

  @override
  String get formInputError => '请输入测量值';

  @override
  String get submit => '提交';

  @override
  String get saving => '保存...';

  @override
  String get deleteAccount => '删除帐户';

  @override
  String get deleteAccountConfirm => '这将永远删除您的帐户和所有用户数据。你确定吗？';

  @override
  String get delete => '删除';

  @override
  String get cancel => '取消';

  @override
  String get noHeartDate => '您似乎没有心率。单击加号图标即可开始。';

  @override
  String get noBloodPressureData => '您似乎没有血压数据。单击加号图标即可开始。';

  @override
  String get processingData => '处理数据...';

  @override
  String get avgHeartRate => '平均心率';

  @override
  String get avgBloodPressure => '平均血压';

  @override
  String get last30 => '过去 30 天';

  @override
  String get home => '家';

  @override
  String get all => '全部';
}
