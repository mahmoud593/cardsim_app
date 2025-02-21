import 'package:dio/dio.dart';
import 'package:games_app/core/network/dio_helper.dart';
import 'package:games_app/features/auth/data/models/google_auth_error.dart';
import 'package:games_app/features/home/data/models/companies_model.dart';
import 'package:games_app/features/home/data/models/image_slider_model.dart';
import 'package:games_app/features/home/data/models/notification_model.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/widgets/toast.dart';

import '../../../../core/constants/urls.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/local/shared_preference/shared_preference.dart';
import '../../../../core/network/api_handle/http_request_handler.dart';
import '../../../../core/network/error_message_model.dart';
import '../models/categories_model.dart';
import '../models/check_field_model.dart';
import '../models/create_order_model.dart';
import '../models/products_model.dart';
import '../models/text_slider_model.dart';

class ApiServices {
  final Dio _dio = Dio();

  HttpHelper httpHelper = HttpHelper();

   int perPage = 10;
   int page = 1;

  Future<List<NotificationModel>> getNotifications() async {
    try{
      List<NotificationModel> notificationModelList = [];
      final response =  await DioHelper.getData(
          url: 'https://cardsim.net/api/notifications',
          authorization: true,
          query: {
            'perPage':perPage,
            'page':page,
          }
      );
      response.data['data'].forEach((element) {
        notificationModelList.add(NotificationModel.fromJson(element),);
      });
      return notificationModelList;
    }on DioError catch(e){
      throw ServerExceptions(errorMessageModel: ErrorMessageModel.fromJson(e.response!.data));
    }
  }

  Future<void> insertGoogleCode({required String code}) async {
    try{

      var res = await DioHelper.postData(
          url: 'https://cardsim.net/api/enter-google-code',
          authorization: true,
        body: {
          "insert_code":code
        }
      );

       print('Response ${res}' );
       print('Token ${UserDataFromStorage.userTokenFromStorage}');

    }on DioError catch(e){
      customToast(title: 'يرجى إدخال رمز صحيح', color: ColorManager.error);
      throw GoogleAuthExceptions(googleAuthError: GoogleAuthError.fromJson(e.response!.data));
    }
  }

  Future<void> updateDeviceToken({required String token}) async {
    try{

      await DioHelper.postData(
          url: 'https://cardsim.net/api/update-device-token',
          authorization: true,
          body: {
            "device_token":token
          }
      );

    }on DioError catch(e){
      throw ServerExceptions(errorMessageModel: ErrorMessageModel.fromJson(e.response!.data));
    }
  }


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
      print(
          'PROFILE API SERVICES>>>>>>>>>Bearer ${UserDataFromStorage.userTokenFromStorage}');
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

  Future<CreateOrderModel> createOrder(
      int productId, int quantity, String field) async {
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

  Future<List<ImageSliderModel>> getImageSlider() async {
    final response = await _dio.get(
      UrlConstants.settingsUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer ${UserDataFromStorage.userTokenFromStorage}',
        },
      ),
    );
    if (response.statusCode == 200) {
      return List<ImageSliderModel>.from(
        (response.data['images_slider'] as List).map(
          (e) => ImageSliderModel.fromJson(e),
        ),
      );
    } else {
      throw ServerExceptions(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  Future<List<TextSliderModel>> getTextSlider() async {
    final response = await _dio.get(
      UrlConstants.settingsUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer ${UserDataFromStorage.userTokenFromStorage}',
        },
      ),
    );
    if (response.statusCode == 200) {
      return List<TextSliderModel>.from(
        (response.data['texts_slider'] as List).map(
              (e) => TextSliderModel.fromJson(e),
        ),
      );
    } else {
      throw ServerExceptions(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }
}
