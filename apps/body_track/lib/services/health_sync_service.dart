import 'package:api/body_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:health/health.dart';
import 'package:models/models.dart';
import 'package:utils/health_sync.dart';

class HealthSyncService {
  HealthSyncService()
      : _core = HealthSync(
          readTypes: const [
            HealthDataType.WEIGHT,
            HealthDataType.HEIGHT,
          ],
          writeTypes: const [
            HealthDataType.WEIGHT,
            HealthDataType.HEIGHT,
            HealthDataType.WAIST_CIRCUMFERENCE,
          ],
        );

  final HealthSync _core;
  final BodyDatabaseService _db = BodyDatabaseService();

  Future<bool> ensurePermissions() => _core.ensurePermissions();

  /// Called when the user toggles HealthKit/Health Connect settings.
  /// If sync is enabled, this will trigger a permission request.
  Future<bool> requestPermissionsAfterToggle(Preferences prefs) async {
    return _core.requestPermissionsAfterToggle(prefs);
  }

  Future<void> syncIfEnabled(User? user, Preferences prefs) async {
    if (user == null) return;
    if (!_core.isPlatformEnabled(prefs)) return;

    final ok = await _core.ensurePermissions();
    if (!ok) return;

    // Fetch last 90 days' data
    final now = DateTime.now();
    final start = now.subtract(const Duration(days: 90));

    try {
      final data = await _core.readBetween(start: start, end: now);

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
    } catch (e) {
      if (kDebugMode) {
        print('HealthSyncService: Sync error: $e');
      }
    }
  }

  Future<void> writeWeightIfEnabled(User? user, Preferences prefs, double kg, {DateTime? date}) async {
    if (user == null || !_core.isPlatformEnabled(prefs)) return;
    final ok = await _core.ensurePermissions();
    if (!ok) return;
    await _core.writeNumeric(type: HealthDataType.WEIGHT, value: kg, when: date);
  }

  Future<void> writeHeightIfEnabled(User? user, Preferences prefs, int cm, {DateTime? date}) async {
    if (user == null || !_core.isPlatformEnabled(prefs)) return;
    final ok = await _core.ensurePermissions();
    if (!ok) return;
    final meters = cm / 100.0;
    await _core.writeNumeric(type: HealthDataType.HEIGHT, value: meters, when: date);
  }

  Future<void> writeWaistIfEnabled(User? user, Preferences prefs, double cm, {DateTime? date}) async {
    if (user == null || !_core.isPlatformEnabled(prefs)) return;
    if (cm <= 0) return;
    final ok = await _core.ensurePermissions();
    if (!ok) return;
    final meters = cm / 100.0;
    await _core.writeNumeric(type: HealthDataType.WAIST_CIRCUMFERENCE, value: meters, when: date);
  }
}
