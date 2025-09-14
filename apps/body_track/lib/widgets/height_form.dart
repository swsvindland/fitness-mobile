import 'package:api/body_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utils/helper.dart';
import 'package:widgets/widgets.dart';
import 'package:body_track/l10n/app_localizations.dart';
import 'package:models/models.dart';

class HeightForm extends StatefulWidget {
  final HeightModel? data;

  const HeightForm({super.key, this.data});

  @override
  State<HeightForm> createState() => _HeightFormState();
}

class _HeightFormState extends State<HeightForm> {
  final db = BodyDatabaseService();
  final _formKey = GlobalKey<FormState>();
  final feetController = TextEditingController();
  final inchesController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.data != null) {
      final totalInches = widget.data!.height;
      feetController.text = (totalInches ~/ 12).toString();
      inchesController.text = (totalInches % 12).toString();
    }
  }

  @override
  void dispose() {
    feetController.dispose();
    inchesController.dispose();
    super.dispose();
  }

  Future<void> submit(User user) async {
    final inches = (int.parse(feetController.text) * 12) + int.parse(inchesController.text);

    if (widget.data != null && widget.data!.id != null) {
      await db.updateHeight(widget.data!.id!, inches);
      return;
    }

    await db.addHeight(user.uid, inches);
  }

  Future<void> delete() async {
    if (widget.data != null && widget.data!.id != null) {
      await db.deleteHeight(widget.data!.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Input(
                    label: AppLocalizations.of(context)!.feet,
                    decimal: false,
                    controller: feetController,
                    validator: checkInValidator,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Input(
                    label: AppLocalizations.of(context)!.inches,
                    decimal: false,
                    controller: inchesController,
                    validator: checkInValidator,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () async {
                if (user == null) return;
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.processingData)),
                  );
                  await submit(user);
                  Navigator.of(context).pop();
                }
              },
              child: Text(AppLocalizations.of(context)!.submit),
            ),
            widget.data != null
                ? OutlinedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(AppLocalizations.of(context)!.processingData)),
                        );
                        await delete();
                        Navigator.of(context).pop();
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
