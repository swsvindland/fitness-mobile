import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    if (user == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return const Align(alignment: Alignment.topCenter, child: Text("Home"));
  }
}
