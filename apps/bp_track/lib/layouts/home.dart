import 'package:api/body_database_service.dart';
import 'package:bp_track/widgets/app_bar_ad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/all.dart';
import '../widgets/check_in_form.dart';
import '../widgets/home.dart';
import '../widgets/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int currentPageIndex = 0;
  final db = BodyDatabaseService();

  handleAction() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return const SizedBox(
            height: 400,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CheckInForm(),
            ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: handleAction,
        child: const Icon(Icons.add),
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
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: AppLocalizations.of(context)!.home,
          ),
          NavigationDestination(
            icon: Icon(Icons.insights),
            label: AppLocalizations.of(context)!.all,
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: AppLocalizations.of(context)!.settings,
          ),
        ],
      ),
    );
  }
}

enum Popup { about, settings, logOut }
