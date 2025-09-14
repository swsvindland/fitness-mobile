import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';
import 'package:water_track/l10n/app_localizations.dart';
import 'package:water_track/widgets/progress_bar.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({super.key, required this.drink});
  final Drinks drink;

  @override
  Widget build(BuildContext context) {
    var preferences = Provider.of<Preferences>(context);

    var water = drink.water.toDouble() / preferences.waterGoal.toDouble();
    var total = (drink.water +
        drink.energyDrink +
        drink.dietEnergyDrink +
        drink.preWorkout +
        drink.tea +
        drink.milk +
        drink.coffee +
        drink.sparklingWater +
        drink.soda +
        drink.dietSoda +
        drink.juice +
        drink.sportsDrink +
        drink.dietSportsDrink.toDouble()) / preferences.totalGoal.toDouble();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.MMMMd(Localizations.localeOf(context).languageCode).format(drink.date).toUpperCase(),
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 14.0,
                letterSpacing: 2.5,
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            Text('${AppLocalizations.of(context)!.water} ${(water * 100).round()}%'),
            ProgressBar(
              value: water,
            ),
            const SizedBox(height: 16),
            Text('${AppLocalizations.of(context)!.total} ${(total * 100).round()}%'),
            ProgressBar(
              value: total,
            ),
          ],
        ),
      ),
    );
  }
}
