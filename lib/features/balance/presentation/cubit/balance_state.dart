abstract class BalanceStates {}

class BalanceInitialState extends BalanceStates {}

class SelectPaymentMethodState extends BalanceStates {}

class SelectCurrencyState extends BalanceStates {}

class GetPaymentMethodsLoadingState extends BalanceStates {}
class GetPaymentMethodsSuccessState extends BalanceStates {}
class GetPaymentMethodsErrorState extends BalanceStates {}

class GetCurrencyLoadingState extends BalanceStates {}
class GetCurrencySuccessState extends BalanceStates {}
class GetCurrencyErrorState extends BalanceStates {}

class GetTransactionsLoadingState extends BalanceStates {}
class GetTransactionsSuccessState extends BalanceStates {}
class GetTransactionsErrorState extends BalanceStates {}

class CreateCustomCodeLoadingState extends BalanceStates {}
class CreateCustomCodeSuccessState extends BalanceStates {}
class CreateCustomCodeErrorState extends BalanceStates {}

class CreateTransactionLoadingState extends BalanceStates {}
class CreateTransactionSuccessState extends BalanceStates {}
class CreateTransactionErrorState extends BalanceStates {}

class ImagePickerSuccessState extends BalanceStates {}
class ImagePickerFailureState extends BalanceStates {}
class RemovePickedImageSuccessState extends BalanceStates {}