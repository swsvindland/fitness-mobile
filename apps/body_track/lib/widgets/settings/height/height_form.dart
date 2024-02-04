import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:body_track/models/models.dart';
import 'package:body_track/services/database_service.dart';

import '../../../utils/helper.dart';
import '../../input.dart';

class HeightForm extends StatefulWidget {
  final Preferences preferences;

  const HeightForm({super.key, required this.preferences});

  @override
  State<HeightForm> createState() => _HeightFormState();
}

class _HeightFormState extends State<HeightForm> {
  final db = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  final feetController = TextEditingController();
  final inchesController = TextEditingController();
  bool set = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    feetController.dispose();
    inchesController.dispose();

    super.dispose();
  }

  void update(User? user) {
    widget.preferences.setHeight(
        int.parse(feetController.text), int.parse(inchesController.text));
    set = false;

    db.updatePreferences(user!.uid, widget.preferences);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    setState(() {
      if (!set) {
        feetController.text =
            (widget.preferences.height / 12).floor().toString();
        inchesController.text = (widget.preferences.height % 12).toString();
      }
    });

    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Input(
                        label: 'Feet',
                        decimal: false,
                        variant: "secondary",
                        controller: feetController,
                        validator: checkInValidator),
                  ),
                  Expanded(
                    child: Input(
                        label: 'Inches',
                        decimal: false,
                        variant: "secondary",
                        controller: inchesController,
                        validator: checkInValidator),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  update(user);
                },
                child: const Text(
                  'Update',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
