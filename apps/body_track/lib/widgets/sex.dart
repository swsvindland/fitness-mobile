import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:body_track/models/models.dart';
import 'package:body_track/services/database_service.dart';

class Sex extends StatefulWidget {
  const Sex({Key? key}) : super(key: key);

  @override
  State<Sex> createState() => _SexState();
}

class _SexState extends State<Sex> {
  final db = DatabaseService();
  SexOptions? _sex = SexOptions.male;
  bool set = false;

  void update(User? user, Preferences preferences) {
    preferences.setSex(_sex == SexOptions.male ? 'male' : 'female');
    set = false;
    db.updatePreferences(user!.uid, preferences);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final preferences = Provider.of<Preferences>(context);

    setState(() {
      if (!set) {
        _sex = preferences.sex == 'male' ? SexOptions.male : SexOptions.female;
      }
    });

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
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
            ElevatedButton(
              onPressed: () {
                update(user, preferences);
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

enum SexOptions { male, female }
