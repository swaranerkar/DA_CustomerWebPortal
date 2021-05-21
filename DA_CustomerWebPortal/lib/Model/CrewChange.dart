class CrewChange {
  int crewChangeID;
  int custQuoteMasterID;
  int signOn;
  int signOff;
  String remarks;
  //int lastUpdatedBy;
  //String lastUpdatedDT;

  CrewChange({
    this.crewChangeID,
    this.custQuoteMasterID,
    this.signOn,
    this.signOff,
    this.remarks,
    //  this.lastUpdatedBy,
    //this.lastUpdatedDT,
  });

  factory CrewChange.fromJson(Map<String, dynamic> json) {
    return CrewChange(
      crewChangeID: json['crewChangeId'],
      custQuoteMasterID: json['custQuoteMasterId'],
      signOn: json['signOn'],
      signOff: json['signOff'],
      remarks: json['remarks'],
      //    lastUpdatedBy: json['lastUpdatedBy'],
      //  lastUpdatedDT: json['lastUpdatedDT'],
    );
  }
}
