import 'package:api/supplement_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:models/user_supplement_activity.dart';
import 'package:provider/provider.dart';
import 'package:sup_track/utils/colors.dart';

class SupplementCard extends StatelessWidget {
  final String name;
  final String brand;
  final String uid;
  final String? supplementId;
  final bool user;

  SupplementCard(
      {super.key,
      required this.name,
      required this.brand,
      required this.uid,
      required this.user,
      this.supplementId});

  final db = SupplementDatabaseService();

  handleTap() {
    if (supplementId == null) return;
    if (user) {
      db.toggleUserSupplementActivity(uid, supplementId!);
    } else {
      db.addUserSupplement(uid, supplementId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    if (user == null) {
      return const CircularProgressIndicator();
    }

    return Card(
      child: InkWell(
        onTap: handleTap,
        child: ListTile(
            title: Text(name),
            subtitle: Text(brand),
            trailing: MultiProvider(
              providers: [
                StreamProvider<Iterable<UserSupplementActivity>>.value(
                  value:
                      db.streamUserSupplementActivity(user.uid, supplementId),
                  initialData: const [],
                  catchError: (context, error) => const [],
                ),
              ],
              child: const CheckedIcon(),
            )),
      ),
    );
  }
}

class CheckedIcon extends StatelessWidget {
  const CheckedIcon({super.key});

  @override
  Widget build(BuildContext context) {
    var userSupplementActivity =
        Provider.of<Iterable<UserSupplementActivity>>(context);

    print(userSupplementActivity.isNotEmpty);

    if (userSupplementActivity.isNotEmpty) {
      return const Icon(Icons.check_circle_outline, color: primary);
    }

    return const SizedBox();
  }
}
