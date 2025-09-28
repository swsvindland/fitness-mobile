import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:models/models.dart';
import 'dart:async';

class BloodPressureDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var date = DateTime.now();

  Stream<Iterable<BloodPressure>> streamBloodPressures(String id) {
    return _db
        .collection('bps')
        .where("uid", isEqualTo: id)
        .snapshots()
        .map((event) => event.docs.map((e) => BloodPressure.fromMap({
              "id": e.id,
              "uid": e.data()["uid"],
              "systolic": e.data()["systolic"],
              "diastolic": e.data()["diastolic"],
              "heartRate": e.data()["heartRate"],
              "date": e.data()["date"]
            })));
  }

  Future<List<BloodPressure>> listBloodPressuresSince(String uid, DateTime from) async {
    final query = await _db
        .collection('bps')
        .where("uid", isEqualTo: uid)
        .where("date", isGreaterThanOrEqualTo: from)
        .get();

    return query.docs
        .map((e) => BloodPressure.fromMap({
              "id": e.id,
              "uid": e.data()["uid"],
              "systolic": e.data()["systolic"],
              "diastolic": e.data()["diastolic"],
              "heartRate": e.data()["heartRate"],
              "date": e.data()["date"]
            }))
        .toList();
  }

  Future<void> deleteBloodPressure(String id) {
    return _db
        .collection('bps')
        .where(FieldPath.documentId, isEqualTo: id)
        .get()
        .then((value) {
      for (var element in value.docs) {
        element.reference.delete();
      }
    });
  }

  Future<void> updateBloodPressure(String id, String uid, int systolic,
      int diastolic, int? heartRate) async {
    return _db
        .collection('bps')
        .where(FieldPath.documentId, isEqualTo: id)
        .get()
        .then((value) {
              for (var element in value.docs)
                {
                  element.reference.update({
                    "uid": uid,
                    "systolic": systolic,
                    "diastolic": diastolic,
                    "heartRate": heartRate
                  });
                };
            });
  }

  Future<void> addBloodPressure(
      String id, int systolic, int diastolic, int? heartRate) {
    return _db.collection('bps').doc().set({
      "uid": id,
      "date": DateTime.now(),
      "systolic": systolic,
      'diastolic': diastolic,
      'heartRate': heartRate
    });
  }

  Future<void> addBloodPressureAt(
      String id, int systolic, int diastolic, int? heartRate, DateTime date) {
    return _db.collection('bps').doc().set({
      "uid": id,
      "date": date,
      "systolic": systolic,
      'diastolic': diastolic,
      'heartRate': heartRate
    });
  }
}
