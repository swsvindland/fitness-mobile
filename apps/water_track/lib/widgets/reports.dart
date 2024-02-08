import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:api/api.dart';
import 'package:water_track/widgets/reports_list.dart';

import 'package:models/models.dart';
import '../utils/constants.dart';

class Reports extends StatelessWidget {
  const Reports({super.key});

  @override
  Widget build(BuildContext context) {
    var db = WaterDatabaseService();
    var user = Provider.of<User?>(context);

    return MultiProvider(
      providers: [
        StreamProvider<Iterable<Drinks>>.value(
            initialData: [Drinks.empty()],
            value: db.streamAllDrinks(user!.uid)),
      ],
      child: Center(
        child: SizedBox(width: sm.toDouble(), child: const ReportsList()),
      ),
    );
  }
}
