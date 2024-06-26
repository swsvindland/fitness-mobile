import 'package:api/fcm_database_service.dart';
import 'package:api/preferences_database_service.dart';
import 'package:api/user_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:period_track/utils/colors.dart';
import 'package:utils/constants.dart';
import "package:os_detect/os_detect.dart" as platform;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:utils/sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _db = UserDatabaseService();
  final _pdb = PreferencesDatabaseService();
  final _fdb = FCMDatabaseService();
  late bool loggingIn;

  @override
  initState() {
    super.initState();
    setState(() {
      loggingIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: 330,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/logo-alt.png', width: 128, height: 128),
                const SizedBox(height: 40),
                loggingIn
                    ? const CircularProgressIndicator()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                loggingIn = true;
                              });
                              signInWithGoogle().then((User? user) {
                                if (user != null) {
                                  _db.updateUserData(user);
                                  _pdb.createDefaultPreferences(user);
                                  _fdb.setFCMData(user);
                                  navigatorKey.currentState!
                                      .pushNamedAndRemoveUntil('/home',
                                          (Route<dynamic> route) => false);
                                }
                              });
                              setState(() {
                                loggingIn = false;
                              });
                            },
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(cream),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(purple3),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('images/google-logo.png',
                                    width: 24, height: 24),
                                const SizedBox(width: 8),
                                Text(
                                  AppLocalizations.of(context)!.googleSignIn,
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          platform.isIOS || platform.isMacOS
                              ? ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      loggingIn = true;
                                    });
                                    signInWithApple().then((User? user) {
                                      if (user != null) {
                                        _db.updateUserData(user);
                                        _pdb.createDefaultPreferences(user);
                                        _fdb.setFCMData(user);
                                        navigatorKey.currentState!
                                            .pushNamedAndRemoveUntil(
                                                '/home',
                                                (Route<dynamic> route) =>
                                                    false);
                                      }
                                    });
                                    setState(() {
                                      loggingIn = false;
                                    });
                                  },
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(cream),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            purple3),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.apple,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .appleSignIn,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(
                              height:
                                  platform.isIOS || platform.isMacOS ? 16 : 0),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  loggingIn = true;
                                });
                                signInAnon().then((User? user) {
                                  if (user != null) {
                                    _db.updateUserData(user);
                                    _pdb.createDefaultPreferences(user);
                                    _fdb.setFCMData(user);
                                    navigatorKey.currentState!
                                        .pushNamedAndRemoveUntil('/home',
                                            (Route<dynamic> route) => false);
                                  }
                                });
                                setState(() {
                                  loggingIn = false;
                                });
                              },
                              child: Text(
                                  AppLocalizations.of(context)!.anonSignIn,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: cream))),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
