abstract class OrdersStates {}

class OrdersInitialState extends OrdersStates {}

class ChangeSelectedFilterState extends OrdersStates {}

class GetOrdersLoadingState extends OrdersStates {}
class GetOrdersSuccessState extends OrdersStates {}
class GetOrdersErrorState extends OrdersStates {}
