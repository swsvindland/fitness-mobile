import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:models/preferences.dart';

class PreferencesDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var date = DateTime.now();

  Stream<Preferences> streamPreferences(String? id) {
    if (id == null) return Stream.error('User ID is null');

    return _db
        .collection('preferences')
        .doc(id)
        .snapshots()
        .map((snap) => Preferences.fromMap(snap.data()!));
  }

  Future<void> updatePreferences(String id, Preferences preferences) {
    return _db
        .collection('preferences')
        .doc(id)
        .set(Preferences.toMap(preferences));
  }

  void createDefaultPreferences(User user) async {
    DocumentSnapshot snapshot =
    await _db.collection('preferences').doc(user.uid).get();

    var empty = Preferences.empty();

    if (!snapshot.exists) {
      snapshot.reference.set(Preferences.toMap(empty));
    }
  }
}
