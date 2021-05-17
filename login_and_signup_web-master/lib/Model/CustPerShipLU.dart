class CustPerShipLU {
  int custPerShipLUID;
  int customerID;
  int custPersonID;
  int vesselID;
  int lastUpdatedBy;
  String lastUpdatedDT;

  CustPerShipLU({
    this.custPerShipLUID,
    this.customerID,
    this.custPersonID,
    this.vesselID,
    this.lastUpdatedBy,
    this.lastUpdatedDT,
  });

  factory CustPerShipLU.fromJson(Map<String, dynamic> json) {
    return CustPerShipLU(
      custPerShipLUID: json['custPerShipLUId'],
      customerID: json['customerId'],
      custPersonID: json['custPersonId'],
      vesselID: json['vesselId'],
      lastUpdatedBy: json['lastUpdatedBy'],
      lastUpdatedDT: json['lastUpdatedDt'],
    );
  }
}
