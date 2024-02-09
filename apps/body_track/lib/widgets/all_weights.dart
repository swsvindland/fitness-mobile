import 'package:api/api.dart';
import 'package:body_track/widgets/checkin_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:provider/provider.dart';

class AllWeights extends StatelessWidget {
  AllWeights({super.key});
  final pdb = PreferencesDatabaseService();
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
            value: pdb.streamPreferences(user.uid),
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
