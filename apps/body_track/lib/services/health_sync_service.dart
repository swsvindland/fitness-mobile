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

  // Data types that this service reads from the Health platform
  List<HealthDataType> get _readDataTypes => const [
        HealthDataType.WEIGHT,
        HealthDataType.HEIGHT,
        // WAIST_CIRCUMFERENCE removed as it's write-only to health platform
      ];

  // Data types that this service can write to the Health platform
  List<HealthDataType> get _writeDataTypes => const [
        HealthDataType.WEIGHT,
        HealthDataType.HEIGHT,
        HealthDataType.WAIST_CIRCUMFERENCE,
      ];

  bool _isEnabled(Preferences prefs) {
    return (Platform.isIOS && prefs.healthKitEnabled) || (Platform.isAndroid && prefs.healthConnectEnabled);
  }

  Future<bool> ensurePermissions() async {
    try {
      // Ensure read permissions for read types
      if (_readDataTypes.isNotEmpty) {
        final readPermissions = List.generate(_readDataTypes.length, (_) => HealthDataAccess.READ);
        bool hasReadPerms = await _health.hasPermissions(_readDataTypes, permissions: readPermissions) ?? false;
        if (!hasReadPerms) {
          hasReadPerms = await _health.requestAuthorization(_readDataTypes, permissions: readPermissions);
        }
        if (!hasReadPerms) {
          if (kDebugMode) {
            print('HealthSyncService: Failed to obtain read permissions for: ${_readDataTypes.map((t) => t.name).join(', ')}');
          }
          return false;
        }
      }

      // Ensure write permissions for write types
      if (_writeDataTypes.isNotEmpty) {
        final writePermissions = List.generate(_writeDataTypes.length, (_) => HealthDataAccess.WRITE);
        bool hasWritePerms = await _health.hasPermissions(_writeDataTypes, permissions: writePermissions) ?? false;
        if (!hasWritePerms) {
          hasWritePerms = await _health.requestAuthorization(_writeDataTypes, permissions: writePermissions);
        }
        if (!hasWritePerms) {
          if (kDebugMode) {
            print('HealthSyncService: Failed to obtain write permissions for: ${_writeDataTypes.map((t) => t.name).join(', ')}');
          }
          return false;
        }
      }
      return true; // All necessary permissions granted
    } catch (e) {
      if (kDebugMode) {
        print('HealthSyncService: Permissions error during ensurePermissions: $e');
      }
      return false;
    }
  }

  /// Called when the user toggles HealthKit/Health Connect settings.
  /// If sync is enabled, this will trigger a permission request.
  Future<bool> requestPermissionsAfterToggle(Preferences prefs) async {
    if (_isEnabled(prefs)) {
      return await ensurePermissions();
    } else {
      // If sync is not enabled, no permissions need to be requested.
      // Return true to indicate success in this context (no action needed).
      return true;
    }
  }

  Future<void> syncIfEnabled(User? user, Preferences prefs) async {
    if (user == null) return;
    // Only proceed if enabled on this platform
    if (!_isEnabled(prefs)) {
      return;
    }

    final ok = await ensurePermissions();
    if (!ok) return;

    // Fetch last 90 days' data
    final now = DateTime.now();
    final start = now.subtract(const Duration(days: 90));

    try {
      if (_readDataTypes.isNotEmpty) { // Only fetch if there are types to read
        final data = await _health.getHealthDataFromTypes(
          types: _readDataTypes, // Use specific read types
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
      }
      // Waist circumference sync is removed from read operations
    } catch (e) {
      if (kDebugMode) {
        print('HealthSyncService: Sync error: $e');
      }
    }
  }

  Future<void> writeWeightIfEnabled(User? user, Preferences prefs, double kg, {DateTime? date}) async {
    if (user == null || !_isEnabled(prefs)) return;
    final ok = await ensurePermissions(); // Use unified permissions check
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
        print('HealthSyncService: Write weight error: $e');
      }
    }
  }

  Future<void> writeHeightIfEnabled(User? user, Preferences prefs, int cm, {DateTime? date}) async {
    if (user == null || !_isEnabled(prefs)) return;
    final ok = await ensurePermissions(); // Use unified permissions check
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
        print('HealthSyncService: Write height error: $e');
      }
    }
  }

  Future<void> writeWaistIfEnabled(User? user, Preferences prefs, double cm, {DateTime? date}) async {
    if (user == null || !_isEnabled(prefs)) return;
    if (cm <= 0) return;
    final ok = await ensurePermissions(); // Use unified permissions check
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
        print('HealthSyncService: Write waist error: $e');
      }
    }
  }
}
