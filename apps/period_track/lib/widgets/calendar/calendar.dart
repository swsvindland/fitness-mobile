import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:models/note.dart';
import 'package:models/preferences.dart';
import 'package:period_track/utils/colors.dart';
import 'package:period_track/utils/helper.dart';
import 'package:period_track/widgets/calendar/calendar_header.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:utils/constants.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final PageController _pageController;
  DateTime _focusedDay = DateTime.now();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var notes = Provider.of<Iterable<NoteModel>>(context).toList();
    var preferences = Provider.of<Preferences>(context);

    var keyedNotes = {for (var e in notes) DateUtils.dateOnly(e.date): e};

    var periodStartNotes =
        notes.where((element) => element.periodStart).toList();

    periodStartNotes.sort((a, b) => a.date.compareTo(b.date));

    int menstrualCycleLength = computeMenstrualLength(
        preferences.defaultCycleLength,
        periodStartNotes.map((e) => e.date).toList());
    int ovulationLength = computeOvulationLength(menstrualCycleLength);

    Map<DateTime, DateTime> periodStartDate = {
      for (var e in periodStartNotes)
        DateUtils.dateOnly(e.date): DateUtils.dateOnly(e.date)
    };

    Map<DateTime, DateTime> ovulationDate = periodStartDate.map((key, value) {
      var newEntry = key.add(Duration(days: ovulationLength));
      return MapEntry(newEntry, newEntry);
    });

    Map<DateTime, DateTime> fertileDays = computeFertility(menstrualCycleLength, ovulationDate);

    Map<DateTime, DateTime> predictedPeriodDays =
        computeNextSixMonthsOfCycles(menstrualCycleLength, periodStartDate);

    List<Event> getEventsFromNotes(DateTime day) {
      var key = DateUtils.dateOnly(day);
      List<Event> events = [];

      if (keyedNotes.containsKey(key) == false) {
        return [];
      }

      if (keyedNotes[key]!.note.isNotEmpty) {
        events.add(const Event('Note'));
      }

      if (keyedNotes[key]?.intimacy ?? false) {
        events.add(const Event('Intimacy'));
      }

      return events;
    }

    return SizedBox(
      width: 600,
      child: Column(
        children: [
          Text(
            _focusedDay.year.toString(),
            textAlign: TextAlign.center,
            style: GoogleFonts.josefinSans(
              color: yellow,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.12,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 24),
          notes.isEmpty
              ? const Text(
                  'Looks like you have not recorded a period yet. Add a new note or click on a day to get started.',
                  style: TextStyle(color: yellow))
              : const SizedBox(),
          const Divider(color: yellow),
          const SizedBox(height: 8),
          CalendarHeader(
            focusedDay: _focusedDay,
            onLeftArrowTap: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
            onRightArrowTap: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
          ),
          const SizedBox(height: 16),
          TableCalendar(
            daysOfWeekVisible: true,
            headerVisible: false,
            firstDay: DateTime.utc(2000, 01, 01),
            lastDay: DateTime.utc(2100, 01, 01),
            focusedDay: _focusedDay,
            eventLoader: getEventsFromNotes,
            daysOfWeekStyle: DaysOfWeekStyle(
              dowTextFormatter: (date, locale) => DateFormat.E(locale).format(date).substring(0, 1).toUpperCase(),
              weekdayStyle: GoogleFonts.josefinSans(
                color: green1,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.10,
              ),
              weekendStyle: GoogleFonts.josefinSans(
                color: green1,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.10,
              ),
            ),
            onDaySelected: (day, day2) {
              navigatorKey.currentState!.pushNamed('/add-note',
                  arguments: {"id": DateUtils.dateOnly(day).toIso8601String()});
            },
            onCalendarCreated: (controller) => _pageController = controller,
            onPageChanged: (focusedDay) => {
              setState(() {
                _focusedDay = focusedDay;
              })
            },
            calendarBuilders: CalendarBuilders(
              todayBuilder: (context, day, day2) {
                return CalendarDay(
                  day: day,
                  day2: day2,
                  periodStartDate: periodStartDate,
                  ovulationDate: ovulationDate,
                  keyedNotes: keyedNotes,
                  predictedPeriodDays: predictedPeriodDays,
                  fertileDays: fertileDays,
                );
              },
              defaultBuilder: (context, day, day2) {
                return CalendarDay(
                  day: day,
                  day2: day2,
                  periodStartDate: periodStartDate,
                  ovulationDate: ovulationDate,
                  keyedNotes: keyedNotes,
                  predictedPeriodDays: predictedPeriodDays,
                  fertileDays: fertileDays,
                );
              },
              disabledBuilder: (context, day, day2) {
                return const Center();
              },
              withinRangeBuilder: (context, day, day2) {
                return const Center();
              },
              outsideBuilder: (context, day, day2) {
                return const Center();
              },
              rangeHighlightBuilder: (context, day, isWithinRange) {
                return const Center();
              },
              rangeStartBuilder: (context, day, day2) {
                return const Center();
              },
              rangeEndBuilder: (context, day, day2) {
                return const Center();
              },
              markerBuilder: (context, day, list) {
                List<Widget> dots = [];

                if (day.month != _focusedDay.month ||
                    day.year != _focusedDay.year) {
                  return const Center();
                }

                for (var element in list) {
                  if (element == const Event('Note')) {
                    dots.add(
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 2),
                        child: CircleAvatar(
                          backgroundColor: yellow,
                          maxRadius: 4,
                        ),
                      ),
                    );
                  }

                  if (element == const Event('Intimacy')) {
                    dots.add(
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 2),
                        child: CircleAvatar(
                          backgroundColor: green2,
                          maxRadius: 4,
                        ),
                      ),
                    );
                  }
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: dots,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarDay extends StatelessWidget {
  const CalendarDay(
      {super.key,
      required this.day,
      required this.day2,
      required this.periodStartDate,
      required this.ovulationDate,
      required this.keyedNotes,
      required this.predictedPeriodDays,
      required this.fertileDays
      });
  final DateTime day;
  final DateTime day2;
  final Map<DateTime, DateTime> periodStartDate;
  final Map<DateTime, DateTime> ovulationDate;
  final Map<DateTime, NoteModel> keyedNotes;
  final Map<DateTime, DateTime> predictedPeriodDays;
  final Map<DateTime, DateTime> fertileDays;

  @override
  Widget build(BuildContext context) {
    var dateOnly = DateUtils.dateOnly(day);
    var notes = Provider.of<Iterable<NoteModel>>(context).toList();

    final calendarTextStyle = GoogleFonts.josefinSans(
      color:
          dateOnly == DateUtils.dateOnly(DateTime.now()) ? yellow : cream,
      fontSize: 16,
      fontWeight: dateOnly == DateUtils.dateOnly(DateTime.now()) ? FontWeight.w600 : FontWeight.w300,
      letterSpacing: 0.05,
    );

    if (day.month != day2.month) {
      return const Center();
    }

    if (notes.isEmpty) {
      return Center(child: Text(day.day.toString(), style: calendarTextStyle));
    }

    if (periodStartDate.containsKey(dateOnly)) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(color: yellow)),
          child: CircleAvatar(
            backgroundColor: purple3,
            child: SizedBox(
              height: 20,
              width: 20,
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: calendarTextStyle,
                ),
              ),
            ),
          ),
        ),
      );
    }

    if (ovulationDate.containsKey(dateOnly)) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(color: green1)),
          child: CircleAvatar(
            backgroundColor: green3,
            child: SizedBox(
              height: 20,
              width: 20,
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: calendarTextStyle,
                ),
              ),
            ),
          ),
        ),
      );
    }

    if (keyedNotes.containsKey(dateOnly)) {
      if (keyedNotes[dateOnly]?.flow != null) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                shape: BoxShape.circle, border: Border.all(color: yellow)),
            child: SizedBox(
              height: 20,
              width: 20,
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: calendarTextStyle,
                ),
              ),
            ),
          ),
        );
      }
    }

    if (fertileDays.containsKey(dateOnly)) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(color: green1)),
          child: SizedBox(
            height: 20,
            width: 20,
            child: Center(
              child: Text(
                day.day.toString(),
                style: calendarTextStyle,
              ),
            ),
          ),
        ),
      );
    }

    if (predictedPeriodDays.containsKey(dateOnly)) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(color: cream)),
          child: SizedBox(
            height: 20,
            width: 20,
            child: Center(
              child: Text(
                day.day.toString(),
                style: calendarTextStyle,
              ),
            ),
          ),
        ),
      );
    }

    return Center(child: Text(day.day.toString(), style: calendarTextStyle));
  }
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}
