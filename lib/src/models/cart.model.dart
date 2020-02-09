// import 'package:ecommerce_app_ui_kit/src/models/cart-item.model.dart';
import 'package:ecommerce_app_ui_kit/src/models/combination.dart';

class Cart {
  String id;
  String customerId;
  String customerName;
  List items;
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

  factory Cart.fromMap(Map<String, dynamic> json, String id) {
    // List<CartItem>.from(json["items"]);
      // var list = json['items'].map((x) => CartItem.fromMap(x)).toList();
      // print(list);
      // var itemsTo = list.map((x)  {
      //   print('xxxxxxxxxxxxxxx');
      //   print(x);
      //   return CartItem.fromMap(x);
      // });
      
      // print(list.runtimeType); //returns List<dynamic>
    return  Cart(
      id: id ?? '',
      customerId: json["customerId"],
      customerName: json["customerName"],
      items: json["items"],
      isActive: json["isActive"],
      totalPrice: json["totalPrice"],
      combinations: json['combinations'] ?? []);
  }

  Map<String, dynamic> toMap() {
    // List<Map> mappedItems = this.items != null ? this.items.map((i) => i.toMap()).toList() : null;
    return {
      "customerId": customerId,
      "customerName": customerName,
      "items": items,
      "isActive": isActive,
      "totalPrice": totalPrice,
    };
  }
}
