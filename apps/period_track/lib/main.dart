import 'dart:ui';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_track/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:period_track/layouts/layouts.dart';
import 'package:utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:api/preferences_database_service.dart';

import 'firebase_options.dart';
import 'layouts/add_note.dart';

const _kTestingCrashlytics = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.appAttest,
  );

  // Non-async exceptions
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  };
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };

  MobileAds.instance.initialize();

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final db = PreferencesDatabaseService();
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  Future<void> _initializeFlutterFire() async {
    if (_kTestingCrashlytics) {
      // Force enable crashlytics collection enabled if we're testing it.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      // Else only enable it in non-debug builds.
      // You could additionally extend this to allow users to opt-in.
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(kReleaseMode);
    }

    analytics.logEvent(name: 'app_started');
  }

  @override
  void initState() {
    super.initState();

    _initializeFlutterFire();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(
            initialData: FirebaseAuth.instance.currentUser,
            value: FirebaseAuth.instance.authStateChanges()),
      ],
      child: GestureDetector(
        // close keyboard if tap anywhere
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MaterialApp(
          title: 'PeriodTrack',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate, // Add this line
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English
            Locale('es', ''), // Spanish
            Locale('pt', ''), // Portuguese
            Locale('fr', ''), // French
            Locale('de', ''), // German
            Locale('it', ''), // Italian
            Locale('zh', ''), // Simplified Chinese
            Locale('ko', ''), // Korean
            Locale('ja', ''), // Japanese
            Locale('ar', ''), // Arabic
            Locale('hi', ''), // Hindi
            Locale('ru', ''), // Russian
            Locale('tr', ''), // Turkish
            Locale('vi', ''), // Vietnamese
            Locale('th', ''), // Thai
            Locale('id', ''), // Indonesian
            Locale('ms', ''), // Malay
            Locale('fil', ''), // Filipino
            Locale('pl', ''), // Polish
            Locale('nl', ''), // Dutch
            Locale('sv', ''), // Swedish
            Locale('da', ''), // Danish
            Locale('fi', ''), // Finnish
            Locale('nb', ''), // Norwegian
            Locale('el', ''), // Greek
            Locale('hu', ''), // Hungarian
            Locale('cs', ''), // Czech
            Locale('he', ''), // Hebrew
            Locale('ro', ''), // Romanian
            Locale('sk', ''), // Slovak
            Locale('uk', ''), // Ukrainian
            Locale('hr', ''), // Croatian
            Locale('ca', ''), // Catalan
            Locale('eu', ''), // Basque
            Locale('gl', ''), // Galician
            Locale('fa', ''), // Persian
          ],
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: purple2),
            textTheme: GoogleFonts.josefinSansTextTheme(),
            scaffoldBackgroundColor: purple2,
            appBarTheme: const AppBarTheme(
              backgroundColor: purple3,
              foregroundColor: cream,
            ),
            drawerTheme: const DrawerThemeData(
              backgroundColor: purple3,
            ),
            navigationRailTheme: NavigationRailThemeData(
              backgroundColor: purple3,
              selectedLabelTextStyle: TextStyle(
                  color: yellow,
                  fontFamily: GoogleFonts.josefinSans().fontFamily),
              unselectedLabelTextStyle: TextStyle(
                  color: yellow,
                  fontFamily: GoogleFonts.josefinSans().fontFamily),
              unselectedIconTheme: const IconThemeData(color: yellow),
            ),
            navigationBarTheme: NavigationBarThemeData(
              backgroundColor: purple3,
              labelTextStyle: const MaterialStatePropertyAll(TextStyle(color: yellow)),
              iconTheme: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return const IconThemeData(color: purple3);
                }
                return const IconThemeData(color: yellow);
              }),
            ),
            cardTheme: const CardTheme(color: cream),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(const Size(300, 55)),
                foregroundColor: MaterialStateProperty.all<Color>(purple3),
                backgroundColor: MaterialStateProperty.all<Color>(cream),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(const Size(300, 55)),
                foregroundColor: MaterialStateProperty.all<Color>(purple3),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                side: MaterialStateProperty.all(
                  const BorderSide(color: purple2),
                ),
              ),
            ),
            dialogBackgroundColor: cream,
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: purple2, brightness: Brightness.dark),
            textTheme: GoogleFonts.josefinSansTextTheme(ThemeData.dark().textTheme),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(const Size(300, 55)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(const Size(300, 55)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                side: MaterialStateProperty.all(
                  const BorderSide(color: Color(0xff7c2946)),
                ),
              ),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              unselectedItemColor: yellow,
              selectedItemColor: yellow,
            ),
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
            ),
          ),
          themeMode: ThemeMode.system,
          initialRoute: '/',
          navigatorObservers: <NavigatorObserver>[observer],
          navigatorKey: navigatorKey,
          routes: {
            '/': (context) => const SplashscreenPage(),
            '/login': (context) => const LoginPage(),
            '/home': (context) => const HomePage(),
            '/add-note': (context) => AddNotePage()
          },
        ),
      ),
    );
  }
}
