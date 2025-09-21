import 'package:body_track/widgets/settings/units/unit.dart';
import 'package:utils/sign_in.dart';
import 'package:go_router/go_router.dart';
import 'package:body_track/widgets/settings/sex/sex.dart';
import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';
import 'package:body_track/l10n/app_localizations.dart';
import 'package:body_track/widgets/settings/health_sync.dart';
import 'package:body_track/widgets/settings/account_linking.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  void handleSignOut(BuildContext context) {
    signOut();
    // After signing out, return to splash so the app will sign in anonymously and go home
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Unit(),
          const Sex(),
          const HealthSyncSettings(),
          const AccountLinkingSettings(),
          FilledButton(
              onPressed: () => handleSignOut(context),
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
