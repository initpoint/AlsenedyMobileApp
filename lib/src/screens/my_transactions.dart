import 'package:ecommerce_app_ui_kit/src/models/customer.dart';
import 'package:ecommerce_app_ui_kit/src/models/invoice.model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountsWidget extends StatefulWidget {
  @override
  _AccountsWidgetState createState() => _AccountsWidgetState();
}

class _AccountsWidgetState extends State<AccountsWidget> {
  List<Invoice> invoicesList = [];
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
          .collection('invoices')
          .where('customerId', isEqualTo: data.uid)
          .snapshots()
          .listen((querySnapshot) {
        setState(() {
          this.invoicesList = querySnapshot.documents
              .map((mess) => Invoice.fromMap(mess.data, mess.documentID))
              .toList();
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 170,
                height: 150,
                color: Colors.lightGreen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'مدين',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    Text(
                      customer.debt,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    Text(
                      'ريال سعودي',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 170,
                height: 150,
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'دائن',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    Text(
                      customer.credit,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    Text(
                      'ريال سعودي',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: this.invoicesList.length,
              itemBuilder: (context, index) {
                final invoice = this.invoicesList[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      invoice.date,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.blueAccent),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          'حالة الحساب : ' +
                              (invoice.debt == '0' ? 'دائن' : 'مدين')
                                  .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          'الرصيد: ' +
                              (invoice.debt == '0'
                                      ? invoice.credit
                                      : invoice.debt)
                                  .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                    Text(
                      'الوصف :',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      invoice.description,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          ),
        ],
      ),
    );
  }
}
