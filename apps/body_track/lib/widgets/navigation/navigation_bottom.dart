import 'package:flutter/material.dart';
import 'package:utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavigationBottom extends StatelessWidget {
  const NavigationBottom({super.key, required this.selectedIndex, required this.onItemTapped});
  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > md) {
      return const SizedBox();
    }

    return NavigationBar(
      destinations: <Widget>[
        NavigationDestination(
          icon: const Icon(Icons.monitor_weight),
          label: AppLocalizations.of(context)!.weight,
        ),
        NavigationDestination(
          icon: const Icon(Icons.straighten),
          label: AppLocalizations.of(context)!.body,
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings),
          label: AppLocalizations.of(context)!.settings,
        ),
      ],
      selectedIndex: selectedIndex,
      onDestinationSelected: onItemTapped,
    );
  }
}
