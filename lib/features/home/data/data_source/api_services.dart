import 'package:dio/dio.dart';
import 'package:games_app/features/home/data/models/companies_model.dart';

import '../../../../core/constants/urls.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/error_message_model.dart';
import '../models/categories_model.dart';

class ApiServices {
  final Dio _dio = Dio();

  Future<List<CompaniesModel>> getCompanies() async {
    final response = await _dio.get(
      UrlConstants.companiesUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer ${UrlConstants.token}',
        },
      ),
    );
    if (response.statusCode == 200) {
      return List<CompaniesModel>.from(
        (response.data as List).map(
          (e) => CompaniesModel.fromJson(e),
        ),
      );
    } else {
      throw ServerExceptions(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  Future<List<CategoriesModel>> getCategories() async {
    final response = await _dio.get(
      UrlConstants.categoriesUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer ${UrlConstants.token}',
        },
      ),
    );
    if (response.statusCode == 200) {
      return List<CategoriesModel>.from(
        (response.data as List).map(
          (e) => CategoriesModel.fromJson(e),
        ),
      );
    } else {
      throw ServerExceptions(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }
}
