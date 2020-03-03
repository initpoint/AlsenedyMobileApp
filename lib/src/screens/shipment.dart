import 'package:ecommerce_app_ui_kit/src/models/bills.model.dart';
import 'package:ecommerce_app_ui_kit/src/models/customer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ShipmentsWidget extends StatefulWidget {
  @override
  _ShipmentsWidgetState createState() => _ShipmentsWidgetState();
}

class _ShipmentsWidgetState extends State<ShipmentsWidget> {
  List<Bill> billList = [];
  Customer customer = new Customer();

  @override
  void initState() {
    customer.credit = '0';
    customer.debt = '0';
    FirebaseAuth.instance.currentUser().then((data) {
      Firestore.instance
          .collection('customers')
          .where('uid', isEqualTo: data.uid)
          .snapshots()
          .map((doc) => doc.documents
              .map((dd) => Customer.fromMap(dd.data, dd.documentID))
              .first)
          .first
          .then((customer) {
        this.customer = customer;
      });

      Firestore.instance
          .collection('bills')
          .where('customerId', isEqualTo: data.uid)
          .snapshots()
          .listen((querySnapshot) {
        setState(() {
          this.billList = querySnapshot.documents
              .map((mess) => Bill.fromMap(mess.data, mess.documentID))
              .toList();
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: ListView.separated(
            itemCount: billList.length,
            itemBuilder: (context, index) {
              final bill = billList[index];
              return Column(
                children: <Widget>[
                  Text(bill.customerId),
                  Text(bill.createDate)
                ],
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          ),
        )
      ],
    );
  }
}
