import 'package:body_track/widgets/body_measurements_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

double log10(num x) => log(x) / ln10;

class CheckInCard extends StatelessWidget {
  const CheckInCard({super.key, required this.data});
  final CheckInModel data;

  @override
  Widget build(BuildContext context) {
    final preferences = Provider.of<Preferences>(context);

    handleAction() {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: BodyMeasurementForm(data: data),
            ),
          );
        },
      );
    }

    final bfMale = 86.010 * log10(data.navel - data.neck) -
        70.041 * log10(preferences.height) +
        36.76;
    final bfFemale =
        163.205 * log10(data.navel + (data.hip ?? data.navel) - data.neck) -
            97.684 * log10(preferences.height) -
            78.387;

    return InkWell(
      onTap: handleAction,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
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
                preferences.sex == 'male'
                    ? Text('BodyFat: ${bfMale.toStringAsFixed(2)}%')
                    : data.hip != null
                        ? Text('BodyFat: ${bfFemale.toStringAsFixed(2)}%')
                        : const SizedBox(height: 0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${AppLocalizations.of(context)!.neck}: ${data.neck}\t\t\t'),
                    Text('${AppLocalizations.of(context)!.shoulders}: ${data.shoulders}\t\t\t'),
                    Text('${AppLocalizations.of(context)!.chest}: ${data.chest}\t\t\t'),
                    Text('${AppLocalizations.of(context)!.leftBicep}: ${data.leftBicep}\t\t\t'),
                    Text('${AppLocalizations.of(context)!.rightBicep}: ${data.rightBicep}\t\t\t'),
                    Text('${AppLocalizations.of(context)!.navel}: ${data.navel}\t\t\t'),
                    Text('${AppLocalizations.of(context)!.waist}: ${data.waist}\t\t\t'),
                    data.hip != null
                        ? Text('${AppLocalizations.of(context)!.hip}: ${data.hip}\t\t\t')
                        : const SizedBox(width: 0),
                    Text('${AppLocalizations.of(context)!.leftThigh}: ${data.leftThigh}\t\t\t'),
                    Text('${AppLocalizations.of(context)!.rightThigh}: ${data.rightThigh}\t\t\t'),
                    Text('${AppLocalizations.of(context)!.leftCalf}: ${data.leftCalf}\t\t\t'),
                    Text('${AppLocalizations.of(context)!.rightCalf}: ${data.rightCalf}\t\t\t'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
