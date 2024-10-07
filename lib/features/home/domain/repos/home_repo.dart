import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/categories_entity.dart';
import '../entities/companies_entity.dart';
import '../entities/products_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<CompaniesEntity>>> getCompanies();

  Future<Either<Failure, List<CategoriesEntity>>> getCategories();

  Future<Either<Failure, List<ProductsEntity>>> getProducts(int companyId);
}
