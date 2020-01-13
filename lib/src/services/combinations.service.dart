import 'dart:async';
import 'package:ecommerce_app_ui_kit/src/models/combination.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CombinationsService {
  Stream<List<Combination>> getCombinations();
}

class CombinationsRepo implements CombinationsService {
  final CollectionReference combinationCollection =  Firestore.instance.collection('combinations');

  Stream<List<Combination>> getCombinations() {
    var combinationRef = combinationCollection.reference();
    var combinations = combinationRef.limit(10).snapshots()
    .map((doc) => doc.documents.map((dd) => Combination.fromMap(dd.data, dd.documentID)).toList());
    return combinations;
  }
  
}

// main(List<String> args) {
//   CombinationsRepo().getCombinations().listen((data) {
//     data.forEach((com) {
//       print(com.amount);
//     });
//   });
// }