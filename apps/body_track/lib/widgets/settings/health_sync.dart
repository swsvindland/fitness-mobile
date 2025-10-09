import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:models/models.dart';
import 'package:provider/provider.dart';
import 'package:widgets/health_sync_toggle.dart';
import 'package:utils/health_sync.dart';
import 'package:body_track/l10n/app_localizations.dart';
import 'package:body_track/services/health_sync_service.dart' as local;

class HealthSyncSettings extends StatelessWidget {
  const HealthSyncSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final preferences = Provider.of<Preferences>(context);

    final core = HealthSync(
      readTypes: const [HealthDataType.WEIGHT, HealthDataType.HEIGHT],
      writeTypes: const [
        HealthDataType.WEIGHT,
        HealthDataType.HEIGHT,
        HealthDataType.WAIST_CIRCUMFERENCE,
      ],
    );

    final service = local.HealthSyncService();

    return HealthSyncToggle(
      user: user,
      preferences: preferences,
      healthSync: core,
      title: AppLocalizations.of(context)!.settings,
      onSyncNow: () => service.syncIfEnabled(user, preferences),
    );
  }
}
