class Supplement {
  String? id;
  String name;
  String brand;

  Supplement({this.id, required this.name, required this.brand});

  factory Supplement.fromMap(Map data) {
    data = data;
    return Supplement(
      id: data['id'],
      name: data['name'],
      brand: data['brand'],
    );
  }

  static Map<String, dynamic> toMap(Supplement data) {
    data = data;
    return {
      'id': data.id,
      'name': data.name,
      'brand': data.brand,
    };
  }
}
