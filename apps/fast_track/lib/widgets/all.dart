import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class All extends StatelessWidget {
  const All({super.key});


  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    return const Text("All");
  }
}
