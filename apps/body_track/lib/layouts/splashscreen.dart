import 'dart:async';
import 'package:body_track/utils/colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:body_track/utils/constants.dart';
import 'package:body_track/utils/helper.dart';
import "package:os_detect/os_detect.dart" as platform;

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
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
          updateUserData(_db, currentUser);
          createDefaultPreferences(_db, currentUser);
          setFCMData(_db, _fcm, currentUser);
          navigatorKey.currentState!.pushNamedAndRemoveUntil(
              '/home', (Route<dynamic> route) => false);
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
              Icon(Icons.straighten, size: 96.0, color: secondary),
              SizedBox(height: 75),
              CircularProgressIndicator(
                backgroundColor: secondary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
