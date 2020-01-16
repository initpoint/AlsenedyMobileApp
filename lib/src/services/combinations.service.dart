import 'dart:async';
import 'package:ecommerce_app_ui_kit/src/models/combination.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_ui_kit/src/models/permission.model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CombinationsService {
  Future<List<Combination>> getCombinations();
}

class CombinationsRepo implements CombinationsService {
  final CollectionReference combinationCollection =
      Firestore.instance.collection('combinations');

  final CollectionReference permissionCollection =
      Firestore.instance.collection('permission');

  Future<List<Combination>> getCombinations() async {
    List<Combination> combList = [];
    var currentUser = await FirebaseAuth.instance.currentUser();
    var uid = currentUser.uid;
    var combIds = await _getPermissions(uid);
    var combinationRef = combinationCollection.reference();
    // var total = 0;
    for (var combId in combIds) {
      // if (total >= 300) {
      //   break;
      // }
      // total++;
      final snapshot = await combinationRef.document(combId).get();
      final combination =
          Combination.fromMap(snapshot.data, snapshot.documentID);
      combList.add(combination);
    }
     await Future.delayed(const Duration(seconds: 7));
    return combList;
  }

  Future<List<String>> _getPermissions(String uid) async {
    List<String> userCombinations = [];
    var permission = await permissionCollection.reference().document(uid).get();
    if (permission.data != null) {
      userCombinations =
          Permission.fromMap(permission.data, permission.documentID).items;
    }
    return userCombinations;
  }
}

