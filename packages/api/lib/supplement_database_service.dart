import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:models/models.dart';
import 'dart:async';

class SupplementDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var date = DateTime.now();

  final Timestamp today = Timestamp.fromDate(DateTime.now());
  final Timestamp yesterday = Timestamp.fromDate(DateTime.now().subtract(Duration(days: 1)));

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

  Future<void> addUserSupplement(String uid, String supplementId) {
    return _db.collection('userSupplements').add({
      "user": '/users/$uid',
      "supplement": '/supplements/$supplementId',
      "date": date,
    });
  }

  Future<Stream<Iterable<UserSupplement>>> streamUserSupplements() async {
    return _db.collection('userSupplements').snapshots().asyncMap((element) {
      return Stream.fromIterable(element.docs).asyncMap((e) async {
        var user =
            await _db.doc(e.data()['user']).get().then((value) => value.data());
        var supplement = await _db
            .doc(e.data()['supplement'])
            .get()
            .then((value) => value.data());

        return UserSupplement.fromMap({
          "id": e.id,
          "user": user != null ? UserModel.fromMap(user) : null,
          "supplement":
              supplement != null ? Supplement.fromMap(supplement) : null,
          "date": e.data()['date']
        });
      }).toList();
    });
  }

  Stream<Iterable<UserSupplementActivity>> streamUserSupplementActivity(
      String uid, String? supplementId) {
    if (supplementId == null) return List.empty() as Stream<Iterable<UserSupplementActivity>>;

    var supplementRef = _db.doc('userSupplements/$supplementId');

    print(supplementId);
    print(supplementRef);

    return _db
        .collection('userSupplementActivity')
        .where('uid', isEqualTo: uid)
        .where('userSupplement', isEqualTo: supplementRef)
        .where('date', isGreaterThanOrEqualTo: yesterday)
        .snapshots()
        .map((event) => event.docs.map((e) => UserSupplementActivity.fromMap(e.data())));
  }

  Future<void> addUserSupplementActivity(String uid, String supplementId) {
    var supplementRef = _db.doc('userSupplements/$supplementId');

    return _db.collection('userSupplementActivity').add({
      "uid": uid,
      "userSupplement": supplementRef,
      "date": date,
    });
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

  Future<void> toggleUserSupplementActivity(String uid, String supplementId) async {
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
