import 'dart:async';
import 'package:ecommerce_app_ui_kit/src/models/combination.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_ui_kit/src/models/customer.dart';
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

  bool allComming = false;

  Future<List<Combination>> getCombinations() async {
    List<Combination> combList = [];
    var currentUser = await FirebaseAuth.instance.currentUser();
    var currentCustomer = await this.currentCustomer(currentUser.uid);

    try {
      // get all combination from firebase that is active
      var combinationRef = combinationCollection.reference();
      var combinationsFromFirebase = await combinationRef
          .where('isActive', isEqualTo: true)
          .where('users', arrayContains: currentCustomer.uid)
          .getDocuments();

      // combinations to json
      var jsonCombinations = combinationsFromFirebase.documents
          .map((data) => Combination.fromMap(data.data, data.documentID))
          .toList();

      jsonCombinations.forEach((comb) {
        // check if combination have the user price list
        final combPrice = comb.prices[currentCustomer.pricelist];
        if (combPrice != null && combPrice != 0) {
          comb.price = combPrice;
          combList.add(comb);
        }
      });
    } catch (e) {
      this.allComming = true;
    }
    return combList;
  }

  Future<Customer> currentCustomer(String uid) async {
    var user = await usersCollection
        .document(uid).get().then((data) {
          return Customer.fromMap(data.data, data.documentID);
        });
    return user;
  }
}
