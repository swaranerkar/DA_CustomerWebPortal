class CTMTrans {
  int ctmtransID;
  int custQuoteMasterID;
  //String vslCallCondtn;
  double ctmamtReq;
  String ctmcurrency;
  String ctmdeliveryDate;
  bool ctmdelivered;
  double ctmdelAmt;
  bool ctminfOps;
  //int lastUpdatedBy;
  //String lastUpdatedDT;

  CTMTrans({
    this.ctmtransID,
    this.custQuoteMasterID,
    this.ctmamtReq,
    this.ctmcurrency,
    this.ctmdeliveryDate,
    this.ctmdelivered,
    this.ctmdelAmt,
    this.ctminfOps,
    //this.lastUpdatedBy,
    //  this.lastUpdatedDT
  });

  factory CTMTrans.fromJson(Map<String, dynamic> json) {
    return CTMTrans(
      ctmtransID: json['ctmtransId'],
      custQuoteMasterID: json['custQuoteMasterId'],
      ctmamtReq: json['ctmamtReq'],
      ctmcurrency: json['ctmcurrency'],
      ctmdeliveryDate: json['ctmdeliveryDate'],
      ctmdelivered: json['ctmdelivered'],
      ctmdelAmt: json['ctmdelAmt'],
      ctminfOps: json['ctminfOps'],
      //LastUpdatedBy: json['lastUpdatedBy'],
      // LastUpdatedDT: json['lastUpdatedDT'],
    );
  }
}
