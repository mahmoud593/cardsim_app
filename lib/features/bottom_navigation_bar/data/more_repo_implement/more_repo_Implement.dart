import 'package:flutter/material.dart';
import 'package:games_app/core/network/api_handle/http_request_handler.dart';
import 'package:games_app/core/network/api_handle/urls.dart';
import 'package:games_app/features/bottom_navigation_bar/data/models/drawer_model.dart';
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

  @override
  Future<List<DrawerModel>> getDrawerData() async{
    print("api url >***************************************> $getDrawerDataUrl");
    final response = await HttpHelper().callService(
      url: getDrawerDataUrl,
      responseType: ResponseType.get,
      authorization: true,
    );

    debugPrint("get More data status >***************************************> ${response["custom_menu"].toString()}");
    List<DrawerModel> drawerList = [];

    for(var item in response["custom_menu"]){
      drawerList.add(DrawerModel.fromMap(item));
    }
    return drawerList;
  }

}