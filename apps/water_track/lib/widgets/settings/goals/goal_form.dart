import 'package:api/body_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';
import 'package:utils/helper.dart';
import 'package:widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GoalForm extends StatefulWidget {
  final Preferences preferences;

  const GoalForm({super.key, required this.preferences});

  @override
  State<GoalForm> createState() => _GoalFormState();
}

class _GoalFormState extends State<GoalForm> {
  final db = BodyDatabaseService();
  final _formKey = GlobalKey<FormState>();
  final water = TextEditingController();
  final total = TextEditingController();
  bool set = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    water.dispose();
    total.dispose();

    super.dispose();
  }

  void update(User? user) {
    widget.preferences.setWaterGoal(int.parse(water.text));
    widget.preferences.setTotalGoal(int.parse(total.text));
    set = false;

    db.updatePreferences(user!.uid, widget.preferences);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    setState(() {
      if (!set) {
        water.text = widget.preferences.waterGoal.toString();
        total.text = widget.preferences.totalGoal.toString();
      }
    });

    return SizedBox(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Input(
                  label: AppLocalizations.of(context)!.waterGoalField,
                  decimal: false,
                  controller: water,
                  validator: checkInValidator),
              Input(
                  label: AppLocalizations.of(context)!.waterGoalField,
                  decimal: false,
                  controller: total,
                  validator: checkInValidator),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  update(user);
                },
                child: Text(
                  AppLocalizations.of(context)!.update,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
