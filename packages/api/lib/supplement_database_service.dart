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

  Future<Stream<Iterable<UserSupplement>>> streamUserSupplements() async {
    return _db.collection('userSupplements').snapshots().asyncMap((element) {
      return Stream.fromIterable(element.docs).asyncMap((e) async {
        var user =
            await _db.doc(e.data()['user']).get().then((value) => value.data());
        var supplement =
            await _db.doc(e.data()['supplement']).get().then((value) => value.data());

        return UserSupplement.fromMap({
          "id": e.id,
          "user": user != null ? UserModel.fromMap(user) : null,
          "supplement": supplement != null ? Supplement.fromMap(supplement) : null,
          "date": e.data()['date']
        });
      }).toList();
    });
  }
}
