import 'package:api/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:body_track/widgets/settings/units/unit.dart';

class UnitForm extends StatefulWidget {
  final Preferences preferences;

  const UnitForm({super.key, required this.preferences});

  @override
  State<UnitForm> createState() => _UnitFormState();
}

class _UnitFormState extends State<UnitForm> {
  final db = PreferencesDatabaseService();
  UnitOptions? _unit = UnitOptions.imperial;
  bool set = false;

  void update(User? user) {
    widget.preferences.setUnit(_unit == UnitOptions.imperial ? 'imperial' : 'metric');
    set = false;
    db.updatePreferences(user!.uid, widget.preferences);
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    setState(() {
      if (!set) {
        _unit = widget.preferences.unit == 'imperial' ? UnitOptions.imperial : UnitOptions.metric;
      }
    });

    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: Text(AppLocalizations.of(context)!.imperial),
              leading: Radio<UnitOptions>(
                value: UnitOptions.imperial,
                groupValue: _unit,
                onChanged: (UnitOptions? value) {
                  setState(() {
                    _unit = value;
                    set = true;
                  });
                },
              ),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.metric),
              leading: Radio<UnitOptions>(
                value: UnitOptions.metric,
                groupValue: _unit,
                onChanged: (UnitOptions? value) {
                  setState(() {
                    _unit = value;
                    set = true;
                  });
                },
              ),
            ),
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
    );
  }
}
