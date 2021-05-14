class ListVoyFiles {
  int custQuoteMasterID;
  int vesselID;
  int customerID;
  int callLocID;
  String vslETA;
  String vslETD;
  String dareference;
  String custShipName;
  //String custShipIMO;
  //String custShipFlag;
  String customerName;
  String customerRef;
  String purposeCall;
  String agencyTypeDesc;
  int assignedTo;
  //bool ordered;
  //bool closedVoyage;
  //bool approvedVoyage;
  //String emailAdd;
  //String ccemailAdd;
  //int userSON;
  //int userSOFF;
  //String custVoyLastPort;
  //String custVoyNextPort;
  int lastUpdatedBy;
  String lastUpdatedDT;

  ListVoyFiles({
    this.custQuoteMasterID,
    this.vesselID,
    this.customerID,
    this.callLocID,
    this.vslETA,
    this.vslETD,
    this.dareference,
    this.custShipName,
    // this.custShipIMO,
    // this.custShipFlag,
    this.customerName,
    this.customerRef,
    this.purposeCall,
    this.agencyTypeDesc,
    this.assignedTo,
    //  this.ordered,
    // this.closedVoyage,
    // this.approvedVoyage,
    // this.emailAdd,
    // this.ccemailAdd,
    // this.userSON,
    //this.userSOFF,
    // this.custVoyLastPort,
    // this.custVoyNextPort,
    this.lastUpdatedBy,
    this.lastUpdatedDT,
  });

  factory ListVoyFiles.fromJson(Map<String, dynamic> json) {
    return ListVoyFiles(
      custQuoteMasterID: json['custQuoteMasterId'],
      vesselID: json['vesselId'],
      customerID: json['customerId'],
      callLocID: json['callLocId'],
      vslETA: json['vslEta'],
      vslETD: json['vslEtd'],
      dareference: json['dareference'],
      custShipName: json['custShipName'],
      // custShipIMO: json['custShipIMO'],
      // custShipFlag: json['custShipFlag'],
      customerName: json['customerName'],
      customerRef: json['customerRef'],
      purposeCall: json['purposeCall'],
      agencyTypeDesc: json['agencyTypeDesc'],
      assignedTo: json['assignedTo'],
      // ordered: json['ordered'],
      // closedVoyage: json['closedVoyage'],
      // approvedVoyage: json['approvedVoyage'],
      // emailAdd: json['emailAdd'],
      // ccemailAdd: json['ccemailAdd'],
      // userSON: json['userSON'],
      //userSOFF: json['userSOFF'],
      //custVoyLastPort: json['custVoyLastPort'],
      // custVoyNextPort: json['custVoyNextPort'],
      lastUpdatedBy: json['lastUpdatedBy'],
      lastUpdatedDT: json['lastUpdatedDt'],
    );
  }
}
