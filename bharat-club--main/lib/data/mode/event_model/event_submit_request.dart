
// event_id:2
// participant_name:samrajan
// email_address:pp@ssdf.com
// no_of_participants:9078675645
// remarks:test

class EventSubmitRequest {
  EventSubmitRequest({
      this.eventId, 
      this.participantName, 
      this.emailAddress, 
      this.noOfParticipants, 
      this.remarks, 
     });

  EventSubmitRequest.fromJson(dynamic json) {
    eventId = json['event_id'];
    participantName = json['participant_name'];
    emailAddress = json['email_address'];
    noOfParticipants = json['no_of_participants'];
    remarks = json['remarks'];

  }
  String? eventId;
  String? participantName;
  String? emailAddress;
  String? noOfParticipants;
  String? remarks;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['event_id'] = eventId;
    map['participant_name'] = participantName;
    map['email_address'] = emailAddress;
    map['no_of_participants'] = noOfParticipants;
    map['remarks'] = remarks;

    return map;
  }

}