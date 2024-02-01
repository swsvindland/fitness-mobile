import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../services/database_service.dart';
import '../utils/constants.dart';
import '../utils/helper.dart';
import 'input.dart';

class CheckInForm extends StatefulWidget {
  const CheckInForm({super.key});

  @override
  State<CheckInForm> createState() => _CheckInState();
}

class _CheckInState extends State<CheckInForm> {
  final db = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  final systolicController = TextEditingController();
  final diastolicController = TextEditingController();
  final heartRateController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    systolicController.dispose();
    diastolicController.dispose();
    heartRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    submit() async {
      if (user == null) return;

      await db.addBloodPressure(
          user.uid,
          int.parse(systolicController.text),
          int.parse(diastolicController.text),
          int.tryParse(heartRateController.text));
    }

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Input(
              label: AppLocalizations.of(context)!.systolic,
              controller: systolicController,
              validator: checkInValidator),
          Input(
              label: AppLocalizations.of(context)!.diastolic,
              controller: diastolicController,
              validator: checkInValidator),
          Input(
            label: AppLocalizations.of(context)!.heartRate,
            controller: heartRateController,
            validator: optionalCheckInIntValidator,
          ),
          FilledButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)!.saving)),
                );
                await submit();
                navigatorKey.currentState!.pop();
              }
            },
            child: Text(AppLocalizations.of(context)!.submit),
          ),
        ],
      ),
    );
  }
}
