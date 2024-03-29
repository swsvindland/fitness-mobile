import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:utils/constants.dart';
import 'package:period_track/widgets/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

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
      child: Text(AppLocalizations.of(context)!.cancel),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      onPressed: handleDeleteAccount,
      child: Text(AppLocalizations.of(context)!.delete),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(AppLocalizations.of(context)!.deleteAccount),
      content: Text(AppLocalizations.of(context)!.deleteAccountConfirm),
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
    return Button(
      onPressed: () {
        showAlertDialog(context);
      },
      child: Text(
        AppLocalizations.of(context)!.deleteAccount,
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}
