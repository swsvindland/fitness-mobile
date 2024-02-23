import 'package:models/models.dart';

class UserSupplement {
  String? id;
  UserModel? user;
  Supplement? supplement;
  DateTime? date;
  String? time;

  UserSupplement({this.id, required this.user, required this.supplement, required this.date, required this.time});

  factory UserSupplement.fromMap(Map data) {
    data = data;
    
    return UserSupplement(
      id: data['id'],
      user: data['user'],
      supplement: data['supplement'],
      date: data['date'].toDate(),
      time: data['time'],
    );
  }

  static Map<String, dynamic> toMap(UserSupplement data) {
    data = data;

    return {
      'id': data.id,
      'user': '/users/${data.user?.id}',
      'supplement': '/supplements/${data.supplement?.id}',
      'date': data.date,
      'time': data.time,
    };
  }
}
