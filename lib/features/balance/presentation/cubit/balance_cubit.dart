import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/balance/presentation/cubit/balance_state.dart';

class BalanceCubit extends Cubit<BalanceStates> {
  BalanceCubit() : super(BalanceInitialState());

  static BalanceCubit get(context) => BlocProvider.of(context);



}