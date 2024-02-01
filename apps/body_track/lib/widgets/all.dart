import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/database_service.dart';

class All extends StatelessWidget {
  All({super.key});
  final db = DatabaseService();


  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    return Text('All');
  }
}
