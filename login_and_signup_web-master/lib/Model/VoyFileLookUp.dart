class VoyFileLookUp {
  int voyFileLookUpID;
  int custQuoteMasterID;
  int userID;

  VoyFileLookUp({this.voyFileLookUpID, this.custQuoteMasterID, this.userID});

  factory VoyFileLookUp.fromJson(Map<String, dynamic> json) {
    return VoyFileLookUp(
      voyFileLookUpID: json['voyFileLookUpId'],
      custQuoteMasterID: json['custQuoteMasterId'],
      userID: json['userId'],
    );
  }
}
