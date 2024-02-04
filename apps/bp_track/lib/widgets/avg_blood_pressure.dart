import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/blood_pressure.dart';

class AvgBloodPressure extends StatelessWidget {
  const AvgBloodPressure({super.key});

  @override
  Widget build(BuildContext context) {
    var sumSystolic = 0;
    var sumDiastolic = 0;
    var bloodPressures = Provider.of<Iterable<BloodPressure>>(context);

    var lastMonth = bloodPressures
        .where((element) => element.date
        .isAfter(DateTime.now()
        .subtract(const Duration(days: 30))));

    for (var bp in lastMonth) {
      sumSystolic += bp.systolic;
      sumDiastolic += bp.diastolic;
    }

    var avgSystolic = (sumSystolic / lastMonth.length).toStringAsFixed(0);
    var avgDiastolic = (sumDiastolic / lastMonth.length).toStringAsFixed(0);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ListTile(
            title: const Text(
              "Average Blood Pressure",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20),
            ),
            subtitle: const Text("Last 30 Days"),
          trailing: Text("$avgSystolic/$avgDiastolic", style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
