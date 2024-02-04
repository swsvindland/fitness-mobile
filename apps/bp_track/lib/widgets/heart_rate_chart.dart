import 'package:bp_track/utils/colors.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';

class HeartRateChart extends StatelessWidget {
  const HeartRateChart({super.key});

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<Iterable<BloodPressure>>(context).toList();

    if (data.isEmpty) {
      return const SizedBox(
        height: 300,
        width: 600,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Center(
            child: Text(
                'Looks like you have no heart rates. Click the scale icon to get started.'),
          ),
        ),
      );
    }

    return charts.TimeSeriesChart(
      _createSampleData(data, context),
      animate: true,
      primaryMeasureAxis: const charts.NumericAxisSpec(
        tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false),
      ),
    );
  }

  static List<charts.Series<TimeSeriesBloodPressure, DateTime>> _createSampleData(
      List<BloodPressure> weights, BuildContext context) {
    final data = weights
            .where((element) => element.heartRate != null)
            .map((e) => TimeSeriesBloodPressure(e.date, e.heartRate!)).toList();

    data.sort((a, b) {
      return a.time.compareTo(b.time);
    });

    return [
      charts.Series<TimeSeriesBloodPressure, DateTime>(
        id: 'HeartRate',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(primary),
        domainFn: (TimeSeriesBloodPressure sales, _) => sales.time,
        measureFn: (TimeSeriesBloodPressure sales, _) => sales.heartRate,
        data: data,
      ),
    ];
  }
}

/// Sample time series data type.
class TimeSeriesBloodPressure {
  final DateTime time;
  final int heartRate;

  TimeSeriesBloodPressure(this.time, this.heartRate);
}
