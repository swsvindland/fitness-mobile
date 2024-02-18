import 'package:api/supplement_database_service.dart';
import 'package:flutter/material.dart';

class SupplementCard extends StatelessWidget {
  final String name;
  final String brand;
  final String uid;
  final String? supplementId;
  SupplementCard({super.key, required this.name, required this.brand, required this.uid, this.supplementId});
  final db = SupplementDatabaseService();

  handleTap() {
    if (supplementId == null) return;
    db.addUserSupplement(uid, supplementId!);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: handleTap,
        child: ListTile(
          title: Text(name),
          subtitle: Text(brand),
        ),
      ),
    );
  }
}
