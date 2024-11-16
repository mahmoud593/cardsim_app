abstract class PaymentHistoryStates {}

class PaymentHistoryInitialState extends PaymentHistoryStates {}

class PaymentHistoryLoadingState extends PaymentHistoryStates {}

class PaymentHistoryErrorState extends PaymentHistoryStates {}

class PaymentHistorySuccessState extends PaymentHistoryStates {}