class EventAttendanceRequest {
  EventAttendanceRequest({
    this.eventId,
    this.membershipId,
    this.adultAttend,
    this.childAttend,
    this.guestAttend,
    this.guestChildAttend,
    this.remarks
  });

  EventAttendanceRequest.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    membershipId = json['membership_id'];
    adultAttend = json['adult_attend'];
    childAttend = json['child_attend'];
    guestAttend = json['guest_attend'];
    guestChildAttend = json['guest_child_attend'];
    remarks = json['remarks'];
  }

  String? eventId;
  String? membershipId;
  int? adultAttend;
  int? childAttend;
  int? guestAttend;
  int? guestChildAttend;
  String? remarks;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event_id'] = eventId;
    data['membership_id'] = membershipId;
    data['adult_attend'] = adultAttend;
    data['child_attend'] = childAttend;
    data['guest_attend'] = guestAttend;
    data['guest_child_attend'] = guestChildAttend;
    data['remarks'] = remarks;
    return data;
  }
}
