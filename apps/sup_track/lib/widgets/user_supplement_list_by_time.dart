import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:models/user_supplement.dart';
import 'package:provider/provider.dart';
import 'package:sup_track/widgets/supplement_card.dart';

class UserSupplementListByTime extends StatelessWidget {
  final String time;
  const UserSupplementListByTime({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    var userSupplements = Provider.of<Iterable<UserSupplement>>(context);

    var filteredSupplements =
        userSupplements.where((element) => element.time?.toLowerCase() == time.toLowerCase());

    if (user == null) {
      return const CircularProgressIndicator();
    }

    if (filteredSupplements.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: <Widget>[
        Text(time.toUpperCase(), style: const TextStyle(fontSize: 20)),
        for (var supplement in filteredSupplements)
          SupplementCard(
            name: supplement.supplement?.name ?? '',
            brand: supplement.supplement?.brand ?? '',
            uid: user.uid,
            supplementId: supplement.id,
            user: true,
          ),
      ],
    );
  }
}
