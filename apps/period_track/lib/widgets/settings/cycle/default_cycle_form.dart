import 'package:api/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:utils/constants.dart';

class DefaultCycleForm extends StatefulWidget {
  final Preferences preferences;

  const DefaultCycleForm({super.key, required this.preferences});

  @override
  State<DefaultCycleForm> createState() => _DefaultCycleFormState();
}

class _DefaultCycleFormState extends State<DefaultCycleForm> {
  final db = PreferencesDatabaseService();
  late int defaultCycleLength;
  bool set = false;
  late TextEditingController controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  void update(User? user, Preferences preferences) {
    preferences.setDefaultCycleLength(int.parse(controller.text));
    set = false;

    db.updatePreferences(user!.uid, preferences);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    setState(() {
      if (!set) {
        defaultCycleLength = widget.preferences.defaultCycleLength;
        controller.text = widget.preferences.defaultCycleLength.toString();
      }
    });

    return Form(
      key: _formKey,
      child: AlertDialog(
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 24.0),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.defaultLength,
            ),
            keyboardType: const TextInputType.numberWithOptions(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              navigatorKey.currentState!.pop();
            },
            child: Text(
              AppLocalizations.of(context)!.cancel,
            ),
          ),
          TextButton(
            onPressed: () {
              update(user, widget.preferences);
              navigatorKey.currentState!.pop();
            },
            child: Text(
              AppLocalizations.of(context)!.update,
            ),
          ),
        ],
      ),
    );
  }
}
