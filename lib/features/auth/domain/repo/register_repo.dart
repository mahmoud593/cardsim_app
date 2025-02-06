import 'package:dartz/dartz.dart';
import 'package:games_app/core/errors/failure.dart';
import 'package:games_app/features/auth/data/models/auth_model.dart';

abstract class RegisterRepo{

  Future<Either<Failure,AuthModel>> register(
      {
        required String email,
        required String password,
        required String name,
        required String phone
      });

}