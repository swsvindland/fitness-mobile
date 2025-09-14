import 'package:body_track/widgets/body_measurements_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:body_track/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';
import 'package:api/api.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckIn extends StatefulWidget {
  const CheckIn({super.key});

  @override
  State<CheckIn> createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(AppLocalizations.of(context)!.checkIn),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Builder(
        builder: (context) {
          final user = Provider.of<User?>(context);
          return StreamProvider<Preferences>.value(
            initialData: Preferences.empty(),
            value: PreferencesDatabaseService().streamPreferences(user!.uid),
            child: const BodyMeasurementForm(),
          );
        },
      ),
    );
  }
}
