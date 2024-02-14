import 'package:api/body_database_service.dart';
import 'package:bp_track/widgets/app_bar_ad.dart';
import 'package:bp_track/widgets/navigation/navigation_bottom.dart';
import 'package:flutter/material.dart';

import '../widgets/all.dart';
import '../widgets/check_in_form.dart';
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
                    ? Home()
                    : currentPageIndex == 1
                    ? All()
                    : Settings(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: handleAction,
        child: const Icon(Icons.add),
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
