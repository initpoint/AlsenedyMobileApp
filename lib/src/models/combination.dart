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
  bool isActive;
  bool isNew;

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
    this.isActive,
    this.isNew,
  });

  Combination.fromMap(Map snapshot, String id) :
        id = id ?? '',
        nameAr = snapshot['nameAr'] ?? '',
        nameEn = snapshot['nameEn'] ?? '',
        descriptionAr = snapshot['descriptionAr'] ?? '',
        descriptionEn = snapshot['descriptionEn'] ?? '',
        amount = snapshot['amount'] ?? 0.0,
        price = snapshot['price'] ?? 0.0,
        rate = snapshot['rate'] ?? 0.0,
        discount = snapshot['discount'] ?? 0.0,
        photoUrl = snapshot['photoUrl'] ?? '',
        isActive = snapshot['isActive'] ?? false,
        isNew = snapshot['isNew'] ?? false;

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
      "isActive": isActive,
      "isNew": isNew,
    };
  }
}
