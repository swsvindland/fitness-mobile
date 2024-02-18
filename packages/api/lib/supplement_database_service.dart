import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:models/models.dart';
import 'dart:async';

class SupplementDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var date = DateTime.now();

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

  Stream<Iterable<UserSupplement>> streamUserSupplements() {
    return _db
        .collection('supplements')
        .snapshots()
        .map((event) => event.docs.map((e) => UserSupplement.fromMap({
              "id": e.id,
              "uid": e.data()['uid'],
              "supplementId": e.data()['supplementId'],
              "date": e.data()['date'],
            })));
  }
}
