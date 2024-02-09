import 'package:flutter/material.dart';
import 'package:utils/sign_in.dart';
import 'package:water_track/widgets/settings/goals/goal.dart';
import 'package:water_track/widgets/settings/units/unit.dart';
import 'package:widgets/delete_account.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:utils/constants.dart';
import 'notification/notification.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: SizedBox(
          width: sm.toDouble(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Unit(),
                const SizedBox(height: 16),
                const Goal(),
                const SizedBox(height: 16),
                const Notifications(),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: signOut,
                  child: Text(
                    AppLocalizations.of(context)!.logOut,
                  ),
                ),
                DeleteAccount(
                  title: AppLocalizations.of(context)!.deleteAccount,
                  content: AppLocalizations.of(context)!.deleteAccountConfirm,
                  accept: AppLocalizations.of(context)!.delete,
                  cancel: AppLocalizations.of(context)!.cancel,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
