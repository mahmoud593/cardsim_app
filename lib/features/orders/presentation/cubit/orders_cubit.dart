
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/errors/exceptions.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/core/network/error_message_model.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_state.dart';
import 'package:games_app/features/home/presentation/view/home_screen.dart';
import 'package:games_app/features/orders/data/models/orders_model.dart';
import 'package:games_app/features/orders/data/orders_repo_implement/orders_repo_implement.dart';
import 'package:games_app/features/orders/presentation/cubit/orders_state.dart';

class OrdersCubit extends Cubit<OrdersStates> {
  OrdersCubit() : super(OrdersInitialState());

  static OrdersCubit get(context) => BlocProvider.of(context);

  final List<String> categories = [
    'الكل',          // All
    'قيد التنفيذ',   // In Progress
    'قيد الإنتظار',  // Pending
    'مكتمل',        // Completed
    'مرفوض'         // Rejected
  ];

  String selectedCategory = 'الكل';
  TextEditingController searchController = TextEditingController();


  void changeCategory(String category) {
    selectedCategory = category;
    emit(ChangeSelectedFilterState());
  }

  OrdersModel ordersModel = OrdersModel(
    total: 0,
    orders: [],
    currentPage: 1,
    lastPage: 1,
    perPage: 10,
    from: 0,
    to: 0,
  );

  int orderWaitingLenght=0;
  int orderRefuseLenght=0;
  Future <void> getOrders({required String search, required String status}) async {
    ordersModel = OrdersModel(
      total: 0,
      orders: [],
      currentPage: 1,
      lastPage: 1,
      perPage: 10,
      from: 0,
      to: 0,
    );
    emit(GetOrdersLoadingState());
    try {
      ordersModel = await OrdersRepoImplement().getOrders(search: search, status: status);
      ordersModel.orders.forEach((element) {
        if(element.status == "pending"){
          orderWaitingLenght+=1;
        }else if(element.status == "reject"){
          orderRefuseLenght+=1;
        }
      });
      debugPrint("get orders >***************************************> ${ordersModel.orders.length}");
      UserDataFromStorage.setAllOrders(double.parse(ordersModel.orders.length.toString()));
      UserDataFromStorage.setOrdersWaiting(double.parse(orderWaitingLenght.toString()));
      UserDataFromStorage.setOrdersRefuse(double.parse(orderRefuseLenght.toString()));
      emit(GetOrdersSuccessState());
    } catch (e) {
      emit(GetOrdersErrorState());
      debugPrint("get orders error >***************************************> ${e
          .toString()}");
    }
  }


}