import 'dart:async';
import 'package:ecommerce_app_ui_kit/src/models/cart.model.dart';
import 'package:ecommerce_app_ui_kit/src/models/combination.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CartService with ChangeNotifier {
  Future<List<Cart>> getAllCarts(String uid);
  Future<void> addCart(Cart cart);
  Future<void> updateCart(Cart cart);
  Future<void> deleteCart(Cart cart);
}

class CartRepo with ChangeNotifier implements CartService {
  final CollectionReference cartCollection =
      Firestore.instance.collection('carts');


  Future<List<Cart>> getAllCarts(String uid) async {
    var userId = await getCurrentUserId();
     var docs = await cartCollection.where('customerId',isEqualTo: userId).getDocuments();
     var carts = docs.documents.map((dd) => Cart.fromMap(dd.data, dd.documentID)).toList();
     return carts;
  }

  Future<void> addCart(Cart cart) async {
    await cartCollection.add(cart.toMap());
  }
  Future<void> updateCart(Cart cart) async {
    await cartCollection.
  }
  Future<void> deleteCart(Cart cart) async {}

  Future<String> getCurrentUserId() async {
    var currentUser = await FirebaseAuth.instance.currentUser();
    return currentUser.uid;
  }
}
