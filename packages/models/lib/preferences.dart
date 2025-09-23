class Preferences {
  String uid; // New field
  String sex;
  String unit;
  int waterGoal;
  int totalGoal;
  int drinkSize;
  int start;
  int end;
  bool adFree;
  int defaultCycleLength;
  bool disclaimer;
  bool healthKitEnabled; // iOS
  bool healthConnectEnabled; // Android

  Preferences({
    required this.uid, // Added uid
    required this.sex,
    required this.unit,
    required this.waterGoal,
    required this.totalGoal,
    required this.drinkSize,
    required this.start,
    required this.end,
    required this.adFree,
    required this.defaultCycleLength,
    required this.disclaimer,
    this.healthKitEnabled = false,
    this.healthConnectEnabled = false,
  });

  void setSex(String value) {
    sex = value;
  }

  void setUnit(String value) {
    unit = value;
  }

  void setWaterGoal(int value) {
    waterGoal = value;
  }

  void setTotalGoal(int value) {
    totalGoal = value;
  }

  void setDrinkSize(int value) {
    drinkSize = value;
  }

  void setStartTime(int value) {
    start = value;
  }

  void setEndTime(int value) {
    end = value;
  }

  void setAdFree(bool value) {
    adFree = value;
  }

  void setDefaultCycleLength(int value) {
    defaultCycleLength = value;
  }

  void agreeToDisclaimer() {
    disclaimer = true;
  }

  void changeUnit() {
    if (unit == 'imperial') {
      unit = 'metric';
      waterGoal = 3000;
      totalGoal = 4000;
      drinkSize = 200;
    } else {
      unit = 'imperial';
      waterGoal = 96;
      totalGoal = 128;
      drinkSize = 8;
    }
  }

  static Preferences empty(String uid) { // Added uid parameter
    return Preferences(
      uid: uid, // Added uid
      start: 7,
      sex: 'male',
      adFree: false,
      unit: 'imperial',
      waterGoal: 96,
      totalGoal: 128,
      drinkSize: 8,
      end: 20,
      defaultCycleLength: 28,
      disclaimer: true,
      healthKitEnabled: false,
      healthConnectEnabled: false,
    );
  }

  factory Preferences.fromMap(Map data, String uid) { // Added uid parameter, or expect it in data
    // Assuming uid might also be in the data map, prioritize parameter if available
    // Or, if uid is always expected to be part of the document data:
    // final String docUid = data['uid'] ?? uid;
    return Preferences(
      uid: data['uid'], // Expect uid in the map
      sex: data['sex'],
      unit: data['unit'] ?? 'imperial',
      waterGoal: data['waterGoal'] ?? (data['unit'] == 'imperial' ? 96 : 3000),
      totalGoal: data['totalGoal'] ?? (data['unit'] == 'imperial' ? 128 : 4000),
      drinkSize: data['drinkSize'] ?? 8,
      start: data['start'].toDate().hour,
      end: data['end'].toDate().hour,
      adFree: data['adFree'] ?? false,
      defaultCycleLength: data['defaultCycleLength'] ?? 28,
      disclaimer: data['disclaimer'] ?? true,
      healthKitEnabled: data['healthKitEnabled'] ?? false,
      healthConnectEnabled: data['healthConnectEnabled'] ?? false,
    );
  }

  static Map<String, dynamic> toMap(Preferences data) {
    return {
      'uid': data.uid, // Added uid
      'sex': data.sex,
      'unit': data.unit,
      'waterGoal': data.waterGoal,
      'totalGoal': data.totalGoal,
      'drinkSize': data.drinkSize,
      'start': DateTime.parse('2000-01-01 ${data.start.toString().padLeft(2, '0')}:00:00'),
      'end': DateTime.parse('2000-01-01 ${data.end.toString().padLeft(2, '0')}:00:00'),
      'adFree': data.adFree,
      'defaultCycleLength': data.defaultCycleLength,
      'disclaimer': data.disclaimer,
      'healthKitEnabled': data.healthKitEnabled,
      'healthConnectEnabled': data.healthConnectEnabled,
    };
  }
}
