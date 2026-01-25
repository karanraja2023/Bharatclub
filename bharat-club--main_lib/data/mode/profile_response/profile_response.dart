import '../registration/registration_response.dart';

/// error : false
/// statusCode : 200
/// statusMessage : "OK"
/// data : {"id":1,"name":"muthu","mobile":"9078675645","email":"partha.paul007@gmail.com","organization":null,"user_type":"USER","login_type":"GOOGLE_LOGIN","status":1,"user_attachments":[{"id":26,"user_id":1,"file_name":null,"file_type":null,"file_url":"https://lh3.googleusercontent.com/a/ACg8ocIBKFmFRW_QmHemhgZIREXw7esuyKmuTsAUiRcDMUZMaVvq_ZIdFQ=s96-c"}]}
/// responseTime : 1713924662

class ProfileResponse {
  ProfileResponse({
    this.error,
    this.statusCode,
    this.statusMessage,
    this.data,
    this.responseTime,});

  ProfileResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data = json['data'] != null ? RegistrationUser.fromJson(json['data']) : null;
    responseTime = json['responseTime'];
  }
  bool? error;
  int? statusCode;
  String? statusMessage;
  RegistrationUser? data;
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