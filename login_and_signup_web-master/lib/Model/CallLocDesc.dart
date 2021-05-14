class CallLocDesc {
  int callLocID;
  String callLocDesc;
  bool isActive;

  CallLocDesc({this.callLocID, this.callLocDesc, this.isActive});

  factory CallLocDesc.fromJson(Map<String, dynamic> json) {
    return CallLocDesc(
      callLocID: json['callLocId'],
      callLocDesc: json['callLocDesc'],
      isActive: json['isActive'],
    );
  }
}
