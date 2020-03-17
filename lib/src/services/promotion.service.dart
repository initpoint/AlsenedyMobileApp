import 'dart:async';
import 'package:ecommerce_app_ui_kit/src/models/promotion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_ui_kit/src/models/customer.dart';
import 'package:flutter/cupertino.dart';

abstract class PromotionsService extends ChangeNotifier {
  Future<List<Promotion>> getPromotions(List<String> promotionsCodes);
}

class PromotionsRepo extends ChangeNotifier implements PromotionsService {
  final CollectionReference promotionCollection =
      Firestore.instance.collection('promotions');

  final CollectionReference usersCollection =
      Firestore.instance.collection('customers');

  Future<List<Promotion>> getPromotions(List<String> promotionsCodes) async {
    List<Promotion> proList = [];
    var promotionRef = promotionCollection.reference();
    for (var promo in promotionsCodes) {
      print(promo);
      var promotion = await promotionRef.document(promo).get();
      proList.add(Promotion.fromMap(promotion.data, promotion.documentID));
    }

    return proList;
  }

  Future<Customer> currentCustomer(String uid) async {
    var user = await usersCollection.document(uid).get().then((data) {
      return Customer.fromMap(data.data, data.documentID);
    });
    return user;
  }
}
