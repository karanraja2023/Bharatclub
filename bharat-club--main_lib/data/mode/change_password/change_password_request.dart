//name:muthu
// mobile:9078675645
// email:partha.paul007@gmail.com
// profile:https://lh3.googleusercontent.com/a/ACg8ocIBKFmFRW_QmHemhgZIREXw7esuyKmuTsAUiRcDMUZMaVvq_ZIdFQ=s96-c
// type:NORMAL_LOGIN

class ChangePasswordRequest{
  ChangePasswordRequest({
    String? oldPassword,
    String? password,
  }) {
    _oldPassword = oldPassword;
    _password = password;
  }

  ChangePasswordRequest.fromJson(dynamic json) {
    _oldPassword = json['oldPassword'];
    _password = json['newpassword'];
  }

  String? _oldPassword;
  String? _password;

  String? get oldPassword => _oldPassword;

  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['oldpassword'] = _oldPassword;
    map['newpassword'] = _password;
    return map;
  }
}
