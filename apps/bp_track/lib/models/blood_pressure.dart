class BloodPressure {
  String uid;
  int systolic;
  int diastolic;
  int? heartRate;
  DateTime date;

  BloodPressure({required this.uid, required this.systolic, required this.diastolic, this.heartRate, required this.date});

  factory BloodPressure.fromMap(Map data) {
    data = data;
    return BloodPressure(
      uid: data['uid'],
      systolic: data['systolic'],
      diastolic: data['diastolic'],
      heartRate: data['heartRate'],
      date: data['date'].toDate(),
    );
  }

  static Map<String, dynamic> toMap(BloodPressure data) {
    data = data;
    return {
      'uid': data.uid,
      'systolic': data.systolic,
      'diastolic': data.diastolic,
      'heartRate': data.heartRate,
      'date': data.date,
    };
  }
}
