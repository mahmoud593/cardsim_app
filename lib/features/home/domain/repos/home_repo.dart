import 'package:dartz/dartz.dart';
import 'package:games_app/features/home/domain/entities/check_field_entity.dart';
import 'package:games_app/features/home/domain/entities/create_order_entity.dart';
import 'package:games_app/features/home/domain/entities/image_slider_entity.dart';

import '../../../../core/errors/failure.dart';
import '../entities/categories_entity.dart';
import '../entities/companies_entity.dart';
import '../entities/products_entity.dart';
import '../entities/text_slider_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<CompaniesEntity>>> getCompanies();

  Future<Either<Failure, List<CategoriesEntity>>> getCategories();

  Future<Either<Failure, List<ProductsEntity>>> getProducts(int companyId);

  Future<Either<Failure, CheckFieldEntity>> checkField(
      String playerId, String type);

  Future<Either<Failure, CreateOrderEntity>> createOrder(
      int productId, int quantity, String field);

  Future<Either<Failure, List<ImageSliderEntity>>> getImageSlider();

  Future<Either<Failure, List<TextSliderEntity>>> getTextSlider();
}
