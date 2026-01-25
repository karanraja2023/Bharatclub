/// error : false
/// statusCode : 200
/// statusMessage : "OK"
/// data : {"message":"Profile uploaded successfully"}
/// responseTime : 1714131799

class ProfilePicResponse {
  ProfilePicResponse({
      this.error, 
      this.statusCode, 
      this.statusMessage, 
      this.data, 
      this.responseTime,});

  ProfilePicResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data = json['data'] != null ? ProfilePicData.fromJson(json['data']) : null;
    responseTime = json['responseTime'];
  }
  bool? error;
  int? statusCode;
  String? statusMessage;
  ProfilePicData? data;
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

/// message : "Profile uploaded successfully"

class ProfilePicData {
  ProfilePicData({
      this.message,});

  ProfilePicData.fromJson(dynamic json) {
    message = json['message'];
  }
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }

}