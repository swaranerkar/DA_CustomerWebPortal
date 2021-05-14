class ListBillActTrans {
  int cqmtransID;
  int cqmtransTypeID;
  int custQuoteMasterID;
  bool statusID;
  String cqmtransTypeDesc; //activity type
  String cqmtransDate;
  String cqmpurpose; //remarks
  int qty;
  String unitsDesc;
  int vendorID;
  String vendorName;
  String vendRef;
  String transStatus;
  bool IsActive;

  ListBillActTrans(
      {this.cqmtransID,
      this.cqmtransTypeID,
      this.custQuoteMasterID,
      this.statusID,
      this.cqmtransTypeDesc,
      this.cqmtransDate,
      this.cqmpurpose,
      this.qty,
      this.unitsDesc,
      this.vendorID,
      this.vendorName,
      this.vendRef,
      this.transStatus,
      this.IsActive});

  factory ListBillActTrans.fromJson(Map<String, dynamic> json) {
    return ListBillActTrans(
      cqmtransID: json['cqmtransId'],
      cqmtransTypeID: json['cqmtransTypeId'],
      custQuoteMasterID: json['custQuoteMasterId'],
      statusID: json['statusId'],
      cqmtransTypeDesc: json['cqmtransTypeDesc'],
      cqmtransDate: json['cqmtransDate'],
      cqmpurpose: json['cqmpurpose'],
      qty: json['qty'],
      unitsDesc: json['unitsDesc'],
      vendorID: json['vendorId'],
      vendorName: json['vendorName'],
      vendRef: json['vendRef'],
      transStatus: json['transStatus'],
      IsActive: json['isActive'],
    );
  }
  Map<String, dynamic> toJson() => {
        "cqmtransId": cqmtransID,
        "cqmtransTypeId": cqmtransTypeID,
        "custQuoteMasterId": custQuoteMasterID,
        "statusID": statusID,
        "cqmtransTypeDesc": cqmtransTypeDesc,
        "cqmtransDate": cqmtransDate,
        "cqmpurpose": cqmpurpose,
        "qty": qty,
        "unitsDesc": unitsDesc,
        "vendorId": vendorID,
        "vendorName": vendorName,
        "vendRef": vendRef,
        "transStatus": transStatus,
        "isActive": IsActive,
      };
}
