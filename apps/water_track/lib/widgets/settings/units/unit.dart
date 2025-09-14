import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';
import 'package:water_track/l10n/app_localizations.dart';
import 'package:water_track/widgets/settings/units/unit_form.dart';

class Unit extends StatefulWidget {
  const Unit({super.key});

  @override
  State<Unit> createState() => _UnitState();
}

class _UnitState extends State<Unit> {
  @override
  Widget build(BuildContext context) {
    final preferences = Provider.of<Preferences>(context);

    handleAction() {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return UnitForm(preferences: preferences);
        },
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListTile(
          title: Text(AppLocalizations.of(context)!.units),
          subtitle: Text(preferences.unit),
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

enum UnitOptions { imperial, metric }
