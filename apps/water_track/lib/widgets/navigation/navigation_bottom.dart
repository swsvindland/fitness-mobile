 import 'package:flutter/material.dart';
import 'package:utils/constants.dart';
import 'package:water_track/l10n/app_localizations.dart';

class NavigationBottom extends StatelessWidget {
  const NavigationBottom({super.key, required this.selectedIndex, required this.onItemTapped});
  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > sm) {
      return const SizedBox();
    }

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: AppLocalizations.of(context)!.home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.insights),
          label: AppLocalizations.of(context)!.reports,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: AppLocalizations.of(context)!.settings,
        ),
      ],
      currentIndex: selectedIndex,
      onTap: onItemTapped,
    );
  }
}
