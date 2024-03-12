import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    if (user == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ExerciseList();
  }
}

class ExerciseList extends StatelessWidget {
  ExerciseList({super.key});

  final exercises = ['Bench', 'Fly', 'Lateral Raise', 'Pushdown'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: exercises.length,
      itemBuilder: (BuildContext context, int index) {
        return ExerciseCard(data: exercises[index]);
      },
    );
  }
}

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(data),
      )
    );
  }
}
