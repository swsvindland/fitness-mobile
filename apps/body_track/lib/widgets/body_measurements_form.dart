import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/database_service.dart';
import '../utils/constants.dart';
import '../utils/helper.dart';
import 'input.dart';

class BodyMeasurementForm extends StatefulWidget {
  const BodyMeasurementForm({Key? key}) : super(key: key);

  @override
  State<BodyMeasurementForm> createState() => _BodyMeasurementFormState();
}

class _BodyMeasurementFormState extends State<BodyMeasurementForm> {
  final db = DatabaseService();
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

  bool showBloodPressureInput = false;

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

    submit() async {
      if (user == null) return;

      await db.addCheckIn(
        user.uid,
        double.parse(neckController.text),
        double.parse(shouldersController.text),
        double.parse(chestController.text),
        double.parse(leftBicepController.text),
        double.parse(rightBicepController.text),
        double.parse(navelController.text),
        double.parse(waistController.text),
        double.parse(hipController.text),
        double.parse(leftThighController.text),
        double.parse(rightThighController.text),
        double.parse(leftCalfController.text),
        double.parse(rightCalfController.text),
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Input(
              label: 'Neck',
              controller: neckController,
              validator: checkInValidator),
          Input(
              label: 'Shoulders',
              controller: shouldersController,
              validator: checkInValidator),
          Input(
              label: 'Chest',
              controller: chestController,
              validator: checkInValidator),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: Input(
                    label: 'Left Bicep',
                    controller: leftBicepController,
                    validator: checkInValidator),
              ),
              SizedBox(
                width: 150,
                child: Input(
                    label: 'Right Bicep',
                    controller: rightBicepController,
                    validator: checkInValidator),
              ),
            ],
          ),
          Input(
              label: 'Navel',
              controller: navelController,
              validator: checkInValidator),
          Input(
              label: 'Waist',
              controller: waistController,
              validator: checkInValidator),
          Input(
              label: 'Hip',
              controller: hipController,
              validator: checkInValidator),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: Input(
                    label: 'Left Thigh',
                    controller: leftThighController,
                    validator: checkInValidator),
              ),
              SizedBox(
                width: 150,
                child: Input(
                    label: 'Right Thigh',
                    controller: rightThighController,
                    validator: checkInValidator),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: Input(
                    label: 'Left Calf',
                    controller: leftCalfController,
                    validator: checkInValidator),
              ),
              SizedBox(
                width: 150,
                child: Input(
                    label: 'Right Calf',
                    controller: rightCalfController,
                    validator: checkInValidator),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: ElevatedButton(
              onPressed: () async {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  await submit();
                  navigatorKey.currentState!.pop();
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
