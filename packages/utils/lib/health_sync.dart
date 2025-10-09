import 'dart:io' show Platform;

import 'package:health/health.dart';
import 'package:models/models.dart';

/// A small, reusable helper around the `health` plugin that centralizes
/// permission handling and basic read/write helpers. Configure with the
/// specific read/write types your feature needs.
class HealthSync {
  HealthSync({
    List<HealthDataType>? readTypes,
    List<HealthDataType>? writeTypes,
  })  : _readTypes = List.unmodifiable(readTypes ?? const <HealthDataType>[]),
        _writeTypes = List.unmodifiable(writeTypes ?? const <HealthDataType>[]);

  final Health _health = Health();
  final List<HealthDataType> _readTypes;
  final List<HealthDataType> _writeTypes;

  /// Returns true if health syncing is enabled for the current platform
  /// according to user preferences.
  bool isPlatformEnabled(Preferences prefs) {
    return (Platform.isIOS && prefs.healthKitEnabled) ||
        (Platform.isAndroid && prefs.healthConnectEnabled);
  }

  /// Ensures the app has the necessary permissions for the configured types.
  /// Returns true if all required permissions are granted.
  Future<bool> ensurePermissions() async {
    try {
      final readPerms = List.generate(_readTypes.length, (_) => HealthDataAccess.READ);
      final writePerms = List.generate(_writeTypes.length, (_) => HealthDataAccess.WRITE);

      bool ok = true;

      if (_readTypes.isNotEmpty) {
        final has = await _health.hasPermissions(_readTypes, permissions: readPerms) ?? false;
        ok = has || await _health.requestAuthorization(_readTypes, permissions: readPerms);
        if (!ok) return false;
      }

      if (_writeTypes.isNotEmpty) {
        final has = await _health.hasPermissions(_writeTypes, permissions: writePerms) ?? false;
        ok = has || await _health.requestAuthorization(_writeTypes, permissions: writePerms);
        if (!ok) return false;
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  /// After the user toggles the setting, call this to request permissions
  /// only when the feature is enabled for the current platform.
  Future<bool> requestPermissionsAfterToggle(Preferences prefs) async {
    if (isPlatformEnabled(prefs)) {
      return await ensurePermissions();
    }
    return true; // nothing to do if not enabled
  }

  /// Read health data for the configured read types within a window.
  Future<List<HealthDataPoint>> readBetween({
    required DateTime start,
    required DateTime end,
  }) async {
    if (_readTypes.isEmpty) return <HealthDataPoint>[];
    try {
      final data = await _health.getHealthDataFromTypes(
        types: _readTypes,
        startTime: start,
        endTime: end,
      );
      return data;
    } catch (_) {
      return <HealthDataPoint>[];
    }
  }

  /// Write a numeric value for a specific type at a given instant.
  Future<bool> writeNumeric({
    required HealthDataType type,
    required num value,
    DateTime? when,
  }) async {
    final t = when ?? DateTime.now();
    try {
      await _health.writeHealthData(
        value: value.toDouble(),
        type: type,
        startTime: t,
        endTime: t,
      );
      return true;
    } catch (_) {
      return false;
    }
  }
}
