import 'package:body_track/utils/colors.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';
import 'package:body_track/l10n/app_localizations.dart';

class Weights extends StatelessWidget {
  const Weights({super.key});

  @override
  Widget build(BuildContext context) {
    var weights = Provider.of<Iterable<Weight>>(context).toList();

    if (weights.isEmpty) {
      return SizedBox(
        height: 300,
        width: 600,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Text(
              AppLocalizations.of(context)!.noWeightData,
            ),
          ),
        ),
      );
    }

    return charts.TimeSeriesChart(
      _createSampleData(weights, context),
      animate: true,
      primaryMeasureAxis: const charts.NumericAxisSpec(
        tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false),
      ),
    );
  }

  static List<charts.Series<TimeSeriesWeight, DateTime>> _createSampleData(
      List<Weight> weights, BuildContext context) {
    final preferences = Provider.of<Preferences>(context, listen: false);
    double toDisplay(double kg) => preferences.unit == 'imperial' ? (kg * 2.2046226218) : kg;

    final data =
        weights.map((e) => TimeSeriesWeight(e.date, toDisplay(e.weight))).toList();

    data.sort((a, b) {
      return a.time.compareTo(b.time);
    });

    final regression = [
      TimeSeriesWeight(data.first.time, data.first.weight),
      TimeSeriesWeight(data.last.time, data.last.weight)
    ];

    return [
      charts.Series<TimeSeriesWeight, DateTime>(
        id: 'WeighIns',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(primary),
        domainFn: (TimeSeriesWeight sales, _) => sales.time,
        measureFn: (TimeSeriesWeight sales, _) => sales.weight,
        data: data,
      ),
      charts.Series<TimeSeriesWeight, DateTime>(
        id: 'Average',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(secondary),
        domainFn: (TimeSeriesWeight sales, _) => sales.time,
        measureFn: (TimeSeriesWeight sales, _) => sales.weight,
        data: regression,
      ),
    ];
  }
}

/// Sample time series data type.
class TimeSeriesWeight {
  final DateTime time;
  final double weight;

  TimeSeriesWeight(this.time, this.weight);
}
