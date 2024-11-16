import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/constants/urls.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/core/network/api_handle/http_request_handler.dart';
import 'package:games_app/features/balance/data/models/get_currency_model.dart';
import 'package:games_app/features/home/presentation/controller/currency_cubit/currency_states.dart';
import 'package:live_currency_rate/live_currency_rate.dart';

import '../../../../../styles/text_styles/text_styles.dart';

class CurrencyCubit extends Cubit<CurrencyStates> {
  CurrencyCubit() : super(CurrencyInitialState());

  static CurrencyCubit get(context) => BlocProvider.of(context);

  String initialCurrency = 'USD';

  double totalPrice = 0.0;

  Future<void> currencyConvert(String from, String to) async {
    emit(ChangeCurrencyLoadingState());
    try {
      UserDataFromStorage.setAppCurrency(to);
      emit(ChangeCurrencySuccessState());
    } catch (error) {
      debugPrint("Error when change currency =================> ${error.toString()}");
      emit(ChangeCurrencyErrorState());
    }
  }

  CurrencyModel ?currencyModel ;

  List<String> currencyList = [];


  Future<void> getCurrency() async {
    currencyList=[];
    emit(GetCurrencyLoadingState());

    try{
      var response = await HttpHelper().callService(
          url: UrlConstants.getCurrencyUrl,
          responseType: ResponseType.get,
          authorization: true
      );

      print(response);

      currencyModel = CurrencyModel.fromJson(response);

      response['data'].forEach((e) {

        currencyList.add(e['short']);
      });

      print('currency model is ${currencyModel!.data![0].code}');

      emit(GetCurrencySuccessState());
    }catch(error){
      print('error in getting currency is $error');
      emit(GetCurrencyErrorState());
    }

  }


}