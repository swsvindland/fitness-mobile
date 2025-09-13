import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_ca.dart';
import 'app_localizations_cs.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_eu.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_fil.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_gl.dart';
import 'app_localizations_he.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_hr.dart';
import 'app_localizations_hu.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_nb.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sk.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_th.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('ca'),
    Locale('cs'),
    Locale('da'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('eu'),
    Locale('fa'),
    Locale('fi'),
    Locale('fil'),
    Locale('fr'),
    Locale('gl'),
    Locale('he'),
    Locale('hi'),
    Locale('hr'),
    Locale('hu'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('ms'),
    Locale('nb'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ro'),
    Locale('ru'),
    Locale('sk'),
    Locale('sv'),
    Locale('th'),
    Locale('tr'),
    Locale('uk'),
    Locale('vi'),
    Locale('zh'),
  ];

  /// No description provided for @bodyTrack.
  ///
  /// In en, this message translates to:
  /// **'Body Track'**
  String get bodyTrack;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// No description provided for @feet.
  ///
  /// In en, this message translates to:
  /// **'Feet'**
  String get feet;

  /// No description provided for @inches.
  ///
  /// In en, this message translates to:
  /// **'Inches'**
  String get inches;

  /// No description provided for @reminderNotification.
  ///
  /// In en, this message translates to:
  /// **'Reminder Notification'**
  String get reminderNotification;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @aboutPageCredits.
  ///
  /// In en, this message translates to:
  /// **'Designed and Built by'**
  String get aboutPageCredits;

  /// No description provided for @aboutPageVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get aboutPageVersion;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @googleSignIn.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get googleSignIn;

  /// No description provided for @appleSignIn.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get appleSignIn;

  /// No description provided for @anonSignIn.
  ///
  /// In en, this message translates to:
  /// **'Continue without Account'**
  String get anonSignIn;

  /// No description provided for @checkIn.
  ///
  /// In en, this message translates to:
  /// **'Check In'**
  String get checkIn;

  /// No description provided for @weighIn.
  ///
  /// In en, this message translates to:
  /// **'Weigh In'**
  String get weighIn;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @neck.
  ///
  /// In en, this message translates to:
  /// **'Neck'**
  String get neck;

  /// No description provided for @shoulders.
  ///
  /// In en, this message translates to:
  /// **'Shoulders'**
  String get shoulders;

  /// No description provided for @chest.
  ///
  /// In en, this message translates to:
  /// **'Chest'**
  String get chest;

  /// No description provided for @leftBicep.
  ///
  /// In en, this message translates to:
  /// **'Left Bicep'**
  String get leftBicep;

  /// No description provided for @rightBicep.
  ///
  /// In en, this message translates to:
  /// **'Right Bicep'**
  String get rightBicep;

  /// No description provided for @navel.
  ///
  /// In en, this message translates to:
  /// **'Navel'**
  String get navel;

  /// No description provided for @waist.
  ///
  /// In en, this message translates to:
  /// **'Waist'**
  String get waist;

  /// No description provided for @hip.
  ///
  /// In en, this message translates to:
  /// **'Hip'**
  String get hip;

  /// No description provided for @leftThigh.
  ///
  /// In en, this message translates to:
  /// **'Left Thigh'**
  String get leftThigh;

  /// No description provided for @rightThigh.
  ///
  /// In en, this message translates to:
  /// **'Right Thigh'**
  String get rightThigh;

  /// No description provided for @leftCalf.
  ///
  /// In en, this message translates to:
  /// **'Left Calf'**
  String get leftCalf;

  /// No description provided for @rightCalf.
  ///
  /// In en, this message translates to:
  /// **'Right Calf'**
  String get rightCalf;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @formInputError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a measurement'**
  String get formInputError;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountConfirm.
  ///
  /// In en, this message translates to:
  /// **'This will delete your account and all user data forever. Are you sure?'**
  String get deleteAccountConfirm;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @processingData.
  ///
  /// In en, this message translates to:
  /// **'Processing Data...'**
  String get processingData;

  /// No description provided for @sex.
  ///
  /// In en, this message translates to:
  /// **'Sex'**
  String get sex;

  /// No description provided for @noWeightData.
  ///
  /// In en, this message translates to:
  /// **'Looks like you have no weigh ins. Click the plus icon to get started.'**
  String get noWeightData;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @body.
  ///
  /// In en, this message translates to:
  /// **'Body'**
  String get body;

  /// No description provided for @units.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get units;

  /// No description provided for @imperial.
  ///
  /// In en, this message translates to:
  /// **'Imperial'**
  String get imperial;

  /// No description provided for @metric.
  ///
  /// In en, this message translates to:
  /// **'Metric'**
  String get metric;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'ca',
    'cs',
    'da',
    'de',
    'el',
    'en',
    'es',
    'eu',
    'fa',
    'fi',
    'fil',
    'fr',
    'gl',
    'he',
    'hi',
    'hr',
    'hu',
    'id',
    'it',
    'ja',
    'ko',
    'ms',
    'nb',
    'nl',
    'pl',
    'pt',
    'ro',
    'ru',
    'sk',
    'sv',
    'th',
    'tr',
    'uk',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'ca':
      return AppLocalizationsCa();
    case 'cs':
      return AppLocalizationsCs();
    case 'da':
      return AppLocalizationsDa();
    case 'de':
      return AppLocalizationsDe();
    case 'el':
      return AppLocalizationsEl();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'eu':
      return AppLocalizationsEu();
    case 'fa':
      return AppLocalizationsFa();
    case 'fi':
      return AppLocalizationsFi();
    case 'fil':
      return AppLocalizationsFil();
    case 'fr':
      return AppLocalizationsFr();
    case 'gl':
      return AppLocalizationsGl();
    case 'he':
      return AppLocalizationsHe();
    case 'hi':
      return AppLocalizationsHi();
    case 'hr':
      return AppLocalizationsHr();
    case 'hu':
      return AppLocalizationsHu();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'ms':
      return AppLocalizationsMs();
    case 'nb':
      return AppLocalizationsNb();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'ru':
      return AppLocalizationsRu();
    case 'sk':
      return AppLocalizationsSk();
    case 'sv':
      return AppLocalizationsSv();
    case 'th':
      return AppLocalizationsTh();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
