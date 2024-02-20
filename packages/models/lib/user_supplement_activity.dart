import 'package:models/models.dart';

class UserSupplementActivity {
  String? id;
  String uid;
  UserSupplement? userSupplement;
  DateTime? date;

  UserSupplementActivity({this.id, required this.uid, required this.userSupplement, required this.date});

  factory UserSupplementActivity.fromMap(Map data) {
    data = data;

    return UserSupplementActivity(
      id: data['id'],
      uid: data['uid'],
      userSupplement: data['userSupplement'],
      date: data['date'].toDate(),
    );
  }

  static Map<String, dynamic> toMap(UserSupplementActivity data) {
    data = data;

    return {
      'id': data.id,
      'uid': data.uid,
      'userSupplement': '/user_supplements/${data.userSupplement?.id}',
      'date': data.date,
    };
  }
}
