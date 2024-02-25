import 'package:firebase_auth/firebase_auth.dart';
import 'package:models/supplement.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:sup_track/widgets/supplement_card.dart';
import 'package:widgets/input.dart';

class SupplementList extends StatefulWidget {
  const SupplementList({super.key});

  @override
  State<SupplementList> createState() => _SupplementListState();
}

class _SupplementListState extends State<SupplementList> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();

    searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var supplements = Provider.of<Iterable<Supplement>>(context);
    var user = Provider.of<User?>(context);

    var filtered = supplements.where((supplement) {
      return supplement.name
          .toLowerCase()
          .contains(searchController.text.toLowerCase());
    }).toList();

    if (user == null) {
      return const CircularProgressIndicator();
    }

    return Column(children: [
      Input(
        leading: const Icon(Icons.search),
        label: "Search",
        controller: searchController,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          setState(() {});
        },
      ),
      Expanded(
        child: ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            var supplement = filtered.elementAt(index);
            return SupplementCard(
              name: supplement.name,
              brand: supplement.brand,
              uid: user.uid,
              supplementId: supplement.id,
              user: false,
            );
          },
        ),
      ),
    ]);
  }
}
