class ListDAActType {
  int cqmtransTypeID;
  String cqmtransTypeDesc;
  int zQuoteItemID;
  int nUnitID;
  String unitsDesc;
  int zVendTypeID;

  ListDAActType(
      {this.cqmtransTypeID,
      this.cqmtransTypeDesc,
      this.zQuoteItemID,
      this.nUnitID,
      this.unitsDesc,
      this.zVendTypeID});

  factory ListDAActType.fromJson(Map<String, dynamic> json) {
    return ListDAActType(
        cqmtransTypeID: json['cqmtransTypeId'],
        cqmtransTypeDesc: json['cqmtransTypeDesc'],
        zQuoteItemID: json['zQuoteItemId'],
        nUnitID: json['nUnitId'],
        unitsDesc: json['unitsDesc'],
        zVendTypeID: json['zVendTypeId']);
  }
}
