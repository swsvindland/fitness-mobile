import 'package:body_track/widgets/settings/notification/notification_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';
import 'package:body_track/l10n/app_localizations.dart';

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
      showDialog<void>(
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
          subtitle: Text("${(preferences.start)}:00"),
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
