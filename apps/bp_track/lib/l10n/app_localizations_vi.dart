// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get bpTrack => 'Theo dõi huyết áp';

  @override
  String get settings => 'Cài đặt';

  @override
  String get about => 'Về';

  @override
  String get aboutPageCredits => 'Thiết kế và xây dựng bởi';

  @override
  String get aboutPageVersion => 'Phiên bản';

  @override
  String get logOut => 'Đăng xuất';

  @override
  String get googleSignIn => 'Tiếp tục với Google';

  @override
  String get appleSignIn => 'Tiếp tục với Apple';

  @override
  String get anonSignIn => 'Tiếp tục mà không cần tài khoản';

  @override
  String get checkIn => 'Đăng ký vào';

  @override
  String get systolic => 'Tâm thu';

  @override
  String get diastolic => 'tâm trương';

  @override
  String get heartRate => 'Nhịp tim';

  @override
  String get goBack => 'Quay lại';

  @override
  String get formInputError => 'Vui lòng nhập số đo';

  @override
  String get submit => 'Nộp';

  @override
  String get saving => 'Tiết kiệm...';

  @override
  String get deleteAccount => 'Xóa tài khoản';

  @override
  String get deleteAccountConfirm =>
      'Điều này sẽ xóa tài khoản của bạn và tất cả dữ liệu người dùng mãi mãi. Bạn có chắc không?';

  @override
  String get delete => 'Xóa bỏ';

  @override
  String get cancel => 'Hủy bỏ';

  @override
  String get noHeartDate =>
      'Có vẻ như bạn không có nhịp tim. Nhấp vào biểu tượng dấu cộng để bắt đầu.';

  @override
  String get noBloodPressureData =>
      'Có vẻ như bạn không có dữ liệu về huyết áp. Nhấp vào biểu tượng dấu cộng để bắt đầu.';

  @override
  String get processingData => 'Tài liệu đã qua xử lý...';

  @override
  String get avgHeartRate => 'Nhịp tim trung bình';

  @override
  String get avgBloodPressure => 'Huyết áp trung bình';

  @override
  String get last30 => '30 ngày trước';

  @override
  String get home => 'Trang chủ';

  @override
  String get all => 'Tất cả';
}
