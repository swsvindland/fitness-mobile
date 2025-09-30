import 'dart:async';
import 'package:api/user_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:utils/colors.dart';
import 'package:utils/sign_in.dart';

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

    // Defer navigation until after the first frame to avoid triggering
    // Router rebuilds during the build phase.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        navigateUser();
      }
    });
  }

  Future<void> navigateUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      try {
        // Fast anonymous sign-in to get user into the app quickly
        final user = await signInAnon();
        if (!mounted) return;
        if (user != null) {
          _db.updateUserData(user);
        }
        context.go('/home');
      } catch (e) {
        // If anon sign-in fails, still navigate to home to avoid blocking UI
        if (!mounted) return;
        context.go('/home');
      }
    } else {
      _db.updateUserData(currentUser);
      if (!mounted) return;
      context.go('/home');
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
              SvgPicture.asset(
                  'images/logo.svg',
                  color: primary,
                  semanticsLabel: 'Blood Pressure Track Logo',
                  width: 200,
                  height: 200
              ),
              const SizedBox(height: 75),
              const CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
