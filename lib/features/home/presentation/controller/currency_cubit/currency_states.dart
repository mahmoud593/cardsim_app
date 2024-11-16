abstract class CurrencyStates{}

class CurrencyInitialState extends CurrencyStates {}

class ChangeCurrencySuccessState extends CurrencyStates {}
class ChangeCurrencyLoadingState extends CurrencyStates {}
class ChangeCurrencyErrorState extends CurrencyStates {}

class GetCurrencyLoadingState extends CurrencyStates {}
class GetCurrencySuccessState extends CurrencyStates {}
class GetCurrencyErrorState extends CurrencyStates {}