import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:water_track/services/database_service.dart';
import 'package:water_track/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:utils/graph_animation_provider.dart';

import 'firebase_options.dart';
import 'layouts/home.dart';
import 'layouts/login.dart';
import 'layouts/splashscreen.dart';
import 'package:models/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});
  final db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(
            initialData: FirebaseAuth.instance.currentUser,
            value: FirebaseAuth.instance.authStateChanges()),
        ChangeNotifierProvider<GraphAnimationProvider>(
            create: (_) => GraphAnimationProvider()),
        StreamProvider<Preferences>.value(
            initialData: Preferences.empty(),
            value: db.streamPreferences(FirebaseAuth.instance.currentUser?.uid),
            catchError: (_, err) => Preferences.empty()),
      ],
      child: MaterialApp(
        title: 'WaterTrack',
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
          Locale('no', ''), // Norwegian
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primary),
          textTheme: GoogleFonts.oswaldTextTheme(),
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
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primary, brightness: Brightness.dark),
          textTheme: GoogleFonts.oswaldTextTheme(ThemeData.dark().textTheme),
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
        ),
        themeMode: ThemeMode.system,
        initialRoute: '/',
        navigatorKey: navigatorKey,
        routes: {
          '/': (context) => const SplashscreenPage(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
        },
      ),
    );
  }
}
