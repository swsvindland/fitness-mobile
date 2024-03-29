import 'package:api/body_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';
import 'package:utils/constants.dart';
import 'package:utils/helper.dart';
import 'package:widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeighInForm extends StatefulWidget {
  final Weight? data;

  const WeighInForm({super.key, this.data});

  @override
  State<WeighInForm> createState() => _WeighInFormState();
}

class _WeighInFormState extends State<WeighInForm> {
  final db = BodyDatabaseService();
  final _formKey = GlobalKey<FormState>();
  final weightController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.data != null) {
      weightController.text = widget.data!.weight.toString();
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    delete() async {
      if (widget.data != null && widget.data!.id != null) {
        await db.deleteWeighIn(widget.data!.id!);
      }
    }

    submit() async {
      if (user == null) return;

      if (widget.data != null && widget.data!.id != null) {
        await db.updateWeighIn(
            widget.data!.id!, double.parse(weightController.text));

        return;
      }

      await db.addWeighIn(user.uid, double.parse(weightController.text));
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Input(
                label: AppLocalizations.of(context)!.weight,
                controller: weightController,
                validator: checkInValidator),
            FilledButton(
              onPressed: () async {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text(AppLocalizations.of(context)!.processingData)),
                  );
                  await submit();
                  navigatorKey.currentState!.pop();
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
                        navigatorKey.currentState!.pop();
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.delete),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
