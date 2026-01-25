
// event_id:2
// participant_name:samrajan
// email_address:pp@ssdf.com
// no_of_participants:9078675645
// remarks:test

class EventPaymentSubmitRequest {
  EventPaymentSubmitRequest({
      this.id,
     });

  EventPaymentSubmitRequest.fromJson(dynamic json) {
    id = json['id'];
  }
  String? id;

  Map<String, String> toJson() {
    final map = <String, String>{};
    map['id'] = id??'';
    // map['attachment'] = attachment;
    return map;
  }

}