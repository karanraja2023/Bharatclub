/// error : false
/// statusCode : 200
/// statusMessage : "OK"
/// data : {"id":3,"page_name":"GALLERY","title":null,"content":null,"status":1,"module":[{"id":1,"file_name":"gallery onw update 123","file_type":null,"file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/gallery/Accounting.png","status":1},{"id":2,"file_name":"test gallery","file_type":null,"file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/gallery/frehdesk sla policy.PNG","status":1},{"id":3,"file_name":"Connecting People","file_type":null,"file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/gallery/cover image.webp","status":1}],"cms_page_attachments":[{"id":3,"cms_page_id":3,"title":"Gallery","small_text":"Moments forever","file_name":"","file_type":null,"file_url":null}]}
/// responseTime : 1714096451

class GalleryResponse {
  GalleryResponse({
    this.error,
    this.statusCode,
    this.statusMessage,
    this.data,
    this.responseTime,
  });

  GalleryResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data = json['data'] != null ? GalleryData.fromJson(json['data']) : null;
    responseTime = json['responseTime'];
  }

  bool? error;
  int? statusCode;
  String? statusMessage;
  GalleryData? data;
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

/// id : 3
/// page_name : "GALLERY"
/// title : null
/// content : null
/// status : 1
/// module : [{"id":1,"file_name":"gallery onw update 123","file_type":null,"file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/gallery/Accounting.png","status":1},{"id":2,"file_name":"test gallery","file_type":null,"file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/gallery/frehdesk sla policy.PNG","status":1},{"id":3,"file_name":"Connecting People","file_type":null,"file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/gallery/cover image.webp","status":1}]
/// cms_page_attachments : [{"id":3,"cms_page_id":3,"title":"Gallery","small_text":"Moments forever","file_name":"","file_type":null,"file_url":null}]

class GalleryData {
  GalleryData({
    this.id,
    this.pageName,
    this.title,
    this.content,
    this.status,
    this.module,
    this.cmsPageAttachments,
  });

  GalleryData.fromJson(dynamic json) {
    id = json['id'];
    pageName = json['page_name'];
    title = json['title'];
    content = json['content'];
    status = json['status'];
    if (json['module'] != null) {
      module = [];
      json['module'].forEach((v) {
        module?.add(GalleryModule.fromJson(v));
      });
    }
    if (json['cms_page_attachments'] != null) {
      cmsPageAttachments = [];
      json['cms_page_attachments'].forEach((v) {
        cmsPageAttachments?.add(CmsPageGalleryAttachments.fromJson(v));
      });
    }
  }

  int? id;
  String? pageName;
  String? title;
  String? content;
  int? status;
  List<GalleryModule>? module;
  List<CmsPageGalleryAttachments>? cmsPageAttachments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['page_name'] = pageName;
    map['title'] = title;
    map['content'] = content;
    map['status'] = status;
    if (module != null) {
      map['module'] = module?.map((v) => v.toJson()).toList();
    }
    if (cmsPageAttachments != null) {
      map['cms_page_attachments'] =
          cmsPageAttachments?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
class CmsPageGalleryAttachments {
  CmsPageGalleryAttachments({
    this.id,
    this.cmsPageId,
    this.title,
    this.smallText,
    this.fileName,
    this.fileType,
    this.fileUrl,
  });

  CmsPageGalleryAttachments.fromJson(dynamic json) {
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
  String? fileType;
  String? fileUrl;

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
class GalleryModule {
  GalleryModule({
    this.id,
    this.fileName,
    this.fileType,
    this.fileUrl,
    this.videoUrl,
    this.status,
  });

  GalleryModule.fromJson(dynamic json) {
    id = json['id'];
    fileName = json['file_name'];
    fileType = json['file_type'].toString();
    fileUrl = json['file_url'];
    videoUrl = json['video_url'];
    status = json['status'];
  }

  int? id;
  String? fileName;
  String? fileType;
  String? fileUrl;
  String? videoUrl;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['file_name'] = fileName;
    map['file_type'] = fileType;
    map['file_url'] = fileUrl;
    map['video_url'] = videoUrl;
    map['status'] = status;
    return map;
  }
}
