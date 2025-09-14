import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';
import 'package:water_track/l10n/app_localizations.dart';
import 'package:water_track/widgets/settings/goals/goal_form.dart';

class Goal extends StatefulWidget {
  const Goal({super.key});

  @override
  State<Goal> createState() => _GoalState();
}

class _GoalState extends State<Goal> {
  @override
  Widget build(BuildContext context) {
    final preferences = Provider.of<Preferences>(context);

    handleAction() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return GoalForm(preferences: preferences);
        },
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListTile(
          title: Text(AppLocalizations.of(context)!.goals),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "${AppLocalizations.of(context)!.waterGoalField}: ${preferences.waterGoal}"),
              Text(
                  "${AppLocalizations.of(context)!.fluidGoalField}: ${preferences.totalGoal}")
            ],
          ),
          trailing: FilledButton(
            onPressed: handleAction,
            child: Text(
              AppLocalizations.of(context)!.update,
            ),
          ),
        ),
      ),
    );
  }
}

enum SexOptions { male, female }
