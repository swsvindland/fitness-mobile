import 'package:body_track/widgets/settings/units/unit.dart';
import 'package:utils/sign_in.dart';
import 'package:utils/constants.dart';
import 'package:body_track/widgets/settings/height/height.dart';
import 'package:body_track/widgets/settings/sex/sex.dart';
import 'package:flutter/material.dart';
import 'notification/notification.dart';
import 'package:widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  handleSignOut() {
    signOut();
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil('/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // const Unit(),
          const Sex(),
          const Height(),
          const Notifications(),
          FilledButton(
              onPressed: handleSignOut,
              child: Text(AppLocalizations.of(context)!.logOut)),
          DeleteAccount(
            title: AppLocalizations.of(context)!.deleteAccount,
            content: AppLocalizations.of(context)!.deleteAccountConfirm,
            accept: AppLocalizations.of(context)!.delete,
            cancel: AppLocalizations.of(context)!.cancel,
          )
        ],
      ),
    );
  }
}
