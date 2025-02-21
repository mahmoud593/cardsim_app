import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/constants/urls.dart';
import 'package:games_app/core/local/cashe_helper/cashe_helper.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/core/network/api_handle/http_request_handler.dart';
import 'package:games_app/core/network/dio_helper.dart';
import 'package:games_app/features/auth/data/auth_repo_implement/auth_repo_implement.dart';
import 'package:games_app/features/auth/data/models/auth_model.dart';
import 'package:games_app/features/auth/data/models/user_info_model.dart';
import 'package:games_app/features/auth/domain/use_cases/register_use_cases.dart';
import 'package:games_app/features/auth/presentation/controller/auth_states.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/view/bottom_navigation_bar.dart';
import 'package:games_app/features/home/domain/repos/home_repo.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/widgets/toast.dart';
import 'package:crypto/crypto.dart';
import 'package:base32/base32.dart';
import '../../../../core/helper/material_navigation.dart';
import '../../../home/presentation/controller/currency_cubit/currency_cubit.dart';

class AuthCubit extends Cubit<AuthStates>{

  AuthCubit(this.registerUseCases,this.homeRepo) : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  TextEditingController emailRegisterController = TextEditingController();
  TextEditingController passwordRegisterController = TextEditingController();
  TextEditingController password2RegisterController = TextEditingController();
  TextEditingController nameRegisterController = TextEditingController();
  TextEditingController phoneRegisterController = TextEditingController();


  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();

  TextEditingController emailProfileController = TextEditingController();
  TextEditingController phoneProfileController = TextEditingController();
  TextEditingController nameProfileController = TextEditingController();

  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  AuthModel ?loginModel;
  AuthModel ?registerModel;
  UserInfoModel ?userInfoModel;

  RegisterUseCases registerUseCases;

  // Future<void> createNewAccount({
  //   required String email,
  //   required String password,
  //   required String name,
  //   required String phone,
  //   required BuildContext context
  //  })async{
  //
  //   emit(CreateAccountLoadingState());
  //     registerModel= await AuthRepoImplement().register(
  //         email: email,
  //         password: password,
  //         name: name,
  //         phone: phone
  //     );
  //     if(registerModel!.token != null){
  //       print('Token: ${registerModel!.token}');
  //       UserDataFromStorage.setGender(registerModel!.role!);
  //       await getUserInfo();
  //       emit(CreateAccountSuccessState());
  //     }else{
  //       print('Error in register ${registerModel}');
  //       customToast(title: 'هذه القيمة مُستخدمة من قبل.', color: Colors.red);
  //       emit(CreateAccountErrorState());
  //
  //   }
  //
  // }

  // await httpHelper.callService(
  // url: 'https://cardsim.net/api/register',
  // responseType: ResponseType.post,
  // parameter: {
  // "name" : "oamr",//min 3 - max 30 - unique
  // "email" : "reda@gmail.com",//unique
  // "phone" : "123456789",//numeric
  // "password" : "reda@gmail.com"//min 8
  // }
  // )

  // Future <void> createAccount({
  //   required String email,
  //   required String password,
  //   required String name,
  //   required String phone,
  //   required BuildContext context
  // })async {
  //   emit(CreateAccountLoadingState());
  //   await DioHelper.postData(
  //       url: 'https://cardsim.net/api/register',
  //       body: {
  //         "name" : "oamr",//min 3 - max 30 - unique
  //         "email" : "reda@gmail.com",//unique
  //         "phone" : "123456789",//numeric
  //         "password" : "reda@gmail.com"//min 8
  //       }
  //   ).then((value) async{
  //     print('value: ${value.toString()}');
  //     // print('Token: ${registerModel!.token}');
  //     // UserDataFromStorage.setGender(registerModel!.role!);
  //     // await getUserInfo();
  //     print('Create account success');
  //     emit(CreateAccountSuccessState());
  //   }).catchError((error){
  //     print('Error in register : ${error.toString()}');
  //     emit(CreateAccountErrorState());
  //   });
  // }


  Future<void> createNewAccount({
    required String email,
    required String password,
    required String name,
    required String phone,
    required BuildContext context,
  })async{

    emit(CreateAccountLoadingState());
    var result = await registerUseCases.register(
        email: email,
        password: password,
        name: name,
        phone: phone
    ).catchError((error){
      print('result: ${error}');
      emit(CreateAccountErrorState());
    });


    result.fold(
      (l) {
        print('Error in register : ${l.error}');
         customToast(title: l.error, color: Colors.red);
         emit(CreateAccountErrorState());
      },
      (r) async{
            registerModel = r;
            print('value: ${r.toString()}');
            print('Token: ${registerModel!.token}');
            UserDataFromStorage.setGender(registerModel!.role!);
            await getUserInfo(context: context);
            print('Create account success');
            emit(CreateAccountSuccessState());
      }
    );

    // if(registerModel!.token != null){
    //   print('Token: ${registerModel!.token}');
    //   UserDataFromStorage.setGender(registerModel!.role!);
    //   await getUserInfo();
    //   emit(CreateAccountSuccessState());
    // }else{
    //   print('Error in register ${registerModel}');
    //   customToast(title: 'هذه القيمة مُستخدمة من قبل.', color: Colors.red);
    //   emit(CreateAccountErrorState());
    //
    // }

  }


  Future<void> loginWithApi({
    required String email,
    required String password,
    required BuildContext context
  })async{

    emit(LoginLoadingState());
    loginModel= await AuthRepoImplement().login(
        email: email,
        password: password,
    );
    if(loginModel!.token != "" && loginModel!.token !=null){
      print('Token: ${loginModel!.token}');
      UserDataFromStorage.setGender(loginModel!.role!);
      // UserDataFromStorage.setUserTokenFromStorage(loginModel!.token!);
      getClientIP();
      await getUserInfo(context: context);
      emit(LoginSuccessState());
    }else {
      customToast(title: 'البريد او كلمه السر غير صحيحه', color: Colors.red);
      emit(LoginErrorState());
    }
    }


  final HomeRepo homeRepo;
  Future<void> insertCode({required String code}) async {
    emit(InsertCodeLoadingState());
    final result = await homeRepo.insertGoogleCode(code: code);
    result.fold(
          (l) => emit(InsertCodeErrorState(l.error)),
          (r) {
        emit(InsertCodeSuccessState());
      },
    );
  }

  String generateSecretKey() {
    var random = Random.secure();
    var values = List<int>.generate(10, (i) => random.nextInt(256));
    return base32.encode(Uint8List.fromList(values)).replaceAll('=', '');
  }

  Future<void> getUserInfo({required context})async{

    emit(GetUserLoadingState());
    userInfoModel= await AuthRepoImplement().getUser(context: context);
    if(userInfoModel != null && userInfoModel!.name != null){
      var secretKey = generateSecretKey();
      if(CashHelper.getData(key: userInfoModel!.email!) != null ){
        print('Secret key: ${CashHelper.getData(key: userInfoModel!.email!)}');
      }else{
        CashHelper.saveData(key: userInfoModel!.email!, value: secretKey);
        print('New Secret key: ${CashHelper.getData(key: userInfoModel!.email!)}');
      }
      UserDataFromStorage.setFullName(userInfoModel!.name!);
      UserDataFromStorage.setPhoneNumber(userInfoModel!.phone??'');
      UserDataFromStorage.setEmail(userInfoModel!.email!);
      UserDataFromStorage.setDistCustomEarning(userInfoModel!.dist_custom_earning!);
      print('Value of custom dist: ${userInfoModel!.dist_custom_earning}');
      UserDataFromStorage.setBalance(double.parse(userInfoModel!.balance!.toString()));
      emailProfileController.text=userInfoModel!.email!;
      phoneProfileController.text=userInfoModel!.phone??'';
      nameProfileController.text=userInfoModel!.name!;
      print('get user info');
      emit(GetUserSuccessState());
    }else {
      print('Error in get user info');
      // customToast(title: 'حدث خطا اثناء الحصول ع البيانات', color: Colors.red);
      emit(GetUserErrorState());
    }
  }

  Future<void> loginWithGoogle({
    required context
  })async{

    await AuthRepoImplement().loginWithGoogle().then((value) async{
      await loginWithAccessToken(accessToken: value,context: context);
    });

   emit(GetGoogleInfoState());

  }

  AuthModel? googleModel;

  Future <void> loginWithAccessToken({
    required String accessToken,
    required context
  })async{

    emit(LoginWithGoogleLoadingState());

    var googleModel = await AuthRepoImplement().loginWithAccessToken(
        accessToken: accessToken
    );

   if(googleModel.token != "" && googleModel.token != null){
     print('Token: ${googleModel.token}');
     UserDataFromStorage.setGender(googleModel.role!);
     await getUserInfo(context: context);
     emit(LoginWithGoogleSuccessState());
   }else {
     customToast(title: 'حدث خطا حاول مره اخري', color: Colors.red);

     emit(LoginWithGoogleErrorState());
   }

  }


  HttpHelper httpHelper = HttpHelper();




  Future <void> forgetPassword({
   required String email
  })async{

    emit(ForgetPasswordLoadingState());

    try{
      var response =  await httpHelper.callService(
        responseType: ResponseType.post,
        url: UrlConstants.forgetPasswordUrl,
        authorization: true,
        parameter: {
          'email':email,
        }
      );

      if(response['message'] == 'User not Found'){
        customToast(title: 'البريد الالكتروني غير موجود', color:ColorManager.error);
      }else if(response['message'] == 'Password reset link sent to your email.'){
        customToast(title: 'تم ارسال رابط تغيير كلمه السر', color:ColorManager.primary);
      }else{
        customToast(title: 'حدث خطا حاول مره اخري', color: Colors.red);
      }

      emit(ForgetPasswordSuccessState());
    }catch(error){
      print('error in forget password is $error');
      emit(ForgetPasswordErrorState());
    }


  }

  String address = '';
  void getClientIP() async {
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        address=addr.address;
        print('IP Address: ${addr.address}');
      }
    }
    emit(GetAddressInfoState());
  }


  Future <void> enableGoogleAuth({
    required String code,
    required BuildContext context
  })async{

    emit(EnableGoogleAuthLoadingState());

    try{
      var response =  await httpHelper.callService(
          responseType: ResponseType.post,
          url: UrlConstants.enable2faoGoogleUrl,
          authorization: true,
          parameter: {
            "google2fa_secret" : CashHelper.getData(key: UserDataFromStorage.emailFromStorage),
            "insert_code" : code,
          }
      );

      print('Response enableGoogleAuth: ${response.toString()}');
      if(response !=null){
        customToast(title: 'تم تفعيل المصادقة عبر جوجل', color:ColorManager.primary);
        customPushAndRemoveUntil(context, BottomNavigationScreen());
      }else{
        customToast(title: 'تحقق من الرمز و حاول مجددا', color:ColorManager.error);
      }

      emit(EnableGoogleAuthSuccessState());
    }catch(error){
      customToast(title: 'تحقق من الرمز و حاول مجددا', color:ColorManager.error);
      print('error in enableGoogleAuth is $error');
      emit(EnableGoogleAuthErrorState());
    }


  }



}