import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import "package:os_detect/os_detect.dart" as platform;

class FCMDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging fcm = FirebaseMessaging.instance;
  var date = DateTime.now();

  void setFCMData(User user) async {
    String? fcmToken = await fcm.getToken();

    if (fcmToken != null) {
      var tokenRef = _db.collection('tokens').doc(user.uid);
      tokenRef.set({
        'created': FieldValue.serverTimestamp(),
        'platform': platform.operatingSystem,
        'token': fcmToken
      });
    }
  }
}
