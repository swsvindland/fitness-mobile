import 'package:body_track/widgets/settings/sex/sex.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/preferences.dart';
import '../../../services/database_service.dart';

class SexForm extends StatefulWidget {
  final Preferences preferences;

  const SexForm({super.key, required this.preferences});

  @override
  State<SexForm> createState() => _SexFormState();
}

class _SexFormState extends State<SexForm> {
  final db = DatabaseService();
  SexOptions? _sex = SexOptions.male;
  bool set = false;

  void update(User? user) {
    widget.preferences.setSex(_sex == SexOptions.male ? 'male' : 'female');
    set = false;
    db.updatePreferences(user!.uid, widget.preferences);
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    setState(() {
      if (!set) {
        _sex = widget.preferences.sex == 'male' ? SexOptions.male : SexOptions.female;
      }
    });

    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: const Text('Male'),
              leading: Radio<SexOptions>(
                value: SexOptions.male,
                groupValue: _sex,
                onChanged: (SexOptions? value) {
                  setState(() {
                    _sex = value;
                    set = true;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Female'),
              leading: Radio<SexOptions>(
                value: SexOptions.female,
                groupValue: _sex,
                onChanged: (SexOptions? value) {
                  setState(() {
                    _sex = value;
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
              child: const Text(
                'Update',
              ),
            )
          ],
        ),
      ),
    );
  }
}
