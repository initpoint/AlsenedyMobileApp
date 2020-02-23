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
  int get cartPrice;
  Future<void> checkoutCart();
  Stream<List<Cart>> getCustomerCarts();
  Future<List<Combination>> getCartCombinations(
      Map<String, int> combinationsIds);
}

class CartRepo with ChangeNotifier implements CartService {
  final CollectionReference cartCollection =
      Firestore.instance.collection('carts');

  final CollectionReference usersCollection =
      Firestore.instance.collection('customers');

  final CollectionReference combinationCollection =
      Firestore.instance.collection('combinations');

  get cartPrice {
    var price = 0;
    for (var item in combinationList) {
      price += item.price * item.amount;
    }
    return price;
  }

  List<Combination> combinationList = [];
  Cart cart;

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

  Future<void> checkoutCart() async {
    var cart = await getCurrentActiveCart();
    cart.isActive = false;
    await cartCollection.document(cart.id).updateData(cart.toMap());
    for (var item in combinationList) {
      item.amount = 0;
    }
    combinationList = [];
  }

  Future<void> addToCartCart(Combination combination) async {
    cart = await getCurrentActiveCart();
    Customer customer = await currentCustomer();
    ++combination.amount;
    cart.combinations.add(combination);
    combinationList.add(combination);
    cart.items.addAll({combination.id: combination.amount});
    cart.customerId = customer.id;
    cart.customerName = customer.fullName;
    cart.totalPrice = cartPrice;
    await cartCollection.document(cart.id).updateData(cart.toMap());
    notifyListeners();
  }

  Future<void> updateCart(Combination combination,
      {bool increment = true}) async {
    cart = await getCurrentActiveCart();
    if (increment) {
      if (!cart.items.containsKey(combination.id)) {
        combination.amount++;
        combinationList.add(combination);
        cart.items.update(combination.id, (com) => combination.amount);
      } else {
        combination.amount++;
        cart.totalPrice = cartPrice;
        cart.items.update(combination.id, (com) => combination.amount);
      }
    } else {
      combination.amount--;
      cart.totalPrice = cartPrice;
      cart.items.update(combination.id, (com) => combination.amount);
      if (combination.amount <= 0) {
        combinationList.remove(combination);
      }
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
        .then((jsonCart) async {
      var carts = jsonCart.documents
          .map((cartObj) => Cart.fromMap(cartObj.data, cartObj.documentID))
          .toList();
      if (carts.length > 0) {
        cart = carts.first;
        cart.combinations = [];
      } else {
        var customer = await currentCustomer();
        cart = Cart(
            combinations: [],
            items: {},
            isActive: true,
            customerId: customer.id,
            customerName: customer.fullName);
        var cartToAdd = await cartCollection.add(cart.toMap());
        cart.id = cartToAdd.documentID;
      }
    });
    return cart;
  }

  Stream<List<Cart>> getCustomerCarts() async* {
    Customer currentCustomer = await this.currentCustomer();
    var carts = cartCollection
        .where('customerId', isEqualTo: currentCustomer.id)
        .snapshots();

    var cartsToReturn = carts.map((data) => data.documents
        .map((cart) => Cart.fromMap(cart.data, cart.documentID))
        .toList());
    print(cartsToReturn);
    yield* cartsToReturn;
  }

  @override
  Future<List<Combination>> getCartCombinations(
      Map<String, int> combinationsIds) async {
    var comList = new List<Combination>();

    for (var id in combinationsIds.keys) {
      var combinations = await combinationCollection
          .where('code', isEqualTo: id)
          .getDocuments();
      var combination = combinations.documents
          .map((doc) => Combination.fromMap(doc.data, doc.documentID))
          .first;
      combination.amount = combinationsIds[id];
      comList.add(combination);
    }
    return comList;
  }
}
