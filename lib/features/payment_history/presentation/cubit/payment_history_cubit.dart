import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/payment_history/presentation/cubit/payment_history_state.dart';


class PaymentHistoryCubit extends Cubit<PaymentHistoryStates> {
  PaymentHistoryCubit() : super(PaymentHistoryInitialState());

  static PaymentHistoryCubit get(context) => BlocProvider.of(context);



}