import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:utils/constants.dart';


class DeleteAccount extends StatelessWidget {
  final String title;
  final String content;
  final String accept;
  final String cancel;

  const DeleteAccount({super.key, required this.title, required this.content, required this.accept, required this.cancel});

  handleDeleteAccount() {
    try {
      var user = FirebaseAuth.instance.currentUser;
      FirebaseAuth.instance.signOut();
      user?.delete();
    } finally {
      navigatorKey.currentState!
          .pushNamedAndRemoveUntil("/", (route) => false);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(cancel),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      onPressed: handleDeleteAccount,
      child: Text(accept),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton(

      onPressed: () {
        showAlertDialog(context);
      },
      child: Text(
        accept,
      ),
    );
  }
}
