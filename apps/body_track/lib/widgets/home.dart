import 'package:api/body_database_service.dart';
import 'package:body_track/widgets/weight_list.dart';
import 'package:body_track/widgets/weights.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final db = BodyDatabaseService();

  @override
  Widget build(BuildContext context) {
    return const Column(
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
        Expanded(flex: 5, child: WeightList()),
      ],
    );
  }
}
