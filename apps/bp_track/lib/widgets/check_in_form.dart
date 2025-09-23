import 'package:api/blood_pressure_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:provider/provider.dart';
import 'package:bp_track/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:utils/helper.dart';
import 'package:widgets/widgets.dart';

class CheckInForm extends StatefulWidget {
  final BloodPressure? data;

  const CheckInForm({super.key, this.data});

  @override
  State<CheckInForm> createState() => _CheckInState();
}

class _CheckInState extends State<CheckInForm> {
  final db = BloodPressureDatabaseService();
  final _formKey = GlobalKey<FormState>();
  final systolicController = TextEditingController();
  final diastolicController = TextEditingController();
  final heartRateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.data != null) {
      systolicController.text = widget.data!.systolic.toString();
      diastolicController.text = widget.data!.diastolic.toString();
      heartRateController.text = widget.data!.heartRate?.toString() ?? '';
    }
  }

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

    delete() async {
      if (widget.data != null && widget.data!.id != null) {
        await db.deleteBloodPressure(widget.data!.id!);
      }
    }

    submit() async {
      if (user == null) return;

      if (widget.data != null && widget.data!.id != null) {
        await db.updateBloodPressure(
            widget.data!.id!,
            user.uid,
            int.parse(systolicController.text),
            int.parse(diastolicController.text),
            int.tryParse(heartRateController.text));
        return;
      }

      await db.addBloodPressure(
          user.uid,
          int.parse(systolicController.text),
          int.parse(diastolicController.text),
          int.tryParse(heartRateController.text));
    }

    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Form(
          key: _formKey,
          child: SizedBox(
            height: 225,
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
              ],
            ),
          ),
        ),
      ),
      actions: [
        widget.data != null
            ? TextButton(
                onPressed: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              AppLocalizations.of(context)!.processingData)),
                    );
                    await delete();
                    context.pop();
                  }
                },
                child: Text(AppLocalizations.of(context)!.delete),
              )
            : const SizedBox(),
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              // If the form is valid, display a snackbar. In the real world,
              // you'd often call a server or save the information in a database.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text(AppLocalizations.of(context)!.processingData)),
              );
              await submit();
              context.pop();
            }
          },
          child: Text(AppLocalizations.of(context)!.submit),
        ),
      ],
    );
  }
}
