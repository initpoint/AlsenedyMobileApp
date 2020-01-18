import 'dart:convert';

import 'package:ecommerce_app_ui_kit/src/models/combination.dart';

class Cart {
  String id;
  String customerId;
  String customerName;
  List<String> items;
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
        items: List<String>.from(json["items"].map((x) => x)) ?? [],
        isActive: json["isActive"],
        totalPrice: json["totalPrice"],
        combinations: json['combinations'] ?? []
      );

  Map<String, dynamic> toMap() => {
        "customerId": customerId,
        "customerName": customerName,
        "items": List<dynamic>.from(items.map((x) => x)),
        "isActive": isActive,
        "totalPrice": totalPrice,
      };
}
