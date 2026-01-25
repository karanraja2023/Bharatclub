import 'dart:convert';

class QrDetailsResponse {
  bool? error;
  int? statusCode;
  String? statusMessage;
  QrDetailsResponseData? data;
  String? eventName;

  int? responseTime;

  QrDetailsResponse({
    this.error,
    this.statusCode,
    this.statusMessage,
    this.data,
    this.responseTime,
    this.eventName,
  });

  factory QrDetailsResponse.fromJson(dynamic json) {
    if (json == null) return QrDetailsResponse();

    return QrDetailsResponse(
      error: json['error'] as bool?,
      statusCode: json['statusCode'] as int?,
      statusMessage: json['statusMessage'] as String?,
      eventName: json['event_name'] as String?,

      data: json['data'] != null
          ? QrDetailsResponseData.fromJson(json['data'])
          : null,
      responseTime: json['responseTime'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'statusCode': statusCode,
      'statusMessage': statusMessage,
      'data': data?.toJson(),
      'responseTime': responseTime,
      'event_name': eventName,
    };
  }
}

class QrDetailsResponseData {
  bool? error;
  QrDetailsResponseDetails? response; // if response is object
  bool? responseBool; // if response is boolean
  String? message; // Add message field

  QrDetailsResponseData({
    this.error,
    this.response,
    this.responseBool,
    this.message,
  });

  factory QrDetailsResponseData.fromJson(dynamic json) {
    if (json == null) return QrDetailsResponseData();

    final dynamic responseData = json['response'];

    // CRITICAL FIX: Handle different response types
    QrDetailsResponseDetails? responseObject;
    bool? responseBoolValue;

    try {
      if (responseData == null) {
        // Response is null
        responseObject = null;
        responseBoolValue = null;
      } else if (responseData is String) {
        // CASE 1: Response is a JSON string - decode it first
        print('📦 Response is String, decoding: $responseData');
        try {
          final decoded = jsonDecode(responseData);

          if (decoded is Map<String, dynamic>) {
            responseObject = QrDetailsResponseDetails.fromJson(decoded);
            print('✅ Decoded to Map with status: ${responseObject.status}');
          } else if (decoded is bool) {
            responseBoolValue = decoded;
            print('✅ Decoded to bool: $decoded');
          } else {
            print('⚠️ Unknown decoded type: ${decoded.runtimeType}');
          }
        } catch (e) {
          print('❌ Error decoding JSON string: $e');
          print('❌ Raw string: $responseData');
        }
      } else if (responseData is Map<String, dynamic>) {
        // CASE 2: Response is already a Map
        print('📦 Response is Map');
        responseObject = QrDetailsResponseDetails.fromJson(responseData);
      } else if (responseData is bool) {
        // CASE 3: Response is a boolean
        print('📦 Response is bool: $responseData');
        responseBoolValue = responseData;
      } else {
        print('⚠️ Unknown response type: ${responseData.runtimeType}');
      }
    } catch (e, stackTrace) {
      print('❌ Error parsing response: $e');
      print('Stack trace: $stackTrace');
    }

    return QrDetailsResponseData(
      error: json['error'] as bool?,
      response: responseObject,
      responseBool: responseBoolValue,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {'error': error, 'message': message};

    if (response != null) {
      map['response'] = response!.toJson();
    } else if (responseBool != null) {
      map['response'] = responseBool;
    }
    return map;
  }

  // Helper method to check if status is present (equals 1 or true)
  bool isStatusPresent() {
    if (response != null && response!.status != null) {
      return response!.status == 1;
    }
    if (responseBool != null) {
      return responseBool == true;
    }
    return false;
  }

  // Helper method to get status value
  int? getStatus() {
    if (response != null) {
      return response!.status;
    }
    if (responseBool != null) {
      return responseBool! ? 1 : 0;
    }
    return null;
  }
}

class QrDetailsResponseDetails {
  String? participantName;
  String? membershipID;
  int? memberNoOfAdults;
  int? memberNoOfChild;
  int? memberNoOfChildFree;
  int? guestNoOfAdults;
  int? guestNoOfChild;
  int? guestNoOfChildFree;
  int? memberChildStatus;
  int? guestChildStatus;
  int? status;
  int? eventID;
  String? eventName;

  QrDetailsResponseDetails({
    this.participantName,
    this.membershipID,
    this.memberNoOfAdults,
    this.memberNoOfChild,
    this.memberNoOfChildFree,
    this.guestNoOfAdults,
    this.guestNoOfChild,
    this.guestNoOfChildFree,
    this.memberChildStatus,
    this.guestChildStatus,
    this.status,
    this.eventName, // 🔥 NEW FIELD

    this.eventID,
  });

  factory QrDetailsResponseDetails.fromJson(dynamic json) {
    if (json == null) return QrDetailsResponseDetails();

    return QrDetailsResponseDetails(
      participantName: json['participant_name'] as String?,
      membershipID: json['membership_id'] as String?,
      memberNoOfAdults: _toInt(json['member_no_of_adults']),
      memberNoOfChild: _toInt(json['member_no_of_child']),
      memberNoOfChildFree: _toInt(json['member_no_of_child_free']),
      guestNoOfAdults: _toInt(json['guest_no_of_adults']),
      guestNoOfChild: _toInt(json['guest_no_of_child']),
      guestNoOfChildFree: _toInt(json['guest_no_of_child_free']),
      memberChildStatus: _toInt(json['member_child_status']),
      guestChildStatus: _toInt(json['guest_child_status']),
      status: _toInt(json['status']),
      eventID: _toInt(json['event_id']),
      eventName: json['event_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'participant_name': participantName,
      'membership_id': membershipID,
      'member_no_of_adults': memberNoOfAdults,
      'member_no_of_child': memberNoOfChild,
      'member_no_of_child_free': memberNoOfChildFree,
      'guest_no_of_adults': guestNoOfAdults,
      'guest_no_of_child': guestNoOfChild,
      'guest_no_of_child_free': guestNoOfChildFree,
      'member_child_status': memberChildStatus,
      'guest_child_status': guestChildStatus,
      'status': status,
      'event_name': eventName,

      'event_id': eventID,
    };
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  void operator [](String other) {}
}
