import 'package:body_track/widgets/checkin_list.dart';
import 'package:body_track/models/checkin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/preferences.dart';
import '../models/weight.dart';
import '../services/database_service.dart';

class All extends StatelessWidget {
  All({super.key});
  final db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    return MultiProvider(
      providers: [
          StreamProvider<Iterable<Weight>>.value(
            initialData: const [],
            value: db.streamWeighIns(user!.uid),
          ),
          StreamProvider<Preferences>.value(
            initialData: Preferences.empty(),
            value: db.streamPreferences(user.uid),
          ),
          StreamProvider<Iterable<CheckIn>>.value(
            initialData: const [],
            value: db.streamCheckIns(user.uid),
          ),
        ],
      child: const CheckInList(),
    );
  }
}
