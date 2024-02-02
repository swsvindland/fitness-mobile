import 'package:bp_track/models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'check_in_form.dart';

class CheckInCard extends StatelessWidget {
  const CheckInCard({super.key, required this.data});
  final BloodPressure data;

  @override
  Widget build(BuildContext context) {
    handleAction() {
      showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: CheckInForm(data: data),
              ),
            );
          });
    }

    return InkWell(
      onTap: handleAction,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListTile(
            title: Text(
              DateFormat.MMMMd(Localizations.localeOf(context).languageCode)
                  .format(data.date),
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 20),
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                Text(
                    '${AppLocalizations.of(context)!.systolic}: ${data.systolic}\t\t\t'),
                Text(
                    '${AppLocalizations.of(context)!.diastolic}: ${data.diastolic}\t\t\t'),
                data.heartRate == null
                    ? const SizedBox()
                    : Text(
                        '${AppLocalizations.of(context)!.heartRate}: ${data.heartRate ?? '-'}\t\t\t'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
