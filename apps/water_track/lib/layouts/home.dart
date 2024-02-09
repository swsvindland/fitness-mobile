import 'package:api/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:water_track/layouts/home_desktop.dart';
import 'package:water_track/layouts/home_mobile.dart';
import 'package:provider/provider.dart';
import 'package:utils/constants.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final db = WaterDatabaseService();
  final pdb = PreferencesDatabaseService();

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
              value: pdb.streamPreferences(user.uid),
              catchError: (_, err) => Preferences.empty()),
          StreamProvider<Drinks>.value(
              initialData: Drinks.empty(),
              value: db.streamDrinks(user.uid),
              catchError: (_, err) => Drinks.empty()),
          StreamProvider<Iterable<Drinks>>.value(
              initialData: [Drinks.empty()],
              value: db.streamAllDrinks(user.uid)),
        ],
        child: MediaQuery.of(context).size.width < md
            ? const HomePageMobile()
            : const HomePageDesktop());
  }
}
