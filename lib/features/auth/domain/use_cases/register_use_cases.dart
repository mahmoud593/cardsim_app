import 'package:dartz/dartz.dart';
import 'package:games_app/core/errors/failure.dart';
import 'package:games_app/features/auth/data/models/auth_model.dart';
import 'package:games_app/features/auth/domain/repo/register_repo.dart';

class RegisterUseCases{

  RegisterRepo registerRepo;

  RegisterUseCases(this.registerRepo);

  Future<Either<Failure, AuthModel>> register({
    required String email,
    required String password,
    required String name,
    required String phone
  })async{

    return await registerRepo.register(email: email, password: password, name: name, phone: phone);

  }


}