import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';
import 'package:bp_track/l10n/app_localizations.dart';
import 'package:utils/colors.dart';

class BloodPressureChart extends StatelessWidget {
  const BloodPressureChart({super.key});

  @override
  Widget build(BuildContext context) {
    var weights = Provider.of<Iterable<BloodPressure>>(context).toList();

    if (weights.isEmpty) {
      return SizedBox(
        height: 300,
        width: 600,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Text(
                AppLocalizations.of(context)!.noBloodPressureData),
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

  static List<charts.Series<TimeSeriesBloodPressure, DateTime>> _createSampleData(
      List<BloodPressure> weights, BuildContext context) {
    final data =
        weights.map((e) => TimeSeriesBloodPressure(e.date, e.systolic, e.diastolic)).toList();

    data.sort((a, b) {
      return a.time.compareTo(b.time);
    });

    return [
      charts.Series<TimeSeriesBloodPressure, DateTime>(
        id: 'Systolic',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(primary),
        domainFn: (TimeSeriesBloodPressure sales, _) => sales.time,
        measureFn: (TimeSeriesBloodPressure sales, _) => sales.systolic,
        data: data,
      ),
      charts.Series<TimeSeriesBloodPressure, DateTime>(
        id: 'Diastolic',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(secondary),
        domainFn: (TimeSeriesBloodPressure sales, _) => sales.time,
        measureFn: (TimeSeriesBloodPressure sales, _) => sales.diastolic,
        data: data,
      ),
    ];
  }
}

/// Sample time series data type.
class TimeSeriesBloodPressure {
  final DateTime time;
  final int systolic;
  final int diastolic;

  TimeSeriesBloodPressure(this.time, this.systolic, this.diastolic);
}
