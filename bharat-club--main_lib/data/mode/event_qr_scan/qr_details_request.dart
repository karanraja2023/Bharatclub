class QrDetailsRequest {
  QrDetailsRequest({
    this.eventId,
    this.membershipId,
  });

  QrDetailsRequest.fromJson(dynamic json) {
    eventId = json['event_id'];
    membershipId = json['membership_id'];
  }

  String? eventId;
  String? membershipId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event_id'] = eventId;
    data['membership_id'] = membershipId;
    return data;
  }
}
