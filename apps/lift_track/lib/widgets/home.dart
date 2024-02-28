import 'package:api/supplement_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final db = SupplementDatabaseService();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    if (user == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return const Align(alignment: Alignment.topCenter, child: Text("Home"));
  }
}
