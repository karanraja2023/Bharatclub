import '../cms_page/event_response.dart';

/// error : false
/// statusCode : 200
/// statusMessage : "OK"
/// data : {"bannerList":[{"id":1,"title":"test","small_text":"test","file_name":"Accounting.png","file_type":"Banner","file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/banner/Accounting.png","sort_order":1,"status":1},{"id":4,"title":"Test banner","small_text":"testing","file_name":"Accounting.png","file_type":"Banner","file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/banner/Accounting.png","sort_order":3,"status":1}],"eventList":[{"id":2,"title":"Event test","description":"Event test","start_date":"2024-05-01","end_date":"2024-05-01","status":1,"event_attachments":[{"id":2,"event_id":2,"file_name":"Accounting.png","file_type":"Event","file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/event/Accounting.png"}]},{"id":3,"title":"Mother's day Event","description":"Mother's Day is around and its time to celebrate.","start_date":"2024-05-07","end_date":"2024-05-07","status":1,"event_attachments":[]}],"galleryList":[{"id":1,"file_name":"gallery onw update 123","file_type":null,"file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/gallery/Accounting.png","status":1},{"id":2,"file_name":"test gallery","file_type":null,"file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/gallery/frehdesk sla policy.PNG","status":1},{"id":3,"file_name":"Connecting People","file_type":null,"file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/gallery/cover image.webp","status":1}]}
/// responseTime : 1714029771

class DashboardResponse {
  DashboardResponse({
    this.error,
    this.statusCode,
    this.statusMessage,
    this.data,
    this.responseTime,});

  DashboardResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data = json['data'] != null ? DashboardData.fromJson(json['data']) : null;
    responseTime = json['responseTime'];
  }
  bool? error;
  int? statusCode;
  String? statusMessage;
  DashboardData? data;
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

/// bannerList : [{"id":1,"title":"test","small_text":"test","file_name":"Accounting.png","file_type":"Banner","file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/banner/Accounting.png","sort_order":1,"status":1},{"id":4,"title":"Test banner","small_text":"testing","file_name":"Accounting.png","file_type":"Banner","file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/banner/Accounting.png","sort_order":3,"status":1}]
/// eventList : [{"id":2,"title":"Event test","description":"Event test","start_date":"2024-05-01","end_date":"2024-05-01","status":1,"event_attachments":[{"id":2,"event_id":2,"file_name":"Accounting.png","file_type":"Event","file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/event/Accounting.png"}]},{"id":3,"title":"Mother's day Event","description":"Mother's Day is around and its time to celebrate.","start_date":"2024-05-07","end_date":"2024-05-07","status":1,"event_attachments":[]}]
/// galleryList : [{"id":1,"file_name":"gallery onw update 123","file_type":null,"file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/gallery/Accounting.png","status":1},{"id":2,"file_name":"test gallery","file_type":null,"file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/gallery/frehdesk sla policy.PNG","status":1},{"id":3,"file_name":"Connecting People","file_type":null,"file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/gallery/cover image.webp","status":1}]

class DashboardData {
  DashboardData({
    this.bannerList,
    this.eventList,
    this.galleryList,});

  DashboardData.fromJson(dynamic json) {
    if (json['bannerList'] != null) {
      bannerList = [];
      json['bannerList'].forEach((v) {
        bannerList?.add(DashboardBannerList.fromJson(v));
      });
    }
    if (json['eventList'] != null) {
      eventList = [];
      json['eventList'].forEach((v) {
        eventList?.add(EventModule.fromJson(v));
      });
    }
    if (json['galleryList'] != null) {
      galleryList = [];
      json['galleryList'].forEach((v) {
        galleryList?.add(DashboardGalleryList.fromJson(v));
      });
    }
  }
  List<DashboardBannerList>? bannerList;
  List<EventModule>? eventList;
  List<DashboardGalleryList>? galleryList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (bannerList != null) {
      map['bannerList'] = bannerList?.map((v) => v.toJson()).toList();
    }
    if (eventList != null) {
      map['eventList'] = eventList?.map((v) => v.toJson()).toList();
    }
    if (galleryList != null) {
      map['galleryList'] = galleryList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
class DashboardGalleryList {
  DashboardGalleryList({
    this.id,
    this.fileName,
    this.fileType,
    this.fileUrl,
    this.videoUrl,
    this.status,});

  DashboardGalleryList.fromJson(dynamic json) {
    id = json['id'];
    fileName = json['file_name'];
    fileType = json['file_type']??'';
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

/// id : 1
/// title : "test"
/// small_text : "test"
/// file_name : "Accounting.png"
/// file_type : "Banner"
/// file_url : "https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/banner/Accounting.png"
/// sort_order : 1
/// status : 1

class DashboardBannerList {
  DashboardBannerList({
    this.id,
    this.title,
    this.smallText,
    this.fileName,
    this.fileType,
    this.fileUrl,
    this.sortOrder,
    this.status,});

  DashboardBannerList.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    smallText = json['small_text'];
    fileName = json['file_name'];
    fileType = json['file_type'];
    fileUrl = json['file_url'];
    sortOrder = json['sort_order'];
    status = json['status'];
  }
  int? id;
  String? title;
  String? smallText;
  String? fileName;
  String? fileType;
  String? fileUrl;
  int? sortOrder;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['small_text'] = smallText;
    map['file_name'] = fileName;
    map['file_type'] = fileType;
    map['file_url'] = fileUrl;
    map['sort_order'] = sortOrder;
    map['status'] = status;
    return map;
  }

}