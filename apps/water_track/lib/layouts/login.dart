import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:utils/constants.dart';
import "package:os_detect/os_detect.dart" as platform;
import 'package:water_track/l10n/app_localizations.dart';
import 'package:utils/sign_in.dart';
import 'package:api/api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _udb = UserDatabaseService();
  final _fdb = FCMDatabaseService();
  final _pdb = PreferencesDatabaseService();
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
                Image.asset('images/logo-alt.png', width: 96, height: 96),
                const SizedBox(height: 40),
                loggingIn
                    ? const CircularProgressIndicator()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FilledButton(
                            onPressed: () {
                              setState(() {
                                loggingIn = true;
                              });
                              signInWithGoogle().then((User? user) {
                                if (user != null) {
                                  _udb.updateUserData(user);
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('images/google-logo.png',
                                    width: 24, height: 24),
                                const SizedBox(width: 8),
                                Text(
                                  AppLocalizations.of(context)!
                                      .googleSignIn
                                      .toUpperCase(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          platform.isIOS
                              ? FilledButton(
                                  onPressed: () {
                                    setState(() {
                                      loggingIn = true;
                                    });
                                    signInWithApple().then((User? user) {
                                      if (user != null) {
                                        _udb.updateUserData(user);
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.apple),
                                      const SizedBox(width: 8),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .appleSignIn
                                            .toUpperCase(),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(height: platform.isIOS ? 16 : 0),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                loggingIn = true;
                              });
                              signInAnon().then((User? user) {
                                if (user != null) {
                                  _udb.updateUserData(user);
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
                              AppLocalizations.of(context)!
                                  .anonSignIn
                                  .toUpperCase(),
                            ),
                          ),
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
