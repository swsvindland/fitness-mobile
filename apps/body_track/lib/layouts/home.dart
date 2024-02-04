import 'package:body_track/widgets/app_bar_ad.dart';
import 'package:flutter/material.dart';
import 'package:body_track/services/database_service.dart';
import 'package:body_track/utils/constants.dart';
import 'package:body_track/widgets/settings/settings.dart';
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

  handleAction() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 200,
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FilledButton.tonal(
                      onPressed: handleWeighIn,
                      child:
                      const Padding(
                        padding: EdgeInsets.all(24),
                        child: Row(
                          children: [
                            Icon(Icons.monitor_weight),
                            Text('Weigh In'),
                          ],
                        ),
                      ),
                    ),
                    FilledButton.tonal(
                      onPressed: handleCheckIn,
                      child:
                      const Padding(
                        padding: EdgeInsets.all(24),
                        child: Row(
                          children: [
                            Icon(Icons.straighten),
                            Text('Check In'),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: handleAction,
            child: const Icon(Icons.add),
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
