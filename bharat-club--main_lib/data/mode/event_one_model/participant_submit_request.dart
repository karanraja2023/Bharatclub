class ParticipantSubmitRequest {
  ParticipantSubmitRequest({
    this.eventId,
    this.participantName,
    this.emailAddress,
    this.noOfParticipants,
    this.noOfAdult,
    this.noOfChild,
    this.noOfFreeChild,
    this.noOfGuest,
    this.noOfGuestChild,
    this.noOfGuestFreeChild,
    this.veg,
    this.nonVeg,
    this.jain,
    this.subsInclude,
    this.totalAmountPaid,
    this.membershipId,
  });

  ParticipantSubmitRequest.fromJson(dynamic json) {
    eventId = json['event_id'];
    participantName = json['participant_name'];
    emailAddress = json['email_address'];
    noOfParticipants = json['no_of_participants'];
    noOfAdult = json['no_of_adult'];
    noOfChild = json['no_of_child'];
    noOfFreeChild = json['no_of_free_child'];
    noOfGuest = json['no_of_guest'];
    noOfGuestChild = json['no_of_guest_child'];
    noOfGuestFreeChild = json['no_of_guest_free_child'];
    veg = json['veg'];
    nonVeg = json['non_veg'];
    jain = json['jain'];
    subsInclude = json['subs_include'];
    totalAmountPaid = json['total_amount_paid'];
    membershipId = json['membership_id'];
  }

  String? eventId;
  String? participantName;
  String? emailAddress;
  int? noOfParticipants;
  int? noOfAdult;
  int? noOfChild;
  int? noOfFreeChild;
  int? noOfGuest;
  int? noOfGuestChild;
  int? noOfGuestFreeChild;
  int? veg;
  int? nonVeg;
  int? jain;
  bool? subsInclude;
  double? totalAmountPaid;
  String? membershipId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['event_id'] = eventId;
    map['participant_name'] = participantName;
    map['email_address'] = emailAddress;
    map['no_of_participants'] = noOfParticipants;
    map['no_of_adult'] = noOfAdult;
    map['no_of_child'] = noOfChild;
    map['no_of_free_child'] = noOfFreeChild;
    map['no_of_guest'] = noOfGuest;
    map['no_of_guest_child'] = noOfGuestChild;
    map['no_of_guest_free_child'] = noOfGuestFreeChild;
    map['veg'] = veg;
    map['non_veg'] = nonVeg;
    map['jain'] = jain;
    map['subs_include'] = subsInclude;
    map['total_amount_paid'] = totalAmountPaid;
    map['membership_id'] = membershipId;
    return map;
  }
}
