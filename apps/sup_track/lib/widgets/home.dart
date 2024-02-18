import 'package:api/supplement_database_service.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {
  Home({super.key});
  final db = SupplementDatabaseService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Iterable<UserSupplement>>.value(
          value: db.streamUserSupplements(),
          initialData: const [],
        )
      ],
      child: const Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Hello World")
            ],
          ),
        ),
      ),
    );
  }
}
