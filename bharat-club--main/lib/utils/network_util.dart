import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtils {
  static final NetworkUtils _instance = NetworkUtils._internal();

  factory NetworkUtils() => _instance;

  NetworkUtils._internal();

  var listenForNetwork = StreamController<bool>.broadcast();

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    }
    return false;
  }
}
