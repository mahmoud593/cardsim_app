import 'package:firebase_auth/firebase_auth.dart';
import 'package:games_app/core/constants/urls.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/core/network/api_handle/http_request_handler.dart';
import 'package:games_app/core/network/api_handle/urls.dart';
import 'package:games_app/features/auth/data/auth_repo/auth_repo.dart';
import 'package:games_app/features/auth/data/models/auth_model.dart';
import 'package:games_app/features/auth/data/models/user_info_model.dart';
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

      print('Register response: ${response.toString()}');
      authModel=AuthModel.fromJson(response);
      UserDataFromStorage.setUserTokenFromStorage(authModel.token!);
      print('register success');

    }catch(e){

      print('Error in Register: ${e.toString()}');
    }

    return authModel??AuthModel();

  }

  @override
  Future<UserInfoModel> getUser() async{

    UserInfoModel userInfoModel = UserInfoModel();

    var response = await httpHelper.callService(
        url: getUserInfoUrl,
        responseType: ResponseType.get,
        authorization: true
    );

    print(response);

    userInfoModel=UserInfoModel.fromJson(response);
    print('Get user info: ${userInfoModel.toString()}');
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

        print(user.user!.email);

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

    print('login with google: ${authModel.toString()}');

   return authModel??AuthModel();

  }


}