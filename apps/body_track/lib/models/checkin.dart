class CheckIn {
  DateTime date;
  double neck;
  double shoulders;
  double chest;
  double leftBicep;
  double rightBicep;
  double navel;
  double waist;
  double? hip;
  double leftThigh;
  double rightThigh;
  double leftCalf;
  double rightCalf;
  double? systolic;
  double? diastolic;

  CheckIn(
      {required this.date,
      required this.neck,
      required this.shoulders,
      required this.chest,
      required this.leftBicep,
      required this.rightBicep,
      required this.navel,
      required this.waist,
      this.hip,
      required this.leftThigh,
      required this.rightThigh,
      required this.leftCalf,
      required this.rightCalf,
      this.systolic,
      this.diastolic});

  factory CheckIn.fromMap(Map data) {
    data = data;
    return CheckIn(
      date: data['date'].toDate(),
      neck: data['neck'],
      shoulders: data['shoulders'],
      chest: data['chest'],
      leftBicep: data['leftBicep'],
      rightBicep: data['rightBicep'],
      navel: data['navel'],
      waist: data['waist'],
      hip: data['hip'],
      leftThigh: data['leftThigh'],
      rightThigh: data['rightThigh'],
      leftCalf: data['leftCalf'],
      rightCalf: data['rightCalf'],
      systolic: data['systolic'],
      diastolic: data['diastolic'],
    );
  }

  static Map<String, dynamic> toMap(CheckIn data) {
    data = data;
    return {
      'date': data.date,
      'neck': data.neck,
      'shoulders': data.shoulders,
      'chest': data.chest,
      'leftBicep': data.leftBicep,
      'rightBicep': data.rightBicep,
      'navel': data.navel,
      'waist': data.waist,
      'hip': data.hip,
      'leftThigh': data.leftThigh,
      'rightThigh': data.rightThigh,
      'leftCalf': data.leftCalf,
      'rightCalf': data.rightCalf,
      'systolic': data.systolic,
      'diastolic': data.diastolic
    };
  }
}
