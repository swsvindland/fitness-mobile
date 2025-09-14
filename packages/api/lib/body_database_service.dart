import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:models/models.dart';
import 'dart:async';

class BodyDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var date = DateTime.now();

  // Heights
  Stream<Iterable<HeightModel>> streamHeights(String id) {
    return _db
        .collection('height')
        .where("uid", isEqualTo: id)
        .orderBy("date", descending: true)
        .snapshots()
        .map((event) => event.docs.map((e) => HeightModel.fromMap({
              "id": e.id,
              "height": e.data()["height"],
              "date": e.data()["date"]
            })));
  }

  Future<void> addHeight(String uid, int height) {
    return _db
        .collection('height')
        .doc()
        .set({"uid": uid, "date": DateTime.now(), "height": height});
  }

  Future<void> deleteHeight(String id) {
    return _db.collection('height').doc(id).delete();
  }

  Future<void> updateHeight(String id, int height) {
    return _db.collection('height').doc(id).update({"height": height});
  }

  Stream<Iterable<Weight>> streamWeighIns(String id) {
    return _db
        .collection('weight')
        .where("uid", isEqualTo: id)
        .orderBy("date", descending: true)
        .snapshots()
        .map((event) => event.docs.map((e) => Weight.fromMap({
              "id": e.id,
              "weight": e.data()["weight"],
              "date": e.data()["date"]
            })));
  }

  Future<void> addWeighIn(String uid, double weight) {
    return _db
        .collection('weight')
        .doc()
        .set({"uid": uid, "date": DateTime.now(), "weight": weight});
  }

  Future<void> deleteWeighIn(String id) {
    return _db.collection('weight').doc(id).delete();
  }

  Future<void> updateWeighIn(String id, double weight) {
    return _db.collection('weight').doc(id).update({"weight": weight});
  }

  Future<void> addCheckIn(
      String id,
      double neck,
      double shoulders,
      double chest,
      double leftBicep,
      double rightBicep,
      double navel,
      double waist,
      double hip,
      double leftThigh,
      double rightThigh,
      double leftCalf,
      double rightCalf) {
    return _db.collection('checkIns').doc().set({
      "uid": id,
      "date": DateTime.now(),
      "neck": neck,
      "shoulders": shoulders,
      "chest": chest,
      "leftBicep": leftBicep,
      "rightBicep": rightBicep,
      "navel": navel,
      "waist": waist,
      "hip": hip,
      "leftThigh": leftThigh,
      "rightThigh": rightThigh,
      "leftCalf": leftCalf,
      "rightCalf": rightCalf
    });
  }

  Future<void> updateCheckIn(
      String id,
      double neck,
      double shoulders,
      double chest,
      double leftBicep,
      double rightBicep,
      double navel,
      double waist,
      double hip,
      double leftThigh,
      double rightThigh,
      double leftCalf,
      double rightCalf) {
    return _db.collection('checkIns').doc(id).update({
      "date": DateTime.now(),
      "neck": neck,
      "shoulders": shoulders,
      "chest": chest,
      "leftBicep": leftBicep,
      "rightBicep": rightBicep,
      "navel": navel,
      "waist": waist,
      "hip": hip,
      "leftThigh": leftThigh,
      "rightThigh": rightThigh,
      "leftCalf": leftCalf,
      "rightCalf": rightCalf
    });
  }

  Future<void> deleteCheckIn(String id) {
    return _db.collection('checkIns').doc(id).delete();
  }

  Stream<Iterable<CheckInModel>> streamCheckIns(String id) {
    return _db
        .collection('checkIns')
        .where("uid", isEqualTo: id)
        .orderBy("date", descending: true)
        .snapshots()
        .map((event) => event.docs.map((e) => CheckInModel.fromMap({
              "id": e.id,
              "date": e.data()["date"],
              "neck": e.data()["neck"],
              "shoulders": e.data()["shoulders"],
              "chest": e.data()["chest"],
              "leftBicep": e.data()["leftBicep"],
              "rightBicep": e.data()["rightBicep"],
              "navel": e.data()["navel"],
              "waist": e.data()["waist"],
              "hip": e.data()["hip"],
              "leftThigh": e.data()["leftThigh"],
              "rightThigh": e.data()["rightThigh"],
              "leftCalf": e.data()["leftCalf"],
              "rightCalf": e.data()["rightCalf"],
            })));
  }
}
