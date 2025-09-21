import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Added for go_router
import 'package:utils/sign_in.dart';

class DeleteAccount extends StatelessWidget {
  final String title;
  final String content;
  final String accept;
  final String cancel;

  const DeleteAccount({super.key, required this.title, required this.content, required this.accept, required this.cancel});

  Future<void> handleDeleteAccount(BuildContext context) async { // Added BuildContext
    var user = FirebaseAuth.instance.currentUser;
    try {
      if (user != null) {
        await user.delete();
      }
      await signInAnon();
    } catch (e, s) {
      debugPrint('Error during account deletion or anonymous sign-in: $e');
      debugPrint('Stack trace: $s');
    } finally {
      // Use context.go for navigation if context is available and mounted
      if (context.mounted) {
        context.go('/');
      }
    }
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text(cancel),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop(); 
        handleDeleteAccount(context); // Pass context      
      },
      child: Text(accept),
    );
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
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
