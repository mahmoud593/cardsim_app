import 'package:games_app/features/auth/data/models/auth_model.dart';
import 'package:games_app/features/auth/data/models/user_info_model.dart';

abstract class AuthRepo{

  Future<AuthModel> login({required String email,required String password});

  Future<AuthModel> register({required String email,required String password,required String name,required String phone});

  Future<UserInfoModel> getUser();

  Future<dynamic> loginWithGoogle();

  Future<AuthModel> loginWithAccessToken({required String accessToken});

}