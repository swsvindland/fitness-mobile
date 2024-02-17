import 'package:api/user_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:utils/constants.dart';
import 'package:utils/sign_in.dart';
import "package:os_detect/os_detect.dart" as platform;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _db = UserDatabaseService();
  late bool loggingIn;

  @override
  initState() {
    super.initState();
    setState(() {
      loggingIn = false;
    });
  }

  handleSignInWithGoogle() {
    setState(() {
      loggingIn = true;
    });
    signInWithGoogle().then((User? user) {
      if (user != null) {
        _db.updateUserData(user);
        navigatorKey.currentState!
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      }
    });
    setState(() {
      loggingIn = false;
    });
  }

  handleSignInWithApple() {
    setState(() {
      loggingIn = true;
    });
    signInWithApple().then((User? user) {
      if (user != null) {
        _db.updateUserData(user);
        navigatorKey.currentState!
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      }
    });
    setState(() {
      loggingIn = false;
    });
  }

  handleSignInAnon() {
    setState(() {
      loggingIn = true;
    });
    signInAnon().then((User? user) {
      if (user != null) {
        _db.updateUserData(user);
        navigatorKey.currentState!
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      }
    });
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
                SvgPicture.asset(
                    'images/logo.svg',
                    semanticsLabel: 'Blood Pressure Track Logo',
                    width: 200,
                    height: 200
                ),
                const SizedBox(height: 40),
                loggingIn
                    ? const CircularProgressIndicator()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FilledButton(
                            onPressed: handleSignInWithGoogle,
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
                          platform.isIOS
                              ? FilledButton(
                                  onPressed: handleSignInWithApple,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.apple),
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
                          SizedBox(height: platform.isIOS ? 16 : 0),
                          TextButton(
                              onPressed: handleSignInAnon,
                              child: Text(
                                  AppLocalizations.of(context)!.anonSignIn)),
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
