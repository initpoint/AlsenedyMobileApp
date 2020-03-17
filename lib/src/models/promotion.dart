class Promotion {
  String id;
  String promotionType;
  String validFrom;
  String validTo;
  String disCountType;
  String disCountPercentage;
  String disCountAmount;
  String notes;
  String priceListNameAr;
  String nameArFull;
  String materialDiscountType;
  String materialDiscountPercentage;
  String materialDiscountAmount;

  Promotion(
      {this.id,
      this.promotionType,
      this.validFrom,
      this.validTo,
      this.disCountType,
      this.disCountPercentage,
      this.disCountAmount,
      this.notes,
      this.nameArFull,
      this.materialDiscountType,
      this.materialDiscountPercentage,
      this.materialDiscountAmount,
      this.priceListNameAr});

  Promotion.fromMap(Map snapshot, String id)
      : id = id ?? '',
        promotionType = snapshot['promotionType'] ?? '',
        validFrom = snapshot['validFrom'] ?? '',
        validTo = snapshot['validTo'] ?? '',
        disCountType = snapshot['disCountType'] ?? '',
        disCountPercentage = snapshot['disCountPercentage'] ?? '',
        disCountAmount = snapshot['disCountAmount'] ?? '',
        notes = snapshot['notes'] ?? '',
        priceListNameAr = snapshot['priceListNameAr'] ?? '',
        materialDiscountType = snapshot['materialDiscountType'] ?? '',
        materialDiscountPercentage = snapshot['materialDiscountPercentage'].toString() ?? '',
        materialDiscountAmount = snapshot['materialDiscountAmount'].toString() ?? '',
        nameArFull = snapshot['nameArFull'] ?? '';
}
