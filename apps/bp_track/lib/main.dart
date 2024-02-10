import 'dart:ui';

import 'package:bp_track/utils/colors.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:bp_track/layouts/layouts.dart';
import 'package:utils/graph_animation_provider.dart';
import 'package:utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'firebase_options.dart';

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
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

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
        ChangeNotifierProvider<GraphAnimationProvider>(
            create: (_) => GraphAnimationProvider()),
      ],
      child: MaterialApp(
        title: 'Blood Pressure Track',
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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primary),
          textTheme: GoogleFonts.oswaldTextTheme(),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: primary, brightness: Brightness.dark),
          textTheme: GoogleFonts.oswaldTextTheme(ThemeData.dark().textTheme),
        ),
        themeMode: ThemeMode.system,
        navigatorKey: navigatorKey,
        navigatorObservers: <NavigatorObserver>[observer],
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreenPage(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
        },
      ),
    );
  }
}
