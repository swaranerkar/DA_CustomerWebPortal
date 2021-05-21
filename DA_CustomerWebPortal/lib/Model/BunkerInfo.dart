class BunkerInfo {
  int bunkerInfoID;
  int custQuoteMasterID;
  double hforecd;
  double mdorecd;
  double gasOilRecd;
  double fwrecd;
  // bool msgSent;
  //int lastUpdatedBy;
  //String lastUpdatedDT;

  BunkerInfo({
    this.bunkerInfoID,
    this.custQuoteMasterID,
    this.hforecd,
    this.mdorecd,
    this.gasOilRecd,
    this.fwrecd,
    //this.msgSent,
    //this.lastUpdatedBy,
    //this.lastUpdatedDT
  });

  factory BunkerInfo.fromJson(Map<String, dynamic> json) {
    return BunkerInfo(
      bunkerInfoID: json['bunkerInfoId'],
      custQuoteMasterID: json['custQuoteMasterId'],
      hforecd: json['hforecd'],
      mdorecd: json['mdorecd'],
      gasOilRecd: json['gasOilRecd'],
      fwrecd: json['fwrecd'],
      //    msgSent: json['msgSent'],
      //  lastUpdatedBy: json['lastUpdatedBy'],
      // lastUpdatedDT: json['lastUpdatedDT'],
    );
  }
}
