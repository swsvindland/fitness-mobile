import 'package:body_track/utils/colors.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:body_track/layouts/layouts.dart';
import 'package:body_track/services/graph_animation_provider.dart';
import 'package:body_track/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

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
        title: 'BodyTrack',
        localizationsDelegates: const [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English
          // Locale('es', ''), // Spanish
          // Locale('pt', ''), // Portuguese
          // Locale('fr', ''), // French
          // Locale('de', ''), // German
          // Locale('it', ''), // Italian
          // Locale('zh', ''), // Simplified Chinese
          // Locale('ko', ''), // Korean
          // Locale('ja', ''), // Japanese
          // Locale('ar', ''), // Arabic
          // Locale('hi', ''), // Hindi
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: primary,
          brightness: Brightness.light,
          textTheme: GoogleFonts.oswaldTextTheme(),
          useMaterial3: true,
          backgroundColor: background,
          scaffoldBackgroundColor: background,
          appBarTheme: const AppBarTheme(
              backgroundColor: background, foregroundColor: textPrimary),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(const Size(300, 55)),
              backgroundColor: MaterialStateProperty.all<Color>(primary),
              foregroundColor: MaterialStateProperty.all<Color>(textPrimary),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(textPrimary),
            ),
          ),
          cardTheme: const CardTheme(
            color: card
          ),
          listTileTheme: const ListTileThemeData(
            textColor: textSecondary
          ),
          dialogTheme: const DialogTheme(
            backgroundColor: card,
            titleTextStyle: TextStyle(color: textPrimary),
            contentTextStyle: TextStyle(color: textSecondary)
          ),
          popupMenuTheme: const PopupMenuThemeData(
            color: card,
            textStyle: TextStyle(color: textSecondary),
          ),
          timePickerTheme: const TimePickerThemeData(
            backgroundColor: card,
            hourMinuteTextColor: textPrimary,
            dialTextColor: textSecondary,
            helpTextStyle: TextStyle(color: textSecondary),
            entryModeIconColor: textSecondary
          )
        ),
        darkTheme: ThemeData(
          colorSchemeSeed: primary,
          brightness: Brightness.dark,
          useMaterial3: true,
          backgroundColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black, foregroundColor: textPrimary),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(const Size(300, 55)),
                backgroundColor: MaterialStateProperty.all<Color>(primary),
                foregroundColor: MaterialStateProperty.all<Color>(textPrimary),
              ),
            ),
            listTileTheme: const ListTileThemeData(
                textColor: textSecondary
            ),
            timePickerTheme: const TimePickerThemeData(
                hourMinuteTextColor: textPrimary,
                dialTextColor: textSecondary,
                helpTextStyle: TextStyle(color: textSecondary),
                entryModeIconColor: textSecondary
            )
        ),
        themeMode: ThemeMode.system,
        navigatorKey: navigatorKey,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreenPage(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => HomePage(),
          '/weigh-in': (context) => const WeighIn(),
          '/check-in': (context) => const CheckIn(),
          '/about': (context) => const AboutPage(),
          '/settings': (context) => const SettingsPage()
        },
      ),
    );
  }
}
