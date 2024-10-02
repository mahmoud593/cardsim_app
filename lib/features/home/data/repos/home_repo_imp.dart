import 'package:dartz/dartz.dart';
import 'package:games_app/features/home/data/data_source/remote_data_source.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/companies_entity.dart';
import '../../domain/repos/home_repo.dart';
import '../models/companies_model.dart';

class HomeRepoImp extends HomeRepo {

final RemoteDataSource remoteDataSource;

  HomeRepoImp(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CompaniesModel>>> getCompanies() async{
    final result = await remoteDataSource.getCompanies();
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}