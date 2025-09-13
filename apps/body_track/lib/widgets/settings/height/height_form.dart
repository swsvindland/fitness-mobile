import 'package:api/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';
import 'package:utils/helper.dart';
import 'package:widgets/widgets.dart';
import 'package:body_track/l10n/app_localizations.dart';

class HeightForm extends StatefulWidget {
  final Preferences preferences;

  const HeightForm({super.key, required this.preferences});

  @override
  State<HeightForm> createState() => _HeightFormState();
}

class _HeightFormState extends State<HeightForm> {
  final db = PreferencesDatabaseService();
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

    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.height),
      content: SizedBox(
        height: 100,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Input(
                        label: AppLocalizations.of(context)!.feet,
                        decimal: false,
                        controller: feetController,
                        validator: checkInValidator),
                  ),
                  Expanded(
                    child: Input(
                        label:
                            AppLocalizations.of(context)!.inches,
                        decimal: false,
                        controller: inchesController,
                        validator: checkInValidator),
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
