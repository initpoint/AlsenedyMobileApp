class Combination {
  String id;
  String nameAr;
  String nameEn;
  String descriptionAr;
  String descriptionEn;
  double amount;
  double price;
  double rate;
  double discount;
  String photoUrl;
  bool active;

  Combination({
    this.id,
    this.nameAr,
    this.nameEn,
    this.descriptionAr,
    this.descriptionEn,
    this.amount,
    this.price,
    this.rate,
    this.discount,
    this.photoUrl,
    this.active,
  });

  Combination.fromMap(Map snapshot, String id) :
        id = id ?? '',
        nameAr = snapshot['nameAr'] ?? '',
        nameEn = snapshot['nameEn'] ?? '',
        descriptionAr = snapshot['descriptionAr'] ?? '',
        descriptionEn = snapshot['descriptionEn'] ?? '',
        amount = snapshot['amount'].toDouble() ?? 0.0,
        price = snapshot['price'].toDouble() ?? 0.0,
        rate = snapshot['rate'].toDouble() ?? 0.0,
        discount = snapshot['discount'].toDouble() ?? 0.0,
        photoUrl = snapshot['photoUrl'] ?? '',
        active = snapshot['active'] ?? false;

  toJson() {
    return {
      "id": id,
      "nameAr": nameAr,
      "nameEn": nameEn,
      "descriptionAr": descriptionAr,
      "descriptionEn": descriptionEn,
      "amount": amount,
      "price": price,
      "rate": rate,
      "discount": discount,
      "photoUrl": photoUrl,
      "active": active,
    };
  }
}
