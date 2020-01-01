import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

abstract class CombinationsService with ChangeNotifier {
  Stream<QuerySnapshot> getCombinations();
}

class CombinationsRepo with ChangeNotifier implements CombinationsService {

  final CollectionReference combinationCollection =  Firestore.instance.collection('combination');

  Stream<QuerySnapshot> getCombinations() {
    var com = combinationCollection.snapshots();
    return com;
  }
  
}
