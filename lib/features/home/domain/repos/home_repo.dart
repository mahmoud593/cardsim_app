import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/companies_model.dart';
import '../entities/companies_entity.dart';

abstract class HomeRepo{
  Future<Either<Failure, List<CompaniesModel>>> getCompanies();
}