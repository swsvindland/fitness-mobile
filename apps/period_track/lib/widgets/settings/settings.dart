import 'package:flutter/material.dart';
import 'package:period_track/widgets/delete_account.dart';
import 'package:period_track/l10n/app_localizations.dart';

import 'package:utils/constants.dart';
import 'package:utils/sign_in.dart';
import 'cycle/default_cycle.dart';

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
                const DefaultCycle(),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    signOut();
                    navigatorKey.currentState!
                        .pushNamedAndRemoveUntil('/login', (route) => false);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.logOut,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const DeleteAccount(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
