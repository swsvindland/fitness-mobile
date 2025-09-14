import 'package:body_track/widgets/height_form.dart';
import 'package:flutter/material.dart';
import 'package:utils/constants.dart';
import 'package:body_track/l10n/app_localizations.dart';

class Height extends StatefulWidget {
  const Height({super.key});

  @override
  State<Height> createState() => _HeightState();
}

class _HeightState extends State<Height> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(AppLocalizations.of(context)!.height),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            navigatorKey.currentState!.pop();
          },
        ),
      ),
      body: const HeightForm(),
    );
  }
}
