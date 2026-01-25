class EventDetailResponse {
  bool? error;
  int? statusCode;
  String? statusMessage;
  EventDetailData? data;
  int? responseTime;

  EventDetailResponse({
    this.error,
    this.statusCode,
    this.statusMessage,
    this.data,
    this.responseTime,
  });

  EventDetailResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data = json['data'] != null ? EventDetailData.fromJson(json['data']) : null;
    responseTime = json['responseTime'];
  }

  @override
  String toString() {
    return 'EventDetailResponse{error: $error, statusCode: $statusCode, statusMessage: $statusMessage, data: $data, responseTime: $responseTime}';
  }

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

class EventDetailData {
  ResponseData? response;
  String? message;

  EventDetailData({
    this.response,
    this.message,
  });

  EventDetailData.fromJson(dynamic json) {
    response = json['response'] != null ? ResponseData.fromJson(json['response']) : null;
    message = json['message'];
  }

  @override
  String toString() {
    return 'EventDetailData{response: $response, message: $message}';
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (response != null) {
      map['response'] = response?.toJson();
    }
    map['message'] = message;
    return map;
  }
}

class ResponseData {
  int? id;
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  int? status;
  int? createdBy;
  int? modifiedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? memberAdultAge;
  double? memberAdultAmount;
  int? memberChildStatus;
  String? memberChildAge;
  double? memberChildAmount;
  String? guestAdultAge;
  double? guestAdultAmount;
  int? guestChildStatus;
  String? guestChildAge;
  double? guestChildAmount;
  int? foodStatus;
  int? subscriptionStatus;

  ResponseData({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.status,
    this.createdBy,
    this.modifiedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.memberAdultAge,
    this.memberAdultAmount,
    this.memberChildStatus,
    this.memberChildAge,
    this.memberChildAmount,
    this.guestAdultAge,
    this.guestAdultAmount,
    this.guestChildStatus,
    this.guestChildAge,
    this.guestChildAmount,
    this.foodStatus,
    this.subscriptionStatus,
  });

  ResponseData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    memberAdultAge = json['member_adult_age'];
    memberAdultAmount = json['member_adult_amount'] != null ? double.parse(json['member_adult_amount'].toString()) : null;
    memberChildStatus = json['member_child_status'];
    memberChildAge = json['member_child_age'];
    memberChildAmount = json['member_child_amount'] != null ? double.parse(json['member_child_amount'].toString()) : null;
    guestAdultAge = json['guest_adult_age'];
    guestAdultAmount = json['guest_adult_amount'] != null ? double.parse(json['guest_adult_amount'].toString()) : null;
    guestChildStatus = json['guest_child_status'];
    guestChildAge = json['guest_child_age'];
    guestChildAmount = json['guest_child_amount'] != null ? double.parse(json['guest_child_amount'].toString()) : null;
    foodStatus = json['food_status'];
    subscriptionStatus = json['subscription_status'];
  }

  @override
  String toString() {
    return 'ResponseData{id: $id, title: $title, description: $description, startDate: $startDate, endDate: $endDate, status: $status, createdBy: $createdBy, modifiedBy: $modifiedBy, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, memberAdultAge: $memberAdultAge, memberAdultAmount: $memberAdultAmount, memberChildStatus: $memberChildStatus, memberChildAge: $memberChildAge, memberChildAmount: $memberChildAmount, guestAdultAge: $guestAdultAge, guestAdultAmount: $guestAdultAmount, guestChildStatus: $guestChildStatus, guestChildAge: $guestChildAge, guestChildAmount: $guestChildAmount, foodStatus: $foodStatus, subscriptionStatus: $subscriptionStatus}';
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['status'] = status;
    map['created_by'] = createdBy;
    map['modified_by'] = modifiedBy;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['member_adult_age'] = memberAdultAge;
    map['member_adult_amount'] = memberAdultAmount;
    map['member_child_status'] = memberChildStatus;
    map['member_child_age'] = memberChildAge;
    map['member_child_amount'] = memberChildAmount;
    map['guest_adult_age'] = guestAdultAge;
    map['guest_adult_amount'] = guestAdultAmount;
    map['guest_child_status'] = guestChildStatus;
    map['guest_child_age'] = guestChildAge;
    map['guest_child_amount'] = guestChildAmount;
    map['food_status'] = foodStatus;
    map['subscription_status'] = subscriptionStatus;
    return map;
  }
}
