class SponsorEventAttachmentResponse {
  final bool error;
  final int statusCode;
  final String statusMessage;
  final SponsorData? data;
  final int responseTime;

  SponsorEventAttachmentResponse({
    required this.error,
    required this.statusCode,
    required this.statusMessage,
    required this.data,
    required this.responseTime,
  });

  factory SponsorEventAttachmentResponse.fromJson(dynamic json) {
    return SponsorEventAttachmentResponse(
      error: json['error'],
      statusCode: json['statusCode'],
      statusMessage: json['statusMessage'],
      data: json['data'] != null ? SponsorData.fromJson(json['data']) : null,
      responseTime: json['responseTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'statusCode': statusCode,
      'statusMessage': statusMessage,
      'data': data?.toJson(),
      'responseTime': responseTime,
    };
  }
}

class SponsorData {
  final List<Sponsor> sponsor;

  SponsorData({required this.sponsor});

  factory SponsorData.fromJson(Map<String, dynamic> json) {
    return SponsorData(
      sponsor: (json['sponsor'] as List?)?.map((e) => Sponsor.fromJson(e)).toList() ?? [],
      );
  }

  Map<String, dynamic> toJson() {
    return {
      'sponsor': sponsor.map((e) => e.toJson()).toList(),
    };
  }
}

class Sponsor {
  final int id;
  final String companyName;
  final String? website;
  final String fileName;
  final String fileType;
  final String fileUrl;

  Sponsor({
    required this.id,
    required this.companyName,
    this.website,
    required this.fileName,
    required this.fileType,
    required this.fileUrl,
  });

  factory Sponsor.fromJson(Map<String, dynamic> json) {
    return Sponsor(
      id: json['id'],
      companyName: json['company_name'],
      website: json['website'],
      fileName: json['file_name'],
      fileType: json['file_type'],
      fileUrl: json['file_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_name': companyName,
      'website': website,
      'file_name': fileName,
      'file_type': fileType,
      'file_url': fileUrl,
    };
  }
}
