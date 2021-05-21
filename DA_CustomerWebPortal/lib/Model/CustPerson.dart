class CustPerson {
  int custPersonID;
  String custPersonFullName;
  String custPersonDesignation;
  String custPersonTelMob;
  String custPersonEmail;
  int customerID;
  String cPerUName;
  String cPerPwd;
  bool isActive;
  int lastUpdatedBy;
  String lastUpdatedDT;

  CustPerson({
    this.custPersonID,
    this.custPersonFullName,
    this.custPersonDesignation,
    this.custPersonTelMob,
    this.custPersonEmail,
    this.customerID,
    this.cPerUName,
    this.cPerPwd,
    this.isActive,
    this.lastUpdatedBy,
    this.lastUpdatedDT,
  });

  factory CustPerson.fromJson(Map<String, dynamic> json) {
    return CustPerson(
      custPersonID: json['custPersonId'],
      custPersonFullName: json['custPersonFullName'],
      custPersonDesignation: json['custPersonDesignation'],
      custPersonTelMob: json['custPersonTelMob'],
      custPersonEmail: json['custPersonEmail'],
      customerID: json['customerId'],
      cPerUName: json['cPerUName'],
      cPerPwd: json['cPerPwd'],
      isActive: json['isActive'],
      lastUpdatedBy: json['lastUpdatedBy'],
      lastUpdatedDT: json['lastUpdatedDt'],
    );
  }
}
