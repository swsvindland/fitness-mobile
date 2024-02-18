import 'package:models/models.dart';

class UserSupplement {
  String? id;
  UserModel user;
  Supplement supplement;
  DateTime date;

  UserSupplement({this.id, required this.user, required this.supplement, required this.date});

  factory UserSupplement.fromMap(Map data) {
    data = data;
    return UserSupplement(
      id: data['id'],
      user: UserModel.fromMap(data['user']),
      supplement: Supplement.fromMap(data['supplement']),
      date: data['date'],
    );
  }

  static Map<String, dynamic> toMap(UserSupplement data) {
    data = data;
    return {
      'id': data.id,
      'user': '/users/${data.user.id}',
      'supplement': '/supplements/${data.supplement.id}',
      'date': data.date,
    };
  }
}
