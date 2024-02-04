import 'package:api/blood_pressure_database_service.dart';
import 'package:bp_track/widgets/avg_blood_pressure.dart';
import 'package:bp_track/widgets/avg_heart_rate.dart';
import 'package:bp_track/widgets/heart_rate_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';

import 'blood_pressure_chart.dart';

class Home extends StatelessWidget {
  Home({super.key});
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AvgBloodPressure(),
              AvgHeartRate(),
              SizedBox(
                height: 300,
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
              SizedBox(
                height: 300,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: HeartRateChart(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
