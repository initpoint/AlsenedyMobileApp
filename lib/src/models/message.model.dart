class Message {
  String id;
  String customerId;
  String text;
  String customerName;
  String sender;
  String userId;
  DateTime createDate;

  Message({
    this.id,
    this.customerId,
    this.text,
    this.customerName,
    this.sender,
    this.userId,
    this.createDate
  });

  Message.fromMap(Map snapshot, String id) :
        id = id ?? '',
        customerId = snapshot['customerId'] ?? '',
        text = snapshot['text'] ?? '',
        customerName = snapshot['customerName'] ?? '',
        sender = snapshot['sender'] ?? '',
        userId = snapshot['userId'] ?? '',
        createDate = DateTime.parse(snapshot['createDate'] ?? '1974-03-20 00:00:00.000') ?? DateTime.now().toString();
  toJson() {
    return {
      "customerId": customerId,
      "text": text,
      "customerName": customerName,
      "sender": sender,
      "createDate": DateTime.now().toString()
    };
  }
}
