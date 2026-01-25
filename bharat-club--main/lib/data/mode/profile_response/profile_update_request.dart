class ProfileUpdateRequest {
  ProfileUpdateRequest({
    String? name,
    String? mobile,
    bool? isPoc,
    String? email,
    String? pocFirstName,
    String? pocMobile,
    String? pocEmail,
    String? companyName,
    String? designation,
    String? location,
    String? companyWebsite,
    String? membershipId,
    String? linkedinUrl,
    String? childOne,
    String? childTwo,
    String? childThree,
    String? childFour,
  }) {
    _name = name;
    _mobile = mobile;
    _email = email;
    _isPoc = isPoc;

    _pocFirstName = pocFirstName;
    _pocMobile = pocMobile;
    _pocEmail = pocEmail;

    _companyName = companyName;
    _designation = designation;
    _location = location;
    _companyWebsite = companyWebsite;
    _linkedinUrl = linkedinUrl;

    _childOne = childOne;
    _childTwo = childTwo;
    _childThree = childThree;
    _childFour = childFour;
  }

  ProfileUpdateRequest.fromJson(dynamic json) {
    _name = json['name'];
    _mobile = json['mobile'];
    _isPoc = json['is_poc'];
    _email = json['email'];

    _pocFirstName = json['poc_first_name'];
    _pocMobile = json['poc_mobile'];
    _pocEmail = json['poc_email'];

    _companyName = json['company_name'];
    _designation = json['designation'];
    _location = json['location'];
    _companyWebsite = json['company_website'];
    _linkedinUrl = json['linkedin_url'];

    _childOne = json['child_one'];
    _childTwo = json['child_two'];
    _childThree = json['child_three'];
    _childFour = json['child_four'];
  }

  String? _name;
  String? _mobile;
  bool? _isPoc;
  String? _email;

  String? _pocFirstName;
  String? _pocMobile;
  String? _pocEmail;

  String? _companyName;
  String? _designation;
  String? _location;
  String? _companyWebsite;
  String? _linkedinUrl;

  String? _childOne;
  String? _childTwo;
  String? _childThree;
  String? _childFour;

  String? get name => _name;
  String? get mobile => _mobile;
  String? get email => _email;
  bool? get isPoc => _isPoc;

  String? get pocFirstName => _pocFirstName;
  String? get pocMobile => _pocMobile;
  String? get pocEmail => _pocEmail;

  String? get companyName => _companyName;
  String? get designation => _designation;
  String? get location => _location;
  String? get companyWebsite => _companyWebsite;
  String? get linkedinUrl => _linkedinUrl;

  String? get childOne => _childOne;
  String? get childTwo => _childTwo;
  String? get childThree => _childThree;
  String? get childFour => _childFour;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    // Always include base user fields if present
    if (_name != null) map['name'] = _name;
    if (_mobile != null) map['mobile'] = _mobile;
    if (_email != null) map['email'] = _email;
    if (_isPoc != null) map['is_poc'] = _isPoc! ? 1 : 0;

    // POC fields
    if (_pocFirstName != null) map['poc_first_name'] = _pocFirstName;
    if (_pocEmail != null) map['poc_email'] = _pocEmail;
    if (_pocMobile != null) map['poc_mobile'] = _pocMobile;

    // Child fields — ALWAYS include if not null/empty
    if (_childOne != null && _childOne!.isNotEmpty)
      map['child_one'] = _childOne;
    if (_childTwo != null && _childTwo!.isNotEmpty)
      map['child_two'] = _childTwo;
    if (_childThree != null && _childThree!.isNotEmpty)
      map['child_three'] = _childThree;
    if (_childFour != null && _childFour!.isNotEmpty)
      map['child_four'] = _childFour;

    // Professional fields
    if (_companyName != null) map['company_name'] = _companyName;
    if (_designation != null) map['designation'] = _designation;
    if (_location != null) map['location'] = _location;
    if (_companyWebsite != null) map['company_website'] = _companyWebsite;
    if (_linkedinUrl != null) map['linkedin_url'] = _linkedinUrl;

    return map;
  }
}
