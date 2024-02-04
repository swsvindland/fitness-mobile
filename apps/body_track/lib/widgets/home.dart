import 'package:api/body_database_service.dart';
import 'package:body_track/widgets/weight_list.dart';
import 'package:body_track/widgets/weights.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';

class Home extends StatelessWidget {
  Home({super.key});

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
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: Weights(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: WeightList()
          ),
        ],
      ),
    );
  }
}
