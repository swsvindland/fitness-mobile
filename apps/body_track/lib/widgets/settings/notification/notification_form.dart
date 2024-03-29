import 'package:api/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationForm extends StatefulWidget {
  final Preferences preferences;

  const NotificationForm({super.key, required this.preferences});

  @override
  State<NotificationForm> createState() => _NotificationFormState();
}

class _NotificationFormState extends State<NotificationForm> {
  final db = PreferencesDatabaseService();
  late int start;
  bool set = false;

  void update(User? user) {
    widget.preferences.setStartTime(start);
    set = false;

    db.updatePreferences(user!.uid, widget.preferences);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    setState(() {
      if (!set) {
        start = widget.preferences.start;
      }
    });

    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.reminderNotification),
      content: SizedBox(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Text('Reminder Notification'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      OutlinedButton(
                        onPressed: () async {
                          TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: const TimeOfDay(hour: 12, minute: 00),
                            builder: (BuildContext context, Widget? child) {
                              return MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: true),
                                child: child ?? const Text('error'),
                              );
                            },
                          );

                          setState(() {
                            start = picked!.hour;
                            set = true;
                          });
                        },
                        child: Text('$start:00'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        TextButton(
          onPressed: () {
            update(user);
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)!.update),
        ),
      ],
    );
  }
}
