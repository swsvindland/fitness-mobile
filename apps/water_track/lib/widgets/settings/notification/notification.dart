import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'notification_form.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationState();
}

class _NotificationState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    final preferences = Provider.of<Preferences>(context);

    handleAction() {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return NotificationForm(preferences: preferences);
        },
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListTile(
          title: Text(AppLocalizations.of(context)!.reminderNotification),
          subtitle: Text("Start: ${(preferences.start)}:00 End: ${(preferences.end)}:00"),
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
