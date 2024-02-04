import 'package:body_track/widgets/settings/height/height_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';

class Height extends StatefulWidget {
  const Height({super.key});

  @override
  State<Height> createState() => _HeightState();
}

class _HeightState extends State<Height> {
  @override
  Widget build(BuildContext context) {
    final preferences = Provider.of<Preferences>(context);

    handleAction() {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return HeightForm(preferences: preferences);
        },
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListTile(
          title: const Text("Height"),
          subtitle: Text(
              "Feet: ${(preferences.height / 12).floor()} Inches: ${(preferences.height % 12).floor()}"),
          trailing: FilledButton(
            onPressed: handleAction,
            child: const Text(
              'Update',
            ),
          ),
        ),
      ),
    );
  }
}

enum SexOptions { male, female }
