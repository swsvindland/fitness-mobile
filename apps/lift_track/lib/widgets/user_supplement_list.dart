import 'package:flutter/material.dart';
import 'package:lift_track/widgets/user_supplement_list_by_time.dart';

class UserSupplementList extends StatelessWidget {
  const UserSupplementList({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserSupplementListByTime(time: 'morning'),
          UserSupplementListByTime(time: 'breakfast'),
          UserSupplementListByTime(time: 'lunch'),
          UserSupplementListByTime(time: 'preWorkout'),
          UserSupplementListByTime(time: 'postWorkout'),
          UserSupplementListByTime(time: 'dinner'),
          UserSupplementListByTime(time: 'evening'),
        ],
      ),
    );
  }
}
