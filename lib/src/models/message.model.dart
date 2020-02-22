class Message {
  String id;
  String customerId;
  String text;
  int createdAt;
  String customerName;
  String sender;
  String userId;
  Message({
    this.id,
    this.customerId,
    this.text,
    this.createdAt,
    this.customerName,
    this.sender,
    this.userId
  });

  Message.fromMap(Map snapshot, String id) :
        id = id ?? '',
        customerId = snapshot['customerId'] ?? '',
        text = snapshot['text'] ?? '',
        createdAt = snapshot['createdAt'] ?? 0,
        customerName = snapshot['customerName'] ?? '',
        sender = snapshot['sender'] ?? '',
        userId = snapshot['userId'] ?? '';
  toJson() {
    return {
      "id": id,
      "customerId": customerId,
      "text": text,
      "createdAt": createdAt,
      "customerName": customerName,
      "sender": sender,
      "userId": userId,
    };
  }
}
