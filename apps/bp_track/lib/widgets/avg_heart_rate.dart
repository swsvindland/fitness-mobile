import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AvgHeartRate extends StatelessWidget {
  const AvgHeartRate({super.key});

  @override
  Widget build(BuildContext context) {
    var sum = 0;
    var bloodPressures = Provider.of<Iterable<BloodPressure>>(context);

    var lastMonth = bloodPressures
        .where((element) => element.heartRate != null)
        .where((element) => element.date
        .isAfter(DateTime.now()
        .subtract(const Duration(days: 30))));

    for (var bp in lastMonth) {
      sum += bp.heartRate!;
    }

    var avg = (sum / lastMonth.length).toStringAsFixed(0);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ListTile(
            title: Text(
              AppLocalizations.of(context)!.avgHeartRate,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text(AppLocalizations.of(context)!.last30),
          trailing: Text(avg, style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
