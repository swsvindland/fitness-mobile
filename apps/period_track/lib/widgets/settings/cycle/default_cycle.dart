import 'package:period_track/widgets/settings/cycle/default_cycle_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DefaultCycle extends StatefulWidget {
  const DefaultCycle({super.key});

  @override
  State<DefaultCycle> createState() => _DefaultCycleState();
}

class _DefaultCycleState extends State<DefaultCycle> {
  @override
  Widget build(BuildContext context) {
    final preferences = Provider.of<Preferences>(context);

    handleAction() {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return DefaultCycleForm(preferences: preferences);
        },
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListTile(
          title: Text(AppLocalizations.of(context)!.defaultLength),
          subtitle: Text(
              "${preferences.defaultCycleLength} ${AppLocalizations.of(context)!.days}"),
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
