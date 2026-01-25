import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobileapp/common/constant/web_constant.dart';
import '../../local/shared_prefs/shared_prefs.dart';

class WebProvider extends GetConnect {
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  Future<Response> getWithRequest(String action, params) async {
    debugPrint("queryRequest ==  $params");
    if (WebConstants.auth) {
      String tokenValue = await SharedPrefs().getUserToken();
      debugPrint("tokenValue$tokenValue");
      headers.addAll({'Authorization': "Bearer ${tokenValue}"});
    }

    var mResponse = await get(action, query: params);
    return mResponse;
  }

  Future<Response> getWithWithoutRequest(String action) async {
    if (WebConstants.auth) {
      String tokenValue = await SharedPrefs().getUserToken();
      debugPrint("tokenValue$tokenValue");
      headers.addAll({'Authorization': "Bearer ${tokenValue}"});
    }
    debugPrint("getWithWithoutRequest ${WebConstants.baseUrlCommon}$action");
    Response mResponse = await get(WebConstants.baseUrlCommon + action);
    return mResponse;
  }

  Future<Response> postWithRequest(String action, params) async {
    if (WebConstants.auth) {
      String tokenValue = await SharedPrefs().getUserToken();
      debugPrint("tokenValue$tokenValue");
      headers.addAll({'Authorization': "Bearer ${tokenValue}"});
    }

    debugPrint("url ==  ${WebConstants.baseUrlCommon + action}");

    debugPrint("plainJsonRequest ==  ${jsonEncode(params)}");
    allowAutoSignedCert = true;
    // final url = Uri.parse( WebConstants.baseUrlCommon + action);
    // print("####### 33333");
    //
    // final response = await http.post(
    //   url,
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Accept': 'application/json',
    //   },
    //   body: jsonEncode(params),
    // );
    var mResponse = post(
      WebConstants.baseUrlCommon + action,
      jsonEncode(params),
      headers: headers,
    );

    return mResponse;
  }

Future<Response> postWithoutRequest(String action) async {
  try {
    if (WebConstants.auth) {
      String tokenValue = await SharedPrefs().getUserToken();
      debugPrint("tokenValue: $tokenValue");
      headers.addAll({'Authorization': "Bearer $tokenValue"});
    }
    debugPrint("url == ${WebConstants.baseUrlCommon + action}");
    debugPrint("headers: $headers");
    
    allowAutoSignedCert = true;
    
    var mResponse = await post(
      WebConstants.baseUrlCommon + action,
      "",
      headers: headers,
    ).timeout(const Duration(seconds: 30));
    
    debugPrint("Response status: ${mResponse.statusCode}");
    return mResponse;
    
  } on TimeoutException catch (e) {
    debugPrint("Timeout error: $e");
    rethrow;
  } catch (e) {
    debugPrint("Error: $e");
    rethrow;
  }
}

  Future<Response> postWithRequestAndAttachment(
    String action,
    Map<String, dynamic> productMap, {
    String filePath = "",
  }) async {
    try {
      if (WebConstants.auth) {
        String tokenValue = await SharedPrefs().getUserToken();
        debugPrint("tokenValue$tokenValue");
        headers.addAll({'Authorization': "Bearer ${tokenValue}"});
      }
      String picName = filePath.split("/").last;
      print("pic name: - $picName");
      print("url name: - ${WebConstants.baseUrlCommon + action}");
      MultipartFile mMultipartFile = MultipartFile(
        File(filePath),
        filename: picName,
        contentType: "multipart/form-data",
      );
      final form = FormData({
        'attachment': mMultipartFile,
      });

      allowAutoSignedCert = true;
      Response mResponse = await post(
        WebConstants.baseUrlCommon + action,
        form,
        headers: headers,
      );
      return mResponse;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
