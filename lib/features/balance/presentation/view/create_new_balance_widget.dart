import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/constants/urls.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/balance/data/models/create_transaction_model.dart';
import 'package:games_app/features/balance/presentation/cubit/balance_cubit.dart';
import 'package:games_app/features/balance/presentation/cubit/balance_state.dart';
import 'package:games_app/styles/assets/asset_manager.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/default_button.dart';
import 'package:games_app/styles/widgets/default_text_field.dart';
import 'package:games_app/styles/widgets/toast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class CreateNewBalanceWidget extends StatefulWidget {
   CreateNewBalanceWidget({super.key});

  @override
  State<CreateNewBalanceWidget> createState() => _CreateNewBalanceWidgetState();
}

class _CreateNewBalanceWidgetState extends State<CreateNewBalanceWidget> {
  String paymentMethod='';

  TextEditingController customCodeController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    BalanceCubit.get(context).paymentId='';
    BalanceCubit.get(context).taxValue='';
    BalanceCubit.get(context).currencyId='';
    BalanceCubit.get(context).image=null;
    BalanceCubit.get(context).amountController.text='';
    BalanceCubit.get(context).currency='';
    BalanceCubit.get(context).paymentMethod='';
    BalanceCubit.get(context).paymentMethodDetails='';
    BalanceCubit.get(context).paymentMethodCompleteData='';
    BalanceCubit.get(context).totalAmountController.text='';
    customCodeController.text='';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BalanceCubit, BalanceStates>(
      listener: (context,state){
         if(state is CreateTransactionSuccessState){
           BalanceCubit.get(context).paymentId='';
           BalanceCubit.get(context).taxValue='';
           BalanceCubit.get(context).currencyId='';
           BalanceCubit.get(context).image=null;
           BalanceCubit.get(context).amountController.text='';
           BalanceCubit.get(context).totalAmountController.text='';
           customCodeController.text='';
           Navigator.pop(context);
         }
      },
      builder: (context, state) {
        var cubit = BalanceCubit.get(context);
        return Scaffold(
          backgroundColor: UserDataFromStorage.themeIsDarkMode ? ColorManager.darkThemeBackgroundLight : Colors.grey[250],
          appBar:  AppBar(
            centerTitle: true,
            title: Text('شحن الرصيد',style: TextStyles.textStyle24Medium,
            ),
          ),
          body: ModalProgressHUD(
            inAsyncCall:  state is CreateCustomCodeLoadingState,
            progressIndicator: const CupertinoActivityIndicator(
              color:  ColorManager.primary,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width*.05,
                      vertical: MediaQuery.of(context).size.height*.02
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start ,
                    children: [

                      Row(
                        children: [

                          const Spacer(),

                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: ()async{
                              if(formKey.currentState!.validate()){
                                if(cubit.paymentId==''){
                                  customToast(title: ' يرجى اختيار طريقة الدفع', color: Colors.red);
                                }else{
                                  if(cubit.currencyId==''){
                                    customToast(title: ' يرجى اختيار العملة', color: Colors.red);
                                  }else{
                                    if(cubit.image ==null){
                                      customToast(title: ' يرجى ارفاق صوره التحويل', color: Colors.red);
                                    }else{
                                      print(cubit.filePath);
                                      MultipartFile file = await MultipartFile.fromFile(
                                        cubit.filePath,
                                        filename: cubit.filePath.split('/').last,
                                      );

                                      var parameter={
                                        'payment_id':cubit.paymentId,
                                        'currency_id':cubit.currencyId,
                                        'image':file,
                                        'amount':cubit.amountController.text,
                                      };


                                        await createTransaction(
                                        context: context,
                                        paymentId:cubit.paymentId,
                                        currencyId:cubit.currencyId,
                                        filePath:cubit.filePath,
                                        notes: customCodeController.text,
                                        amount:cubit.amountController.text,
                                        ).then((value){
                                          BalanceCubit.get(context).paymentId='';
                                          BalanceCubit.get(context).taxValue='';
                                          BalanceCubit.get(context).currencyId='';
                                          BalanceCubit.get(context).image=null;
                                          BalanceCubit.get(context).amountController.text='';
                                          BalanceCubit.get(context).currency='';
                                          BalanceCubit.get(context).paymentMethod='';
                                          BalanceCubit.get(context).paymentMethodDetails='';
                                          BalanceCubit.get(context).paymentMethodCompleteData='';
                                          BalanceCubit.get(context).totalAmountController.text='';
                                          customCodeController.text='';
                                          customToast(title: 'تم ارسال الطلب', color: ColorManager.primary);
                                          Navigator.pop(context);
                                        });

                                    }
                                  }
                                }

                              }
                            },
                            color: ColorManager.primary,
                            child: Row(
                              children: [
                                Text('ارسال الطلب', style: TextStyles.textStyle18Medium.copyWith(
                                    color: UserDataFromStorage.themeIsDarkMode ? ColorManager.white : ColorManager.white
                                ),),
                                SizedBox( width: MediaQuery.of(context).size.width*.02, ),
                                const Icon(Icons.send, color: ColorManager.white,size:  15,),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox( height: MediaQuery.of(context).size.height*.02, ),

                      BlocBuilder<BalanceCubit, BalanceStates>(
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DropdownButton(
                                    dropdownColor:  ColorManager.white,
                                    isExpanded: true,
                                    style: const TextStyle(
                                        color: ColorManager.darkThemeBackground
                                    ),
                                    items: BalanceCubit.get(context).paymentMethodList,
                                    hint: BalanceCubit.get(context).paymentMethod=='' ?
                                    Text('اختر طريقة الدفع', style: TextStyles.textStyle18Medium.copyWith(
                                        color: UserDataFromStorage.themeIsDarkMode ? ColorManager.white : ColorManager.black
                                    )):Text(BalanceCubit.get(context).paymentMethod, style: TextStyles.textStyle18Medium.copyWith(
                                        color: UserDataFromStorage.themeIsDarkMode ? ColorManager.white : ColorManager.black
                                    )),
                                    focusColor: Colors.white,
                                    onChanged: (value){
                                      BalanceCubit.get(context).selectPaymentMethod(value: value.toString());
                                      print('paymentMethodDetails is ${BalanceCubit.get(context).paymentMethod}');
                                    }
                                ),

                                BalanceCubit.get(context).paymentMethodDetails==''?Container():
                                SizedBox( height: MediaQuery.of(context).size.height*.02, ),


                                BalanceCubit.get(context).paymentMethodDetails==''?Container():
                                Text( BalanceCubit.get(context).paymentMethodDetails,style:  TextStyles.textStyle18Medium.copyWith(
                                  color: UserDataFromStorage.themeIsDarkMode ? ColorManager.white : ColorManager.black,
                                ),),

                                BalanceCubit.get(context).paymentMethodCompleteData==''?Container():
                                SizedBox( height: MediaQuery.of(context).size.height*.02, ),

                                BalanceCubit.get(context).paymentMethodCompleteData==''?Container():
                                Text('يرجي تحويل المبلغ المراد شحنه الى المحفظه التاليه :',style:  TextStyles.textStyle18Medium.copyWith(
                                  color: UserDataFromStorage.themeIsDarkMode ? ColorManager.white : ColorManager.black,
                                ),),

                                BalanceCubit.get(context).paymentMethodCompleteData==''?Container():
                                SizedBox( height: MediaQuery.of(context).size.height*.01, ),

                                BalanceCubit.get(context).paymentMethodCompleteData==''?
                                Container():
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(
                                          12
                                        ),
                                        decoration: BoxDecoration(
                                          color: UserDataFromStorage.themeIsDarkMode ? ColorManager.gray : ColorManager.gray,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(BalanceCubit.get(context).paymentMethodCompleteData,style:  TextStyles.textStyle18Regular.copyWith(
                                          color: UserDataFromStorage.themeIsDarkMode ? ColorManager.black : ColorManager.black,
                                          fontSize: 13
                                        ),
                                        textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width:  MediaQuery.of(context).size.width*.02,),

                                    DefaultButton(
                                        onPressed: (){
                                      Clipboard.setData(ClipboardData(text: BalanceCubit.get(context).paymentMethodCompleteData));
                                      customToast(title: 'تم نسخ الرمز', color: ColorManager.primary);
                                    }, borderRadius: BorderRadius.circular(12), text: 'نسخ')
                                  ],
                                )
                              ],
                            );
                          }
                      ),

                      SizedBox( height: MediaQuery.of(context).size.height*.02, ),

                      BlocBuilder<BalanceCubit, BalanceStates>(
                          builder: (context, state) {
                            return DropdownButton(
                                dropdownColor:  ColorManager.white,
                                isExpanded: true,
                                style: const TextStyle(
                                    color: ColorManager.darkThemeBackground
                                ),
                                items: BalanceCubit.get(context).currencyList,
                                hint: BalanceCubit.get(context).currency==''?
                                Text('اختر العمله', style: TextStyles.textStyle18Medium.copyWith(
                                    color: UserDataFromStorage.themeIsDarkMode ? ColorManager.white : ColorManager.black
                                )):Text(BalanceCubit.get(context).currency, style: TextStyles.textStyle18Medium.copyWith(
                                    color: UserDataFromStorage.themeIsDarkMode ? ColorManager.white : ColorManager.black
                                )),
                                focusColor: Colors.white,
                                onChanged: (value){
                                  BalanceCubit.get(context).selectCurrency(
                                      value: value.toString(),
                                  );
                                }
                            );
                          }
                      ),

                      SizedBox( height: MediaQuery.of(context).size.height*.02, ),

                      DefaultTextField(
                          controller: cubit.amountController,
                          hintText: 'المبلغ',
                          validator: (value){
                            if(value.isEmpty){
                              return 'ادخل المبلغ الذي سيتم دفعه';
                            }
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          fillColor: ColorManager.gray,
                          onChanged: (value){
                            if(cubit.amountController.text==''){
                              cubit.totalAmountController.text = '';
                            }
                            print('total is ${cubit.chargeRate* double.parse(cubit.amountController.text)}');
                            cubit.totalAmountController.text = '${((double.parse(cubit.amountController.text)/ cubit.chargeRate) - (double.parse(cubit.amountController.text) / cubit.chargeRate* (double.parse(cubit.taxValue)) /100)) }' ;
                            cubit.totalAmountController.text = double.parse(cubit.totalAmountController.text).toStringAsFixed(2);
                          },
                      ),

                      SizedBox( height: MediaQuery.of(context).size.height*.02, ),

                      DefaultTextField(
                          enable: false,
                          controller: cubit.totalAmountController,
                          hintText: 'المبلغ الذي سيتم استلامه بالدولار',
                          validator: (value){
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          fillColor: ColorManager.gray
                      ),

                      SizedBox( height: MediaQuery.of(context).size.height*.02, ),

                      DefaultTextField(
                          maxLines: 3,
                          controller: customCodeController,
                          hintText: 'ملاحظات',
                          validator: (value){
                            if(value.isEmpty){
                            }
                          },
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          fillColor: ColorManager.gray
                      ),

                      SizedBox( height: MediaQuery.of(context).size.height*.02, ),

                      GestureDetector(
                        onTap: (){
                          cubit.pickMoneyTransactionImage();
                        },
                        child: Container(
                          height:  MediaQuery.of(context).size.height*.25,
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                              borderRadius:  BorderRadius.circular(20),
                              border:  Border.all(
                                  color: UserDataFromStorage.themeIsDarkMode ? ColorManager.white : ColorManager.black
                              )
                          ),
                          width: double.infinity,
                          child:
                          cubit.image==null?
                          Column(
                            children: [
                              Text('ارفق اثبات التحويل', style: TextStyles.textStyle18Medium.copyWith(
                                color: UserDataFromStorage.themeIsDarkMode ? ColorManager.white : ColorManager.black,),
                                textAlign: TextAlign.center,
                              ),

                              SizedBox( height: MediaQuery.of(context).size.height*.02, ),

                              const Expanded(
                                child: Image(
                                  image: AssetImage(AssetManager.logo),
                                ),
                              ),

                            ],
                          ):
                          Image(
                            fit: BoxFit.contain,
                            image: FileImage(cubit.image!),
                          ),
                        ),
                        ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


Future<void> createTransaction({
  required String filePath,
  required String paymentId,
  required String currencyId,
  required String amount,
  String ?notes='',
  required BuildContext context,
}) async {

  try {
    MultipartFile file = await MultipartFile.fromFile(
      filePath,
      filename: filePath.split('/').last,
    );

    // تجهيز FormData
    FormData formData = FormData.fromMap({
      'payment_id': paymentId,
      'currency_id': currencyId,
      'image': file,
      'amount': amount,
      'notes': notes,
    });

    Dio dio = Dio();
    var response = await dio.post(
      UrlConstants.createTransaction,
      data: formData,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': "Bearer ${UserDataFromStorage.userTokenFromStorage}",
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    print(TranscationModel.fromJson(response.data).message);

    BalanceCubit.get(context).getAllTransactions();

  } catch (error) {
    customToast(title: 'حدث خطا يرجي المحاولة مرة اخرى', color: ColorManager.error);
    print('Error in getting transaction: $error');
  }
}
