import 'package:api/blood_pressure_database_service.dart';
import 'package:api/preferences_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:models/models.dart';
import 'package:provider/provider.dart';
import 'package:utils/health_sync.dart';
import 'package:widgets/health_sync_toggle.dart';
import 'package:bp_track/services/health_sync.dart' as bp_sync;

class HealthSyncSettings extends StatelessWidget {
  const HealthSyncSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null) return const SizedBox.shrink();

    final prefsDb = PreferencesDatabaseService();

    return StreamBuilder<Preferences>(
      stream: prefsDb.streamPreferences(user.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }
        final preferences = snapshot.data!;

        final core = HealthSync(
          readTypes: const [
            HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
            HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
            HealthDataType.HEART_RATE,
          ],
          writeTypes: const [
            HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
            HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
          ],
        );

        final service = bp_sync.HealthSyncService();
        final db = BloodPressureDatabaseService();

        return HealthSyncToggle(
          user: user,
          preferences: preferences,
          healthSync: core,
          title: 'Health sync',
          onSyncNow: () => service.resyncLast90Days(user.uid, db),
        );
      },
    );
  }
}
