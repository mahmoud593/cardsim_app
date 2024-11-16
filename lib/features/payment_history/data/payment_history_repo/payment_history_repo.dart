import 'package:games_app/features/payment_history/data/model/transcation_model.dart';

abstract class PaymentHistoryRepo {
  Future<TransationModel> getPaymentHistory();
}