import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import 'package:models/models.dart';
import 'package:utils/graph_animation_provider.dart';
import 'package:water_track/utils/constants.dart';
import 'package:water_track/widgets/progress_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Graph extends StatelessWidget {
  const Graph({super.key});

  static List<charts.Series<GraphDrinks, String>> _createData(Drinks drinks) {
    var none = drinks.water +
                drinks.energyDrink +
                drinks.dietEnergyDrink +
                drinks.preWorkout +
                drinks.tea +
                drinks.milk +
                drinks.coffee +
                drinks.sparklingWater +
                drinks.soda +
                drinks.dietSoda +
                drinks.juice +
                drinks.sportsDrink +
                drinks.dietSportsDrink ==
            0
        ? 1
        : 0;

    var data = [
      GraphDrinks('Water', drinks.water, water),
      GraphDrinks('Sparkling Water', drinks.sparklingWater, sparklingWater),
      GraphDrinks('Sports Drink', drinks.sportsDrink, sportsDrink),
      GraphDrinks('Diet Sports Drink', drinks.dietSportsDrink, dietSportsDrink),
      GraphDrinks('Coffee', drinks.coffee, coffee),
      GraphDrinks('Tea', drinks.tea, tea),
      GraphDrinks('Milk', drinks.milk, milk),
      GraphDrinks('Soda', drinks.soda, soda),
      GraphDrinks('Diet Soda', drinks.dietSoda, dietSoda),
      GraphDrinks('Juice', drinks.juice, juice),
      GraphDrinks('Energy Drink', drinks.energyDrink, energyDrink),
      GraphDrinks('Diet Energy Drink', drinks.dietEnergyDrink, dietEnergyDrink),
      GraphDrinks('Pre Workout', drinks.preWorkout, preWorkout),
      GraphDrinks('None', none, Colors.grey[200]!)
    ];

    return [
      charts.Series<GraphDrinks, String>(
        id: 'Drinks',
        domainFn: (GraphDrinks drinks, _) => drinks.drink,
        measureFn: (GraphDrinks drinks, _) => drinks.value,
        colorFn: (GraphDrinks fluid, _) =>
            charts.ColorUtil.fromDartColor(fluid.colorval),
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final drink = Provider.of<Drinks>(context);
    final preferences = Provider.of<Preferences>(context);
    var graphData = _createData(drink);

    var water = drink.water.toDouble() / preferences.waterGoal.toDouble();
    var totalAmount = drink.water +
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
        drink.dietSportsDrink;
    var total = totalAmount / preferences.totalGoal.toDouble();

    var unit = preferences.unit == 'imperial' ? 'oz' : 'ml';

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          graphData.isNotEmpty
              ? SizedBox(
                  height: 200,
                  width: 200,
                  child: charts.PieChart<String>(graphData,
                      animate: context.watch<GraphAnimationProvider>().animate,
                      animationDuration: const Duration(milliseconds: 500),
                      defaultRenderer: charts.ArcRendererConfig(arcWidth: 180)))
              : Container(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${AppLocalizations.of(context)!.water} ${(drink.water).round()} $unit'),
              ProgressBar(
                value: water,
              ),
              const SizedBox(height: 8),
              Text('${AppLocalizations.of(context)!.total} ${(totalAmount).round()} $unit'),
              ProgressBar(
                value: total,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GraphDrinks {
  String drink;
  int value;
  Color colorval;

  GraphDrinks(this.drink, this.value, this.colorval);
}
