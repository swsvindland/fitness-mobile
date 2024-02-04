import 'package:api/body_database_service.dart';
import 'package:utils/sign_in.dart';
import 'package:utils/constants.dart';
import 'package:body_track/widgets/settings/height/height.dart';
import 'package:body_track/widgets/settings/sex/sex.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';
import 'notification/notification.dart';
import 'package:widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  final db = BodyDatabaseService();

  handleSignOut() {
    signOut();
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil('/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    return MultiProvider(
      providers: [
        StreamProvider<Preferences>.value(
          initialData: Preferences.empty(),
          value: db.streamPreferences(user!.uid),
        ),
      ],
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Sex(),
            const Height(),
            const Notifications(),
            FilledButton(onPressed: handleSignOut, child: const Text("Sign Out")),
            DeleteAccount(
                title: AppLocalizations.of(context)!.deleteAccount,
                content: AppLocalizations.of(context)!.deleteAccountConfirm,
                accept: AppLocalizations.of(context)!.delete,
                cancel: AppLocalizations.of(context)!.cancel,
            )
          ],
        ),
      ),
    );
  }
}
