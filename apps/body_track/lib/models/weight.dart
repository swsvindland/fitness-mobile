class Weight {
  double weight;
  DateTime date;

  Weight({required this.weight, required this.date});

  factory Weight.fromMap(Map data) {
    data = data;
    return Weight(
      weight: data['weight'],
      date: data['date'].toDate(),
    );
  }

  static Map<String, dynamic> toMap(Weight data) {
    data = data;
    return {
      'weight': data.weight,
      'date': data.date,
    };
  }
}
