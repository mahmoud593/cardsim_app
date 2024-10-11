
import 'package:flutter/material.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/core/network/api_handle/http_request_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

enum ResponseType {
  post,
  get,
  put,
  delete,
}

class HttpHelper {
  /// TO CALL ANY API [post-get-put-delete]

  Future<dynamic> callService(
      {required String url,
      required ResponseType responseType,
      bool authorization = false,
      var parameter}) async {
    http.Response? response;
    Map<String, String> header = {
      'Accept': 'application/json',
      "Content-type": "application/json",
      'Authorization': authorization
          ? "Bearer ${UserDataFromStorage.userTokenFromStorage}"
          : "",
    };
    try {
      switch (responseType) {
        case ResponseType.post:
          await http
              .post(Uri.parse(url),
                  headers: header, body: jsonEncode(parameter))
              .then((value) {
            response = value;
          }).timeout(const Duration(seconds: 30));
          break;
        case ResponseType.get:
          await http.get(Uri.parse(url), headers: header).then((value) {
            response = value;
          }).timeout(const Duration(seconds: 30));
          break;
        case ResponseType.put:
          await http
              .put(Uri.parse(url), headers: header, body: jsonEncode(parameter))
              .then((value) {
            response = value;
          }).timeout(const Duration(seconds: 30));
          break;
        case ResponseType.delete:
          await http
              .delete(Uri.parse(url),
                  headers: header, body: jsonEncode(parameter))
              .then((value) {
            response = value;
          }).timeout(const Duration(seconds: 30));
          break;
      }
    } on SocketException {
      throw InternetException('internet');
    } on TimeoutException {
      throw TimeOutException('');
    }
    return responseExceptionHandler(response!);
  }
}

///Exception STATUE
dynamic responseExceptionHandler(http.Response response) {
  // print('esooo ${response.body}');
  // final bottomBarProvider = Provider.of<BottomBarProvider>(ZCardApp.navigatorKey.currentState!.context,listen: false);

  switch (response.statusCode) {
    // success response
    case 200:
      return json.decode(response.body);
    case 401:
    case 403:
      debugPrint('Unauthorised Exception');

      return json.decode(response.body);
    case 404:
      // Not Found Exception
      debugPrint('Not Found 404');

      return json.decode(response.body);
    case 400:
      // bad request Exception
      debugPrint('bad request or otp wrong=${response.statusCode}');
      return json.decode(response.body);
    case 408:
      // Time Out Exception
      debugPrint('Time Out Exception 408');

      return json.decode(response.body);
    case 204:
      debugPrint('timeOutErrorMessage');
      break;

    default:
      debugPrint('publicErrorMessage');
  }
}
