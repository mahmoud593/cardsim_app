import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/auth/data/auth_repo_implement/auth_repo_implement.dart';
import 'package:games_app/features/auth/data/models/auth_model.dart';
import 'package:games_app/features/auth/data/models/user_info_model.dart';
import 'package:games_app/features/auth/presentation/controller/auth_states.dart';
import 'package:games_app/styles/widgets/toast.dart';

class AuthCubit extends Cubit<AuthStates>{

  AuthCubit() : super(AuthInitialState());

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

  Future<void> createNewAccount({
    required String email,
    required String password,
    required String name,
    required String phone
   })async{

    emit(CreateAccountLoadingState());
      registerModel= await AuthRepoImplement().register(
          email: email,
          password: password,
          name: name,
          phone: phone
      );
      if(registerModel!.token != null){
        print('Token: ${registerModel!.token}');
        await getUserInfo();
        emit(CreateAccountSuccessState());
      }else{
        print('Error in register ${registerModel}');
        customToast(title: 'الحساب مسجل من قبل', color: Colors.red);
        emit(CreateAccountErrorState());

    }

  }


  Future<void> loginWithApi({
    required String email,
    required String password,
  })async{

    emit(LoginLoadingState());
    loginModel= await AuthRepoImplement().login(
        email: email,
        password: password,
    );
    if(loginModel!.token != ""){
      print('Token: ${loginModel!.token}');
      await getUserInfo();
      emit(LoginSuccessState());
    }else {
      customToast(title: 'البريد او كلمه السر غير صحيحه', color: Colors.red);
      emit(LoginErrorState());
    }
    }

  Future<void> getUserInfo()async{

    emit(GetUserLoadingState());
    userInfoModel= await AuthRepoImplement().getUser();
    if(userInfoModel != null){
      emailProfileController.text=userInfoModel!.email!;
      phoneProfileController.text=userInfoModel!.phone??'';
      nameProfileController.text=userInfoModel!.name!;
      print('get user info');
      emit(GetUserSuccessState());
    }else {
      customToast(title: 'حدث خطا اثناء الحصول ع البيانات', color: Colors.red);
      emit(GetUserErrorState());
    }
  }

  Future<void> loginWithGoogle()async{

    await AuthRepoImplement().loginWithGoogle().then((value) async{
      await loginWithAccessToken(accessToken: value);
    });

   emit(GetGoogleInfoState());

  }

  AuthModel? googleModel;

  Future <void> loginWithAccessToken({
    required String accessToken
  })async{

    emit(LoginWithGoogleLoadingState());

    var googleModel = await AuthRepoImplement().loginWithAccessToken(
        accessToken: accessToken
    );

   if(googleModel.token != ""){
     print('Token: ${googleModel.token}');
     await getUserInfo();
     emit(LoginWithGoogleSuccessState());
   }else {
     customToast(title: 'حدث خطا حاول مره اخري', color: Colors.red);
     emit(LoginWithGoogleErrorState());
   }

  }



}