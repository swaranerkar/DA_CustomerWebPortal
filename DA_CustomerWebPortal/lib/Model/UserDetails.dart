class UserDetails {
  int userID;
  String fullName;
  String userShortName;
  String logonName;
  String password;
  String mobileNumber;
  String imeino;
  String deviceID;
  String emailID;
  bool isActive;
  UserDetails({
    this.userID,
    this.fullName,
    this.userShortName,
    this.logonName,
    this.password,
    this.mobileNumber,
    this.imeino,
    this.deviceID,
    this.emailID,
    this.isActive,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      userID: json['userId'],
      fullName: json['fullName'],
      userShortName: json['userShortName'],
      logonName: json['logonName'],
      password: json['password'],
      mobileNumber: json['mobileNumber'],
      imeino: json['imeino'],
      deviceID: json['deviceId'],
      emailID: json['emailId'],
      isActive: json['isActive'],
    );
  }
}
