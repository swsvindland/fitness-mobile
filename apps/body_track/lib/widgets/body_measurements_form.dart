import 'package:api/body_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';
import 'package:go_router/go_router.dart';
import 'package:utils/helper.dart';
import 'package:widgets/widgets.dart';
import 'package:body_track/l10n/app_localizations.dart';
import 'package:body_track/services/health_sync_service.dart' as health_sync;

class BodyMeasurementForm extends StatefulWidget {
  final CheckInModel? data;

  const BodyMeasurementForm({super.key, this.data});

  @override
  State<BodyMeasurementForm> createState() => _BodyMeasurementFormState();
}

class _BodyMeasurementFormState extends State<BodyMeasurementForm> {
  final db = BodyDatabaseService();
  final _formKey = GlobalKey<FormState>();
  final neckController = TextEditingController();
  final shouldersController = TextEditingController();
  final chestController = TextEditingController();
  final leftBicepController = TextEditingController();
  final rightBicepController = TextEditingController();
  final navelController = TextEditingController();
  final waistController = TextEditingController();
  final hipController = TextEditingController();
  final leftThighController = TextEditingController();
  final rightThighController = TextEditingController();
  final leftCalfController = TextEditingController();
  final rightCalfController = TextEditingController();
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    neckController.dispose();
    shouldersController.dispose();
    chestController.dispose();
    leftBicepController.dispose();
    rightBicepController.dispose();
    navelController.dispose();
    waistController.dispose();
    hipController.dispose();
    leftThighController.dispose();
    rightThighController.dispose();
    leftCalfController.dispose();
    rightCalfController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    final preferences = Provider.of<Preferences>(context);

    // Initialize the controllers with the current data in the user's preferred display units
    if (!_initialized && widget.data != null) {
      double toDisplay(double cm) => preferences.unit == 'imperial' ? (cm / 2.54) : cm;

      neckController.text = toDisplay(widget.data!.neck).toStringAsFixed(1);
      shouldersController.text = toDisplay(widget.data!.shoulders).toStringAsFixed(1);
      chestController.text = toDisplay(widget.data!.chest).toStringAsFixed(1);
      leftBicepController.text = toDisplay(widget.data!.leftBicep).toStringAsFixed(1);
      rightBicepController.text = toDisplay(widget.data!.rightBicep).toStringAsFixed(1);
      navelController.text = toDisplay(widget.data!.navel).toStringAsFixed(1);
      waistController.text = toDisplay(widget.data!.waist).toStringAsFixed(1);
      if (widget.data!.hip != null) {
        hipController.text = toDisplay(widget.data!.hip!).toStringAsFixed(1);
      }
      leftThighController.text = toDisplay(widget.data!.leftThigh).toStringAsFixed(1);
      rightThighController.text = toDisplay(widget.data!.rightThigh).toStringAsFixed(1);
      leftCalfController.text = toDisplay(widget.data!.leftCalf).toStringAsFixed(1);
      rightCalfController.text = toDisplay(widget.data!.rightCalf).toStringAsFixed(1);

      _initialized = true;
    }

    delete() async {
      if (widget.data != null && widget.data!.id != null) {
        await db.deleteCheckIn(widget.data!.id!);
      }
    }

    submit() async {
      if (user == null) return;

      double toCm(String txt) {
        final val = double.parse(txt);
        return preferences.unit == 'imperial' ? (val * 2.54) : val;
      }

      final sync = health_sync.HealthSyncService();
      final waistCm = toCm(waistController.text);

      await db.addCheckIn(
        user.uid,
        toCm(neckController.text),
        toCm(shouldersController.text),
        toCm(chestController.text),
        toCm(leftBicepController.text),
        toCm(rightBicepController.text),
        toCm(navelController.text),
        waistCm,
        hipController.text.isEmpty ? 0.0 : toCm(hipController.text),
        toCm(leftThighController.text),
        toCm(rightThighController.text),
        toCm(leftCalfController.text),
        toCm(rightCalfController.text),
      );

      await sync.writeWaistIfEnabled(user, preferences, waistCm);
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Input(
                  label: '${AppLocalizations.of(context)!.neck} (${preferences.unit == 'imperial' ? 'in' : 'cm'})',
                  controller: neckController,
                  validator: checkInValidator),
              Input(
                  label: '${AppLocalizations.of(context)!.shoulders} (${preferences.unit == 'imperial' ? 'in' : 'cm'})',
                  controller: shouldersController,
                  validator: checkInValidator),
              Input(
                  label: '${AppLocalizations.of(context)!.chest} (${preferences.unit == 'imperial' ? 'in' : 'cm'})',
                  controller: chestController,
                  validator: checkInValidator),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Input(
                        label: '${AppLocalizations.of(context)!.leftBicep} (${preferences.unit == 'imperial' ? 'in' : 'cm'})',
                        controller: leftBicepController,
                        validator: checkInValidator),
                  ),
                  Expanded(
                    child: Input(
                        label: '${AppLocalizations.of(context)!.rightBicep} (${preferences.unit == 'imperial' ? 'in' : 'cm'})',
                        controller: rightBicepController,
                        validator: checkInValidator),
                  ),
                ],
              ),
              Input(
                  label: '${AppLocalizations.of(context)!.navel} (${preferences.unit == 'imperial' ? 'in' : 'cm'})',
                  controller: navelController,
                  validator: checkInValidator),
              Input(
                  label: '${AppLocalizations.of(context)!.waist} (${preferences.unit == 'imperial' ? 'in' : 'cm'})',
                  controller: waistController,
                  validator: checkInValidator),
              Input(
                  label: '${AppLocalizations.of(context)!.hip} (${preferences.unit == 'imperial' ? 'in' : 'cm'})',
                  controller: hipController,
                  validator: checkInValidator),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Input(
                        label: '${AppLocalizations.of(context)!.leftThigh} (${preferences.unit == 'imperial' ? 'in' : 'cm'})',
                        controller: leftThighController,
                        validator: checkInValidator),
                  ),
                  Expanded(
                    child: Input(
                        label: '${AppLocalizations.of(context)!.rightThigh} (${preferences.unit == 'imperial' ? 'in' : 'cm'})',
                        controller: rightThighController,
                        validator: checkInValidator),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Input(
                        label: '${AppLocalizations.of(context)!.leftCalf} (${preferences.unit == 'imperial' ? 'in' : 'cm'})',
                        controller: leftCalfController,
                        validator: checkInValidator),
                  ),
                  Expanded(
                    child: Input(
                        label: '${AppLocalizations.of(context)!.rightCalf} (${preferences.unit == 'imperial' ? 'in' : 'cm'})',
                        controller: rightCalfController,
                        validator: checkInValidator),
                  ),
                ],
              ),
              FilledButton(
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
                    await submit();
                    context.pop();
                  }
                },
                child: Text(AppLocalizations.of(context)!.submit),
              ),
              widget.data != null
                  ? OutlinedButton(
                      onPressed: () async {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(AppLocalizations.of(context)!
                                    .processingData)),
                          );
                          await delete();
                          context.pop();
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.delete),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
