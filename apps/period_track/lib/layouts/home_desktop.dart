import 'package:api/period_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:models/note.dart';
import 'package:models/preferences.dart';
import 'package:period_track/widgets/navigation/side_navigation.dart';
import 'package:provider/provider.dart';
import 'package:utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/app_bar_ad.dart';
import '../widgets/home/home.dart';
import '../widgets/notes.dart';
import '../widgets/reports/reports.dart';
import '../widgets/settings/settings.dart';

class HomePageDesktop extends StatefulWidget {
  const HomePageDesktop({Key? key}) : super(key: key);

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
    var db = PeriodDatabaseService();
    var user = Provider.of<User?>(context);
    var preferences = Provider.of<Preferences>(context);

    if (user == null) {
      return const CircularProgressIndicator();
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
        child: Row(
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
                        ? const Notes()
                        : _selectedIndex == 2
                            ? const Reports()
                            : const Settings()
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigatorKey.currentState!.pushNamed('/add-note', arguments: {
            "id": DateUtils.dateOnly(DateTime.now()).toIso8601String()
          });
        },
        child: const Icon(Icons.note_add),
      ),
    );
  }
}
