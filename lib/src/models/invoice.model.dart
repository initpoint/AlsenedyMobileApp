class Invoice {
  String id = '';
  String date = '';
  String dateH = '';
  String description = '';
  String debt = '';
  String credit = '';
  String account = '';
  String refNumber = '';
  String typeCode = '';
  String typeName = '';
  String siteCode = '';
  String siteName = '';

  Invoice({
    this.date,
    this.dateH,
    this.description,
    this.debt,
    this.credit,
    this.account,
    this.refNumber,
    this.typeCode,
    this.typeName,
    this.siteCode,
    this.siteName,
  });

  Invoice.fromMap(Map snapshot, String id)
      : id = id ?? '',
        date = snapshot['date'].toString() ?? '',
        dateH = snapshot['dateH'].toString() ?? '',
        description = snapshot['description'].toString() ?? '',
        debt = snapshot['debt'].toString() ?? '',
        credit = snapshot['credit'].toString() ?? '',
        account = snapshot['account'].toString() ?? '',
        refNumber = snapshot['refNumber'].toString() ?? '',
        typeCode = snapshot['typeCode'].toString() ?? '',
        typeName = snapshot['typeName'].toString() ?? '',
        siteCode = snapshot['siteCode'].toString() ?? '',
        siteName = snapshot['siteName'].toString() ?? '';
}
