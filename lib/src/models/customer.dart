class Customer {
  String id = '';
  String fullName = '';
  String photoUrl = '';
  String uid = '';
  String email = '';
  String pricelist;

  Customer({
    this.id,
    this.fullName,
    this.photoUrl,
    this.uid,
    this.email,
    this.pricelist
  });

  Customer.fromMap(Map snapshot, String id) :
        id = id ?? '',
        fullName = snapshot['fullName'] ?? '',
        photoUrl = snapshot['photoUrl'] ?? '',
        uid = snapshot['uid'] ?? '',
        pricelist = snapshot['pricelist'] ?? '',
        email = snapshot['email'] ?? '';

  toJson() {
    return {
      "id": id,
      "fullName": fullName,
      "photoUrl": photoUrl,
      "uid": uid,
      "email": email,
    };
  }
}
