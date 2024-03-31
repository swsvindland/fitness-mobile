import 'package:api/period_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:models/note.dart';
import 'package:provider/provider.dart';

import '../widgets/add_note_form.dart';

class AddNotePage extends StatelessWidget {
  AddNotePage({super.key});
  final _db = PeriodDatabaseService();

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    var user = Provider.of<User?>(context);

    return MultiProvider(
      providers: [
        StreamProvider<Iterable<NoteModel>>.value(
          initialData: const [],
          value: _db.streamNotes(user!.uid),
          catchError: (_, err) => [],
        ),
      ],
      child: AddNoteForm(
        date: DateTime.parse(
          arguments["id"].toString(),
        ),
      ),
    );
  }
}
