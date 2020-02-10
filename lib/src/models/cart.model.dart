import 'dart:convert';

import 'package:ecommerce_app_ui_kit/src/models/combination.dart';

class Cart {
  String id;
  String customerId;
  String customerName;
  Map<String, int> items;
  bool isActive;
  List<Combination> combinations;
  int totalPrice = 0;

  Cart({
    this.id,
    this.customerId,
    this.customerName,
    this.items,
    this.isActive,
    this.combinations,
    this.totalPrice,
  });

  factory Cart.fromMap(Map<String, dynamic> json, String id) => Cart(
        id: id ?? '',
        customerId: json["customerId"],
        customerName: json["customerName"],
        items: Map<String, int>.from(json["items"]),
        isActive: json["isActive"],
        totalPrice: json["totalPrice"],
        combinations: json['combinations'] ?? []
      );

  Map<String, dynamic> toMap() => {
        "customerId": customerId,
        "customerName": customerName,
        "items": items,
        "isActive": isActive,
        "totalPrice": totalPrice,
      };
}
