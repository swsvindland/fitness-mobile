import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_track/utils/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalendarKey extends StatelessWidget {
  const CalendarKey({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CalendarKeyItem(
                  icon: const CalendarKeyItemIconCircle(color: purple3),
                  text: AppLocalizations.of(context)!.cycleBegin.toLowerCase()),
              CalendarKeyItem(
                  icon: const CalendarKeyItemIconCircle(color: green2),
                  text: AppLocalizations.of(context)!.estOvulation.toLowerCase()),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CalendarKeyItem(
                  icon: const CalendarKeyItemIconOutlinedCircle(
                      color: yellow),
                  text: AppLocalizations.of(context)!.period.toLowerCase()),
              CalendarKeyItem(
                  icon: const CalendarKeyItemIconOutlinedCircle(
                      color: green1),
                  text: AppLocalizations.of(context)!.estFertileDays.toLowerCase()),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CalendarKeyItem(
                  icon: const CalendarKeyItemIconOutlinedCircle(
                      color: purple1),
                  text: AppLocalizations.of(context)!.estCycle.toLowerCase()),
              CalendarKeyItem(
                  icon: const CalendarKeyItemIconDot(color: yellow),
                  text: AppLocalizations.of(context)!.notes.toLowerCase()),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 175),
              CalendarKeyItem(
                  icon: const CalendarKeyItemIconDot(color: green1),
                  text: AppLocalizations.of(context)!.intimacy.toLowerCase()),
            ],
          ),
        )
      ],
    );
  }
}

class CalendarKeyItem extends StatelessWidget {
  const CalendarKeyItem({super.key, required this.icon, required this.text});
  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 175,
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 24,
            child: icon,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.josefinSans(
                color: cream,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.12),
          )
        ],
      ),
    );
  }
}

class CalendarKeyItemIconCircle extends StatelessWidget {
  const CalendarKeyItemIconCircle({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: color,
        child: const SizedBox(
          height: 16,
          width: 16,
        ));
  }
}

class CalendarKeyItemIconOutlinedCircle extends StatelessWidget {
  const CalendarKeyItemIconOutlinedCircle({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            shape: BoxShape.circle, border: Border.all(color: color)),
        child: const SizedBox(width: 16, height: 16));
  }
}

class CalendarKeyItemIconDot extends StatelessWidget {
  const CalendarKeyItemIconDot({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(backgroundColor: color, maxRadius: 4);
  }
}
