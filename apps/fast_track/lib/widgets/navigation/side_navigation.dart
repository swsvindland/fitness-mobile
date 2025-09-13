import 'package:flutter/material.dart';
import 'package:fast_track/l10n/app_localizations.dart';
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
          icon: const Icon(Icons.home),
          label: Text(AppLocalizations.of(context)!.home),
        ),
        NavigationRailDestination(
          padding: const EdgeInsets.all(8),
          icon: const Icon(Icons.insights),
          label: Text(AppLocalizations.of(context)!.all),
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