import 'package:dartz/dartz.dart';
import 'package:games_app/features/home/data/data_source/api_services.dart';
import 'package:games_app/features/home/domain/entities/companies_entity.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repos/home_repo.dart';

class HomeRepoImp implements HomeRepo {
  final ApiServices remoteDataSource;

  HomeRepoImp(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CompaniesEntity>>> getCompanies() async {
    final result = await remoteDataSource.getCompanies();
    try {
      //print(result);
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
