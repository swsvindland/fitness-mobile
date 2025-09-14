import 'package:body_track/widgets/height_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';

class HeightList extends StatelessWidget {
  const HeightList({super.key});

  @override
  Widget build(BuildContext context) {
    var heights = Provider.of<Iterable<HeightModel>>(context).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: heights.length,
      itemBuilder: (BuildContext context, int index) {
        return HeightCard(data: heights[index]);
      },
    );
  }
}
