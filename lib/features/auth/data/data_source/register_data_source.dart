import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:games_app/core/errors/exceptions.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/core/network/api_handle/http_request_handler.dart';
import 'package:games_app/core/network/api_handle/urls.dart';
import 'package:games_app/core/network/dio_helper.dart';
import 'package:games_app/features/auth/data/models/auth_model.dart';
import 'package:games_app/features/auth/data/models/error_model.dart';
import 'package:games_app/styles/widgets/toast.dart';

abstract class RegisterDataSource{

  Future<AuthModel> register(
      {
        required String email,
        required String password,
        required String name,
        required String phone
      });

}

HttpHelper httpHelper = HttpHelper();

class RegisterDataSourceImplement implements RegisterDataSource{

  @override
  Future<AuthModel> register({
    required String email,
    required String password,
    required String name,
    required String phone
  }) async {
    AuthModel authModel = AuthModel();
    try{

      var result = await DioHelper.postData(
        url:'https://cardsim.net/api/register',
        body:{
          "name" : name,
          "email" : email,
          "phone" : phone,
          "password" : password
        },
      );

      print('Register response: ${result.toString()}');
      authModel = AuthModel.fromJson(result.data);
      UserDataFromStorage.setUserTokenFromStorage(authModel.token!);
      print('Status code: ${result.statusCode}');
      if (result.statusCode == 200) {
        return authModel;
      } else if (result.statusCode == 422) {
        throw RegisterExceptions(errorModel: ErrorModel.fromJson(result.data));
      }else{
        print('result: ${result.data}');
        throw Exception(ErrorModel.fromJson(result.data).message);
      }
    }on DioException catch (error) {
      if (error.response != null) {
        final responseData = error.response!.data;
         print('Error is ${error.response!.data}');
        if (responseData is Map<String, dynamic> && responseData.containsKey('errors')) {
          final errors = responseData['errors'];

          String errorMessage = '';

          if (errors.containsKey('name')) {
            errorMessage += 'الاسم مستخدم من قبل , ';
          }
          if (errors.containsKey('email')) {
            errorMessage += 'البريد الإلكتروني مستخدم من قبل ,';
          }
          if (errors.containsKey('password')) {
            errorMessage += 'يجب أن يكون طول كلمة المرور على الأقل 8 حروفٍ/حرفًا ,';
          }


          customToast(title: '${errorMessage.trim()}', color: Colors.red);
        } else {
          print('حدث خطأ أثناء التسجيل.');
        }
      } else {
        print('حدث خطأ غير متوقع.');
      }      throw RegisterExceptions(errorModel: ErrorModel.fromJson(error.response!.data));
    }


  }

}