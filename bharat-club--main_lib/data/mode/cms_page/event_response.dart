/// error : false
/// statusCode : 200
/// statusMessage : "OK"
/// data : {"id":2,"page_name":"EVENTS","title":null,"content":"<p><b>Every year, the club organizes a variety of programs and activities that encourage maximum participation by the members, especially the children.</b></p>\r\n\r\n<p>The typical club calendar consists of the following functions/activities</p>\r\n\r\n<ul><li>New Year Function</li><li>Holi</li><li>Morning Walk</li><li>Picnic</li><li>Diwali</li><li>Sports events</li><li>Badminton</li><li>Bowling</li><li>Cricket</li><li>Tennis</li></ul>\r\n\r\n<p>The club also organizes Quizzes, Speeches by experts and Performances by professionals in order to address the varied interests of all the members.</p>","status":1,"module":[{"id":1,"title":"tetinnnn update","description":"tesinnn update","start_date":"2024-04-18","end_date":"2024-04-18","status":1,"event_attachments":[{"id":1,"event_id":1,"file_name":"Accounting.png","file_type":"Event","file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/event/Accounting.png"}]},{"id":2,"title":"Event test","description":"Event test","start_date":"2024-05-01","end_date":"2024-05-01","status":1,"event_attachments":[{"id":2,"event_id":2,"file_name":"Accounting.png","file_type":"Event","file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/event/Accounting.png"}]}],"cms_page_attachments":[{"id":2,"cms_page_id":2,"title":"Events","small_text":"Participate IN our","file_name":"","file_type":null,"file_url":null}]}
/// responseTime : 1713939184

class EventResponse {
  EventResponse({
      this.error, 
      this.statusCode, 
      this.statusMessage, 
      this.data, 
      this.responseTime,});

  EventResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data = json['data'] != null ? EventData.fromJson(json['data']) : null;
    responseTime = json['responseTime'];
  }
  bool? error; 
  int? statusCode;
  String? statusMessage;
  EventData? data;
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

/// id : 2
/// page_name : "EVENTS"
/// title : null
/// content : "<p><b>Every year, the club organizes a variety of programs and activities that encourage maximum participation by the members, especially the children.</b></p>\r\n\r\n<p>The typical club calendar consists of the following functions/activities</p>\r\n\r\n<ul><li>New Year Function</li><li>Holi</li><li>Morning Walk</li><li>Picnic</li><li>Diwali</li><li>Sports events</li><li>Badminton</li><li>Bowling</li><li>Cricket</li><li>Tennis</li></ul>\r\n\r\n<p>The club also organizes Quizzes, Speeches by experts and Performances by professionals in order to address the varied interests of all the members.</p>"
/// status : 1
/// module : [{"id":1,"title":"tetinnnn update","description":"tesinnn update","start_date":"2024-04-18","end_date":"2024-04-18","status":1,"event_attachments":[{"id":1,"event_id":1,"file_name":"Accounting.png","file_type":"Event","file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/event/Accounting.png"}]},{"id":2,"title":"Event test","description":"Event test","start_date":"2024-05-01","end_date":"2024-05-01","status":1,"event_attachments":[{"id":2,"event_id":2,"file_name":"Accounting.png","file_type":"Event","file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/event/Accounting.png"}]}]
/// cms_page_attachments : [{"id":2,"cms_page_id":2,"title":"Events","small_text":"Participate IN our","file_name":"","file_type":null,"file_url":null}]

class EventData {
  EventData({
      this.id, 
      this.pageName, 
      this.title, 
      this.content, 
      this.status, 
      this.module, 
      this.cmsPageAttachments,});

  EventData.fromJson(dynamic json) {
    id = json['id'];
    pageName = json['page_name'];
    title = json['title'];
    content = json['content'];
    status = json['status'];
    if (json['module'] != null) {
      module = [];
      json['module'].forEach((v) {
        module?.add(EventModule.fromJson(v));
      });
    }
    if (json['cms_page_attachments'] != null) {
      cmsPageAttachments = [];
      json['cms_page_attachments'].forEach((v) {
        cmsPageAttachments?.add(EventAttachments.fromJson(v));
      });
    }
  }
  int? id;
  String? pageName;
  String? title;
  String? content;
  int? status;
  List<EventModule>? module;
  List<EventAttachments>? cmsPageAttachments;

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

/// id : 2
/// cms_page_id : 2
/// title : "Events"
/// small_text : "Participate IN our"
/// file_name : ""
/// file_type : null
/// file_url : null

class EventAttachments {
  EventAttachments({
      this.id, 
      this.cmsPageId, 
      this.title, 
      this.smallText, 
      this.fileName, 
      this.fileType, 
      this.fileUrl,});

  EventAttachments.fromJson(dynamic json) {
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
/// title : "tetinnnn update"
/// description : "tesinnn update"
/// start_date : "2024-04-18"
/// end_date : "2024-04-18"
/// status : 1
/// event_attachments : [{"id":1,"event_id":1,"file_name":"Accounting.png","file_type":"Event","file_url":"https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/event/Accounting.png"}]

class EventModule {
  EventModule({
      this.id, 
      this.title, 
      this.description, 
      this.startDate, 
      this.endDate, 
      this.status, 
      this.memberAdultAge,
      this.memberAdultAmount,
      this.memberChildStatus,
      this.memberChildAge,
      this.memberChildAmount,
      this.guestAdultAge,
      this.guestAdultAmount,
      this.guestChildStatus,
      this.guestChildAge,
      this.guestChildAmount,
      this.foodStatus,
      this.subscriptionStatus,
      this.eventAttachments,});

  EventModule.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    memberAdultAge = json['member_adult_age'];
    memberAdultAmount =  json['member_adult_amount'];
    memberChildStatus =  json['member_child_status'];
    memberChildAge = json['member_child_age'];
    memberChildAmount = json['member_child_amount'];
    guestAdultAge = json['guest_adult_age'];
    guestAdultAmount =  json['guest_adult_amount'];
    guestChildStatus = json['guest_child_status'];
    guestChildAge = json['guest_child_age'];
    guestChildAmount = json['guest_child_amount'];
    foodStatus = json['food_status'];
    subscriptionStatus = json['subscription_status'];
    if (json['event_attachments'] != null) {
      eventAttachments = [];
      json['event_attachments'].forEach((v) {
        eventAttachments?.add(EventModuleAttachments.fromJson(v));
      });
    }
  }
  int? id;
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  String? memberAdultAge;
  String? memberAdultAmount; 
  int? memberChildStatus; 
  String? memberChildAge;
  String? memberChildAmount; 
  String? guestAdultAge;
  String? guestAdultAmount;
  int? guestChildStatus;
  String? guestChildAge;
  String? guestChildAmount;
  int? foodStatus;
  int? subscriptionStatus; 
  int? status;

  List<EventModuleAttachments>? eventAttachments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['status'] = status;
    map['member_adult_age'] = memberAdultAge;
    map['member_adult_amount'] = memberAdultAmount;
    map['member_child_status'] = memberChildStatus;
    map['member_child_age'] = memberChildAge;
    map['member_child_amount'] = memberChildAmount;
    map['guest_adult_age'] = guestAdultAge;
    map['guest_adult_amount'] = guestAdultAmount;
    map['guest_child_status'] = guestChildStatus;
    map['guest_child_age'] = guestChildAge;
    map['guest_child_amount'] = guestChildAmount;
    map['food_status'] = foodStatus;
    map['subscription_status'] = subscriptionStatus;
    if (eventAttachments != null) {
      map['event_attachments'] = eventAttachments?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// event_id : 1
/// file_name : "Accounting.png"
/// file_type : "Event"
/// file_url : "https://hcm-storage.ap-south-1.linodeobjects.com/club_portal/event/Accounting.png"

class EventModuleAttachments {
  EventModuleAttachments({
      this.id, 
      this.eventId, 
      this.fileName, 
      this.fileType, 
      this.fileUrl,});

  EventModuleAttachments.fromJson(dynamic json) {
    id = json['id'];
    eventId = json['event_id'];
    fileName = json['file_name'];
    fileType = json['file_type'];
    fileUrl = json['file_url'];
  }
  int? id;
  int? eventId;
  String? fileName;
  String? fileType;
  String? fileUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['event_id'] = eventId;
    map['file_name'] = fileName;
    map['file_type'] = fileType;
    map['file_url'] = fileUrl;
    return map;
  }

}