// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get bpTrack => 'Kan Basıncı Takibi';

  @override
  String get settings => 'Ayarlar';

  @override
  String get about => 'Hakkında';

  @override
  String get aboutPageCredits => 'Tarafından tasarlandı ve inşa edildi';

  @override
  String get aboutPageVersion => 'Sürüm';

  @override
  String get logOut => 'Çıkış Yap';

  @override
  String get googleSignIn => 'Google ile devam';

  @override
  String get appleSignIn => 'Apple\'la devam et';

  @override
  String get anonSignIn => 'Hesapsız Devam Et';

  @override
  String get checkIn => 'Giriş';

  @override
  String get systolic => 'Sistolik';

  @override
  String get diastolic => 'Diyastolik';

  @override
  String get heartRate => 'Kalp Atış Hızı';

  @override
  String get goBack => 'Geri gitmek';

  @override
  String get formInputError => 'Lütfen bir ölçüm girin';

  @override
  String get submit => 'Göndermek';

  @override
  String get saving => 'Kaydediliyor...';

  @override
  String get deleteAccount => 'Hesabı sil';

  @override
  String get deleteAccountConfirm =>
      'Bu, hesabınızı ve tüm kullanıcı verilerinizi sonsuza kadar silecektir. Emin misin?';

  @override
  String get delete => 'Silmek';

  @override
  String get cancel => 'İptal etmek';

  @override
  String get noHeartDate =>
      'Görünüşe göre kalp atış hızın yok. Başlamak için artı simgesini tıklayın.';

  @override
  String get noBloodPressureData =>
      'Tansiyon veriniz yok gibi görünüyor. Başlamak için artı simgesini tıklayın.';

  @override
  String get processingData => 'Veri işleniyor...';

  @override
  String get avgHeartRate => 'Ortalama Kalp Atış Hızı';

  @override
  String get avgBloodPressure => 'Ortalama Kan Basıncı';

  @override
  String get last30 => 'Son 30 gün';

  @override
  String get home => 'Ev';

  @override
  String get all => 'Tüm';
}
