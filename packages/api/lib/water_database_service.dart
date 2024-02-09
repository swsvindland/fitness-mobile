import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'dart:async';

class WaterDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var date = DateTime.now();

  Stream<Drinks> streamDrinks(String? id) {
    if (id == null) return Stream.error('User ID is null');

    try {
      return _db
          .collection('drinks')
          .doc(id)
          .collection('days')
          .doc(DateUtils.dateOnly(date).toIso8601String())
          .snapshots()
          .map((snap) => Drinks.fromMap(snap.data()!));
    } catch (err) {
      return Stream.error(err);
    }
  }

  Future<void> updateDrinks(String id, Drinks drinks) {
    try {
      return _db
          .collection('drinks')
          .doc(id)
          .collection('days')
          .doc(DateUtils.dateOnly(date).toIso8601String())
          .set(Drinks.toMap(drinks));
    } catch (err) {
      return Future.error(err);
    }
  }

  Stream<Iterable<Drinks>> streamAllDrinks(String? id) {
    if (id == null) return Stream.error('User ID is null');

    try {
      return _db
          .collection('drinks')
          .doc(id)
          .collection('days')
          .snapshots()
          .map((event) => event.docs.map((e) => Drinks.fromMap(e.data())));
    } catch (err) {
      return Stream.error(err);
    }
  }
}
