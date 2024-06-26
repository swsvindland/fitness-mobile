import 'package:flutter/material.dart';
import 'package:period_track/utils/colors.dart';
import 'package:period_track/widgets/calendar/calendar_key.dart';

import '../calendar/calendar.dart';

class HomeDesktop extends StatefulWidget {
  const HomeDesktop({super.key});

  @override
  State<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {
  bool drawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const SizedBox(height: 24),
              const Calendar(),
              const SizedBox(height: 24),
              const SizedBox(
                width: 600,
                child: Divider(color: yellow),
              ),
              const SizedBox(height: 24),
              Card(
                color: Theme.of(context).brightness == Brightness.light
                    ? purple4
                    : Theme.of(context).cardColor,
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: SizedBox(
                    width: 600,
                    child: CalendarKey(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
