import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            title: Text(
              AppLocalizations.of(context)!.avgBloodPressure,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 20),
            ),
            subtitle: Text(AppLocalizations.of(context)!.last30),
          trailing: Text("$avgSystolic/$avgDiastolic", style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
