import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:models/note.dart';
import 'package:models/preferences.dart';
import 'package:period_track/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../utils/helper.dart';
import 'not_enough_data.dart';

class FlowLength extends StatelessWidget {
  const FlowLength({super.key});

  @override
  Widget build(BuildContext context) {
    var preferences = Provider.of<Preferences>(context);
    var notes = Provider.of<Iterable<NoteModel>>(context).toList();

    if (notes.isEmpty) {
      return const NotEnoughData();
    }

    var periodStarts = notes.where((element) => element.periodStart)
        .map((e) => e.date)
        .toList();

    if (periodStarts.length < 2) {
      return const NotEnoughData();
    }

    var cycleLength = computeMenstrualLength(preferences.defaultCycleLength, periodStarts);
    var cycles = computeFlowLengthsForGraph(cycleLength, notes);

    return charts.BarChart(
      _createSampleData(cycles, context),
      animate: true,
    );
  }

  static List<charts.Series<Cycle, String>> _createSampleData(
      List<Cycle> cycles, BuildContext context) {
    final List<Cycle> data = [];
    for (var cycle in cycles) {
      data.add(Cycle(date: cycle.date, length: cycle.length));
    }

    data.sort((a, b) {
      return a.date.compareTo(b.date);
    });

    return [
      charts.Series<Cycle, String>(
        id: 'FlowLength',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(primaryDark),
        domainFn: (Cycle sales, _) =>
            DateFormat.MMM(Localizations.localeOf(context).languageCode)
                .format(sales.date),
        measureFn: (Cycle sales, _) => sales.length,
        data: data.sublist(data.length - 12, data.length - 1),
      ),
    ];
  }
}
