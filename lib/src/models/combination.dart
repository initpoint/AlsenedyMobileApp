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
  dynamic prices;
  List<String> pics;
  String barCodeId;
  String code;
  bool hasChildren;
  String headId;
  String materialCode;
  String materialNameAr;
  String nameArFull;
  String unitCode;
  String unitNameAr;

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
    this.prices,
    this.pics,
    this.barCodeId,
    this.code,
    this.hasChildren,
    this.headId,
    this.materialCode,
    this.materialNameAr,
    this.nameArFull,
    this.unitCode,
    this.unitNameAr
  });

  Combination.fromMap(Map snapshot, String id) :
        id = id ?? '',
        nameAr = snapshot['nameAr'] ?? 'default name',
        nameEn = snapshot['nameEn'] ?? '',
        descriptionAr = snapshot['descriptionAr'] ?? '',
        descriptionEn = snapshot['descriptionEn'] ?? '',
        amount = snapshot['amount'] ?? 0.0,
        price = snapshot['price'] ?? 0.0,
        rate = snapshot['rate'] ?? 0.0,
        discount = snapshot['discount'] ?? 0.0,
        photoUrl = snapshot['photoUrl'] ?? '',
        isActive = snapshot['isActive'] ?? false,
        pics = snapshot['pics']?.cast<String>() ?? [],
        isNew = snapshot['isNew'] ?? false,
        prices = snapshot['prices'] ?? [],
        barCodeId = snapshot['barCodeId'] ?? '',
        code = snapshot['code'] ?? '',
        hasChildren = snapshot['hasChildren'] ?? '',
        headId = snapshot['headId'] ?? '',
        materialCode = snapshot['materialCode'] ?? '',
        materialNameAr = snapshot['materialNameAr'] ?? '',
        nameArFull = snapshot['nameArFull'] ?? '',
        unitCode = snapshot['unitCode'] ?? '',
        unitNameAr = snapshot['unitNameA'] ?? '';

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
      "pics": pics,
    };
  }
}
