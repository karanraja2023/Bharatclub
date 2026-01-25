enum RegistrationRequestType { GOOGLE_LOGIN, NORMAL_LOGIN }

class RegistrationRequest {
  RegistrationRequest({
    String? name,
    String? mobile,
    String? email,
    String? password,
    String? profile,
    String? type,
    String? deviceId,          // <-- NEW FIELD
  }) {
    _name = name;
    _mobile = mobile;
    _email = email;
    _password = password;
    _profile = profile;
    _type = type;
    _deviceId = deviceId;      // <-- NEW FIELD
  }

  RegistrationRequest.fromJson(dynamic json) {
    _email = json['email'];
    _password = json['password'];
    _deviceId = json['device_id']; // <-- GET FROM API IF NEEDED
  }

  String? _name;
  String? _mobile;
  String? _email;
  String? _password;
  String? _profile;
  String? _type;
  String? _deviceId;           // <-- NEW FIELD

  String? get name => _name;
  String? get mobile => _mobile;
  String? get email => _email;
  String? get password => _password;
  String? get profile => _profile;
  String? get type => _type;
  String? get deviceId => _deviceId; // <-- GETTER

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['email'] = _email;
    map['password'] = _password;
    map['device_id'] = _deviceId;   // <-- IMPORTANT (SENDS TO BACKEND)

    return map;
  }
}
