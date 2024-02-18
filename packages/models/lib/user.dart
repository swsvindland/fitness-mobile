class UserModel {
  String? id;
  String? displayName;
  String? email;
  DateTime? lastSeen;
  String uid;

  UserModel({this.id, this.displayName, this.email, this.lastSeen, required this.uid});

  factory UserModel.fromMap(Map data) {
    data = data;
    return UserModel(
      id: data['id'],
      displayName: data['displayName'],
      email: data['email'],
      lastSeen: data['lastSeen'].toDate(),
      uid: data['uid'],
    );
  }

  static Map<String, dynamic> toMap(UserModel data) {
    data = data;
    return {
      'id': data.id,
      'displayName': data.displayName,
      'email': data.email,
      'lastSeen': data.lastSeen,
      'uid': data.uid,
    };
  }
}
