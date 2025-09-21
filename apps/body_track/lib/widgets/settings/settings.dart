import 'package:body_track/widgets/settings/units/unit.dart';
import 'package:utils/sign_in.dart';
import 'package:go_router/go_router.dart';
import 'package:body_track/widgets/settings/sex/sex.dart';
import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';
import 'package:body_track/l10n/app_localizations.dart';
import 'package:body_track/widgets/settings/health_sync.dart';
import 'package:body_track/widgets/settings/account_linking.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  void handleSignOut(BuildContext context) {
    signOut();
    // After signing out, return to splash so the app will sign in anonymously and go home
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final bool isLoggedIn = currentUser != null && !currentUser.isAnonymous;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding( // Added padding for the whole column
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch, // Changed to stretch for full width buttons
          children: <Widget>[
            const Unit(),
            const Sex(),
            const HealthSyncSettings(),
            const AccountLinkingSettings(),
            if (isLoggedIn)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                      onPressed: () => handleSignOut(context),
                      child: Text(AppLocalizations.of(context)!.logOut)),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: DeleteAccount(
                  title: AppLocalizations.of(context)!.deleteAccount,
                  content: AppLocalizations.of(context)!.deleteAccountConfirm,
                  accept: AppLocalizations.of(context)!.delete,
                  cancel: AppLocalizations.of(context)!.cancel,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
