import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotEnoughData extends StatelessWidget {
  const NotEnoughData({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 600,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.noNotesError,
          ),
        ),
      ),
    );
  }
}
