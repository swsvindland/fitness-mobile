import 'package:api/supplement_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:provider/provider.dart';
import 'package:sup_track/widgets/user_supplement_list.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final db = SupplementDatabaseService();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    if (user == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return FutureBuilder(
      future: db.streamUserSupplements(user.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              StreamProvider<Iterable<UserSupplement>>.value(
                value: snapshot.data as Stream<Iterable<UserSupplement>>,
                initialData: const [],
                catchError: (context, error) => const [],
              ),
            ],
            child: const Align(
                alignment: Alignment.topCenter, child: UserSupplementList()),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
