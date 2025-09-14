import 'package:body_track/widgets/weigh_in_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:body_track/l10n/app_localizations.dart';

class WeighIn extends StatefulWidget {
  const WeighIn({super.key});

  @override
  State<WeighIn> createState() => _WeighInState();
}

class _WeighInState extends State<WeighIn> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(AppLocalizations.of(context)!.weighIn),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: const WeighInForm(),
    );
  }
}
