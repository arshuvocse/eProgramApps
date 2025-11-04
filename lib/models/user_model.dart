
class User {
  final int userId;
  final int empInfoId;
  final String userName;
  final String empMasterCode;
  final String userType;
  final String loginName;
  final String password;
  final String userEmail;
  final String contactInfo;
  final String userCo;
  final int roleTypeId;
  final bool isApprove;
  final bool isForward;
  final String roleType;
  final int isImeiMatched;
  final String versionName;
  final String? shiftStartTime;
  final String? shiftEndTime;
  final bool isTrackEnable;
  final String empRole;
  final String desigName;
  final String? twoDeviceMsg;

  User({
    required this.userId,
    required this.empInfoId,
    required this.userName,
    required this.empMasterCode,
    required this.userType,
    required this.loginName,
    required this.password,
    required this.userEmail,
    required this.contactInfo,
    required this.userCo,
    required this.roleTypeId,
    required this.isApprove,
    required this.isForward,
    required this.roleType,
    required this.isImeiMatched,
    required this.versionName,
    this.shiftStartTime,
    this.shiftEndTime,
    required this.isTrackEnable,
    required this.empRole,
    required this.desigName,
    this.twoDeviceMsg,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['UserId'],
      empInfoId: json['EmpInfoId'],
      userName: json['UserName'],
      empMasterCode: json['EmpMasterCode'],
      userType: json['UserType'],
      loginName: json['LoginName'],
      password: json['Password'],
      userEmail: json['UserEmail'],
      contactInfo: json['ContactInfo'],
      userCo: json['UserCo'],
      roleTypeId: json['RoleTypeId'],
      isApprove: json['IsApprove'],
      isForward: json['IsForward'],
      roleType: json['RoleType'],
      isImeiMatched: json['IsImeiMatched'],
      versionName: json['VersionName'],
      shiftStartTime: json['ShiftStartTime'],
      shiftEndTime: json['ShiftEndTime'],
      isTrackEnable: json['IsTrackEnable'],
      empRole: json['EmpRole'],
      desigName: json['DesigName'],
      twoDeviceMsg: json['TwoDeviceMsg'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'UserId': userId,
      'EmpInfoId': empInfoId,
      'UserName': userName,
      'EmpMasterCode': empMasterCode,
      'UserType': userType,
      'LoginName': loginName,
      'Password': password,
      'UserEmail': userEmail,
      'ContactInfo': contactInfo,
      'UserCo': userCo,
      'RoleTypeId': roleTypeId,
      'IsApprove': isApprove ? 1 : 0,
      'IsForward': isForward ? 1 : 0,
      'RoleType': roleType,
      'IsImeiMatched': isImeiMatched,
      'VersionName': versionName,
      'ShiftStartTime': shiftStartTime,
      'ShiftEndTime': shiftEndTime,
      'IsTrackEnable': isTrackEnable ? 1 : 0,
      'EmpRole': empRole,
      'DesigName': desigName,
      'TwoDeviceMsg': twoDeviceMsg,
    };
  }
}
