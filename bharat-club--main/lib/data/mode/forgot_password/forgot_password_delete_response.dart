/// error : false
/// statusCode : 200
/// statusMessage : "OK"
/// data : {"message":"User Deleted Successfully!"}
/// responseTime : 1727138555

class ForgotPasswordDeleteResponse {
  ForgotPasswordDeleteResponse({
      this.error, 
      this.statusCode, 
      this.statusMessage, 
      this.data, 
      this.responseTime,});

  ForgotPasswordDeleteResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data = json['data'] != null ? DeleteResponseData.fromJson(json['data']) : null;
    responseTime = json['responseTime'];
  }
  bool? error;
  int? statusCode;
  String? statusMessage;
  DeleteResponseData? data;
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

/// message : "User Deleted Successfully!"

class DeleteResponseData {
  DeleteResponseData({
      this.message,});

  DeleteResponseData.fromJson(dynamic json) {
    message = json['message'];
  }
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }

}