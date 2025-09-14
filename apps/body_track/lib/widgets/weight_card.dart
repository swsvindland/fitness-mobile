import 'package:body_track/widgets/weigh_in_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:models/models.dart';
import 'package:body_track/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class WeightCard extends StatelessWidget {
  const WeightCard({super.key, required this.data});
  final Weight data;

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
            body: WeighInForm(data: data),
          ),
        ),
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
              children: [
                const Divider(),
                Text('${AppLocalizations.of(context)!.weight}: ${(preferences.unit == 'imperial' ? (data.weight * 2.2046226218) : data.weight).toStringAsFixed(1)} ${preferences.unit == 'imperial' ? 'lbs' : 'kg'}')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
