/// error : false
/// statusCode : 200
/// statusMessage : "OK"
/// data : {"message":"Your data has been successfully submitted"}
/// responseTime : 1714986242

class JoinClubSubmitResponse {
  JoinClubSubmitResponse({
    this.error,
    this.statusCode,
    this.statusMessage,
    this.data,
    this.responseTime,
  });

  JoinClubSubmitResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data =
    json['data'] != null ? JoinClubSubmitData.fromJson(json['data']) : null;
    responseTime = json['responseTime'];
  }

  bool? error;
  int? statusCode;
  String? statusMessage;
  JoinClubSubmitData? data;
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

/// message : "Your data has been successfully submitted"

class JoinClubSubmitData {
  JoinClubSubmitData({
    this.message,
  });

  JoinClubSubmitData.fromJson(dynamic json) {
    message = json['message'];
  }

  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }
}
