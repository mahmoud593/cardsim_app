import 'package:dio/dio.dart';
import 'package:games_app/features/home/data/models/companies_model.dart';

import '../../../../core/constants/urls.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/local/shared_preference/shared_preference.dart';
import '../../../../core/network/api_handle/http_request_handler.dart';
import '../../../../core/network/error_message_model.dart';
import '../models/categories_model.dart';
import '../models/check_field_model.dart';
import '../models/create_order_model.dart';
import '../models/products_model.dart';

class ApiServices {
  final Dio _dio = Dio();

  HttpHelper httpHelper = HttpHelper();

  Future<List<CompaniesModel>> getCompanies() async {
    final response = await _dio.get(
      UrlConstants.companiesUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer ${UserDataFromStorage.userTokenFromStorage}',
        },
      ),
    );
    if (response.statusCode == 200) {
     print('PROFILE API SERVICES>>>>>>>>>Bearer ${UserDataFromStorage.userTokenFromStorage}');
      return List<CompaniesModel>.from(
        (response.data['data'] as List).map(
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
          'Authorization': 'Bearer ${UserDataFromStorage.userTokenFromStorage}',
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

  Future<List<ProductsModel>> getProducts(int companyId) async {
    final response = await _dio.get(
      UrlConstants.productsUrl(companyId),
      options: Options(
        headers: {
          'Authorization': 'Bearer ${UserDataFromStorage.userTokenFromStorage}',
        },
      ),
    );
    if (response.statusCode == 200) {
      return List<ProductsModel>.from(
        (response.data as List).map(
          (e) => ProductsModel.fromJson(e),
        ),
      );
    } else {
      throw ServerExceptions(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  Future<CheckFieldModel> checkField(String playerId, String type) async {
    var parameter = {
      'player_id': playerId,
      'type': type,
    };

    final response = await _dio.post(
      UrlConstants.checkIdFieldUrl,
      data: parameter,
      options: Options(
        headers: {
          'Authorization': 'Bearer ${UserDataFromStorage.userTokenFromStorage}',
        },
      ),
    );
    if (response.statusCode == 200) {
      return CheckFieldModel.fromJson(response.data);
    } else {
      throw ServerExceptions(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  Future<CreateOrderModel> createOrder(int productId, int quantity, String field) async {
    //print(">>>>>>>>> $productId ,,,, $quantity ,,,, $field <<<<<<<<<<");
    var parameter = {
      'product': productId,
      'quantity': quantity,
      'field': field
    };

    final response = await _dio.post(
      UrlConstants.createOrderUrl,
      data: parameter,
      options: Options(
        headers: {
          'Authorization': 'Bearer ${UserDataFromStorage.userTokenFromStorage}',
        },
      ),
    );
    if (response.statusCode == 200) {
      return CreateOrderModel.fromJson(response.data);
    } else {
      throw ServerExceptions(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
}
}
