import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:utils/sign_in.dart';
import 'package:go_router/go_router.dart';
import "package:os_detect/os_detect.dart" as platform;
import 'package:body_track/l10n/app_localizations.dart';
import 'package:api/api.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _fdb = FCMDatabaseService();
  final _pdb = PreferencesDatabaseService();
  final _udb = UserDatabaseService();
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
    // Auto-redirect to home when already authenticated (e.g., after Apple sign-in returns)
    final user = Provider.of<User?>(context);
    if (user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        context.go('/home');
      });
    }

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
                const Icon(Icons.straighten, size: 96.0),
                const SizedBox(height: 40),
                loggingIn
                    ? const CircularProgressIndicator()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                loggingIn = true;
                              });
                              try {
                                final user = await signInWithGoogle();
                                if (user != null) {
                                  _udb.updateUserData(user);
                                  _pdb.createDefaultPreferences(user);
                                  _fdb.setFCMData(user);
                                  if (mounted) context.go('/home');
                                }
                              } finally {
                                if (mounted) {
                                  setState(() {
                                    loggingIn = false;
                                  });
                                }
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('images/google-logo.png',
                                    width: 24, height: 24),
                                const SizedBox(width: 8),
                                Text(AppLocalizations.of(context)!.googleSignIn,
                                    style: const TextStyle(fontSize: 16.0)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          platform.isIOS
                              ? ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      loggingIn = true;
                                    });
                                    try {
                                      final user = await signInWithApple();
                                      if (user != null) {
                                        _udb.updateUserData(user);
                                        _pdb.createDefaultPreferences(user);
                                        _fdb.setFCMData(user);
                                        if (mounted) context.go('/home');
                                      }
                                    } finally {
                                      if (mounted) {
                                        setState(() {
                                          loggingIn = false;
                                        });
                                      }
                                    }
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
                            onPressed: () async {
                              setState(() {
                                loggingIn = true;
                              });
                              try {
                                final user = await signInAnon();
                                if (user != null) {
                                  _udb.updateUserData(user);
                                  _pdb.createDefaultPreferences(user);
                                  _fdb.setFCMData(user);
                                  if (mounted) context.go('/home');
                                }
                              } finally {
                                if (mounted) {
                                  setState(() {
                                    loggingIn = false;
                                  });
                                }
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)!.anonSignIn,
                              style: const TextStyle(fontSize: 16.0),
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
