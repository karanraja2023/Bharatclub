/// QR Access Request Model
class QRAccessRequest {
  final String deviceId;
  final String accessName;

  QRAccessRequest({required this.deviceId, required this.accessName});

  Map<String, dynamic> toJson() {
    return {'device_id': deviceId, 'access_name': accessName};
  }
}

/// QR Access Response Model
class QRAccessResponse {
  final bool? error;
  final int? statusCode;
  final String? statusMessage;
  final Map<String, dynamic>? data;
  final int? responseTime;

  QRAccessResponse({
    this.error,
    this.statusCode,
    this.statusMessage,
    this.data,
    this.responseTime,
  });

  factory QRAccessResponse.fromJson(Map<String, dynamic> json) {
    return QRAccessResponse(
      error: json['error'] as bool?,
      statusCode: json['statusCode'] as int?,
      statusMessage: json['statusMessage']?.toString(),
      data: json['data'] as Map<String, dynamic>?,
      responseTime: json['responseTime'] as int?,
    );
  }

  String? get message => data?['message']?.toString();

  bool get isAccessGranted =>
      error == false && statusCode == 200 && message == 'Access Granted';

  bool get isAccessDenied =>
      error == true || statusCode == 403 || message == 'Access Denied';
}
