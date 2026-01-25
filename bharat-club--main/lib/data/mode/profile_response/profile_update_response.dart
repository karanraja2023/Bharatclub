/// error : false
/// statusCode : 200
/// statusMessage : "OK"
/// data : {"message":"User Updated Successfully"}
/// responseTime : 1713933949

class ProfileUpdateResponse {
  ProfileUpdateResponse({
      this.error, 
      this.statusCode, 
      this.statusMessage, 
      this.data, 
      this.responseTime,});

  ProfileUpdateResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data = json['data'] != null ? ProfileUpdateData.fromJson(json['data']) : null;
    responseTime = json['responseTime'];
  }
  bool? error;
  int? statusCode;
  String? statusMessage;
  ProfileUpdateData? data;
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

/// message : "User Updated Successfully"

class ProfileUpdateData {
  ProfileUpdateData({
      this.message,});

  ProfileUpdateData.fromJson(dynamic json) {
    message = json['message'];
  }
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }

}