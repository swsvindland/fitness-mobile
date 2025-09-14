import 'package:flutter/material.dart';
import 'package:body_track/l10n/app_localizations.dart';
import 'package:utils/constants.dart';

class SideNavigation extends StatelessWidget {
  const SideNavigation(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < md) {
      return const SizedBox();
    }
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onItemTapped,
      extended: false,
      labelType: NavigationRailLabelType.all,
      leading: const Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.straighten, size: 48.0),
          ],
        ),
      ),
      destinations: <NavigationRailDestination>[
        NavigationRailDestination(
          padding: const EdgeInsets.all(8),
          icon: const Icon(Icons.monitor_weight),
          label: Text(AppLocalizations.of(context)!.weight),
        ),
        NavigationRailDestination(
          padding: const EdgeInsets.all(8),
          icon: const Icon(Icons.straighten),
          label: Text(AppLocalizations.of(context)!.body),
        ),
        NavigationRailDestination(
          padding: const EdgeInsets.all(8),
          icon: const Icon(Icons.height),
          label: Text(AppLocalizations.of(context)!.height),
        ),
        NavigationRailDestination(
          padding: const EdgeInsets.all(8),
          icon: const Icon(Icons.photo_camera),
          label: const Text('Photos'),
        ),
        NavigationRailDestination(
          padding: const EdgeInsets.all(8),
          icon: const Icon(Icons.settings),
          label: Text(AppLocalizations.of(context)!.settings),
        ),
      ],
    );
  }
}