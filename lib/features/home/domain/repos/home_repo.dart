import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/companies_entity.dart';

abstract class HomeRepo{
  Future<Either<Failure, List<CompaniesEntity>>> getCompanies();
}