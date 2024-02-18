import 'package:firebase_auth/firebase_auth.dart';
import 'package:models/supplement.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:sup_track/widgets/supplement_card.dart';

class SupplementList extends StatelessWidget {
  const SupplementList({super.key});

  @override
  Widget build(BuildContext context) {
    var supplements = Provider.of<Iterable<Supplement>>(context);
    var user = Provider.of<User?>(context);

    if (user == null) {
      return const CircularProgressIndicator();
    }

    return ListView.builder(
      itemCount: supplements.length,
      itemBuilder: (context, index) {
        var supplement = supplements.elementAt(index);
        return SupplementCard(name: supplement.name, brand: supplement.brand, uid: user.uid, supplementId: supplement.id);
      },
    );
  }
}
