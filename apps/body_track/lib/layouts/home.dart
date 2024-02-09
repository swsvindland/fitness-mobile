import 'package:body_track/widgets/app_bar_ad.dart';
import 'package:body_track/widgets/navigation/side_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:models/checkin.dart';
import 'package:models/preferences.dart';
import 'package:models/weight.dart';
import 'package:provider/provider.dart';
import 'package:utils/constants.dart';
import 'package:body_track/widgets/settings/settings.dart';
import 'package:body_track/widgets/all.dart';
import 'package:body_track/widgets/home.dart';
import 'package:api/api.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/navigation/navigation_bottom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int currentPageIndex = 0;
  final db = BodyDatabaseService();
  final pdb = PreferencesDatabaseService();

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
    var user = Provider.of<User?>(context);

    return MultiProvider(
      providers: [
        StreamProvider<Iterable<Weight>>.value(
          initialData: const [],
          value: db.streamWeighIns(user!.uid),
        ),
        StreamProvider<Preferences>.value(
          initialData: Preferences.empty(),
          value: pdb.streamPreferences(user.uid),
        ),
        StreamProvider<Iterable<CheckInModel>>.value(
          initialData: const [],
          value: db.streamCheckIns(user.uid),
        ),
      ],
      child: Scaffold(
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
                          ? const All()
                          : const Settings(),
                ),
              ),
            ),
          ],
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
        bottomNavigationBar: NavigationBottom(
          selectedIndex: currentPageIndex,
          onItemTapped: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
        ),
      ),
    );
  }
}

enum Popup { about, settings, logOut }
