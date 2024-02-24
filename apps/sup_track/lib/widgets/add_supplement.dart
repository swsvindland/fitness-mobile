import 'package:api/supplement_database_service.dart';
import 'package:flutter/material.dart';

class AddSupplement extends StatefulWidget {
  final String uid;
  final String supplementId;
  const AddSupplement(
      {super.key, required this.uid, required this.supplementId});

  @override
  State<AddSupplement> createState() => _AddSupplementState();
}

class _AddSupplementState extends State<AddSupplement> {
  var morning = false;
  var breakfast = false;
  var lunch = false;
  var preWorkout = false;
  var postWorkout = false;
  var dinner = false;
  var evening = false;

  final db = SupplementDatabaseService();

  handleSupplementAdd() async {
    await db.removeUserSupplement(widget.uid, widget.supplementId);

    if (morning) {
      db.addUserSupplement(widget.uid, widget.supplementId, 'morning');
    }
    if (breakfast) {
      db.addUserSupplement(widget.uid, widget.supplementId, 'breakfast');
    }
    if (lunch) {
      db.addUserSupplement(widget.uid, widget.supplementId, 'lunch');
    }
    if (preWorkout) {
      db.addUserSupplement(widget.uid, widget.supplementId, 'preWorkout');
    }
    if (postWorkout) {
      db.addUserSupplement(widget.uid, widget.supplementId, 'postWorkout');
    }
    if (dinner) {
      db.addUserSupplement(widget.uid, widget.supplementId, 'dinner');
    }
    if (evening) {
      db.addUserSupplement(widget.uid, widget.supplementId, 'evening');
    }
  }

  void handleTimes() async {
    var userSupplements = await db.getUserSupplementTimes(widget.uid, widget.supplementId);
    for (var element in userSupplements) {
      switch (element.time) {
        case 'morning':
          setState(() {
            morning = true;
          });
          break;
        case 'breakfast':
          setState(() {
            breakfast = true;
          });
          break;
        case 'lunch':
          setState(() {
            lunch = true;
          });
          break;
        case 'preWorkout':
          setState(() {
            preWorkout = true;
          });
          break;
        case 'postWorkout':
          setState(() {
            postWorkout = true;
          });
          break;
        case 'dinner':
          setState(() {
            dinner = true;
          });
          break;
        case 'evening':
          setState(() {
            evening = true;
          });
          break;
      }
    }
  }

  @override
  void initState() {
    super.initState();

    handleTimes();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Supplement'),
      content: SizedBox(
        height: 425,
        child: Column(
          children: <Widget>[
            const Text('Would you like to add this supplement to your list?'),
            ListTile(
              title: const Text('Morning'),
              trailing: Switch(
                value: morning,
                onChanged: (bool value) {
                  setState(() {
                    morning = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Breakfast'),
              trailing: Switch(
                value: breakfast,
                onChanged: (bool value) {
                  setState(() {
                    breakfast = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Lunch'),
              trailing: Switch(
                value: lunch,
                onChanged: (bool value) {
                  setState(() {
                    lunch = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Pre-Workout'),
              trailing: Switch(
                value: preWorkout,
                onChanged: (bool value) {
                  setState(() {
                    preWorkout = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Post-Workout'),
              trailing: Switch(
                value: postWorkout,
                onChanged: (bool value) {
                  setState(() {
                    postWorkout = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Dinner'),
              trailing: Switch(
                value: dinner,
                onChanged: (bool value) {
                  setState(() {
                    dinner = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Evening'),
              trailing: Switch(
                value: evening,
                onChanged: (bool value) {
                  setState(() {
                    evening = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Update'),
          onPressed: () {
            handleSupplementAdd();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
