import 'package:flutter/material.dart';
import 'package:utils/sign_in.dart';
import 'package:water_track/widgets/settings/delete_account.dart';
import 'package:water_track/widgets/settings/unit_switch.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/constants.dart';
import 'goals.dart';
import 'notifications.dart';

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
                const UnitSwitch(),
                const SizedBox(height: 16),
                const Goals(),
                const SizedBox(height: 16),
                const Notifications(),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: signOut,
                  child: Text(
                    AppLocalizations.of(context)!.logOut.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 14.0,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const DeleteAccount()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
