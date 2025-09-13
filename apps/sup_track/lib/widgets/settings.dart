import 'package:api/blood_pressure_database_service.dart';
import 'package:utils/constants.dart';
import 'package:utils/sign_in.dart';
import 'package:widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:sup_track/l10n/app_localizations.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  final db = BloodPressureDatabaseService();

  handleSignOut() {
    signOut();
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil('/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          FilledButton(onPressed: handleSignOut, child: Text(AppLocalizations.of(context)!.logOut)),
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
