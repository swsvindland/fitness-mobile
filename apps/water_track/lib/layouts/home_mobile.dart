import 'package:flutter/material.dart';
import 'package:water_track/l10n/app_localizations.dart';

import '../widgets/home.dart';
import '../widgets/reports.dart';
import '../widgets/settings/settings.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Water Track'),
          elevation: 0,
        ),
        body: currentPageIndex == 0
            ? const Home()
            : currentPageIndex == 1
                ? const Reports()
                : const Settings(),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: <Widget>[
            NavigationDestination(
              icon: const Icon(Icons.home),
              label: AppLocalizations.of(context)!.home,
            ),
            NavigationDestination(
              icon: const Icon(Icons.insights),
              label: AppLocalizations.of(context)!.reports,
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

enum Popup { about, logOut }
