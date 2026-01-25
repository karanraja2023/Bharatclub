/*
 * Project      : organization
 * File         : forgot_password_request.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-09-25
 * Version      : 1.0
 * Ticket       : 
 */
//name:muthu
// mobile:9078675645
// email:partha.paul007@gmail.com
// profile:https://lh3.googleusercontent.com/a/ACg8ocIBKFmFRW_QmHemhgZIREXw7esuyKmuTsAUiRcDMUZMaVvq_ZIdFQ=s96-c
// type:NORMAL_LOGIN

class ForgotPasswordDeleteRequest {
  ForgotPasswordDeleteRequest({
    String? email,
  }) {
    _email = email;
  }

  ForgotPasswordDeleteRequest.fromJson(dynamic json) {
    _email = json['email'];
  }

  String? _email;

  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    return map;
  }
}
