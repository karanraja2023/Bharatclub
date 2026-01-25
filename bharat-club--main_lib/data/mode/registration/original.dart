/// original : {"error":true,"statusCode":400,"statusMessage":"Bad Request","data":{"error":"Old Password Does not match!"},"responseTime":1723020177}

class Original {
  Original({
      this.original,});

  Original.fromJson(dynamic json) {
    original = json['original'] != null ? Original.fromJson(json['original']) : null;
  }
  Original? original;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (original != null) {
      map['original'] = original?.toJson();
    }
    return map;
  }

}

/// error : true
/// statusCode : 400
/// statusMessage : "Bad Request"
/// data : {"error":"Old Password Does not match!"}
/// responseTime : 1723020177

class OriginalData {
  OriginalData({
      this.error, 
      this.statusCode, 
      this.statusMessage, 
      this.data, 
      this.responseTime,});

  OriginalData.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data = json['data'] != null ? GetData.fromJson(json['data']) : null;
    responseTime = json['responseTime'];
  }
  bool? error;
  int? statusCode;
  String? statusMessage;
  GetData? data;
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

/// error : "Old Password Does not match!"

class GetData {
  GetData({
      this.error,});

  GetData.fromJson(dynamic json) {
    error = json['error'];
  }
  String? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    return map;
  }

}