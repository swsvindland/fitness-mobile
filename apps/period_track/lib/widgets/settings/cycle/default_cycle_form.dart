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

    navigatorKey.currentState!.pop();
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

    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.defaultLength,
                ),
                keyboardType: const TextInputType.numberWithOptions(),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  update(user, widget.preferences);
                },
                child: Text(
                  AppLocalizations.of(context)!.update,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
