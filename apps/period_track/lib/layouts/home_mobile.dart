import 'package:api/period_database_service.dart';
import 'package:api/preferences_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:models/note.dart';
import 'package:models/preferences.dart';
import 'package:period_track/widgets/app_bar_ad.dart';
import 'package:provider/provider.dart';
import 'package:utils/constants.dart';
import 'package:period_track/widgets/navigation/navigation_bottom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/home/home.dart';
import '../widgets/notes.dart';
import '../widgets/reports/reports.dart';
import '../widgets/settings/settings.dart';
import '../widgets/disclaimer_dialog.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var db = PeriodDatabaseService();
    var pdb = PreferencesDatabaseService();
    var user = Provider.of<User?>(context);
    var preferences = Provider.of<Preferences>(context);

    if (user == null) {
      return const CircularProgressIndicator();
    }

    if (preferences.disclaimer == false) {
      Future.delayed(Duration.zero, () => showDisclaimerDialog(context, user, preferences, pdb));
    }

    return Scaffold(
      appBar: AppBar(
        title:
            preferences.adFree ? Text(AppLocalizations.of(context)!.periodTrack) : const AppBarAd(),
        elevation: 0
      ),
      body: MultiProvider(
        providers: [
          StreamProvider<Iterable<NoteModel>>.value(
            initialData: const [],
            value: db.streamNotes(user.uid),
            catchError: (_, err) => [],
          ),
        ],
        child: _selectedIndex == 0
            ? const Home()
            : _selectedIndex == 1
                ? const Notes()
                : _selectedIndex == 2
                    ? const Reports()
                    : const Settings(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigatorKey.currentState!.pushNamed('/add-note', arguments: {
            "id": DateUtils.dateOnly(DateTime.now()).toIso8601String()
          });
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBottom(
          selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
    );
  }
}

enum Popup { about, logOut }
