import 'package:flutter/material.dart';
import 'buttons/buttons.dart';
import 'drink_size.dart';
import 'graph.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          width: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Graph(),
              const SizedBox(height: 16),
              Buttons(),
              const DrinkSize(),
            ],
          ),
        ),
      ),
    );
  }
}
