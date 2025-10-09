import 'dart:io' show Platform;

import 'package:api/preferences_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:utils/health_sync.dart';

class HealthSyncToggle extends StatefulWidget {
  const HealthSyncToggle({
    super.key,
    required this.user,
    required this.preferences,
    required this.healthSync,
    this.title,
    this.onChanged,
    this.onSyncNow,
  });

  final User? user;
  final Preferences preferences;
  final HealthSync healthSync;
  final String? title;
  final ValueChanged<bool>? onChanged;
  final Future<void> Function()? onSyncNow;

  @override
  State<HealthSyncToggle> createState() => _HealthSyncToggleState();
}

class _HealthSyncToggleState extends State<HealthSyncToggle> {
  final _prefsDb = PreferencesDatabaseService();
  bool _busy = false;

  Future<void> _setEnabled(bool value) async {
    if (widget.user == null) return;
    setState(() => _busy = true);
    try {
      if (Platform.isIOS) {
        widget.preferences.healthKitEnabled = value;
      } else if (Platform.isAndroid) {
        widget.preferences.healthConnectEnabled = value;
      }
      await _prefsDb.updatePreferences(widget.user!.uid, widget.preferences);

      // Request permissions if enabling
      await widget.healthSync.requestPermissionsAfterToggle(widget.preferences);

      widget.onChanged?.call(value);

      // If enabling and a sync callback is provided, kick off a sync
      if (value && widget.onSyncNow != null) {
        await widget.onSyncNow!();
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;
    final isAndroid = Platform.isAndroid;

    final enabled = isIOS
        ? widget.preferences.healthKitEnabled
        : isAndroid
            ? widget.preferences.healthConnectEnabled
            : false;

    final subtitle = isIOS
        ? 'Sync with Apple Health'
        : isAndroid
            ? 'Sync with Health Connect'
            : 'Health sync not supported on this platform';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(widget.title ?? 'Health sync'),
              subtitle: Text(subtitle),
              trailing: (isIOS || isAndroid)
                  ? Switch(
                      value: enabled,
                      onChanged: _busy ? null : (v) => _setEnabled(v),
                    )
                  : null,
            ),
            if (isIOS || isAndroid)
              Align(
                alignment: Alignment.centerLeft,
                child: OutlinedButton.icon(
                  onPressed: (!enabled || _busy)
                      ? null
                      : () async {
                          setState(() => _busy = true);
                          try {
                            // Ensure we still have permissions then trigger sync
                            await widget.healthSync.ensurePermissions();
                            if (widget.onSyncNow != null) await widget.onSyncNow!();
                          } finally {
                            if (mounted) setState(() => _busy = false);
                          }
                        },
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
