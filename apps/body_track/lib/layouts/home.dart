import 'package:body_track/widgets/app_bar_ad.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:body_track/models/models.dart';
import 'package:body_track/services/database_service.dart';
import 'package:body_track/services/sign_in.dart';
import 'package:body_track/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:body_track/widgets/weights.dart';

import '../widgets/checkin_list.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final db = DatabaseService();

  handleWeighIn() {
    navigatorKey.currentState!.pushNamed('/weigh-in');
  }

  handleCheckIn() {
    navigatorKey.currentState!.pushNamed('/check-in');
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    return Scaffold(
      appBar: AppBar(
        title: const AppBarAd(),
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton<Popup>(
            onSelected: (Popup result) {
              if (result == Popup.settings) {
                navigatorKey.currentState!.pushNamed('/settings');
              }
              if (result == Popup.about) {
                navigatorKey.currentState!.pushNamed('/about');
              }
              if (result == Popup.logOut) {
                signOut();
                navigatorKey.currentState!
                    .pushNamedAndRemoveUntil('/login', (route) => false);
              }
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Popup>>[
              const PopupMenuItem<Popup>(
                value: Popup.settings,
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
              ),
              const PopupMenuItem<Popup>(
                value: Popup.about,
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About'),
                ),
              ),
              const PopupMenuItem<Popup>(
                value: Popup.logOut,
                child: ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Log Out'),
                ),
              ),
            ].toList(),
          ),
        ],
      ),
      body: StreamProvider<Iterable<Weight>>.value(
        initialData: const [],
        value: db.streamWeighIns(user!.uid),
        child: StreamProvider<Preferences>.value(
          initialData: Preferences.empty(),
          value: db.streamPreferences(user.uid),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Weights(),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: StreamProvider<Iterable<CheckIn>>.value(
                  initialData: const [],
                  value: db.streamCheckIns(user.uid),
                  child: const CheckInList(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag: "WeighIn",
            onPressed: handleWeighIn,
            child: const Icon(Icons.monitor_weight),
          ),
          const SizedBox(width: 16),
          FloatingActionButton.extended(
            heroTag: "CheckIn",
            onPressed: handleCheckIn,
            label: const Text('Check In'),
            icon: const Icon(Icons.straighten),
          ),
        ],
      ),
    );
  }
}

enum Popup { about, settings, logOut }
