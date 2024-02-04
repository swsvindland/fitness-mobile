import 'package:api/body_database_service.dart';
import 'package:body_track/widgets/checkin_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:provider/provider.dart';

class All extends StatelessWidget {
  All({super.key});
  final db = BodyDatabaseService();

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
          StreamProvider<Iterable<CheckInModel>>.value(
            initialData: const [],
            value: db.streamCheckIns(user.uid),
          ),
        ],
      child: const CheckInList(),
    );
  }
}
