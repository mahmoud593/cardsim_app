import 'package:flutter/material.dart';
import 'package:games_app/features/auth/data/models/auth_model.dart';
import 'package:games_app/features/auth/data/models/user_info_model.dart';

abstract class AuthRepo{

  Future<AuthModel> login({required String email,required String password});

  Future<void> updateToken({required String token});

  Future<UserInfoModel> getUser({required context});

  Future<dynamic> loginWithGoogle();

  Future<AuthModel> loginWithAccessToken({required String accessToken});

}