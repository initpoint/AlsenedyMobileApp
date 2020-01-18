import 'dart:async';
import 'package:ecommerce_app_ui_kit/src/models/cart.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_ui_kit/src/models/combination.dart';
import 'package:ecommerce_app_ui_kit/src/models/customer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CartService with ChangeNotifier {
  Future<List<Cart>> getAllCarts(String uid);
  Future<void> addToCartCart(Combination cart);
  Future<void> updateCart(Combination combination, {bool increment = true});
  Future<void> deleteCart(Cart cart);
  List<Combination> get combinationList;
}

class CartRepo with ChangeNotifier implements CartService {
  final CollectionReference cartCollection =
      Firestore.instance.collection('carts');

  final CollectionReference usersCollection =
      Firestore.instance.collection('customers');

  CartRepo() {
    this.getCurrentActiveCart();
  }

  List<Combination> combinationList = [];
  Cart cart;
  bool anyCartActive = true;
  Future<List<Cart>> getAllCarts(String uid) async {
    var userId = await getCurrentUserId();
    var docs = await cartCollection
        .where('customerId', isEqualTo: userId)
        .getDocuments();
    var carts = docs.documents
        .map((dd) => Cart.fromMap(dd.data, dd.documentID))
        .toList();
    return carts;
  }

  Future<void> addToCartCart(Combination combination) async {
    Customer customer = await currentCustomer();
    cart.combinations.add(combination);
    cart.items.add(combination.id);
    combinationList.add(combination);
    cart.customerId = customer.id;
    cart.customerName = customer.fullName;

    if (anyCartActive) {
      await cartCollection.document(cart.id).updateData(cart.toMap());
    } else {
      var cartToAdd = await cartCollection.add(cart.toMap());
      cart.id = cartToAdd.documentID;
      this.anyCartActive = true;
    }
    combination.amount++;

    notifyListeners();
  }

  Future<void> updateCart(Combination combination,
      {bool increment = true}) async {
    if (increment) {
      if (cart.items.where((x) => x == combination.id) == null) {
        combination.amount++;
        combinationList.add(combination);
      } else {
        combination.amount++;
      }
    } else {
      cart.items.remove(combination.id);
      combination.amount--;
    }
    await cartCollection.document(cart.id).updateData(cart.toMap());
    notifyListeners();
  }

  Future<void> deleteCart(Cart cart) async {}

  Future<String> getCurrentUserId() async {
    var currentUser = await FirebaseAuth.instance.currentUser();
    return currentUser.uid;
  }

  Future<Customer> currentCustomer() async {
    var currentUser = await FirebaseAuth.instance.currentUser();
    var uid = currentUser.uid;
    var user = usersCollection.where('uid', isEqualTo: uid).snapshots().map(
        (doc) => doc.documents
            .map((dd) => Customer.fromMap(dd.data, dd.documentID))
            .first);
    return user.first;
  }

  Future<Cart> getCurrentActiveCart() async {
    Cart cart;
    var currentUser = await FirebaseAuth.instance.currentUser();
    var uid = currentUser.uid;
    await cartCollection
        .where('customerId', isEqualTo: uid)
        .where('isActive', isEqualTo: true)
        .getDocuments()
        .then((jsonCart) {
      var carts = jsonCart.documents
          .map((cartObj) => Cart.fromMap(cartObj.data, cartObj.documentID))
          .toList();
      if (carts.length > 0) {
        cart = carts.first;
      } else {
        this.anyCartActive = false;
      }
    });
    this.cart = cart ??= Cart(combinations: [], items: [], isActive: true);
    return cart ??= Cart(combinations: [], items: [], isActive: true);
  }
}
