/// error : false
/// statusCode : 200
/// statusMessage : "OK"
/// data : {"Clubs":[{"id":1,"club_title":"BHARAT CLUB","description":"<p>","short_description":"<p>APPLICATION FOR THE MEMBERSHIP OF BHARAT CLUB - KUALA LUMPUR","address":"<p>\r\nThe Secretary <BR>\r\nKelab Bharat Kuala Lumpur <BR>\r\nP.O.Box: 11802, 50782, Kuala Lumpur\r\n</p>","pic_name":null,"pic_title":null,"phone":"+6019 533 1794","email":"clubbharat@gmail.com","status":1}],"ClubsAttachments":[{"id":1,"clubs_id":1,"file_name":"Accounting.png","file_type":null,"file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/event/Accounting.png"}],"ClubsMembership":[{"id":1,"clubs_id":1,"membership_package_title":"LIFE MEMBERSHIP","membership_package_amount":2000,"validity":12,"status":1},{"id":2,"clubs_id":1,"membership_package_title":"ORDINARY MEMBERSHIP","membership_package_amount":200,"validity":1,"status":1}]}
/// responseTime : 1714707518

class JoinClubResponse {
  JoinClubResponse({
    this.error,
    this.statusCode,
    this.statusMessage,
    this.data,
    this.responseTime,});

  JoinClubResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data = json['data'] != null ? JoinClubData.fromJson(json['data']) : null;
    responseTime = json['responseTime'];
  }
  bool? error;
  int? statusCode;
  String? statusMessage;
  JoinClubData? data;
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

/// Clubs : [{"id":1,"club_title":"BHARAT CLUB","description":"<p>","short_description":"<p>APPLICATION FOR THE MEMBERSHIP OF BHARAT CLUB - KUALA LUMPUR","address":"<p>\r\nThe Secretary <BR>\r\nKelab Bharat Kuala Lumpur <BR>\r\nP.O.Box: 11802, 50782, Kuala Lumpur\r\n</p>","pic_name":null,"pic_title":null,"phone":"+6019 533 1794","email":"clubbharat@gmail.com","status":1}]
/// ClubsAttachments : [{"id":1,"clubs_id":1,"file_name":"Accounting.png","file_type":null,"file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/event/Accounting.png"}]
/// ClubsMembership : [{"id":1,"clubs_id":1,"membership_package_title":"LIFE MEMBERSHIP","membership_package_amount":2000,"validity":12,"status":1},{"id":2,"clubs_id":1,"membership_package_title":"ORDINARY MEMBERSHIP","membership_package_amount":200,"validity":1,"status":1}]

class JoinClubData {
  JoinClubData({
    this.clubs,
    this.clubsAttachments,
    this.clubsMembership,});

  JoinClubData.fromJson(dynamic json) {
    if (json['Clubs'] != null) {
      clubs = [];
      json['Clubs'].forEach((v) {
        clubs?.add(Clubs.fromJson(v));
      });
    }
    if (json['ClubsAttachments'] != null) {
      clubsAttachments = [];
      json['ClubsAttachments'].forEach((v) {
        clubsAttachments?.add(ClubsAttachments.fromJson(v));
      });
    }
    if (json['ClubsMembership'] != null) {
      clubsMembership = [];
      json['ClubsMembership'].forEach((v) {
        clubsMembership?.add(ClubsMembership.fromJson(v));
      });
    }
  }
  List<Clubs>? clubs;
  List<ClubsAttachments>? clubsAttachments;
  List<ClubsMembership>? clubsMembership;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (clubs != null) {
      map['Clubs'] = clubs?.map((v) => v.toJson()).toList();
    }
    if (clubsAttachments != null) {
      map['ClubsAttachments'] = clubsAttachments?.map((v) => v.toJson()).toList();
    }
    if (clubsMembership != null) {
      map['ClubsMembership'] = clubsMembership?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// clubs_id : 1
/// membership_package_title : "LIFE MEMBERSHIP"
/// membership_package_amount : 2000
/// validity : 12
/// status : 1

class ClubsMembership {
  ClubsMembership({
    this.id,
    this.clubsId,
    this.membershipPackageTitle,
    this.membershipPackageAmount,
    this.validity,
    this.status,});

  ClubsMembership.fromJson(dynamic json) {
    id = json['id'];
    clubsId = json['clubs_id'];
    membershipPackageTitle = json['membership_package_title'];
    membershipPackageAmount = json['membership_package_amount'].toString();
    validity = json['validity'];
    status = json['status'];
  }
  int? id;
  int? clubsId;
  String? membershipPackageTitle;
  String? membershipPackageAmount;
  int? validity;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['clubs_id'] = clubsId;
    map['membership_package_title'] = membershipPackageTitle;
    map['membership_package_amount'] = membershipPackageAmount;
    map['validity'] = validity;
    map['status'] = status;
    return map;
  }

}

/// id : 1
/// clubs_id : 1
/// file_name : "Accounting.png"
/// file_type : null
/// file_url : "https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/event/Accounting.png"

class ClubsAttachments {
  ClubsAttachments({
    this.id,
    this.clubsId,
    this.fileName,
    this.fileType,
    this.fileUrl,});

  ClubsAttachments.fromJson(dynamic json) {
    id = json['id'];
    clubsId = json['clubs_id'];
    fileName = json['file_name'];
    fileType = json['file_type'];
    fileUrl = json['file_url'];
  }
  int? id;
  int? clubsId;
  String? fileName;
  dynamic fileType;
  String? fileUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['clubs_id'] = clubsId;
    map['file_name'] = fileName;
    map['file_type'] = fileType;
    map['file_url'] = fileUrl;
    return map;
  }

}

/// id : 1
/// club_title : "BHARAT CLUB"
/// description : "<p>"
/// short_description : "<p>APPLICATION FOR THE MEMBERSHIP OF BHARAT CLUB - KUALA LUMPUR"
/// address : "<p>\r\nThe Secretary <BR>\r\nKelab Bharat Kuala Lumpur <BR>\r\nP.O.Box: 11802, 50782, Kuala Lumpur\r\n</p>"
/// pic_name : null
/// pic_title : null
/// phone : "+6019 533 1794"
/// email : "clubbharat@gmail.com"
/// status : 1

class Clubs {
  Clubs({
    this.id,
    this.clubTitle,
    this.description,
    this.shortDescription,
    this.address,
    this.picName,
    this.picTitle,
    this.phone,
    this.email,
    this.status,});

  Clubs.fromJson(dynamic json) {
    id = json['id'];
    clubTitle = json['club_title'];
    description = json['description'];
    shortDescription = json['short_description'];
    address = json['address'];
    picName = json['pic_name'];
    picTitle = json['pic_title'];
    phone = json['phone'];
    email = json['email'];
    status = json['status'];
  }
  int? id;
  String? clubTitle;
  String? description;
  String? shortDescription;
  String? address;
  dynamic picName;
  dynamic picTitle;
  String? phone;
  String? email;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['club_title'] = clubTitle;
    map['description'] = description;
    map['short_description'] = shortDescription;
    map['address'] = address;
    map['pic_name'] = picName;
    map['pic_title'] = picTitle;
    map['phone'] = phone;
    map['email'] = email;
    map['status'] = status;
    return map;
  }

}