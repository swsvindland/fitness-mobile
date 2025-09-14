import 'package:body_track/widgets/body_measurements_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:models/models.dart';
import 'package:body_track/l10n/app_localizations.dart';

double log10(num x) => log(x) / ln10;

class CheckInCard extends StatelessWidget {
  const CheckInCard({super.key, required this.data});
  final CheckInModel data;

  @override
  Widget build(BuildContext context) {
    final preferences = Provider.of<Preferences>(context);

    handleAction() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(AppLocalizations.of(context)!.weighIn),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: BodyMeasurementForm(data: data),
          ),
        ),
      );
    }

    final heights = Provider.of<Iterable<HeightModel>>(context).toList();
    final double? heightInches = heights.isNotEmpty ? (heights.first.height / 2.54) : null;

    double? bf;
    if (heightInches != null) {
      final neckIn = data.neck / 2.54;
      final navelIn = data.navel / 2.54;
      final hipIn = data.hip != null ? (data.hip! / 2.54) : null;

      if (preferences.sex == 'male') {
        bf = 86.010 * log10(navelIn - neckIn) - 70.041 * log10(heightInches) + 36.76;
      } else if (hipIn != null) {
        bf = 163.205 * log10(navelIn + (hipIn) - neckIn) - 97.684 * log10(heightInches) - 78.387;
      }
    }

    final String unitLabel = preferences.unit == 'imperial' ? 'in' : 'cm';
    String fmt(double cm) => (preferences.unit == 'imperial' ? (cm / 2.54) : cm).toStringAsFixed(1);

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
                bf != null
                    ? Text('BodyFat: ${bf!.toStringAsFixed(2)}%')
                    : const SizedBox(height: 0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${AppLocalizations.of(context)!.neck}: ${fmt(data.neck)} $unitLabel'),
                    Text('${AppLocalizations.of(context)!.shoulders}: ${fmt(data.shoulders)} $unitLabel'),
                    Text('${AppLocalizations.of(context)!.chest}: ${fmt(data.chest)} $unitLabel'),
                    Text('${AppLocalizations.of(context)!.leftBicep}: ${fmt(data.leftBicep)} $unitLabel'),
                    Text('${AppLocalizations.of(context)!.rightBicep}: ${fmt(data.rightBicep)} $unitLabel'),
                    Text('${AppLocalizations.of(context)!.navel}: ${fmt(data.navel)} $unitLabel'),
                    Text('${AppLocalizations.of(context)!.waist}: ${fmt(data.waist)} $unitLabel'),
                    if (data.hip != null)
                      Text('${AppLocalizations.of(context)!.hip}: ${fmt(data.hip!)} $unitLabel'),
                    Text('${AppLocalizations.of(context)!.leftThigh}: ${fmt(data.leftThigh)} $unitLabel'),
                    Text('${AppLocalizations.of(context)!.rightThigh}: ${fmt(data.rightThigh)} $unitLabel'),
                    Text('${AppLocalizations.of(context)!.leftCalf}: ${fmt(data.leftCalf)} $unitLabel'),
                    Text('${AppLocalizations.of(context)!.rightCalf}: ${fmt(data.rightCalf)} $unitLabel'),
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
