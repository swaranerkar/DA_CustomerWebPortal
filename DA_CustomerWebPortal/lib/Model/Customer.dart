class Customer {
  int customerID;
  String customerName;
  String customerRef;
  bool isActive;
  int lastUpdatedBy;
  String lastUpdatedDT;

  Customer({
    this.customerID,
    this.customerName,
    this.customerRef,
    this.isActive,
    this.lastUpdatedBy,
    this.lastUpdatedDT,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerID: json['customerId'],
      customerName: json['customerName'],
      customerRef: json['customerRef'],
      isActive: json['isActive'],
      lastUpdatedBy: json['lastUpdatedBy'],
      lastUpdatedDT: json['lastUpdatedDt'],
    );
  }
}
