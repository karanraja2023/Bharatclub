class EventAttendanceResponse {
  EventAttendanceResponse({
    this.error,
    this.statusCode,
    this.statusMessage,
    this.data,
    this.responseTime,
  });

  EventAttendanceResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data = json['data'] != null
        ? EventAttendanceResponseData.fromJson(json['data'])
        : null;
    responseTime = json['responseTime'];
  }

  bool? error;
  int? statusCode;
  String? statusMessage;
  EventAttendanceResponseData? data;
  int? responseTime;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['statusCode'] = statusCode;
    data['statusMessage'] = statusMessage;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['responseTime'] = responseTime;
    return data;
  }
}

class EventAttendanceResponseData {
  EventAttendanceResponseData({
    this.error,
    this.response,
    this.message,
  });

  EventAttendanceResponseData.fromJson(dynamic json) {
    error = json['error'];
    response = json['response'];
    message = json['message'];
  }

  bool? error;
  int? response;
  String? message;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['response'] = response;
    data['message'] = message;
    return data;
  }
}
