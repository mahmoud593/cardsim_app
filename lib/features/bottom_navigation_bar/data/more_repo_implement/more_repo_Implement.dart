import 'package:flutter/material.dart';
import 'package:games_app/core/network/api_handle/http_request_handler.dart';
import 'package:games_app/core/network/api_handle/urls.dart';
import 'package:games_app/features/bottom_navigation_bar/data/models/more_model.dart';
import 'package:games_app/features/bottom_navigation_bar/data/more_repo/more_repo.dart';

class MoreRepoImplement extends MoreRepo{
  @override
  Future<MoreModel> getMoreData({required String key}) async{

    print("api url >***************************************> ${getMoreScreenUrl(key)}");
    final response = await HttpHelper().callService(
      url: getMoreScreenUrl(key),
      responseType: ResponseType.get,
      authorization: true,
    );

    debugPrint("get More data status >***************************************> ${response.toString()}");
    return MoreModel.fromMap(response);
  }

}