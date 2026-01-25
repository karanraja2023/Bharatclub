class MembershipTypeResponse {
  MembershipTypeResponse({
    this.error,
    this.statusCode,
    this.statusMessage,
    this.data,
    this.responseTime,
  });

  MembershipTypeResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(MembershipTypeData.fromJson(v));
      });
    }
    responseTime = json['responseTime'];
  }

  bool? error;
  int? statusCode;
  String? statusMessage;
  List<MembershipTypeData>? data;
  int? responseTime;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['statusCode'] = statusCode;
    data['statusMessage'] = statusMessage;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    data['responseTime'] = responseTime;
    return data;
  }
}

class MembershipTypeData {
  MembershipTypeData({
    this.id,
    this.type,
    this.subscriptionAmount,
    this.renewalStatus,
  });

  MembershipTypeData.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    subscriptionAmount = json['subscription_amount'];
    renewalStatus = json['renewal_status'];
  }

  int? id;
  String? type;
  String? subscriptionAmount;
  int? renewalStatus;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['subscription_amount'] = subscriptionAmount;
    data['renewal_status'] = renewalStatus;
    return data;
  }
}
