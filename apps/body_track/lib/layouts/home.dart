import 'package:body_track/widgets/height_list.dart';
import 'package:body_track/widgets/progress_photos_list.dart';
import 'package:body_track/widgets/navigation/side_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:models/checkin.dart';
import 'package:models/preferences.dart';
import 'package:models/weight.dart';
import 'package:models/height.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:body_track/widgets/settings/settings.dart';
import 'package:body_track/widgets/all.dart';
import 'package:body_track/widgets/home.dart';
import 'package:api/api.dart';

import '../widgets/navigation/navigation_bottom.dart';
import 'package:body_track/l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int currentPageIndex = 0;
  final db = BodyDatabaseService();
  final pdb = PreferencesDatabaseService();

  void handleWeighIn() {
    context.push('/weigh-in');
  }

  void handleCheckIn() {
    context.push('/check-in');
  }

  void handleHeight() {
    context.push('/height');
  }

  void handleProgressPhotosAdd() {
    context.push('/progress-photos/add');
  }

  void handleAction() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.8,
              children: [
                FilledButton.tonal(
                  onPressed: () { Navigator.of(context).pop(); handleWeighIn(); },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.monitor_weight),
                      const SizedBox(width: 8),
                      Text(AppLocalizations.of(context)!.weighIn),
                    ],
                  ),
                ),
                FilledButton.tonal(
                  onPressed: () { Navigator.of(context).pop(); handleCheckIn(); },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.straighten),
                      const SizedBox(width: 8),
                      Text(AppLocalizations.of(context)!.checkIn),
                    ],
                  ),
                ),
                FilledButton.tonal(
                  onPressed: () { Navigator.of(context).pop(); handleHeight(); },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.height),
                      const SizedBox(width: 8),
                      Text(AppLocalizations.of(context)!.height),
                    ],
                  ),
                ),
                FilledButton.tonal(
                  onPressed: () { Navigator.of(context).pop(); handleProgressPhotosAdd(); },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.photo_camera),
                      const SizedBox(width: 8),
                      const Text('Progress Photos'),
                    ],
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
        StreamProvider<Iterable<HeightModel>>.value(
          initialData: const [],
          value: db.streamHeights(user.uid),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text('Body Track'), elevation: 0),
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
                          : currentPageIndex == 2
                              ? const HeightList()
                              : currentPageIndex == 3
                                  ? const ProgressPhotosList()
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
