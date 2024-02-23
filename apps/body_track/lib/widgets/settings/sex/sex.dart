import 'package:body_track/widgets/settings/sex/sex_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Sex extends StatefulWidget {
  const Sex({super.key});

  @override
  State<Sex> createState() => _SexState();
}

class _SexState extends State<Sex> {
  @override
  Widget build(BuildContext context) {
    final preferences = Provider.of<Preferences>(context);

    handleAction() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SexForm(preferences: preferences);
        },
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListTile(
          title: Text(AppLocalizations.of(context)!.sex),
          subtitle: Text(preferences.sex),
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
