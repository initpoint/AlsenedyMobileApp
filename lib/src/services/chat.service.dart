import 'dart:async';
import 'package:ecommerce_app_ui_kit/src/models/customer.dart';
import 'package:ecommerce_app_ui_kit/src/models/message.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseChatService with ChangeNotifier {
  Stream<List<Message>> getMyChat();
  Future<bool> createMessage(String message);
}

class ChatService with ChangeNotifier implements BaseChatService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final CollectionReference usersCollection =
      Firestore.instance.collection('customers');

  final CollectionReference messagessCollection =
      Firestore.instance.collection('messages');

  Future<bool> createMessage(String messageText) async {
    var currentUser = await FirebaseAuth.instance.currentUser();
    var currentCustomer = await this.currentCustomer(currentUser.uid);

    var message = Message();
    message.customerId = currentCustomer.uid;
    message.text = messageText;
    message.sender = currentCustomer.uid;
    message.customerName = currentCustomer.fullName;
    print(message.toJson());
    await messagessCollection.add(message.toJson());
    return true;
  }

  Stream<List<Message>> getMyChat() async* {
    var currentUser = await FirebaseAuth.instance.currentUser();
   var messages =  messagessCollection
        .where('customerId', isEqualTo: currentUser.uid)
        .snapshots();

    yield* messages.map((data) => data.documents
            .map((mess) => Message.fromMap(mess.data, mess.documentID))
            .toList());
  }

  Future<Customer> currentCustomer(String uid) async {
    var user = usersCollection.where('uid', isEqualTo: uid).snapshots().map(
        (doc) => doc.documents
            .map((dd) => Customer.fromMap(dd.data, dd.documentID))
            .first);
    return user.first;
  }
}
