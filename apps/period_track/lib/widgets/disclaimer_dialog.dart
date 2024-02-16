import 'package:api/preferences_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:models/preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> showDisclaimerDialog(BuildContext context, User user,
      Preferences preferences, PreferencesDatabaseService db) async {
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