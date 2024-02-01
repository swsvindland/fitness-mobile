import 'package:body_track/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../models/checkin.dart';
import '../models/preferences.dart';

double log10(num x) => log(x) / ln10;

class CheckInCard extends StatelessWidget {
  const CheckInCard({Key? key, required this.data}) : super(key: key);
  final CheckIn data;

  @override
  Widget build(BuildContext context) {
    final preferences = Provider.of<Preferences>(context);

    final bfMale = 86.010 * log10(data.navel - data.neck) -
        70.041 * log10(preferences.height) +
        36.76;
    final bfFemale =
        163.205 * log10(data.navel + (data.hip ?? data.navel) - data.neck) -
            97.684 * log10(preferences.height) -
            78.387;

    return Card(
      child: Padding(
          padding: const EdgeInsets.all(24),
          child: ListTile(
            title: Text(
              DateFormat.MMMMd(Localizations.localeOf(context).languageCode)
                  .format(data.date),
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 20, color: textPrimary),
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                preferences.sex == 'male'
                    ? Text('BodyFat: ${bfMale.toStringAsFixed(2)}%')
                    : data.hip != null
                        ? Text('BodyFat: ${bfFemale.toStringAsFixed(2)}%')
                        : const SizedBox(height: 0),
                Wrap(
                  children: [
                    Text('Neck: ${data.neck}\t\t\t'),
                    Text('Shoulders: ${data.shoulders}\t\t\t'),
                    Text('Chest: ${data.chest}\t\t\t'),
                    Text('Left Bicep: ${data.leftBicep}\t\t\t'),
                    Text('Right Bicep: ${data.rightBicep}\t\t\t'),
                    Text('Navel: ${data.navel}\t\t\t'),
                    Text('Waist: ${data.waist}\t\t\t'),
                    data.hip != null
                        ? Text('Hip: ${data.hip}\t\t\t')
                        : const SizedBox(width: 0),
                    Text('Left Thigh: ${data.leftThigh}\t\t\t'),
                    Text('Right Thigh: ${data.rightThigh}\t\t\t'),
                    Text('Left Calf: ${data.leftCalf}\t\t\t'),
                    Text('Right Calf: ${data.rightCalf}\t\t\t'),
                  ],
                ),
              ],
            ),
          )
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //       DateFormat.MMMMd(Localizations.localeOf(context).languageCode).format(data.date),
          //       textAlign: TextAlign.left,
          //       style: const TextStyle(fontSize: 20),
          //     ),
          //     const Divider(),
          //     preferences.sex == 'male'
          //         ? Text('BodyFat: ${bfMale.toStringAsFixed(2)}%')
          //         : data.hip != null
          //             ? Text('BodyFat: ${bfFemale.toStringAsFixed(2)}%')
          //             : const SizedBox(height: 0),
          //     Wrap(
          //       children: [
          //         Text('Neck: ${data.neck}\t\t\t'),
          //         Text('Shoulders: ${data.shoulders}\t\t\t'),
          //         Text('Chest: ${data.chest}\t\t\t'),
          //         Text('Left Bicep: ${data.leftBicep}\t\t\t'),
          //         Text('Right Bicep: ${data.rightBicep}\t\t\t'),
          //         Text('Navel: ${data.navel}\t\t\t'),
          //         Text('Waist: ${data.waist}\t\t\t'),
          //         data.hip != null
          //             ? Text('Hip: ${data.hip}\t\t\t')
          //             : const SizedBox(width: 0),
          //         Text('Left Thigh: ${data.leftThigh}\t\t\t'),
          //         Text('Right Thigh: ${data.rightThigh}\t\t\t'),
          //         Text('Left Calf: ${data.leftCalf}\t\t\t'),
          //         Text('Right Calf: ${data.rightCalf}\t\t\t'),
          //       ],
          //     ),
          //   ],
          // ),
          ),
    );
  }
}
