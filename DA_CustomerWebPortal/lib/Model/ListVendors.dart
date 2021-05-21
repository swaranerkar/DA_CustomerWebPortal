class ListVendors {
  int vendorID;
  String vendorName;
  String vendRef;
  bool isActive;
  int lastUpdatedBy;
  String lastUpdatedDT;
  ListVendors(
      {this.vendorID,
      this.vendorName,
      this.vendRef,
      this.isActive,
      this.lastUpdatedBy,
      this.lastUpdatedDT});

  factory ListVendors.fromJson(Map<String, dynamic> json) {
    return ListVendors(
        vendorID: json['VendorId'],
        vendorName: json['VendorName'],
        vendRef: json['VendRef'],
        isActive: json['IsActive'],
        lastUpdatedBy: json['LastUpdatedBy'],
        lastUpdatedDT: json['LastUpdatedDT']);
  }
}
