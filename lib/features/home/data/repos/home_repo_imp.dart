import 'package:dartz/dartz.dart';
import 'package:games_app/features/home/data/data_source/api_services.dart';
import 'package:games_app/features/home/data/models/check_field_model.dart';
import 'package:games_app/features/home/data/models/image_slider_model.dart';
import 'package:games_app/features/home/domain/entities/categories_entity.dart';
import 'package:games_app/features/home/domain/entities/companies_entity.dart';
import 'package:games_app/features/home/domain/entities/image_slider_entity.dart';
import 'package:games_app/features/home/domain/entities/notification_entity.dart';
import 'package:games_app/features/home/domain/entities/products_entity.dart';
import 'package:games_app/features/home/domain/entities/settings_entity.dart';
import 'package:games_app/features/home/domain/entities/text_slider_entity.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repos/home_repo.dart';
import '../models/create_order_model.dart';

class HomeRepoImp implements HomeRepo {
  final ApiServices apiServices;

  HomeRepoImp(this.apiServices);

  @override
  Future<Either<Failure, List<CompaniesEntity>>> getCompanies() async {
    final result = await apiServices.getCompanies();
    try {
      //print(result);
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<CategoriesEntity>>> getCategories() async {
    final result = await apiServices.getCategories();
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<ProductsEntity>>> getProducts(
      int companyId) async {
    final result = await apiServices.getProducts(companyId);
    try {
      print(result);
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, CheckFieldModel>> checkField(
      String playerId, String type) async {
    final result = await apiServices.checkField(playerId, type);
    try {
      print(result);
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, CreateOrderModel>> createOrder(
      int productId, int quantity, String field) async {
    final result = await apiServices.createOrder(productId, quantity, field);
    try {
      print(result);
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<ImageSliderEntity>>> getImageSlider() async {
    final result = await apiServices.getImageSlider();
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<TextSliderEntity>>> getTextSlider() async{
   final result = await apiServices.getTextSlider();
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications({required bool isLoadMore}) async{
    final result = await apiServices.getNotifications();
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, void>> insertGoogleCode({required String code}) async{
    final result = await apiServices.insertGoogleCode(code: code);
    try {
      return Right(result);
    } on GoogleAuthExceptions catch (failure) {
      return Left(ServerFailure(failure.googleAuthError.message!));
    }
  }

  @override
  Future<Either<Failure, void>> updateDeviceToken({required String token}) async{
    final result = await apiServices.updateDeviceToken(token: token);
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
