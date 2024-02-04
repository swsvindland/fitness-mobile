import 'package:body_track/widgets/weigh_in_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:models/models.dart';

class WeightCard extends StatelessWidget {
  const WeightCard({super.key, required this.data});
  final Weight data;

  @override
  Widget build(BuildContext context) {
    handleAction() {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: WeighInForm(data: data),
            ),
          );
        },
      );
    }

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
              children: [const Divider(), Text('Weight: ${data.weight}')],
            ),
          ),
        ),
      ),
    );
  }
}
