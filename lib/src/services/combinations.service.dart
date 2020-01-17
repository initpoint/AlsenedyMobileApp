import 'dart:async';
import 'package:ecommerce_app_ui_kit/src/models/combination.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_ui_kit/src/models/customer.dart';
import 'package:ecommerce_app_ui_kit/src/models/permission.model.dart';
import 'package:ecommerce_app_ui_kit/src/services/customer.service.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CombinationsService {
  Future<List<Combination>> getCombinations();
}

class CombinationsRepo implements CombinationsService {
  final CollectionReference combinationCollection =
      Firestore.instance.collection('combinations');

  final CollectionReference permissionCollection =
      Firestore.instance.collection('permission');

  final CollectionReference usersCollection =
      Firestore.instance.collection('customers');

  Future<List<Combination>> getCombinations() async {
    List<Combination> combList = [];
    var currentUser = await FirebaseAuth.instance.currentUser();
    var uid = currentUser.uid;
    var currentCustomer = await this.currentCustomer(uid);
    var combIds = await _getPermissions(uid);
    var combinationRef = combinationCollection.reference();
    for (var combId in combIds) {
      final snapshot = await combinationRef.document(combId).get();
      final combination =
          Combination.fromMap(snapshot.data, snapshot.documentID);
      // print(currentCustomer.pricelist);
      final combPrice = combination.prices[currentCustomer.pricelist];
      if (combPrice != null && combPrice != 0) {
        combination.price = combPrice;
        combList.add(combination);
      }
    }
    // await Future.delayed(const Duration(seconds: 7));
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

  Future<Customer> currentCustomer(String uid) async {
    var user = usersCollection.where('uid', isEqualTo: uid).snapshots().map(
        (doc) => doc.documents
            .map((dd) => Customer.fromMap(dd.data, dd.documentID))
            .first);
    return user.first;
  }
}
