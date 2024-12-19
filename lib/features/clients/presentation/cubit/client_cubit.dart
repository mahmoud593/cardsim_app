import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/constants/constants.dart';
import 'package:games_app/core/constants/urls.dart';
import 'package:games_app/core/network/api_handle/http_request_handler.dart';
import 'package:games_app/features/clients/data/model/get_all_clients_model.dart';
import 'package:games_app/features/clients/presentation/cubit/client_state.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/widgets/toast.dart';


class ClientCubit extends Cubit<ClientState> {
  ClientCubit() : super(ClientInitialState());

  static ClientCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();

  HttpHelper httpHelper = HttpHelper();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController earningController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  List<ClientsData> clientsList = [];

  Future<void> getAllClients() async {

    GetAllClientsModel getAllClientsModel = GetAllClientsModel();
    clientsList=[];
    emit(GetAllClientsLoadingState());

    try{

      var response= await httpHelper.callService(
          url: UrlConstants.getAllClients,
          responseType: ResponseType.get,
          authorization: true
      );

      getAllClientsModel = GetAllClientsModel.fromJson(response);

      getAllClientsModel.data!.forEach((element){
        clientsList.add(element);
      });

      emit(GetAllClientsSuccessState());
    }catch(e){

      print('Error in get all clients is : ${e.toString()}');
      emit(GetAllClientsErrorState());
    }


  }

  Future<void> searchInAllClients({
   required String searchValue,
  }) async {

    GetAllClientsModel getAllClientsModel = GetAllClientsModel();
    clientsList=[];
    emit(GetAllClientsLoadingState());

    try{

      var response= await httpHelper.callService(
          url: '${UrlConstants.getAllClients}?search=$searchValue',
          responseType: ResponseType.get,
          authorization: true
      );

      getAllClientsModel = GetAllClientsModel.fromJson(response);

      getAllClientsModel.data!.forEach((element){
        clientsList.add(element);
      });

      emit(GetAllClientsSuccessState());
    }catch(e){

      print('Error in search in all clients is : ${e.toString()}');
      emit(GetAllClientsErrorState());
    }


  }



  Future<void> createNewClient({
   required String name,
   required String email,
   required String phone,
   required String password,
   required num earningDistValue,
     
  }) async {

    emit(AddClientLoadingState());
    
    try{

      var parameter={};
      if(earningDistValue!=0){
         parameter =
        {
          "name" : name,
          "email" : email,
          "phone" : phone,
          "earning_dist_value": earningDistValue,
          "password" : password
        };
      }else{
         parameter =
        {
          "name" : name,
          "email" : email,
          "phone" : phone,
          "password" : password
        };
      }


      var response= await httpHelper.callService(
          url: UrlConstants.addClient,
          responseType: ResponseType.post,
          authorization: true,
          parameter:parameter
      );

      customToast(title: response['message_ar'], color: ColorManager.primary);
      getAllClients();

      emit(AddClientSuccessState());
    }catch(e){

      customToast(title: 'الاسم او الايميل مسجل بالفعل', color: ColorManager.error);
      print('Error in add clients is : ${e.toString()}');
      emit(AddClientErrorState());
    }


  }




}