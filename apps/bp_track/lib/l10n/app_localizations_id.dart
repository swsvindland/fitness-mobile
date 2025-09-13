// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get bpTrack => 'Pelacakan Tekanan Darah';

  @override
  String get settings => 'Pengaturan';

  @override
  String get about => 'Tentang';

  @override
  String get aboutPageCredits => 'Dirancang dan Dibangun oleh';

  @override
  String get aboutPageVersion => 'Versi: kapan';

  @override
  String get logOut => 'Keluar';

  @override
  String get googleSignIn => 'Lanjutkan dengan Google';

  @override
  String get appleSignIn => 'Lanjutkan dengan Apple';

  @override
  String get anonSignIn => 'Lanjutkan tanpa Akun';

  @override
  String get checkIn => 'Mendaftar';

  @override
  String get systolic => 'sistolik';

  @override
  String get diastolic => 'Diastolik';

  @override
  String get heartRate => 'Detak Jantung';

  @override
  String get goBack => 'Kembali';

  @override
  String get formInputError => 'Silakan masukkan pengukuran';

  @override
  String get submit => 'Kirim';

  @override
  String get saving => 'Penghematan...';

  @override
  String get deleteAccount => 'Hapus akun';

  @override
  String get deleteAccountConfirm =>
      'Ini akan menghapus akun Anda dan semua data pengguna selamanya. Apa kamu yakin?';

  @override
  String get delete => 'Menghapus';

  @override
  String get cancel => 'Membatalkan';

  @override
  String get noHeartDate =>
      'Sepertinya Anda tidak memiliki detak jantung. Klik ikon plus untuk memulai.';

  @override
  String get noBloodPressureData =>
      'Sepertinya Anda tidak memiliki data tekanan darah. Klik ikon plus untuk memulai.';

  @override
  String get processingData => 'Mengolah data...';

  @override
  String get avgHeartRate => 'Denyut Jantung Rata-rata';

  @override
  String get avgBloodPressure => 'Tekanan Darah Rata-rata';

  @override
  String get last30 => '30 hari terakhir';

  @override
  String get home => 'Rumah';

  @override
  String get all => 'Semua';
}
