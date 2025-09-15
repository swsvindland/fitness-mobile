import 'package:api/body_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utils/helper.dart';
import 'package:widgets/widgets.dart';
import 'package:body_track/l10n/app_localizations.dart';
import 'package:models/models.dart';
import 'package:body_track/services/health_sync_service.dart' as health_sync;

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
  final cmController = TextEditingController();
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    feetController.dispose();
    inchesController.dispose();
    cmController.dispose();
    super.dispose();
  }

  Future<void> submit(User user, Preferences preferences) async {
    int cm;
    if (preferences.unit == 'imperial') {
      final inches = (int.parse(feetController.text) * 12) + int.parse(inchesController.text);
      cm = (inches * 2.54).round();
    } else {
      cm = int.parse(cmController.text);
    }

    final sync = health_sync.HealthSyncService();

    if (widget.data != null && widget.data!.id != null) {
      await db.updateHeight(widget.data!.id!, cm);
      await sync.writeHeightIfEnabled(user, preferences, cm, date: widget.data!.date);
      return;
    }

    await db.addHeight(user.uid, cm);
    await sync.writeHeightIfEnabled(user, preferences, cm);
  }

  Future<void> delete() async {
    if (widget.data != null && widget.data!.id != null) {
      await db.deleteHeight(widget.data!.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final preferences = Provider.of<Preferences>(context);

    // Initialize controllers based on stored cm and user preference for display
    if (!_initialized && widget.data != null) {
      final storedCm = widget.data!.height;
      if (preferences.unit == 'imperial') {
        final totalInches = (storedCm / 2.54).round();
        feetController.text = (totalInches ~/ 12).toString();
        inchesController.text = (totalInches % 12).toString();
      } else {
        cmController.text = storedCm.toString();
      }
      _initialized = true;
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (preferences.unit == 'imperial')
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
              )
            else
              Input(
                label: '${AppLocalizations.of(context)!.height} (cm)',
                decimal: false,
                controller: cmController,
                validator: checkInValidator,
              ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () async {
                if (user == null) return;
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.processingData)),
                  );
                  await submit(user, preferences);
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
