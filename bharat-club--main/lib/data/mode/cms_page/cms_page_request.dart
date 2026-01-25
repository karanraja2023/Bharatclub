// {
// "page_name": "EVENTS"
// // ABOUT_US | EVENTS | NEWS | GALLERY | CONTACT
// }
enum CmsPageRequestType { ABOUT_US, EVENTS,NEWS,GALLERY,CONTACT }

class CmsPageRequest {
  CmsPageRequest({
    String? name,
  }) {
    _name = name;
  }

  CmsPageRequest.fromJson(dynamic json) {
    _name = json['page_name'];
  }

  String? _name;

  String? get name => _name;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page_name'] = _name;
    return map;
  }
}
