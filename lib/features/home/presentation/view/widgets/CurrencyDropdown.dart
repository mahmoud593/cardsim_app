import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/home/presentation/controller/currency_cubit/currency_cubit.dart';
import 'package:games_app/features/home/presentation/controller/currency_cubit/currency_states.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/widgets/loading_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../core/helper/app_size_config.dart';

class CurrencyDropdown extends StatefulWidget {
  final String initialValue;
  final Function(String) onCurrencyChanged;

  const CurrencyDropdown(
      {super.key, required this.initialValue, required this.onCurrencyChanged});

  @override
  _CurrencyDropdownState createState() => _CurrencyDropdownState();
}

class _CurrencyDropdownState extends State<CurrencyDropdown> {
  String selectedCurrency = 'USD'; // default selection

  @override
  void initState() {
    super.initState();
    selectedCurrency = UserDataFromStorage.appCurrencyFromStorage;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyCubit, CurrencyStates>(
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is GetCurrencyLoadingState ? true : false,
          progressIndicator: const LoadingAnimationWidget(),
          color: Colors.transparent,
          child: Container(
            height: SizeConfig.height * 0.04,
            width: SizeConfig.height * 0.06,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
              border: Border.all(
                color: ColorManager.primary,
                width: 0.7,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: SizeConfig.height * 0.006),
              child: DropdownButton(
                value: selectedCurrency,
                items: CurrencyCubit.get(context).currencyList.map((String currency) {
                  return DropdownMenuItem<String>(
                    value: currency,
                    child: Text(currency, style: TextStyle(color: ColorManager
                        .primary),),
                  );
                }).toList(),
                underline: Container(),
                icon: Container(),
                borderRadius: BorderRadius.circular(10),
                onChanged: (newCurrency) {
                  setState(() {
                    selectedCurrency = newCurrency!;
                    widget.onCurrencyChanged(selectedCurrency);
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
