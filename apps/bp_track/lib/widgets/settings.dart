import 'package:api/blood_pressure_database_service.dart';
import 'package:api/user_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:utils/sign_in.dart';
import 'package:widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:bp_track/l10n/app_localizations.dart';
import 'package:bp_track/widgets/health_sync_settings.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  final db = BloodPressureDatabaseService();
  final _userDb = UserDatabaseService();

  void handleSignOut(BuildContext context) {
    signOut();
    context.go('/');
  }

  void _onLinked(User user, BuildContext context) {
    _userDb.updateUserData(user);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account linked successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Show account link/sign-in options when user is anonymous
            AccountLink(
              onSignedIn: (User user) => _onLinked(user, context),
            ),
            const SizedBox(height: 24),
            // Health sync toggle
            const HealthSyncSettings(),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => handleSignOut(context),
              child: Text(AppLocalizations.of(context)!.logOut),
            ),
            const SizedBox(height: 12),
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
