import 'package:firebase_auth/firebase_auth.dart';
import 'package:models/models.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:sup_track/widgets/supplement_card.dart';

class UserSupplementList extends StatelessWidget {
  const UserSupplementList({super.key});

  @override
  Widget build(BuildContext context) {
    var userSupplements = Provider.of<Iterable<UserSupplement>>(context);
    var user = Provider.of<User?>(context);

    if (user == null) {
      return const CircularProgressIndicator();
    }

    return ListView.builder(
      itemCount: userSupplements.length,
      itemBuilder: (context, index) {
        var userSupplement = userSupplements.elementAt(index);

        return SupplementCard(
          name: userSupplement.supplement?.name ?? '',
          brand: userSupplement.supplement?.brand ?? '',
          uid: user.uid,
          supplementId: userSupplement.id,
          user: true,
        );
      },
    );
  }
}
