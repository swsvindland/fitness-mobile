import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/blood_pressure.dart';
import '../services/database_service.dart';
import 'blood_pressure_chart.dart';
import 'checkin_list.dart';

class Home extends StatelessWidget {
  Home({super.key});
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: BloodPressureChart(),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: CheckInList(),
              ),
            ],
          ),
        ),
    );
  }
}
