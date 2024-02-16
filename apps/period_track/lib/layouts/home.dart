import 'package:api/preferences_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:models/preferences.dart';
import 'package:period_track/layouts/home_desktop.dart';
import 'package:period_track/layouts/home_mobile.dart';
import 'package:provider/provider.dart';
import 'package:utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _db = PreferencesDatabaseService();


  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return MultiProvider(
      providers: [
        StreamProvider<Preferences>.value(
          initialData: Preferences.empty(),
          value: _db.streamPreferences(user.uid),
          catchError: (_, err)  => Preferences.empty()
        ),
      ],
      child: MediaQuery.of(context).size.width < md
          ? const HomePageMobile()
          : const HomePageDesktop(),
    );
  }
}

enum Popup { about, logOut }
