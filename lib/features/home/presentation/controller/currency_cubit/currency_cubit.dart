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

  Future<void> currencyConvert(String from, String to, double amount) async {
    emit(ChangeCurrencyLoadingState());
    try {
      debugPrint("Starting currency conversion from: $from to: $to, amount: $amount");

      // Ensure currencyModel is valid
      if (currencyModel == null || currencyModel!.data == null) {
        throw Exception("Currency data is not available.");
      }

      // Retrieve currencies
      final fromCurrency = currencyModel!.data!.firstWhere(
            (currency) => currency.short == from,
        orElse: () => throw Exception("From currency not found."),
      );
      final toCurrency = currencyModel!.data!.firstWhere(
            (currency) => currency.short == to,
        orElse: () => throw Exception("To currency not found."),
      );

      // Debug: Log exchange rates
      debugPrint("From exchange rate: ${fromCurrency.exchangeRate}, To exchange rate: ${toCurrency.exchangeRate}");

      // Validate exchange rates
      num fromExchangeRate = fromCurrency.exchangeRate ?? 0;
      num toExchangeRate = toCurrency.exchangeRate ?? 0;

      if (fromExchangeRate == 0 || toExchangeRate == 0) {
        throw Exception("Invalid exchange rates: From($fromExchangeRate), To($toExchangeRate)");
      }

      // Perform the conversion
      double amountInUSD = amount / fromExchangeRate;
      double convertedAmount = amountInUSD * toExchangeRate;

      // Debug: Log intermediate conversion results
      debugPrint("Amount in USD: $amountInUSD, Converted Amount: $convertedAmount");

      // Update totalPrice with the converted amount
      totalPrice = convertedAmount;

      // Save the balance and selected currency
      UserDataFromStorage.setBalance(totalPrice);
      UserDataFromStorage.setAppCurrency(to);

      emit(ChangeCurrencySuccessState());
    } catch (error) {
      debugPrint("Error in currency conversion: ${error.toString()}");
      emit(ChangeCurrencyErrorState());
    }
  }


}