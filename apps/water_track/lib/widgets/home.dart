import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_track/services/database_service.dart';
import 'package:models/models.dart';
import 'buttons/buttons.dart';
import 'drink_size.dart';
import 'graph.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var db = DatabaseService();
    var user = Provider.of<User?>(context);

    return MultiProvider(
      providers: [
        StreamProvider<Drinks>.value(
            initialData: Drinks.empty(),
            value: db.streamDrinks(user!.uid),
            catchError: (_, err) => Drinks.empty()),
      ],
      child: Center(
        child: SingleChildScrollView(
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
