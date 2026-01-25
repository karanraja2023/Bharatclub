import 'dart:convert';

/// error : false
/// statusCode : 200
/// statusMessage : "OK"
/// data : {"response":{"event_id":"2","participant_name":"samrajan","email_address":"pp@ssdf.com","no_of_participants":"9078675645","remarks":"test","status":1,"updated_at":"2024-08-13T02:12:47.000000Z","created_at":"2024-08-13T02:12:47.000000Z","id":6},"message":"Your data has been successfully submitted"}
/// responseTime : 1723515167

class EventApplyResponse {
  EventApplyResponse({
    this.error,
    this.statusCode,
    this.statusMessage,
    this.data,
    this.responseTime,
  });

  EventApplyResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    if (statusCode == 200) {
      statusMessage = json['statusMessage'];
      data = json['data'] != null
          ? EventApplyResponseData.fromJson(json['data'])
          : null;
      responseTime = json['responseTime'];
    } else {
      statusMessage = json['data'];
    }
  }

  bool? error;
  int? statusCode;
  String? statusMessage;
  EventApplyResponseData? data;
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

/// response : {"event_id":"2","participant_name":"samrajan","email_address":"pp@ssdf.com","no_of_participants":"9078675645","remarks":"test","status":1,"updated_at":"2024-08-13T02:12:47.000000Z","created_at":"2024-08-13T02:12:47.000000Z","id":6}
/// message : "Your data has been successfully submitted"

class EventApplyResponseData {
  EventApplyResponseData({
    this.emailAddress,
    this.response,
    this.message,
  });

  EventApplyResponseData.fromJson(dynamic json) {
    emailAddress = json['email_address'] != null
        ? json['email_address'].cast<String>()
        : [];
    response = json['response'] != null
        ? ResponseData.fromJson(jsonDecode(json['response']))
        : null;
    message = json['message'];
  }

  ResponseData? response;
  String? message;
  List<String>? emailAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (response != null) {
      map['response'] = response?.toJson();
    }
    map['message'] = message;
    map['email_address'] = emailAddress;
    return map;
  }
}

/// event_id : "2"
/// participant_name : "samrajan"
/// email_address : "pp@ssdf.com"
/// no_of_participants : "9078675645"
/// remarks : "test"
/// status : 1
/// updated_at : "2024-08-13T02:12:47.000000Z"
/// created_at : "2024-08-13T02:12:47.000000Z"
/// id : 6

class ResponseData {
  ResponseData({
    this.eventId,
    this.participantName,
    this.emailAddress,
    this.noOfParticipants,
    this.remarks,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  ResponseData.fromJson(dynamic json) {
    eventId = json['event_id'];
    participantName = json['participant_name'];
    emailAddress = json['email_address'];
    noOfParticipants = json['no_of_participants'];
    remarks = json['remarks'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  String? eventId;
  String? participantName;
  String? emailAddress;
  String? noOfParticipants;
  String? remarks;
  int? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['event_id'] = eventId;
    map['participant_name'] = participantName;
    map['email_address'] = emailAddress;
    map['no_of_participants'] = noOfParticipants;
    map['remarks'] = remarks;
    map['status'] = status;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }
}
