import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:period_track/utils/colors.dart';

class CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;

  const CalendarHeader({
    super.key,
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
  });

  @override
  Widget build(BuildContext context) {
    final headerText = DateFormat.MMMM().format(focusedDay);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, color: cream),
            onPressed: onLeftArrowTap,
          ),
          Text(
              headerText.toLowerCase(),
              style: GoogleFonts.josefinSlab(fontWeight: FontWeight.w600, fontSize: 36, letterSpacing: 0.10, color: yellow),
            ),
          IconButton(
            icon: const Icon(Icons.chevron_right, color: cream),
            onPressed: onRightArrowTap,
          ),
        ],
      ),
    );
  }
}