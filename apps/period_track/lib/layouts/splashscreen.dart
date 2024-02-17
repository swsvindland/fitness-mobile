import 'dart:async';
import 'package:api/api.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:utils/constants.dart';
import "package:os_detect/os_detect.dart" as platform;

class SplashscreenPage extends StatefulWidget {
  const SplashscreenPage({super.key});

  @override
  State<SplashscreenPage> createState() => _SplashscreenPageState();
}

class _SplashscreenPageState extends State<SplashscreenPage> {
  final _db = UserDatabaseService();
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

  navigateUser() {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      Timer(const Duration(milliseconds: 850),
          () => navigatorKey.currentState!.pushReplacementNamed("/login"));
    } else {
      Timer(
        const Duration(milliseconds: 500),
        () {
          _db.updateUserData(currentUser);
          _pdb.createDefaultPreferences(currentUser);
          _fdb.setFCMData(currentUser);
          navigatorKey.currentState!.pushNamedAndRemoveUntil(
              '/home', (Route<dynamic> route) => false);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/logo-alt.png', width: 96, height: 96),
              const SizedBox(height: 75),
              const CircularProgressIndicator(
                backgroundColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
