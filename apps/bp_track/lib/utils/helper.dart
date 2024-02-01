import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void updateUserData(FirebaseFirestore db, User user) async {
  DocumentReference ref = db.collection('users').doc(user.uid);

  return ref.set({
    'uid': user.uid,
    'email': user.email,
    'displayName': user.displayName,
    'lastSeen': DateTime.now()
  });
}

bool isNumeric(String? num) {
  if (num == null) {
    return false;
  }

  return double.tryParse(num) != null;
}

bool isInt(String? num) {
  if (num == null) {
    return false;
  }

  return int.tryParse(num) != null;
}

String? checkInValidator(String? value) {
  if (value == null || value.isEmpty || !isNumeric(value)) {
    return 'Please enter a measurement';
  }
  return null;
}

String? optionalCheckInIntValidator(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }

  if (!isInt(value)) {
    return 'Please enter a valid number';
  }
  return null;
}