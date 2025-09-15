import 'dart:async';
import 'package:api/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:utils/sign_in.dart';
import "package:os_detect/os_detect.dart" as platform;

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final _udb = UserDatabaseService();
  final _pdb = PreferencesDatabaseService();
  final _fdb = FCMDatabaseService();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  late StreamSubscription iosSubscription;

  @override
  void initState() {
    super.initState();

    if (platform.isIOS) {
      _fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }

    navigateUser();
  }

  navigateUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      // Perform anonymous sign-in then navigate to home
      try {
        final user = await signInAnon();
        if (user != null) {
          _udb.updateUserData(user);
          _pdb.createDefaultPreferences(user);
          _fdb.setFCMData(user);
          Timer(const Duration(milliseconds: 500), () => context.go('/home'));
        } else {
          // Fallback: if sign-in fails, stay on splash briefly then retry
          Timer(const Duration(milliseconds: 850), () => navigateUser());
        }
      } catch (_) {
        // If any error occurs, try again after a short delay
        Timer(const Duration(milliseconds: 850), () => navigateUser());
      }
    } else {
      Timer(
        const Duration(milliseconds: 500),
        () {
          _udb.updateUserData(currentUser);
          _pdb.createDefaultPreferences(currentUser);
          _fdb.setFCMData(currentUser);
          context.go('/home');
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.straighten, size: 96.0),
              SizedBox(height: 75),
              CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
