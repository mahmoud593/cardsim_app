import 'package:dartz/dartz.dart';
import 'package:games_app/core/errors/exceptions.dart';
import 'package:games_app/core/errors/failure.dart';
import 'package:games_app/features/auth/data/data_source/register_data_source.dart';
import 'package:games_app/features/auth/data/models/auth_model.dart';
import 'package:games_app/features/auth/domain/repo/register_repo.dart';

class RegisterRepoImplement implements RegisterRepo{

  RegisterDataSource registerDataSource;

  RegisterRepoImplement({required this.registerDataSource});
  @override
  Future<Either<Failure, AuthModel>> register({
    required String email,
    required String password,
    required String name,
    required String phone
  }) async{

    try{
      return Right(
          await registerDataSource.register(
          email: email,
          password: password,
          name: name,
          phone: phone
      ));
    }on RegisterExceptions catch(e){
      return Left(
          ResponseFailure(e.errorModel.errors!));
    }

  }


}