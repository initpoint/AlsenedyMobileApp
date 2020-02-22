import 'dart:async';
import 'package:ecommerce_app_ui_kit/src/models/customer.dart';
import 'package:ecommerce_app_ui_kit/src/models/message.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseChatService with ChangeNotifier {
  Future<List<Message>> getMyChat();
  Future<bool> createMessage(String message);
}

class ChatService with ChangeNotifier implements BaseChatService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final CollectionReference usersCollection =
      Firestore.instance.collection('customers');

  final CollectionReference messagessCollection =
      Firestore.instance.collection('messages');

  Future<bool> createMessage(String message) async {
    var currentUser = await FirebaseAuth.instance.currentUser();
    var currentCustomer = await this.currentCustomer(currentUser.uid);

    var message = Message();
    message.customerId = currentCustomer.uid;
    message.text = message.text;
    message.sender = currentCustomer.uid;
    message.customerName = currentCustomer.fullName;

    await messagessCollection.add(message.toJson());
    return true;
  }

  Future<List<Message>> getMyChat() async {
    var currentUser = await FirebaseAuth.instance.currentUser();
    var userMessagesFromFirebase = await messagessCollection
        .where('customerId', isEqualTo: currentUser.uid)
        .getDocuments();

    var jsonMessages = userMessagesFromFirebase.documents
        .map((data) => Message.fromMap(data.data, data.documentID))
        .toList();

    return jsonMessages;
  }

  Future<Customer> currentCustomer(String uid) async {
    var user = usersCollection.where('uid', isEqualTo: uid).snapshots().map(
        (doc) => doc.documents
            .map((dd) => Customer.fromMap(dd.data, dd.documentID))
            .first);
    return user.first;
  }
}
