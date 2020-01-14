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
    var total = 0;
    for (var combId in combIds) {
      if(total >= 300) {
        break;
      }
      total ++;
      final snapshot = await combinationRef.document(combId).get();
      final combination =
          Combination.fromMap(snapshot.data, snapshot.documentID);
      combList.add(combination);
    }
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
