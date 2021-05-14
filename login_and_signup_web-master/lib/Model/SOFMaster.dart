class SOFMaster {
  int sofmasterID;
  String softype;

  SOFMaster({
    this.sofmasterID,
    this.softype,
  });

  factory SOFMaster.fromJson(Map<String, dynamic> json) {
    return SOFMaster(
      sofmasterID: json['sofmasterId'],
      softype: json['softype'],
    );
  }
}
