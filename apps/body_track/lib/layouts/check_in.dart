import 'package:body_track/widgets/body_measurements_form.dart';
import 'package:flutter/material.dart';
import 'package:utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            navigatorKey.currentState!.pop();
          },
        ),
      ),
      body: const BodyMeasurementForm(),
    );
  }
}
