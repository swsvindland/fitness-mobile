// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get bpTrack => '혈압 트랙';

  @override
  String get settings => '설정';

  @override
  String get about => '에 대한';

  @override
  String get aboutPageCredits => '설계 및 제작:';

  @override
  String get aboutPageVersion => '버전';

  @override
  String get logOut => '로그 아웃';

  @override
  String get googleSignIn => 'Google로 계속하기';

  @override
  String get appleSignIn => 'Apple과 함께 계속하세요';

  @override
  String get anonSignIn => '계정 없이 계속하기';

  @override
  String get checkIn => '체크인';

  @override
  String get systolic => '수축기';

  @override
  String get diastolic => '확장기';

  @override
  String get heartRate => '심박수';

  @override
  String get goBack => '돌아가기';

  @override
  String get formInputError => '측정값을 입력하세요.';

  @override
  String get submit => '제출하다';

  @override
  String get saving => '절약...';

  @override
  String get deleteAccount => '계정 삭제';

  @override
  String get deleteAccountConfirm =>
      '이렇게 하면 귀하의 계정과 모든 사용자 데이터가 영구적으로 삭제됩니다. 확실합니까?';

  @override
  String get delete => '삭제';

  @override
  String get cancel => '취소';

  @override
  String get noHeartDate => '심박수가 없는 것 같습니다. 시작하려면 더하기 아이콘을 클릭하세요.';

  @override
  String get noBloodPressureData => '혈압 데이터가 없는 것 같습니다. 시작하려면 더하기 아이콘을 클릭하세요.';

  @override
  String get processingData => '데이터 처리 중...';

  @override
  String get avgHeartRate => '평균 심박수';

  @override
  String get avgBloodPressure => '평균 혈압';

  @override
  String get last30 => '지난 30일';

  @override
  String get home => '집';

  @override
  String get all => '모두';
}
