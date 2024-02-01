import 'package:body_track/widgets/app_bar_ad.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:body_track/models/models.dart';
import 'package:body_track/services/database_service.dart';
import 'package:body_track/services/sign_in.dart';
import 'package:body_track/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:body_track/widgets/weights.dart';
import 'package:body_track/widgets/settings.dart';
import 'package:body_track/widgets/all.dart';
import 'package:body_track/widgets/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int currentPageIndex = 0;
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
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        child: currentPageIndex == 0
            ? Home()
            : currentPageIndex == 1
            ? All()
            : Settings(),
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
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.monitor_weight),
            label: 'Weight',
          ),
          NavigationDestination(
            icon: Icon(Icons.straighten),
            label: 'Body',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

enum Popup { about, settings, logOut }
