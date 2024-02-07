import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/home.dart';
import '../widgets/navigation/side_navigation.dart';
import '../widgets/reports.dart';
import '../widgets/settings/settings.dart';

class HomePageDesktop extends StatefulWidget {
  const HomePageDesktop({super.key});

  @override
  State<HomePageDesktop> createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    if (user == null) {
      return const CircularProgressIndicator();
    }

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SideNavigation(
              selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(24),
                child: _selectedIndex == 0
                    ? const Home()
                    : _selectedIndex == 1
                        ? const Reports()
                        : const Settings()),
          ),
        ],
      ),
    );
  }
}
