import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bp_track/models/models.dart';
import 'dart:async';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var date = DateTime.now();

  Stream<Iterable<BloodPressure>> streamBloodPressures(String id) {
    return _db
        .collection('bps')
        .where("uid", isEqualTo: id)
        .snapshots()
        .map((event) => event.docs.map((e) => BloodPressure.fromMap(e.data())));
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
}
