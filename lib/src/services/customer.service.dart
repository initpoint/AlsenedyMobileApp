import 'dart:async';
import 'package:ecommerce_app_ui_kit/src/models/customer.dart';
import 'package:ecommerce_app_ui_kit/src/services/auth.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

abstract class UsersService with ChangeNotifier {
  Future<Customer> getUser();
  Future<void> addUser(Customer customer);
}

class UsersRepo with ChangeNotifier implements UsersService {
  final BaseAuth baseAuth;

  final CollectionReference usersCollection =
      Firestore.instance.collection('customers');

  UsersRepo({this.baseAuth});

  Future<Customer> getUser() async {
    var currentUser = await baseAuth.getCurrentUser();
    var uid = currentUser.uid;
    var user = usersCollection.where('uid', isEqualTo: uid).snapshots().map(
        (doc) => doc.documents
            .map((dd) => Customer.fromMap(dd.data, dd.documentID))
            .first);
    return user.first;
  }

  @override
  Future<void> addUser(Customer customer) async {
    print(customer.id);
    await usersCollection.document(customer.id).setData(customer.toJson(), merge: true);
    // print(ss);
  }
}
