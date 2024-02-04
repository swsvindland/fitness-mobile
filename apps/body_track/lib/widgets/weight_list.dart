import 'package:body_track/widgets/weight_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';

class WeightList extends StatelessWidget {
  const WeightList({super.key});

  @override
  Widget build(BuildContext context) {
    var weights = Provider.of<Iterable<Weight>>(context).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: weights.length,
      itemBuilder: (BuildContext context, int index) {
        return WeightCard(data: weights[index]);
      },
    );
  }
}
