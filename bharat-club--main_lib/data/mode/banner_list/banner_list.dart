
class BannerListResponse {
  BannerListResponse({
      this.error, 
      this.statusCode, 
      this.statusMessage, 
      this.data, 
      this.responseTime,});

  BannerListResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data = json['data'] != null ? BannerListResponseData.fromJson(json['data']) : null;
    responseTime = json['responseTime'];
  }
  
  bool? error;
  int? statusCode;
  String? statusMessage;
  BannerListResponseData? data;
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

class BannerListResponseData {
  BannerListResponseData({
      this.banner,});

  BannerListResponseData.fromJson(dynamic json) {
    // ✅ FIXED: Changed 'banner' to 'sponsor' to match API response
    if (json['sponsor'] != null) {
      banner = [];
      json['sponsor'].forEach((v) {
        banner?.add(BannerShow.fromJson(v));
      });
    }
  }
  
  List<BannerShow>? banner;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (banner != null) {
      map['sponsor'] = banner?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class BannerShow {
  BannerShow({
      this.id, 
      this.title, 
      this.smallText, 
      this.fileName, 
      this.fileType, 
      this.fileUrl,
      this.status,});

  BannerShow.fromJson(dynamic json) {
    id = json['id'];
    title = json['company_name'];
    smallText = json['website'];
    fileName = json['file_name'];
    fileType = json['file_type'];
    fileUrl = json['file_url'];
    status = json['status'];
  }
  
  int? id;
  String? title;
  String? smallText;
  String? fileName;
  String? fileType;
  String? fileUrl;
  int? status;
  
  // Getter methods for backward compatibility
  String? get image => fileUrl;
  String? get redirectionUrl => smallText;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['company_name'] = title;
    map['website'] = smallText;
    map['file_name'] = fileName;
    map['file_type'] = fileType;
    map['file_url'] = fileUrl;
    map['status'] = status;
    return map;
  }
}
