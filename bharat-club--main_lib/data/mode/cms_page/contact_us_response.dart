/// error : false
/// statusCode : 200
/// statusMessage : "OK"
/// data : {"id":4,"page_name":"CONTACT","title":null,"content":null,"status":1,"module":[{"id":1,"name":"The Association Of Global Organisation Of People Of Indian Origin (GOPIO Malaysia)","latitude":null,"longitude":null,"location":"MALAYSIA (International Secretariat)","primary_mobile":"60 18244 2124","secondary_mobile":"60 18244 2124","email":"secretariat@gopio.org.my","website":"https://www.gopio.org.my/","address":"No. 2B, 2nd Floor, Pearl Court, Jalan Thamby Abdullah, 50470 Kuala Lumpur, Malaysia.","status":1}],"cms_page_attachments":[{"id":4,"cms_page_id":4,"title":"Contact","small_text":"Get in touch","file_name":"","file_type":null,"file_url":null}]}
/// responseTime : 1713939893

class ContactUsResponse {
  ContactUsResponse({
      this.error, 
      this.statusCode, 
      this.statusMessage, 
      this.data, 
      this.responseTime,});

  ContactUsResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data = json['data'] != null ? ContactData.fromJson(json['data']) : null;
    responseTime = json['responseTime'];
  }
  bool? error;
  int? statusCode;
  String? statusMessage;
  ContactData? data;
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

/// id : 4
/// page_name : "CONTACT"
/// title : null
/// content : null
/// status : 1
/// module : [{"id":1,"name":"The Association Of Global Organisation Of People Of Indian Origin (GOPIO Malaysia)","latitude":null,"longitude":null,"location":"MALAYSIA (International Secretariat)","primary_mobile":"60 18244 2124","secondary_mobile":"60 18244 2124","email":"secretariat@gopio.org.my","website":"https://www.gopio.org.my/","address":"No. 2B, 2nd Floor, Pearl Court, Jalan Thamby Abdullah, 50470 Kuala Lumpur, Malaysia.","status":1}]
/// cms_page_attachments : [{"id":4,"cms_page_id":4,"title":"Contact","small_text":"Get in touch","file_name":"","file_type":null,"file_url":null}]

class ContactData {
  ContactData({
      this.id, 
      this.pageName, 
      this.title, 
      this.content, 
      this.status, 
      this.module, 
      this.cmsPageAttachments,});

  ContactData.fromJson(dynamic json) {
    id = json['id'];
    pageName = json['page_name'];
    title = json['title'];
    content = json['content'];
    status = json['status'];
    if (json['module'] != null) {
      module = [];
      json['module'].forEach((v) {
        module?.add(ContactModule.fromJson(v));
      });
    }
    if (json['cms_page_attachments'] != null) {
      cmsPageAttachments = [];
      json['cms_page_attachments'].forEach((v) {
        cmsPageAttachments?.add(ContactUsAttachments.fromJson(v));
      });
    }
  }
  int? id;
  String? pageName;
  String? title;
  String? content;
  int? status;
  List<ContactModule>? module;
  List<ContactUsAttachments>? cmsPageAttachments;

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
      map['cms_page_attachments'] = cmsPageAttachments?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 4
/// cms_page_id : 4
/// title : "Contact"
/// small_text : "Get in touch"
/// file_name : ""
/// file_type : null
/// file_url : null

class ContactUsAttachments {
  ContactUsAttachments({
      this.id, 
      this.cmsPageId, 
      this.title, 
      this.smallText, 
      this.fileName, 
      this.fileType, 
      this.fileUrl,});

  ContactUsAttachments.fromJson(dynamic json) {
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

/// id : 1
/// name : "The Association Of Global Organisation Of People Of Indian Origin (GOPIO Malaysia)"
/// latitude : null
/// longitude : null
/// location : "MALAYSIA (International Secretariat)"
/// primary_mobile : "60 18244 2124"
/// secondary_mobile : "60 18244 2124"
/// email : "secretariat@gopio.org.my"
/// website : "https://www.gopio.org.my/"
/// address : "No. 2B, 2nd Floor, Pearl Court, Jalan Thamby Abdullah, 50470 Kuala Lumpur, Malaysia."
/// status : 1

class ContactModule {
  ContactModule({
      this.id, 
      this.name, 
      this.latitude, 
      this.longitude, 
      this.location, 
      this.primaryMobile, 
      this.secondaryMobile, 
      this.email, 
      this.website, 
      this.address, 
      this.status,});

  ContactModule.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    primaryMobile = json['primary_mobile'];
    secondaryMobile = json['secondary_mobile'];
    email = json['email'];
    website = json['website'];
    address = json['address'];
    status = json['status'];
  }
  int? id;
  String? name;
  dynamic latitude;
  dynamic longitude;
  String? location;
  String? primaryMobile;
  String? secondaryMobile;
  String? email;
  String? website;
  String? address;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['location'] = location;
    map['primary_mobile'] = primaryMobile;
    map['secondary_mobile'] = secondaryMobile;
    map['email'] = email;
    map['website'] = website;
    map['address'] = address;
    map['status'] = status;
    return map;
  }

}