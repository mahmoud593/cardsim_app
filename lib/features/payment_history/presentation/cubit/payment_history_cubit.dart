import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/payment_history/data/model/transcation_model.dart';
import 'package:games_app/features/payment_history/presentation/cubit/payment_history_state.dart';

import '../../data/payment_history_repo/payment_history_repo.dart';
import '../../data/payment_history_repo/payment_history_repo_implement.dart';


class PaymentHistoryCubit extends Cubit<PaymentHistoryStates> {
  PaymentHistoryCubit() : super(PaymentHistoryInitialState());

  static PaymentHistoryCubit get(context) => BlocProvider.of(context);


  TransationModel transcationModel = TransationModel(status: false, total: 0, data: []);

  Future<void> getPaymentHistory() async{
    emit(PaymentHistoryLoadingState());
    transcationModel = TransationModel(status: false, total: 0, data: []);

    try{
      transcationModel = await PaymentHistoryRepoImplement().getPaymentHistory();
      emit(PaymentHistorySuccessState());
    }catch(e){
      debugPrint("Error when get Payment History =================> ${e.toString()}");
      emit(PaymentHistoryErrorState());
    }
  }

}