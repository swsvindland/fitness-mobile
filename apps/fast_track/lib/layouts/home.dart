import 'package:fast_track/l10n/app_localizations.dart';
import 'package:fast_track/widgets/navigation/navigation_bottom.dart';
import 'package:flutter/material.dart';

import '../widgets/all.dart';
import '../widgets/home.dart';
import '../widgets/navigation/side_navigation.dart';
import '../widgets/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fast Track'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SideNavigation(
            selectedIndex: currentPageIndex,
            onItemTapped: (index) {
              setState(() {
                currentPageIndex = index;
              });
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 600,
                child: currentPageIndex == 0
                    ? const Home()
                    : currentPageIndex == 1
                    ? const All()
                    : const Settings(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBottom(
        selectedIndex: currentPageIndex,
        onItemTapped: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
    );
  }
}

enum Popup { about, settings, logOut }
