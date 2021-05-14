class DepartureInfo {
  int arrInfoID;
  int custQuoteMasterID;
  String vslCallCondtn;
  double hforob;
  double mdorob;
  double lubROB;
  double gasOilROB;
  double fwrob;
  //bool MsgSent;
  //int LastUpdatedBy;
  //String LastUpdatedDT;

  DepartureInfo({
    this.arrInfoID,
    this.custQuoteMasterID,
    this.vslCallCondtn,
    this.hforob,
    this.mdorob,
    this.lubROB,
    this.gasOilROB,
    this.fwrob,
    // this.MsgSent,
    //this.LastUpdatedBy,
    //this.LastUpdatedDT
  });

  factory DepartureInfo.fromJson(Map<String, dynamic> json) {
    return DepartureInfo(
      arrInfoID: json['arrInfoId'],
      custQuoteMasterID: json['custQuoteMasterId'],
      vslCallCondtn: json['vslCallCondtn'],
      hforob: json['hforob'],
      mdorob: json['mdorob'],
      lubROB: json['lubRob'],
      gasOilROB: json['gasOilRob'],
      fwrob: json['fwrob'],
      //MsgSent: json['MsgSent'],
      //LastUpdatedBy: json['LastUpdatedBy'],
      //  LastUpdatedDT: json['LastUpdatedDT'],
    );
  }
}
