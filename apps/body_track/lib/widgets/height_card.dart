import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:models/models.dart';
import 'package:body_track/l10n/app_localizations.dart';
import 'package:body_track/widgets/height_form.dart';

class HeightCard extends StatelessWidget {
  const HeightCard({super.key, required this.data});
  final HeightModel data;

  @override
  Widget build(BuildContext context) {
    handleAction() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(AppLocalizations.of(context)!.height),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: HeightForm(data: data),
          ),
        ),
      );
    }

    final feet = (data.height ~/ 12);
    final inches = (data.height % 12);

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
                Text('${AppLocalizations.of(context)!.feet}: $feet  ${AppLocalizations.of(context)!.inches}: $inches'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
