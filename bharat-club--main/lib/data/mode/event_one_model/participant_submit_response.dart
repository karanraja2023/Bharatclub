import 'dart:convert';

class ParticipantSubmitResponse {
  ParticipantSubmitResponse({
    this.error,
    this.statusCode,
    this.statusMessage,
    this.data,
    this.responseTime,
  });

  ParticipantSubmitResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data = json['data'] != null ? ResponseData.fromJson(json['data']) : null;
    responseTime = json['responseTime'];
  }

  bool? error;
  int? statusCode;
  String? statusMessage;
  ResponseData? data;
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

class ResponseData {
  ResponseData({
    this.error,
    this.response, // This is a JSON string, not an object
    this.message,
  });

  ResponseData.fromJson(dynamic json) {
    error = json['error'];
    // IMPORTANT: Keep response as a String - it contains JSON
    response = json['response']?.toString();
    message = json['message'];
  }

  bool? error;
  String? response; // This is a JSON string that needs to be parsed
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['response'] = response;
    map['message'] = message;
    return map;
  }

  // Helper method to get parsed response as Map
  Map<String, dynamic>? getParsedResponse() {
    if (response == null || response!.isEmpty) return null;
    try {
      return json.decode(response!) as Map<String, dynamic>;
    } catch (e) {
      print("Error parsing response: $e");
      return null;
    }
  }

  // Helper method to get participant ID directly
  String? getParticipantId() {
    var parsed = getParsedResponse();
    if (parsed != null && parsed.containsKey('id')) {
      return parsed['id'].toString();
    }
    return null;
  }
}
