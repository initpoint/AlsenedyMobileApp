class Customer {
  String id = '';
  String fullName = '';
  String photoUrl = '';
  String uid = '';
  String email = '';
  String pricelist;
  String debt = '';
  String credit = '';

  Customer({
    this.id,
    this.fullName,
    this.photoUrl,
    this.uid,
    this.email,
    this.pricelist,
    this.debt,
    this.credit
  });

  Customer.fromMap(Map snapshot, String id) :
        id = id ?? '',
        fullName = snapshot['name'] ?? '',
        photoUrl = snapshot['photoUrl'] ?? '',
        uid = snapshot['uid'] ?? '',
        pricelist = snapshot['pricelist'] ?? '',
        email = snapshot['email'] ?? '',
        credit = snapshot['credit'].toString() ?? '',
        debt = snapshot['debt'].toString() ?? '';

  toJson() {
    return {
      "id": id,
      "name": fullName,
      "photoUrl": photoUrl,
      "uid": uid,
      "email": email,
    };
  }
}
