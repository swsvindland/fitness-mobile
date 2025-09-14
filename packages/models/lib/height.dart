class HeightModel {
  String? id;
  int height; // stored in total inches (imperial) for consistency with existing UI
  DateTime date;

  HeightModel({this.id, required this.height, required this.date});

  factory HeightModel.fromMap(Map data) {
    data = data;
    return HeightModel(
      id: data['id'],
      height: data['height'],
      date: data['date'].toDate(),
    );
  }

  static Map<String, dynamic> toMap(HeightModel data) {
    data = data;
    return {
      'id': data.id,
      'height': data.height,
      'date': data.date,
    };
  }
}
