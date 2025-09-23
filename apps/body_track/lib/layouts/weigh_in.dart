import 'package:body_track/widgets/weigh_in_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:body_track/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:models/models.dart';
import 'package:api/api.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      body: Builder(
        builder: (context) {
          final user = Provider.of<User?>(context);
          return StreamProvider<Preferences>.value(
            initialData: Preferences.empty(user!.uid),
            value: PreferencesDatabaseService().streamPreferences(user.uid),
            child: const WeighInForm(),
          );
        },
      ),
    );
  }
}
