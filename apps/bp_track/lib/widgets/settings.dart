import 'package:bp_track/services/sign_in.dart';
import 'package:bp_track/utils/constants.dart';
import 'package:bp_track/widgets/delete_account.dart';
import 'package:flutter/material.dart';

import '../services/database_service.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  final db = DatabaseService();

  handleSignOut() {
    signOut();
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil('/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          FilledButton(onPressed: handleSignOut, child: const Text("Sign Out")),
          const DeleteAccount()
        ],
      ),
    );
  }
}
