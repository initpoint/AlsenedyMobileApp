import 'package:ecommerce_app_ui_kit/src/models/bill_item.model.dart';

class Bill {
  String id = '';
  String createDate = '';
  String customerId = '';
  List<BillItem> items = [];

  Bill({
    this.createDate,
    this.customerId,
    this.items
  });

  Bill.fromMap(Map snapshot, String id)
      : id = id ?? '',
        createDate = snapshot['createDate'].toString() ?? '',
        customerId = snapshot['customerId'].toString() ?? '',
        items = parseBillItem(snapshot) ?? [];

  static List<BillItem> parseBillItem(billItemJson) {
    var list = billItemJson['items'] as List;
    List<BillItem> billItems = list.map((data) => BillItem.fromMap(data)).toList();
    return billItems;
  }
}
