/// error : false
/// statusCode : 200
/// statusMessage : "OK"
/// data : {"id":1,"page_name":"ABOUT_US","title":"","content":"<p>History</p>\r\n\r\n<p><b>Bharat Club Kuala Lumpur Established in Year 1974 is a reputed social club based in Kuala Lumpur with the Honorable High Commissioner of India to Malaysia as the Patron.</b></p>\r\n\r\n<p>The Club is primarily for Indian expatriates working and living in Malaysia. However, the membership is open to all Indians with certain membership requirements.</p>\r\n\r\n<p>Most of our members are well established professionals in the leading Global and Malaysian Corporates and Institutions</p>\r\n\r\n<p>Bharat club organizes various functions and events such as New Year Function, Holi, Morning walk, Picnic, Diwali function and sport events like Tennis, Badminton, cricket, Bowling for member families.</p>\r\n\r\n<p>Ladies wing of our club also organizes some ladies&rsquo; specific events such as cookery demos, handicrafts workshops etc.</p>\r\n\r\n<p>We welcome you to join our Esteemed Club and connect with our fellow Indians who came from all parts of India with diverse cultural and regional flavours in true spirits of Unity in Diversity.</p>\r\n\r\n<p>The Club endeavours to connect new expats as they arrive in this amazing city and makes them feel at &ldquo; home away from home&rdquo; and am extended family in Kuala Lumpur .</p>\r\n\r\n<p>Over the years, the club has organized several charity events and contributed over MYR 400,000 to various charitable organizations in India and Malaysia.</p>","status":1,"module":[],"cms_page_attachments":[{"id":1,"cms_page_id":1,"title":"About Us","small_text":"A few words","file_name":"","file_type":null,"file_url":null}]}
/// responseTime : 1714102604

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

/// id : 1
/// page_name : "ABOUT_US"
/// title : ""
/// content : "<p>History</p>\r\n\r\n<p><b>Bharat Club Kuala Lumpur Established in Year 1974 is a reputed social club based in Kuala Lumpur with the Honorable High Commissioner of India to Malaysia as the Patron.</b></p>\r\n\r\n<p>The Club is primarily for Indian expatriates working and living in Malaysia. However, the membership is open to all Indians with certain membership requirements.</p>\r\n\r\n<p>Most of our members are well established professionals in the leading Global and Malaysian Corporates and Institutions</p>\r\n\r\n<p>Bharat club organizes various functions and events such as New Year Function, Holi, Morning walk, Picnic, Diwali function and sport events like Tennis, Badminton, cricket, Bowling for member families.</p>\r\n\r\n<p>Ladies wing of our club also organizes some ladies&rsquo; specific events such as cookery demos, handicrafts workshops etc.</p>\r\n\r\n<p>We welcome you to join our Esteemed Club and connect with our fellow Indians who came from all parts of India with diverse cultural and regional flavours in true spirits of Unity in Diversity.</p>\r\n\r\n<p>The Club endeavours to connect new expats as they arrive in this amazing city and makes them feel at &ldquo; home away from home&rdquo; and am extended family in Kuala Lumpur .</p>\r\n\r\n<p>Over the years, the club has organized several charity events and contributed over MYR 400,000 to various charitable organizations in India and Malaysia.</p>"
/// status : 1
/// module : []
/// cms_page_attachments : [{"id":1,"cms_page_id":1,"title":"About Us","small_text":"A few words","file_name":"","file_type":null,"file_url":null}]

class AboutUsData {
  AboutUsData({
    this.id,
    this.pageName,
    this.title,
    this.content,
    this.status,
    // this.module,
    this.cmsPageAttachments,
  });

  AboutUsData.fromJson(dynamic json) {
    id = json['id'];
    pageName = json['page_name'];
    title = json['title'];
    content = json['content'];
    status = json['status'];
    // if (json['module'] != null) {
    //   module = [];
    //   json['module'].forEach((v) {
    //     module?.add(Dynamic.fromJson(v));
    //   });
    // }
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

  // List<dynamic>? module;
  List<CmsPageAboutUsAttachments>? cmsPageAttachments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['page_name'] = pageName;
    map['title'] = title;
    map['content'] = content;
    map['status'] = status;
    // if (module != null) {
    //   map['module'] = module?.map((v) => v.toJson()).toList();
    // }
    if (cmsPageAttachments != null) {
      map['cms_page_attachments'] =
          cmsPageAttachments?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// cms_page_id : 1
/// title : "About Us"
/// small_text : "A few words"
/// file_name : ""
/// file_type : null
/// file_url : null

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
