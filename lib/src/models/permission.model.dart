class Permission {
  String id;
  String customerId;
  String customerName;
  bool isActive;
  List<String> items;

  Permission({
    this.id,
    this.customerId,
    this.customerName,
    this.isActive,
    this.items,
  });

  factory Permission.fromMap(Map<String, dynamic> json, String id) =>
      Permission(
        id: id ?? '',
        customerId: json["customerId"] ?? '',
        customerName: json["customerName"] ?? '',
        isActive: json["isActive"] ?? false,
        items: List<String>.from(json["items"].map((x) => x)) ?? [],
      );

  Map<String, dynamic> toMap() => {
        "customerId": customerId,
        "customerName": customerName,
        "isActive": isActive,
        "items": List<dynamic>.from(items.map((x) => x)),
      };
}
