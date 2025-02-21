import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:games_app/core/constants/urls.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/core/network/api_handle/http_request_handler.dart';
import 'package:games_app/core/network/api_handle/urls.dart';
import 'package:games_app/core/network/dio_helper.dart';
import 'package:games_app/features/auth/data/auth_repo/auth_repo.dart';
import 'package:games_app/features/auth/data/models/auth_model.dart';
import 'package:games_app/features/auth/data/models/user_info_model.dart';
import 'package:games_app/features/auth/presentation/view/screens/register_screen.dart';
import 'package:games_app/features/auth/presentation/view/widgets/insert_code_dialog_widget.dart';
import 'package:games_app/features/google_autherized/presentation/view/screens/insert_google_code_screen.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/widgets/toast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;


class AuthRepoImplement implements AuthRepo{

  HttpHelper httpHelper = HttpHelper();
  @override
  Future<AuthModel> login({required String email, required String password}) async{

    AuthModel authModel=AuthModel();

    var parameter = {
      'email' : email,
      'password' : password
    };

    try{
      var response = await httpHelper.callService(
        responseType: ResponseType.post,
        url: loginUrl,
        parameter: parameter,
        authorization: false,
      );



      print('Login response: ${response.toString()}');
      authModel=AuthModel.fromJson(response);
      UserDataFromStorage.setUserTokenFromStorage(authModel.token!);
      await updateToken(token: authModel.token!);
      print('login success');

    }catch(e){
      print('Error in login: ${e.toString()}');
    }

    return authModel??AuthModel();

  }

  @override
  Future<AuthModel> register({
    required String email,
    required String password,
    required String name,
    required String phone
  }) async{
    AuthModel authModel=AuthModel();

    var parameter = {
      'email' : email,
      'password' : password,
      'name' : name,
      'phone' : phone,
    };

    print('parameter: ${parameter.toString()}');
    try{
      var response = await httpHelper.callService(
        responseType: ResponseType.post,
        url: registerUrl,
        parameter: parameter,
        authorization: false,
      );

      var result = await DioHelper.postData(
          url: registerUrl,
          body: parameter,
      );
      print('Status code: ${result.statusCode}');
      print('result: ${result.data}');

      print('Register response: ${response.toString()}');
      authModel=AuthModel.fromJson(response);
      UserDataFromStorage.setUserTokenFromStorage(authModel.token!);
      await updateToken(token: authModel.token!);
      print('register success');

    }catch(e){
      print('Error in Register: ${e.toString()}');
    }

    return authModel??AuthModel();

  }

  @override
  Future<UserInfoModel> getUser({required context}) async{

    UserInfoModel userInfoModel = UserInfoModel();

    var response = await httpHelper.callService(
        url:getUserInfoUrl,
        responseType: ResponseType.get,
        authorization: true
    );

    print('Token ${UserDataFromStorage.userTokenFromStorage}');
    print(response);
    if(response['status'] == false){
      print('Insert code dialog');
      customPushAndRemoveUntil(context, InsertGoogleCodeScreen());
      //  insertCodeDialogWidget(
      //   context: context,
      //   controller:  codeController
      // );
    }else {
      if (response != null) {
        userInfoModel = UserInfoModel.fromJson(response);
        print('Get user info: ${userInfoModel.toString()}');
      }
    }

    return userInfoModel??UserInfoModel();
  }

  @override
  Future<dynamic> loginWithGoogle() async{
      try {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        var user =await FirebaseAuth.instance.signInWithCredential(credential);

        print('user: ${user.toString()}');

        return googleAuth?.accessToken;
      } on Exception catch (e) {
        print('exception->$e');
      }
    }

  @override
  Future <AuthModel> loginWithAccessToken({required String accessToken }) async{

    AuthModel authModel=AuthModel();

    var parameter = {
      "access_token" : accessToken
    };

   var response = await httpHelper.callService(
        url: UrlConstants.loginWithGoogleUrl,
        responseType: ResponseType.post,
        authorization: false,
        parameter:parameter,
    );

    authModel =AuthModel.fromJson(response);
    UserDataFromStorage.setUserTokenFromStorage(authModel.token!);
    await updateToken(token: authModel.token!);
    print('login with google: ${authModel.toString()}');

   return authModel??AuthModel();

  }

  @override
  Future<void> updateToken({required String token}) async{
    try{
      var response = await httpHelper.callService(
        responseType: ResponseType.post,
        url: updateTokenUrl,
        parameter: {
            "device_token":token
        },
        authorization: true,
      );

      print('Response: ${response.toString()}');
      // customToast(title: response['message'], color: ColorManager.primary);

    }catch(e){
      print('Error in updateToken: ${e.toString()}');
    }
  }


}