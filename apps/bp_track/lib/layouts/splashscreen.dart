import 'dart:async';
import 'package:api/user_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:utils/constants.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final _db = UserDatabaseService();
  late StreamSubscription iosSubscription;

  @override
  void initState() {
    super.initState();

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
              Icon(Icons.monitor_heart, size: 96.0),
              SizedBox(height: 75),
              CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
