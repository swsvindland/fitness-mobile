import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var date = DateTime.now();

  Future<void> updateUserData(User user) async {
    final users = _db.collection('users');
    final data = {
      "uid": user.uid,
      "email": user.email,
      "displayName": user.displayName,
      "lastSeen": DateTime.now(),
    };

    // Try to find an existing document by uid
    final snapshot = await users.where('uid', isEqualTo: user.uid).limit(1).get();

    if (snapshot.docs.isNotEmpty) {
      // Update existing doc (merge to preserve other fields)
      await snapshot.docs.first.reference.set(data, SetOptions(merge: true));
    } else {
      // Create a new doc keyed by uid (upsert)
      await users.doc().set(data, SetOptions(merge: true));
    }
  }
}
