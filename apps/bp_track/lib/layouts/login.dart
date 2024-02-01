import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bp_track/services/sign_in.dart';
import 'package:bp_track/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:os_detect/os_detect.dart" as platform;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bp_track/utils/helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
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
        updateUserData(_db, user);
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
        updateUserData(_db, user);
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
        updateUserData(_db, user);
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
                const Icon(Icons.monitor_heart, size: 96.0),
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
