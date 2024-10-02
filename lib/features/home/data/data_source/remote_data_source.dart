import 'package:dio/dio.dart';

import '../../../../core/constants/urls.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/error_message_model.dart';
import '../models/companies_model.dart';

class RemoteDataSource{
  final Dio dio;
  RemoteDataSource(this.dio);

  Future<List<CompaniesModel>> getCompanies() async {
    final response = await dio.get(
      UrlsConstants.companiesUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer ${UrlsConstants.token}',
        },
      ),
    );
    if (response.statusCode == 200) {
      List<CompaniesModel> companies = [];
      for (var item in response.data) {
        if(item != null){
          companies.add(CompaniesModel.fromJson(item));
        }
      }
      print(companies);
      print(companies.length);
      return companies;
    } else {
      throw ServerExceptions(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }
}
