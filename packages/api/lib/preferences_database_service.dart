import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:models/preferences.dart';

class PreferencesDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // var date = DateTime.now(); // This variable 'date' was unused. Removed.

  Stream<Preferences> streamPreferences(String? userId) {
    if (userId == null) return Stream.error('User ID is null');

    return _db
        .collection('preferences')
        .where('uid', isEqualTo: userId)
        .limit(1) // Expect only one preferences document per user UID
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        // This case should ideally be handled by createDefaultPreferences ensuring a doc always exists.
        // However, to be robust, we could return a default or throw an error.
        // For now, let's assume createDefaultPreferences has run.
        // If not, this stream will not emit until a document is created.
        // Or, we could create and return default preferences here if needed,
        // but that might have side effects if not intended.
        // For typical scenarios, an error or an empty stream might be more appropriate
        // if the document is truly expected to exist.
        // Let's re-evaluate if this causes issues.
        // For now, if no doc, we can make the stream emit an error or handle it upstream.
        // Throwing an error here if no doc found.
        throw Exception('Preferences not found for user \$userId and not created.');
        // Alternatively, to ensure the stream doesn't break if docs are momentarily absent
        // and defaults are expected to be created soon:
        // return Preferences.empty(userId); // but this is a new object not from DB.
      }
      // Pass the userId to fromMap, as per the current fromMap signature in Preferences model
      return Preferences.fromMap(snapshot.docs.first.data(), userId);
    });
  }

  Future<void> updatePreferences(String userId, Preferences preferences) async {
    // Ensure the preferences object being saved has the correct uid.
    if (preferences.uid != userId) {
      throw ArgumentError('Preferences UID does not match User ID for update.');
    }

    final querySnapshot = await _db
        .collection('preferences')
        .where('uid', isEqualTo: userId)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Document exists, update it using its actual Firestore document ID
      final docId = querySnapshot.docs.first.id;
      await _db
          .collection('preferences')
          .doc(docId)
          .set(Preferences.toMap(preferences));
    } else {
      // Document does not exist, create a new one.
      // Firestore will auto-generate a document ID.
      // The 'uid' field is already part of the map from Preferences.toMap.
      await _db.collection('preferences').add(Preferences.toMap(preferences));
    }
  }

  Future<void> createDefaultPreferences(User user) async {
    final querySnapshot = await _db
        .collection('preferences')
        .where('uid', isEqualTo: user.uid)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      // No preferences document found for this user UID, create one.
      var emptyPrefs = Preferences.empty(user.uid); // Pass user.uid here
      await _db.collection('preferences').add(Preferences.toMap(emptyPrefs));
    }
    // If a document already exists, do nothing.
  }
}
