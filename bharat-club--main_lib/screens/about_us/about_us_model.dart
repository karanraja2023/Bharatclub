
class AboutUsResponse {
  AboutUsResponse({
    this.error,
    this.statusCode,
    this.statusMessage,
    this.data,
    this.responseTime,
  });

  AboutUsResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data = json['data'] != null ? AboutUsData.fromJson(json['data']) : null;
    responseTime = json['responseTime'];
  }

  bool? error;
  int? statusCode;
  String? statusMessage;
  AboutUsData? data;
  int? responseTime;

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

class AboutUsData {
  AboutUsData({
    this.id,
    this.pageName,
    this.title,
    this.content,
    this.status,
    this.cmsPageAttachments,
  });

  AboutUsData.fromJson(dynamic json) {
    id = json['id'];
    pageName = json['page_name'];
    title = json['title'];
    content = json['content'];
    status = json['status'];
    if (json['cms_page_attachments'] != null) {
      cmsPageAttachments = [];
      json['cms_page_attachments'].forEach((v) {
        cmsPageAttachments?.add(CmsPageAboutUsAttachments.fromJson(v));
      });
    }
  }

  int? id;
  String? pageName;
  String? title;
  String? content;
  int? status;

  List<CmsPageAboutUsAttachments>? cmsPageAttachments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['page_name'] = pageName;
    map['title'] = title;
    map['content'] = content;
    map['status'] = status;
    if (cmsPageAttachments != null) {
      map['cms_page_attachments'] = cmsPageAttachments
          ?.map((v) => v.toJson())
          .toList();
    }
    return map;
  }
}

class CmsPageAboutUsAttachments {
  CmsPageAboutUsAttachments({
    this.id,
    this.cmsPageId,
    this.title,
    this.smallText,
    this.fileName,
    this.fileType,
    this.fileUrl,
  });

  CmsPageAboutUsAttachments.fromJson(dynamic json) {
    id = json['id'];
    cmsPageId = json['cms_page_id'];
    title = json['title'];
    smallText = json['small_text'];
    fileName = json['file_name'];
    fileType = json['file_type'];
    fileUrl = json['file_url'];
  }

  int? id;
  int? cmsPageId;
  String? title;
  String? smallText;
  String? fileName;
  dynamic fileType;
  dynamic fileUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['cms_page_id'] = cmsPageId;
    map['title'] = title;
    map['small_text'] = smallText;
    map['file_name'] = fileName;
    map['file_type'] = fileType;
    map['file_url'] = fileUrl;
    return map;
  }
}
