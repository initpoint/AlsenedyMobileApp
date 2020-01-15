import 'dart:convert';

class Cart {
  String id;
  String customerId;
  String customerName;
  List<String> items;
  bool isActive;

  Cart({
    this.id,
    this.customerId,
    this.customerName,
    this.items,
    this.isActive,
  });

  factory Cart.fromMap(Map<String, dynamic> json, String id) => Cart(
        id: id ?? '',
        customerId: json["customerId"],
        customerName: json["customerName"],
        items: List<String>.from(json["items"].map((x) => x)),
        isActive: json["isActive"],
      );

  Map<String, dynamic> toMap() => {
        "customerId": customerId,
        "customerName": customerName,
        "items": List<dynamic>.from(items.map((x) => x)),
        "isActive": isActive,
      };
}
