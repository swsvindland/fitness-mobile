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
  late int end;
  bool set = false;

  void update(User? user) {
    widget.preferences.setStartTime(start);
    widget.preferences.setEndTime(end);
    set = false;

    db.updatePreferences(user!.uid, widget.preferences);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    setState(() {
      if (!set) {
        start = widget.preferences.start;
        end = widget.preferences.end;
      }
    });

    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.reminderNotification),
      content: SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text('Start'),
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
                  const SizedBox(width: 16),
                  Column(
                    children: [
                      const Text('End'),
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
                            end = picked!.hour;
                            set = true;
                          });
                        },
                        child: Text('$end:00'),
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
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        TextButton(
          onPressed: () {
            update(user);
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.update),
        ),
      ],
    );
  }
}
