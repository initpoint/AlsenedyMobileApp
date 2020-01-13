import 'dart:async';
import 'package:ecommerce_app_ui_kit/src/models/combination.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CombinationsService with ChangeNotifier {
  Stream<List<Combination>> getCombinations();
}

class CombinationsRepo with ChangeNotifier implements CombinationsService {
  final CollectionReference combinationCollection =
      Firestore.instance.collection('combinations');

  Stream<List<Combination>> getCombinations() async* {
    var currentUser = await FirebaseAuth.instance.currentUser();
    var uid = currentUser.uid;
    var combinationRef = combinationCollection.reference();
    final snapshots =
        combinationRef.where('users', arrayContains: uid).limit(10).snapshots();
    await for (final snapshot in snapshots) {
      final combinations = await snapshot.documents
          .map((doc) => Combination.fromMap(doc.data, doc.documentID))
          .toList();
      yield combinations;
    }
  }
}

// main(List<String> args) {
//   CombinationsRepo().getCombinations().listen((data) {
//     data.forEach((com) {
//       print(com.amount);
//     });
//   });
// }
