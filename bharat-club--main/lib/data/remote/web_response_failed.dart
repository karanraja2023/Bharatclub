// error : true
// statusCode : 400
// statusMessage : "Bad Request"
// data : {"message":"Token is Expired"} OR "The attachment is required"
// responseTime : 1639548038

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
    
    // FIX: Handle both String and Map for data field
    if (json['data'] != null) {
      if (json['data'] is String) {
        // If data is a string, create a WebResponseFailedData with that message
        _data = WebResponseFailedData(message: json['data'] as String);
      } else if (json['data'] is Map) {
        // If data is a map, parse it normally
        _data = WebResponseFailedData.fromJson(json['data']);
      }
    }
    
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
    // Handle both direct string and object with message field
    if (json is String) {
      _message = json;
    } else if (json is Map) {
      _message = json['message']?.toString();
    }
  }

  String? _message;

  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    return map;
  }
}