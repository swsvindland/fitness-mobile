import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:models/note.dart';
import 'dart:async';

class PeriodDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var date = DateTime.now();

  Stream<Iterable<NoteModel>> streamNotes(String id) {
    try {
      return _db
          .collection('notes')
          .where('uid', isEqualTo: id)
          .snapshots()
          .map((event) => event.docs.map((e) => NoteModel.fromMap(e.data())));
    } catch (err) {
      return Stream.error(err);
    }
  }

  Future<void> addNote(String id, NoteModel note) {
    try {
      return _db
          .collection('notes')
          .add(NoteModel.toMap(note));
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<void> updateNote(String id, NoteModel note) async {
    try {
      var snapshot = await _db
          .collection('notes')
          .where('uid', isEqualTo: id)
          .where('date', isEqualTo: note.date)
          .get();

      return snapshot.docs.first.reference.set(NoteModel.toMap(note));
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<void> deleteNote(String id, DateTime date) async {
    try {
      var querySnapshot = await _db
          .collection('notes')
          .where('uid', isEqualTo: id)
          .where('date', isGreaterThanOrEqualTo: date)
          .where('date', isLessThan: date.add(const Duration(days: 1)))
          .get();

      for(int i = 0; i < querySnapshot.docs.length; ++i) {
        querySnapshot.docs[i].reference.delete();
      }
    } catch (err) {
      return Future.error(err);
    }
  }
}
