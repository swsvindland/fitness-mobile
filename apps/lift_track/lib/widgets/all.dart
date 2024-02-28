import 'package:flutter/material.dart';
import 'package:models/supplement.dart';
import 'package:provider/provider.dart';
import 'package:api/supplement_database_service.dart';

class All extends StatelessWidget {
  All({super.key});
  final db = SupplementDatabaseService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Iterable<Supplement>>.value(
          value: db.streamAllSupplements(),
          initialData: const [],
        )
      ],
      child: const Align(
        alignment: Alignment.topCenter,
        child: Text("All"),
      ),
    );
  }
}
