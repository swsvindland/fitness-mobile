import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/blood_pressure.dart';
import '../services/database_service.dart';
import 'checkin_list.dart';

class All extends StatelessWidget {
  All({super.key});
  final db = DatabaseService();


  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    return MultiProvider(
      providers: [
        StreamProvider<Iterable<BloodPressure>>.value(
          initialData: const [],
          value: db.streamBloodPressures(user!.uid),
        ),
      ],
      child: const Align(
        alignment: Alignment.topCenter,
        child: CheckInList(),
      ),
    );
  }
}
