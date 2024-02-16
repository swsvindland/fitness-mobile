import 'package:api/preferences_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:models/preferences.dart';
import 'package:period_track/layouts/home_desktop.dart';
import 'package:period_track/layouts/home_mobile.dart';
import 'package:provider/provider.dart';
import 'package:utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _db = PreferencesDatabaseService();

  Future<void> _showDisclaimerDialog(BuildContext context, User user, Preferences preferences, PreferencesDatabaseService db) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.disclaimer),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AppLocalizations.of(context)!.disclaimerLine1),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.iAgree),
              onPressed: () {
                preferences.agreeToDisclaimer();
                db.updatePreferences(user.uid, preferences);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    var preferences = Provider.of<Preferences>(context);

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (preferences.disclaimer == false) {
      Future.delayed(Duration.zero, () => _showDisclaimerDialog(context, user, preferences, _db));
    }

    if (MediaQuery.of(context).size.width < md) {
      return const HomePageMobile();
    }

    return const HomePageDesktop();
  }
}

enum Popup { about, logOut }
