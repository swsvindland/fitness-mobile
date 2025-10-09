import 'dart:async';

import 'package:api/blood_pressure_database_service.dart';
import 'package:health/health.dart';
import 'package:utils/health_sync.dart';

class HealthSyncService {
  HealthSyncService._internal()
      : _core = HealthSync(
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
  static final HealthSyncService _instance = HealthSyncService._internal();
  factory HealthSyncService() => _instance;

  final HealthSync _core;

  Future<bool> _ensurePermissions() async {
    return _core.ensurePermissions();
  }

  /// Resync last 90 days of blood pressure readings from HealthKit/Health Connect into Firestore.
  Future<void> resyncLast90Days(String uid, BloodPressureDatabaseService db) async {
    final granted = await _ensurePermissions();
    if (!granted) return;

    final DateTime end = DateTime.now();
    final DateTime start = end.subtract(const Duration(days: 90));

    List<HealthDataPoint> points = [];
    try {
      points = await _core.readBetween(start: start, end: end);
    } catch (_) {
      // ignore errors; just abort quietly
      return;
    }

    if (points.isEmpty) return;

    // Normalize timestamps to the minute to pair systolic and diastolic
    final Map<String, num> systolicByKey = {};
    final Map<String, num> diastolicByKey = {};
    final Map<String, num> hrByKey = {};
    final Map<String, DateTime> keyToDate = {};

    String makeKey(DateTime d) {
      // truncate to minute and include timezone offset to prevent collisions
      final dt = DateTime(d.year, d.month, d.day, d.hour, d.minute);
      final key = '${dt.toIso8601String()}_${dt.timeZoneOffset.inMinutes}';
      keyToDate[key] = dt;
      return key;
    }

    for (final p in points) {
      final key = makeKey(p.dateFrom);
      switch (p.type) {
        case HealthDataType.BLOOD_PRESSURE_SYSTOLIC:
          systolicByKey[key] = (p.value is num) ? p.value as num : num.tryParse('${p.value}') ?? 0;
          break;
        case HealthDataType.BLOOD_PRESSURE_DIASTOLIC:
          diastolicByKey[key] = (p.value is num) ? p.value as num : num.tryParse('${p.value}') ?? 0;
          break;
        case HealthDataType.HEART_RATE:
          hrByKey[key] = (p.value is num) ? p.value as num : num.tryParse('${p.value}') ?? 0;
          break;
        default:
          break;
      }
    }

    // Fetch existing BPs for the same window to avoid duplicates
    final existing = await db.listBloodPressuresSince(uid, start);

    final existingKeys = existing.map((bp) {
      final dt = DateTime(bp.date.year, bp.date.month, bp.date.day, bp.date.hour, bp.date.minute);
      return '${dt.toIso8601String()}_${dt.timeZoneOffset.inMinutes}';
    }).toSet();

    for (final key in systolicByKey.keys) {
      if (!diastolicByKey.containsKey(key)) continue; // require both values
      if (existingKeys.contains(key)) continue; // already have this minute

      final int sys = systolicByKey[key]!.round();
      final int dia = diastolicByKey[key]!.round();
      final int? hr = hrByKey[key]?.round();
      final when = keyToDate[key] ?? DateTime.now();

      try {
        await db.addBloodPressureAt(uid, sys, dia, hr, when);
      } catch (_) {
        // ignore individual failures
      }
    }
  }

  /// Write a BP sample (systolic & diastolic) to HealthKit/Health Connect at the given time.
  Future<void> writeBloodPressure({
    required int systolic,
    required int diastolic,
    DateTime? date,
  }) async {
    final granted = await _ensurePermissions();
    if (!granted) return;

    final when = date ?? DateTime.now();

    try {
      await _core.writeNumeric(
        type: HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
        value: systolic,
        when: when,
      );
      await _core.writeNumeric(
        type: HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
        value: diastolic,
        when: when,
      );
    } catch (_) {
      // ignore write failure
    }
  }
}
