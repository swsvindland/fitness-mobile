import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:models/models.dart';
import 'dart:async';

class SupplementDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var date = DateTime.now();

  final Timestamp today = Timestamp.fromDate(DateTime.now());
  final Timestamp yesterday =
      Timestamp.fromDate(DateTime.now().subtract(Duration(days: 1)));

  Stream<Iterable<Supplement>> streamAllSupplements() {
    return _db
        .collection('supplements')
        .snapshots()
        .map((event) => event.docs.map((e) => Supplement.fromMap({
              "id": e.id,
              "name": e.data()['name'],
              "brand": e.data()['brand'],
            })));
  }

  Future<void> addUserSupplement(String uid, String supplementId, String time) {
    var userRef = _db.doc('users/$uid');
    var supplementRef = _db.doc('supplements/$supplementId');

    return _db.collection('userSupplements').add({
      "user": userRef,
      "supplement": supplementRef,
      "date": date,
      "time": time,
    });
  }

  Future<Stream<Iterable<UserSupplement>>> streamUserSupplements(String uid) async {
    var userRef = _db.doc('users/$uid');

    return await _db
        .collection('userSupplements')
        .where('user', isEqualTo: userRef)
        .snapshots()
        .asyncMap((element) {
      return Stream.fromIterable(element.docs).asyncMap((e) async {
        var supplementRef = e.data()['supplement'];

        var user = await userRef.get();
        var supplement = await supplementRef.get();

        return UserSupplement.fromMap({
          "id": e.id,
          "user": user.data() != null ? UserModel.fromMap(user.data()!) : null,
          "supplement":
              supplement.data() != null ? Supplement.fromMap(supplement.data()!) : null,
          "date": e.data()['date'],
          "time": e.data()['time'],
        });
      }).toList();
    });
  }

  Future<Iterable<UserSupplement>> getUserSupplementTimes(
      String uid, String supplementId) async {

    var userRef = _db.doc('users/$uid');
    var supplementRef = _db.doc('supplements/$supplementId');

    var userSupplements = await _db
        .collection('userSupplements')
        .where('user', isEqualTo: userRef)
        .where('supplement', isEqualTo: supplementRef)
        .get()
        .then((value) => value.docs.map((e) => UserSupplement.fromMap({
              "id": e.id,
              "user": null,
              "supplement": null,
              "date": e.data()['date'],
              "time": e.data()['time'],
            })));

    return userSupplements;
  }

  Stream<Iterable<UserSupplementActivity>> streamUserSupplementActivity(
      String uid, String? supplementId) {
    if (supplementId == null)
      return List.empty() as Stream<Iterable<UserSupplementActivity>>;

    var supplementRef = _db.doc('userSupplements/$supplementId');

    return _db
        .collection('userSupplementActivity')
        .where('uid', isEqualTo: uid)
        .where('userSupplement', isEqualTo: supplementRef)
        .where('date', isGreaterThanOrEqualTo: yesterday)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => UserSupplementActivity.fromMap(e.data())));
  }

  Future<void> addUserSupplementActivity(String uid, String supplementId) {
    var supplementRef = _db.doc('userSupplements/$supplementId');

    return _db.collection('userSupplementActivity').add({
      "uid": uid,
      "userSupplement": supplementRef,
      "date": date,
    });
  }

  Future<void> removeUserSupplement(String uid, String supplementId) {
    return _db
        .collection('userSupplements')
        .where('user', isEqualTo: '/users/$uid')
        .where('supplement', isEqualTo: '/supplements/$supplementId')
        .get()
        .then((value) => value.docs.forEach((element) {
              _db.collection('userSupplements').doc(element.id).delete();
            }));
  }

  Future<void> removeUserSupplementActivity(String uid, String supplementId) {
    var supplementRef = _db.doc('userSupplements/$supplementId');

    return _db
        .collection('userSupplementActivity')
        .where('uid', isEqualTo: uid)
        .where('userSupplement', isEqualTo: supplementRef)
        .where('date', isGreaterThanOrEqualTo: yesterday)
        .get()
        .then((value) => value.docs.forEach((element) {
              _db.collection('userSupplementActivity').doc(element.id).delete();
            }));
  }

  Future<void> toggleUserSupplementActivity(
      String uid, String supplementId) async {
    var supplementRef = _db.doc('userSupplements/$supplementId');

    var activity = await _db
        .collection('userSupplementActivity')
        .where('uid', isEqualTo: uid)
        .where('userSupplement', isEqualTo: supplementRef)
        .where('date', isGreaterThanOrEqualTo: yesterday)
        .get();

    print(activity.docs.isEmpty);

    if (activity.docs.isEmpty) {
      addUserSupplementActivity(uid, supplementId);
    } else {
      removeUserSupplementActivity(uid, supplementId);
    }
  }
}
