import 'package:utils/colors.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:bp_track/layouts/layouts.dart';
import 'package:utils/graph_animation_provider.dart';
import 'package:bp_track/l10n/app_localizations.dart';

import 'firebase_options.dart';

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

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreenPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );

  @override
  void initState() {
    super.initState();
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
      child: MaterialApp.router(
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
          colorScheme: ColorScheme.fromSeed(seedColor: primary).copyWith(
              primary: primary,
              secondary: secondary,
              tertiary: tertiary,
              error: error,
              brightness: Brightness.light
          ),
          textTheme: GoogleFonts.oswaldTextTheme(),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primary, brightness: Brightness.dark).copyWith(
              primary: primary,
              secondary: secondary,
              tertiary: tertiary,
              error: error,
              brightness: Brightness.dark
          ),
          textTheme: GoogleFonts.oswaldTextTheme(ThemeData.dark().textTheme),
        ),
        themeMode: ThemeMode.system,
        routerConfig: _router,
      ),
    );
  }
}
