import 'dart:io' show Platform;

import 'package:api/preferences_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';
import 'package:body_track/l10n/app_localizations.dart';
import 'package:body_track/services/health_sync_service.dart' as local;

class HealthSyncSettings extends StatefulWidget {
  const HealthSyncSettings({super.key});

  @override
  State<HealthSyncSettings> createState() => _HealthSyncSettingsState();
}

class _HealthSyncSettingsState extends State<HealthSyncSettings> {
  final _prefsDb = PreferencesDatabaseService();
  final _sync = local.HealthSyncService();

  Future<void> _toggle(User? user, Preferences p, bool value) async {
    if (user == null) return;
    if (Platform.isIOS) {
      p.healthKitEnabled = value;
    } else if (Platform.isAndroid) {
      p.healthConnectEnabled = value;
    }
    await _prefsDb.updatePreferences(user.uid, p);

    if (value) {
      // If enabling, try to request permissions and do an immediate sync
      await _sync.syncIfEnabled(user, p);
    }

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final preferences = Provider.of<Preferences>(context);

    final isIOS = Platform.isIOS;
    final isAndroid = Platform.isAndroid;

    String title = AppLocalizations.of(context)!.settings;
    String subtitle = isIOS
        ? 'Sync with Apple Health'
        : isAndroid
            ? 'Sync with Health Connect'
            : 'Health sync not supported on this platform';

    final enabled = isIOS
        ? preferences.healthKitEnabled
        : isAndroid
            ? preferences.healthConnectEnabled
            : false;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(title),
              subtitle: Text(subtitle),
              trailing: (isIOS || isAndroid)
                  ? Switch(
                      value: enabled,
                      onChanged: (v) => _toggle(user, preferences, v),
                    )
                  : null,
            ),
            if (isIOS || isAndroid)
              Align(
                alignment: Alignment.centerLeft,
                child: OutlinedButton.icon(
                  onPressed: enabled ? () => _sync.syncIfEnabled(user, preferences) : null,
                  icon: const Icon(Icons.sync),
                  label: const Text('Sync now'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
