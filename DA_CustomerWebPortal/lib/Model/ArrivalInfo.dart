class ArrivalInfo {
  int arrInfoID;
  int custQuoteMasterID;
  String vslCallCondtn;
  double hforob;
  double mdorob;
  double lubROB;
  double gasOilROB;
  double fwrob;
  //bool msgSent;
  //int lastUpdatedBy;
  //String lastUpdatedDT;

  ArrivalInfo({
    this.arrInfoID,
    this.custQuoteMasterID,
    this.vslCallCondtn,
    this.hforob,
    this.mdorob,
    this.lubROB,
    this.gasOilROB,
    this.fwrob,
    //this.msgSent,
    //this.lastUpdatedBy,
    //this.lastUpdatedDT
  });

  factory ArrivalInfo.fromJson(Map<String, dynamic> json) {
    return ArrivalInfo(
      arrInfoID: json['arrInfoId'],
      custQuoteMasterID: json['custQuoteMasterId'],
      vslCallCondtn: json['vslCallCondtn'],
      hforob: json['hforob'],
      mdorob: json['mdorob'],
      lubROB: json['lubRob'],
      gasOilROB: json['gasOilRob'],
      fwrob: json['fwrob'],
      //msgSent: json['msgSent'],
      //lastUpdatedBy: json['lastUpdatedBy'],
      //lastUpdatedDT: json['lastUpdatedDT'],
    );
  }
}
