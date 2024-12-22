import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/constants/urls.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/core/network/api_handle/http_request_handler.dart';
import 'package:games_app/features/balance/data/models/create_custom_code_model.dart';
import 'package:games_app/features/balance/data/models/create_transaction_model.dart';
import 'package:games_app/features/balance/data/models/get_all_transctions_model.dart';
import 'package:games_app/features/balance/data/models/get_currency_model.dart';
import 'package:games_app/features/balance/data/models/get_payment_method_model.dart';
import 'package:games_app/features/balance/presentation/cubit/balance_state.dart';
import 'package:games_app/styles/assets/asset_manager.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/default_button.dart';
import 'package:games_app/styles/widgets/default_text_field.dart';
import 'package:games_app/styles/widgets/toast.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:image_picker/image_picker.dart';

class BalanceCubit extends Cubit<BalanceStates> {
  BalanceCubit() : super(BalanceInitialState());

  static BalanceCubit get(context) => BlocProvider.of(context);

  HttpHelper httpHelper = HttpHelper();


  String paymentMethod = '';
  String paymentId='';

  void selectPaymentMethod({required String value}) {
    paymentMethodModel!.data!.forEach((element) {
      if(element.name==value){
        paymentId=element.id.toString();
        print('paymentId is ${paymentId}');
      }
    });
    paymentMethod = value;
    emit(SelectPaymentMethodState());
  }


  String currency = '';
  num chargeRate = 1;
  String currencyId='';

  void selectCurrency({required String value,}) {
    currencyModel!.data!.forEach((element) {
      if(element.code==value){
        currencyId=element.id.toString();
        chargeRate=element.exchangeRate!;
        totalAmountController.text='';
        amountController.text='';
      }
    });
    currency = value;
    emit(SelectCurrencyState());
  }

  PaymentMethodModel ?paymentMethodModel;

  List<DropdownMenuItem> paymentMethodList =[];

  Future<void> getPaymentMethods() async {
    paymentMethodList=[];
    emit(GetPaymentMethodsLoadingState());

    try {
      var response = await httpHelper.callService(
          url: UrlConstants.getPaymentMethodUrl,
          responseType: ResponseType.get,
          authorization: true
      );

      paymentMethodModel = PaymentMethodModel.fromJson(response);


      paymentMethodModel!.data!.forEach((e) {

        paymentMethodList.add(
          DropdownMenuItem(

            value: e.name,
            child: Row(
              children: [
                Image(image: NetworkImage( e.image! ),height: 50,width: 50,),
                SizedBox(height: 20,),
                Text('${e.name}',style: TextStyles.textStyle18Medium,),
              ],
            ),
          ),
        );
      });

      emit(GetPaymentMethodsSuccessState());
    } catch (error) {
      print('error in getting payment methods is $error');
      emit(GetPaymentMethodsErrorState());
    }
  }

  CurrencyModel ?currencyModel ;

  List<DropdownMenuItem> currencyList =[];


  Future<void> getCurrency() async {
    currencyList=[];
    emit(GetCurrencyLoadingState());

    try{
      var response = await httpHelper.callService(
          url: UrlConstants.getCurrencyUrl,
          responseType: ResponseType.get,
          authorization: true
      );

      currencyModel = CurrencyModel.fromJson(response);

      currencyModel!.data!.forEach((e) {

        currencyList.add(
            DropdownMenuItem(
              value: e.code,
              child: Text('${e.code}',style: TextStyles.textStyle18Medium,),
        ),
        );
      });

      print('currency model is ${currencyModel!.data![0].code}');

      emit(GetCurrencySuccessState());
    }catch(error){
      print('error in getting currency is $error');
      emit(GetCurrencyErrorState());
    }

  }

  AllTranscationModel ?allTransactionModel ;

  Future<void> getAllTransactions() async {

    emit(GetTransactionsLoadingState());

    try{
      var response = await httpHelper.callService(
          url: UrlConstants.getAllTransactionUrl,
          responseType: ResponseType.get,
          authorization: true
      );

      allTransactionModel = AllTranscationModel.fromJson(response);


      print('transactionModel  is ${allTransactionModel!.status}');

      emit(GetTransactionsSuccessState());
    }catch(error){
      print('error in getting transactions is $error');
      emit(GetTransactionsErrorState());
    }

  }

  Future<void> searchInAllTransactions({
   required String searchValue,
  }) async {

    emit(GetTransactionsLoadingState());

    try{
      var response = await httpHelper.callService(
          url:'${UrlConstants.getAllTransactionUrl}?search=$searchValue',
          responseType: ResponseType.get,
          authorization: true
      );

      allTransactionModel = AllTranscationModel.fromJson(response);

      print('transactionModel  is ${allTransactionModel!.status}');

      emit(GetTransactionsSuccessState());
    }catch(error){
      print('error in search in transactions is $error');
      emit(GetTransactionsErrorState());
    }

  }



  CustomCodeModel ?customCodeModel ;

  Future<void> createCustomCode({
    required String code
   }) async {

    emit(CreateCustomCodeLoadingState());

    var parameter={
      'code':code
    };

    try{
      var response = await httpHelper.callService(
          url: UrlConstants.createCustomCode,
          responseType: ResponseType.post,
          authorization: true,
          parameter: parameter
      );

      customCodeModel = CustomCodeModel.fromJson(response);

      customToast(title:  '${customCodeModel!.messageAr!}', color: Colors.red);

      print('customCodeModel  is ${customCodeModel!.message!}');

      emit(CreateCustomCodeSuccessState());
    }catch(error){
      print('error in getting customCode is $error');
      emit(CreateCustomCodeErrorState());
    }

  }


  TranscationModel ?transcationModel ;

  TextEditingController amountController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  Future<void> createTransaction({
    required String paymentId,
    required String currencyId,
    required String image,
    required String amount,
  }) async {

    emit(CreateCustomCodeLoadingState());

    var parameter={
      'payment_id':paymentId,
      'currency_id':currencyId,
      // 'image':AssetManager.logout,
      'amount':amount,
    };

    try{
      var response = await httpHelper.callService(
          url: UrlConstants.createTransaction,
          responseType: ResponseType.post,
          authorization: true,
          parameter: parameter
      );

      print(response);

      transcationModel = TranscationModel.fromJson(response);

      print('transcationModel  is ${transcationModel!.message!}');
      getAllTransactions();

      emit(CreateTransactionSuccessState());
    }catch(error){
      print('error in getting transaction is $error');
      emit(CreateTransactionErrorState());
    }

  }


  void showCustomCodeDialog(BuildContext context) {

    TextEditingController customCodeController = TextEditingController();

    showDialog(context: context, builder: (context){
      return AlertDialog(
          backgroundColor: UserDataFromStorage.themeIsDarkMode ? ColorManager.darkThemeBackgroundLight : ColorManager.secondPrimary,
          title: Text('إدخال القسيمة', style: TextStyles.textStyle18Bold.copyWith(
              color: UserDataFromStorage.themeIsDarkMode ? ColorManager.white : ColorManager.white
          ),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              DefaultTextField(
                  isCode: true,
                  controller: customCodeController,
                  hintText: 'xxxx-xxxx-xxxx-xxxx',
                  validator: (value){
                    return '';
                  },
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  fillColor: ColorManager.gray
              ),

              SizedBox( height: MediaQuery.of(context).size.height*.02, ),

              DefaultButton(
                  onPressed: (){
                    createCustomCode(code: customCodeController.text);
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(10.0),
                  text: 'التحقق من القسيمه'
              ),
            ],
          )
      );
    });


  }


  var picker = ImagePicker();
  File? image;

  void pickMoneyTransactionImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    print('pickedFile is ${pickedFile}');
    if (pickedFile != null) {
      print('pickedFile.path is ${pickedFile.path}');
      image = File(pickedFile.path);
      emit(ImagePickerSuccessState());
    } else {
      print('No image selected');
      emit(ImagePickerFailureState());
    }
  }

  void removeImage() {
    image = null;
    emit(RemovePickedImageSuccessState());
  }



}