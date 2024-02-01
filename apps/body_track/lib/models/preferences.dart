class Preferences {
  int start;
  int height;
  String sex;

  Preferences({
    required this.start,
    required this.height,
    required this.sex,
  });

  void setStartTime(int value) {
    start = value;
  }

  void setHeight(int feet, int inches) {
    height = (12 * feet) + inches;
  }

  List<int> getHeight() {
    return [(height / 12).floor(), height % 2];
  }

  void setSex(String value) {
    sex = value;
  }

  static Preferences empty() {
    return Preferences(start: 7, height: 66, sex: 'male');
  }

  factory Preferences.fromMap(Map data) {
    data = data;

    return Preferences(
        start: data['start'].toDate().hour,
        height: data['height'],
        sex: data['sex']);
  }

  static Map<String, dynamic> toMap(Preferences data) {
    data = data;
    return {
      'start': DateTime.parse(
          '2000-01-01 ${data.start.toString().padLeft(2, '0')}:00:00'),
      'height': data.height,
      'sex': data.sex
    };
  }
}
