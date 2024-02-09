import 'package:flutter/material.dart';
import 'package:water_track/widgets/reports_list.dart';

import 'package:utils/constants.dart';

class Reports extends StatelessWidget {
  const Reports({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(width: sm.toDouble(), child: const ReportsList()),
    );
  }
}
