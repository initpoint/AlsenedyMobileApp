import 'dart:async';
import 'package:ecommerce_app_ui_kit/src/models/combination.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CombinationsService with ChangeNotifier {
  Future<List<Combination>> getCombinations();
}

class CombinationsRepo with ChangeNotifier implements CombinationsService {
  final CollectionReference combinationCollection =
      Firestore.instance.collection('combinations');

  final CollectionReference permissionCollection =
      Firestore.instance.collection('permission');

  Future<List<Combination>> getCombinations() async {
    List<Combination> combList = [];
    var currentUser = await FirebaseAuth.instance.currentUser();
    var uid = currentUser.uid;
    var combIds = await getPermissions(uid);
    var combinationRef = combinationCollection.reference();
    // final snapshots =
    //     combinationRef.where('documentId', arrayContainsAny: comIds).limit(10).snapshots();
    // Stream<QuerySnapshot>  snapshots2;
    for (var combId in combIds) {
      print(combId);
      final snapshot = await combinationRef.document(combId).get();
      // var ss = snapshot.data.map((doc) => Combination.fromMap(doc.data, doc.documentID));
      //       print(combinations);
      //    combinations;
      final combination =
          Combination.fromMap(snapshot.data, snapshot.documentID);
      combList.add(combination);
    }

    // await for (final snapshot in snapshots2) {
    //   final combinations = await snapshot.documents
    //       .map((doc) => Combination.fromMap(doc.data, doc.documentID))
    //       .toList();
    // yield combinations;
    // }
    return combList;
  }

  Future<List<String>> getPermissions(String uid) async {
    var permission = await permissionCollection.reference().document(uid).get();
    List<String> userCombinations =
        permission.data['items'].cast<String>() ?? [];
    return userCombinations;
  }
}

// main(List<String> args) {
//   CombinationsRepo().ge
// }
