class BillItem {
  String id = '';
  String freeQty = '';
  String basicPrice = '';
  String code = '';
  String dealerCode = '';
  String dealerName = '';
  String materialCode = '';
  String materialNameAr = '';
  String nameArFull = '';
  String pricePerUnit = '';
  String qty = '';
  String siteCode = '';
  String siteName = '';
  String tax = '';
  String totalPrice = '';
  String unitNameAr = '';

  BillItem({
    this.freeQty,
    this.basicPrice,
    this.code,
    this.dealerCode,
    this.dealerName,
    this.materialCode,
    this.materialNameAr,
    this.nameArFull,
    this.pricePerUnit,
    this.qty,
    this.siteCode,
    this.siteName,
    this.tax,
    this.totalPrice,
    this.unitNameAr,
  });

  BillItem.fromMap(Map snapshot)
      : freeQty = snapshot['freeQty'].toString() ?? '',
        basicPrice = snapshot['basicPrice'].toString() ?? '',
        code = snapshot['code'].toString() ?? '',
        dealerCode = snapshot['dealerCode'].toString() ?? '',
        dealerName = snapshot['dealerName'].toString() ?? '',
        materialCode = snapshot['materialCode'].toString() ?? '',
        materialNameAr = snapshot['materialNameAr'].toString() ?? '',
        nameArFull = snapshot['nameArFull'].toString() ?? '',
        pricePerUnit = snapshot['pricePerUnit'].toString() ?? '',
        qty = snapshot['qty'].toString() ?? '',
        siteCode = snapshot['siteCode'].toString() ?? '',
        siteName = snapshot['siteName'].toString() ?? '',
        tax = snapshot['tax'].toString() ?? '',
        totalPrice = snapshot['totalPrice'].toString() ?? '',
        unitNameAr = snapshot['unitNameAr'].toString() ?? '';
}
