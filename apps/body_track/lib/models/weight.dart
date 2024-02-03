class Weight {
  String? id;
  double weight;
  DateTime date;

  Weight({this.id, required this.weight, required this.date});

  factory Weight.fromMap(Map data) {
    data = data;
    return Weight(
      id: data['id'],
      weight: data['weight'],
      date: data['date'].toDate(),
    );
  }

  static Map<String, dynamic> toMap(Weight data) {
    data = data;
    return {
      'id': data.id,
      'weight': data.weight,
      'date': data.date,
    };
  }
}
