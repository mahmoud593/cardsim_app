abstract class BottomNavStates {}

class BottomNavInitialState extends BottomNavStates {}

class BottomNavChangeState extends BottomNavStates {}

class GetUserLoadingState extends BottomNavStates {}
class GetUserSuccessState extends BottomNavStates {}
class GetUserErrorState extends BottomNavStates {}

class LogoutLoadingState extends BottomNavStates {}
class LogoutSuccessState extends BottomNavStates {}
class LogoutErrorState extends BottomNavStates {}

class DeleteAccountLoadingState extends BottomNavStates {}
class DeleteAccountSuccessState extends BottomNavStates {}
class DeleteAccountErrorState extends BottomNavStates {}