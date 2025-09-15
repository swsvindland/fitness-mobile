import 'dart:io' show Platform;

import 'package:api/body_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:health/health.dart';
import 'package:models/models.dart';

class HealthSyncService {
  HealthSyncService();

  final Health _health = Health();
  final BodyDatabaseService _db = BodyDatabaseService();

  List<HealthDataType> get _types => const [
        HealthDataType.WEIGHT,
        HealthDataType.HEIGHT,
        HealthDataType.WAIST_CIRCUMFERENCE,
      ];

  List<HealthDataAccess> get _readPermissions => const [
        HealthDataAccess.READ,
        HealthDataAccess.READ,
        HealthDataAccess.READ,
      ];

  List<HealthDataAccess> get _writePermissions => const [
        HealthDataAccess.WRITE,
        HealthDataAccess.WRITE,
        HealthDataAccess.WRITE,
      ];

  bool _isEnabled(Preferences prefs) {
    return (Platform.isIOS && prefs.healthKitEnabled) || (Platform.isAndroid && prefs.healthConnectEnabled);
  }

  Future<bool> ensurePermissions() async {
    try {
      final has = await _health.hasPermissions(_types, permissions: _readPermissions) ?? false;
      if (!has) {
        return await _health.requestAuthorization(_types, permissions: _readPermissions);
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Health permissions error: $e');
      }
      return false;
    }
  }

  Future<bool> ensureWritePermissions() async {
    try {
      final has = await _health.hasPermissions(_types, permissions: _writePermissions) ?? false;
      if (!has) {
        return await _health.requestAuthorization(_types, permissions: _writePermissions);
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Health write permissions error: $e');
      }
      return false;
    }
  }

  Future<void> syncIfEnabled(User? user, Preferences prefs) async {
    if (user == null) return;
    // Only proceed if enabled on this platform
    if ((Platform.isIOS && !prefs.healthKitEnabled) ||
        (Platform.isAndroid && !prefs.healthConnectEnabled)) {
      return;
    }

    final ok = await ensurePermissions();
    if (!ok) return;

    // Fetch last year's data to be safe; we'll pick the most recent entries by type
    final now = DateTime.now();
    final start = now.subtract(const Duration(days: 365));

    try {
      final data = await _health.getHealthDataFromTypes(
        types: _types,
        startTime: start,
        endTime: now,
      );

      HealthDataPoint? latestOf(HealthDataType t) {
        final items = data.where((e) => e.type == t).toList();
        if (items.isEmpty) return null;
        items.sort((a, b) => (a.dateTo).compareTo(b.dateTo));
        return items.last;
      }

      // Weight (kg)
      final latestWeight = latestOf(HealthDataType.WEIGHT);
      if (latestWeight != null) {
        final w = (latestWeight.value is NumericHealthValue)
            ? (latestWeight.value as NumericHealthValue).numericValue.toDouble()
            : double.tryParse(latestWeight.value.toString());
        if (w != null && w > 0) {
          await _db.addWeighIn(user.uid, w);
        }
      }

      // Height (cm) - health plugin usually reports meters
      final latestHeight = latestOf(HealthDataType.HEIGHT);
      if (latestHeight != null) {
        final h = (latestHeight.value is NumericHealthValue)
            ? (latestHeight.value as NumericHealthValue).numericValue.toDouble()
            : double.tryParse(latestHeight.value.toString());
        if (h != null && h > 0) {
          // convert meters to cm if likely in meters
          final cm = h < 3.5 ? (h * 100).round() : h.round();
          await _db.addHeight(user.uid, cm);
        }
      }

      // Waist circumference (cm) - plugin likely returns meters
      final latestWaist = latestOf(HealthDataType.WAIST_CIRCUMFERENCE);
      if (latestWaist != null) {
        final v = (latestWaist.value is NumericHealthValue)
            ? (latestWaist.value as NumericHealthValue).numericValue.toDouble()
            : double.tryParse(latestWaist.value.toString());
        if (v != null && v > 0) {
          final cm = v < 3.5 ? (v * 100) : v; // if meters, convert to cm
          // Create a minimal check-in with only waist populated
          await _db.addCheckIn(
            user.uid,
            0.0, // neck
            0.0, // shoulders
            0.0, // chest
            0.0, // leftBicep
            0.0, // rightBicep
            0.0, // navel
            cm, // waist
            0.0, // hip
            0.0, // leftThigh
            0.0, // rightThigh
            0.0, // leftCalf
            0.0, // rightCalf
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Health sync error: $e');
      }
    }
  }

  Future<void> writeWeightIfEnabled(User? user, Preferences prefs, double kg, {DateTime? date}) async {
    if (!_isEnabled(prefs)) return;
    final ok = await ensureWritePermissions();
    if (!ok) return;
    final t = date ?? DateTime.now();
    try {
      await _health.writeHealthData(
        value: kg,
        type: HealthDataType.WEIGHT,
        startTime: t,
        endTime: t,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Health write weight error: $e');
      }
    }
  }

  Future<void> writeHeightIfEnabled(User? user, Preferences prefs, int cm, {DateTime? date}) async {
    if (!_isEnabled(prefs)) return;
    final ok = await ensureWritePermissions();
    if (!ok) return;
    final t = date ?? DateTime.now();
    final meters = cm / 100.0;
    try {
      await _health.writeHealthData(
        value: meters,
        type: HealthDataType.HEIGHT,
        startTime: t,
        endTime: t,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Health write height error: $e');
      }
    }
  }

  Future<void> writeWaistIfEnabled(User? user, Preferences prefs, double cm, {DateTime? date}) async {
    if (!_isEnabled(prefs)) return;
    if (cm <= 0) return;
    final ok = await ensureWritePermissions();
    if (!ok) return;
    final t = date ?? DateTime.now();
    final meters = cm / 100.0;
    try {
      await _health.writeHealthData(
        value: meters,
        type: HealthDataType.WAIST_CIRCUMFERENCE,
        startTime: t,
        endTime: t,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Health write waist error: $e');
      }
    }
  }
}
