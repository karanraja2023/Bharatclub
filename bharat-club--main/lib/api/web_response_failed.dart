
class WebResponseFailed {
  WebResponseFailed({
    bool? error,
    int? statusCode,
    String? statusMessage,
    WebResponseFailedData? data,
    int? responseTime,
  }) {
    _error = error;
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _data = data;
    _responseTime = responseTime;
  }

  WebResponseFailed.fromJson(dynamic json) {
    _error = json['error'];
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
    _data = json['data'] != null
        ? WebResponseFailedData.fromJson(json['data'])
        : null;
    _responseTime = json['responseTime'];
  }

  bool? _error;
  int? _statusCode;
  String? _statusMessage;
  WebResponseFailedData? _data;
  int? _responseTime;

  bool? get error => _error;

  int? get statusCode => _statusCode;

  String? get statusMessage => _statusMessage;

  WebResponseFailedData? get data => _data;

  int? get responseTime => _responseTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['statusCode'] = _statusCode;
    map['statusMessage'] = _statusMessage;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['responseTime'] = _responseTime;
    return map;
  }
}

/// message : "Token is Expired"

class WebResponseFailedData {
  WebResponseFailedData({
    String? message,
  }) {
    _message = message;
  }

  WebResponseFailedData.fromJson(dynamic json) {
    _message = json['message'];
  }

  String? _message;

  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    return map;
  }
}
