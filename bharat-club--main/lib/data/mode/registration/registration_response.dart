import 'original.dart';


class RegistrationResponse {
  RegistrationResponse({
    this.error,
    this.statusCode,
    this.statusMessage,
    this.data,
    this.responseTime,
  });

  RegistrationResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data = json['data'] != null
        ? RegistrationData.fromJson(json['data'])
        : null;
    responseTime = json['responseTime'];
  }

  bool? error;
  int? statusCode;
  String? statusMessage;
  RegistrationData? data;
  int? responseTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['statusCode'] = statusCode;
    map['statusMessage'] = statusMessage;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['responseTime'] = responseTime;
    return map;
  }
}


class RegistrationData {
  RegistrationData({this.token, this.user, this.tokenType, this.expiresIn});

  RegistrationData.fromJson(dynamic json) {
    token = json['token'];
    user = json['user'] != null
        ? RegistrationUser.fromJson(json['user'])
        : null;
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }

  String? token;
  RegistrationUser? user;

  String? tokenType;
  int? expiresIn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token_type'] = tokenType;
    map['expires_in'] = expiresIn;
    return map;
  }
}

class RegistrationUser {
  RegistrationUser({
    this.id,
    this.name,
    this.membershipType,
    this.membershipId,
    this.childOne,
    this.childTwo,
    this.childThree,
    this.childFour,
    this.membershipStartDate,
    this.membershipEndDate,
    this.mobile,
    this.isPoc,
    this.isProfileInfo,
    this.isBasicDetails,
    this.email,
    this.organization,
    this.userType,
    this.loginType,
    this.status,
    this.firstName,
    this.lastName,
    this.pocFirstName,
    this.pocLastName,
    this.pocEmail,
    this.pocMobile,
    this.companyName,
    this.companyWebsite,
    this.designation,
    this.location,
    this.linkedinUrl,
    this.loginStatus,
    this.joinMemberShip,
    this.original,
    this.adminFlag,
    this.membershipTypeID,
    this.userAttachments,
  });

  RegistrationUser.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    membershipType = json['membership_type'];
    membershipId = json['membership_id'];
    childOne = json['child_one'];
    childTwo = json['child_two'];
    childThree = json['child_three'];
    childFour = json['child_four'];
    membershipStartDate = json['membership_start_date'];
    membershipEndDate = json['membership_end_date'];
    mobile = json['mobile'];
    email = json['email'];
    organization = json['mobileapp'];
    userType = json['user_type'];
    loginType = json['login_type'];
    status = json['status'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    pocFirstName = json['poc_first_name'];
    pocLastName = json['poc_last_name'];
    pocEmail = json['poc_email'];
    pocMobile = json['poc_mobile'];
    companyName = json['company_name'];
    companyWebsite = json['company_website'];
    designation = json['designation'];
    location = json['location'];
    isPoc = json['is_poc'] ?? 0;
    isBasicDetails = json['is_basicdetails'] ?? 0;
    isProfileInfo = json['is_profile_info'] ?? 0;
    linkedinUrl = json['linkedin_url'];
    loginStatus = json['login_status'] ?? 0;
    joinMemberShip = json['join_member_ship'];
    original = json['original'] != null
        ? OriginalData.fromJson(json['original'])
        : null;
    adminFlag = json['admin_flag'];
    membershipTypeID = json['membership_type_id'];

    if (json['user_attachments'] != null) {
      userAttachments = [];
      json['user_attachments'].forEach((v) {
        userAttachments?.add(UserAttachments.fromJson(v));
      });
    }
  }

  int? id;
  String? name;
  String? mobile;
  String? email;
  String? organization;
  String? userType;
  String? loginType;
  int? status;
  String? firstName;
  String? lastName;
  String? pocFirstName;
  String? pocLastName;
  String? pocEmail;
  String? pocMobile;
  String? companyName;
  String? membershipType;
  String? membershipId;
  String? childOne;
  String? childTwo;
  String? childThree;
  String? childFour;
  String? membershipStartDate;
  String? membershipEndDate;
  String? companyWebsite;
  String? designation;
  String? location;
  String? linkedinUrl;
  int? loginStatus;
  String? joinMemberShip;
  int? isPoc;
  int? isBasicDetails;
  int? isProfileInfo;
  OriginalData? original;
  int? adminFlag;
  int? membershipTypeID;
  List<UserAttachments>? userAttachments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['mobile'] = mobile;
    map['is_poc'] = isPoc;
    map['is_basicdetails'] = isBasicDetails;
    map['is_profile_info'] = isProfileInfo;
    map['email'] = email;
    map['mobileapp'] = organization;
    map['user_type'] = userType;
    map['login_type'] = loginType;
    map['status'] = status;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['poc_first_name'] = pocFirstName;
    map['poc_last_name'] = pocLastName;
    map['poc_email'] = pocEmail;
    map['membership_type'] = membershipType;
    map['membership_id'] = membershipId;
    map['child_one'] = childOne;
    map['child_two'] = childTwo;
    map['child_three'] = childThree;
    map['child_four'] = childFour;
    map['membership_start_date'] = membershipStartDate;
    map['membership_end_date'] = membershipEndDate;
    map['poc_mobile'] = pocMobile;
    map['company_name'] = companyName;
    map['company_website'] = companyWebsite;
    map['designation'] = designation;
    map['location'] = location;
    map['linkedin_url'] = linkedinUrl;
    map['login_status'] = loginStatus;
    map['join_member_ship'] = joinMemberShip;
    map['admin_flag'] = adminFlag;
    map['membership_type_id'] = membershipTypeID;
    if (original != null) {
      map['original'] = original?.toJson();
    }
    if (userAttachments != null) {
      map['user_attachments'] = userAttachments
          ?.map((v) => v.toJson())
          .toList();
    }
    return map;
  }
}

/// id : 38
/// user_id : 3
/// file_name : null
/// file_type : null
/// file_url : "https://lh3.googleusercontent.com/a/ACg8ocIBKFmFRW_QmHemhgZIREXw7esuyKmuTsAUiRcDMUZMaVvq_ZIdFQ=s96-c"

class UserAttachments {
  UserAttachments({
    this.id,
    this.userId,
    this.fileName,
    this.fileType,
    this.fileUrl,
  });

  UserAttachments.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    fileName = json['file_name'];
    fileType = json['file_type'];
    fileUrl = json['file_url'];
  }

  int? id;
  int? userId;
  String? fileName;
  String? fileType;
  String? fileUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['file_name'] = fileName;
    map['file_type'] = fileType;
    map['file_url'] = fileUrl;
    return map;
  }
}
