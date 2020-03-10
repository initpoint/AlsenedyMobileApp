class Customer {
  String id = '';
  String fullName = '';
  String photoUrl = '';
  String uid = '';
  String email = '';
  String phoneNumber = '';
  String pricelist = '';
  String company;
  String debt = '';
  String credit = '';

  Customer({
    this.id,
    this.fullName,
    this.photoUrl,
    this.uid,
    this.email,
    this.company,
    this.phoneNumber,
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
        debt = snapshot['debt'].toString() ?? '',
        phoneNumber = snapshot['phoneNumber'].toString() ?? '',
        company = snapshot['company'].toString() ?? '';

  toJson() {
    return {
      "id": id,
      "name": fullName,
      "photoUrl": photoUrl,
      "uid": uid,
      "email": email,
      "debt": debt,
      "credit": credit,
      "company": company,
      "phoneNumber": phoneNumber,
      "pricelist": pricelist,
    };
  }
}
