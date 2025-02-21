
import 'package:dio/dio.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';

class DioHelper {
  static Dio? dio;

  static dioInit() {
    dio = Dio(
      BaseOptions(
        baseUrl: '',
        receiveDataWhenStatusError: true,
        followRedirects: true,
        maxRedirects: 5,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    bool authorization =false,
  }) async {
    dio!.options.headers = {
      'Authorization': authorization ?
      'Bearer ${UserDataFromStorage.userTokenFromStorage}' : '',
      'Content-Type': 'application/json',
    };
    final res = await dio!.get(url, queryParameters: query,);
    return res;
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    bool authorization=false,
  }) async {
    dio!.options.headers = {
      'Authorization': authorization ?
      'Bearer ${UserDataFromStorage.userTokenFromStorage}' : '',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Connection': 'keep-alive',
    };
    final res= dio!.post(url,data: body);
    return res;
  }


}