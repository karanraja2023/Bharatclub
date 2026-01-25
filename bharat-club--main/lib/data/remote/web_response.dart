
class WebResponseSuccess {
  WebResponseSuccess({
      bool? error, 
      int? statusCode, 
      String? statusMessage, 
      dynamic data,}){
    _error = error;
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _data = data;
}

  bool? _error;
  int? _statusCode;
  String? _statusMessage;
  dynamic _data;

  bool? get error => _error;
  int? get statusCode => _statusCode;
  String? get statusMessage => _statusMessage;
  dynamic get data => _data;

}
