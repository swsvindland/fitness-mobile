import 'package:body_track/widgets/app_bar_ad.dart';
import 'package:flutter/material.dart';
import 'package:utils/constants.dart';
import 'package:body_track/widgets/settings/settings.dart';
import 'package:body_track/widgets/all.dart';
import 'package:body_track/widgets/home.dart';
import 'package:api/body_database_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int currentPageIndex = 0;
  final db = BodyDatabaseService();

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
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      children: [
                        const Icon(Icons.monitor_weight),
                        Text(AppLocalizations.of(context)!.weighIn),
                      ],
                    ),
                  ),
                ),
                FilledButton.tonal(
                  onPressed: handleCheckIn,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      children: [
                        const Icon(Icons.straighten),
                        Text(AppLocalizations.of(context)!.checkIn),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
        destinations: <Widget>[
          NavigationDestination(
            icon: const Icon(Icons.monitor_weight),
            label: AppLocalizations.of(context)!.weight,
          ),
          NavigationDestination(
            icon: const Icon(Icons.straighten),
            label: AppLocalizations.of(context)!.body,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings),
            label: AppLocalizations.of(context)!.settings,
          ),
        ],
      ),
    );
  }
}

enum Popup { about, settings, logOut }
