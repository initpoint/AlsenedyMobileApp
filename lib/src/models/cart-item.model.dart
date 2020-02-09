class CartItem {
  String code;
  String name;
  int qty;
  int shippedQty;

  CartItem({this.code, this.name, this.qty, this.shippedQty});

  factory CartItem.fromMap(Map<String, dynamic> json) => CartItem(
      code: json["code"] ?? '',
      name: json["name"],
      qty: json["qty"],
      shippedQty: json['shippedQty']);

  Map<String, dynamic> toMap() =>
      {"code": code, "name": name, "qty": qty, "shippedQty": shippedQty};
}

class CartItemsList {
  final List<CartItem> cartItems;
  CartItemsList({
    this.cartItems,
  });

  factory CartItemsList.fromJson(List<dynamic> parsedJson) {
    List<CartItem> cartItems = new List<CartItem>();
    return new CartItemsList(
      cartItems: cartItems,
    );
  }
}
