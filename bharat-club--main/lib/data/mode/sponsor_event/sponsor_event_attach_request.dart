class SponsorEventAttachmentRequest {
  final String eventId;

  SponsorEventAttachmentRequest({required this.eventId});

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
    };
  }
}
