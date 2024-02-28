import 'package:flutter/material.dart';
import 'package:models/user_supplement.dart';
import 'package:provider/provider.dart';
import 'package:sup_track/widgets/user_supplement_list_by_time.dart';

class UserSupplementList extends StatelessWidget {
  const UserSupplementList({super.key});

  @override
  Widget build(BuildContext context) {
    var userSupplements = Provider.of<Iterable<UserSupplement>?>(context);

    if (userSupplements == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (userSupplements.isEmpty) {
      return const Center(
        child: Text('No supplements added'),
      );
    }

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
