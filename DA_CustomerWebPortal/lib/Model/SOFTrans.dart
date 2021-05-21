class SOFTrans {
  int softransID;
  int custQuoteMasterID;
  int sofmasterID;
  String softransDate;
  String softransRemarks;
  int lastUpdatedBy;
  String lastUpdatedDT;
  bool isActive;
  String sofmasterDesc;

  SOFTrans({
    this.softransID,
    this.custQuoteMasterID,
    this.sofmasterID,
    this.softransDate,
    this.softransRemarks,
    this.lastUpdatedBy,
    this.lastUpdatedDT,
    this.isActive,
    this.sofmasterDesc,
  });

  factory SOFTrans.fromJson(Map<String, dynamic> json) {
    return SOFTrans(
      softransID: json['softransId'],
      custQuoteMasterID: json['custQuoteMasterId'],
      sofmasterID: json['sofmasterId'],
      softransDate: json['softransDate'],
      softransRemarks: json['softransRemarks'],
      lastUpdatedBy: json['lastUpdatedBy'],
      lastUpdatedDT: json['lastUpdatedDT'],
      isActive: json['isActive'],
    );
  }
}
