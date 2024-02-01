import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import 'checkin_card.dart';

class CheckInList extends StatelessWidget {
  const CheckInList({super.key});

  @override
  Widget build(BuildContext context) {
    var checkIns = Provider.of<Iterable<BloodPressure>>(context).toList();
    checkIns.sort((a, b) => b.date.compareTo(a.date));

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: checkIns.length,
      itemBuilder: (BuildContext context, int index) {
        return CheckInCard(data: checkIns[index]);
      },
    );
  }
}
