import 'package:api/blood_pressure_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';

import 'checkin_list.dart';

class All extends StatelessWidget {
  All({super.key});
  final db = BloodPressureDatabaseService();


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
