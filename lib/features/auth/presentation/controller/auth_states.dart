class AuthStates {}

class AuthInitialState extends AuthStates {}

class CreateAccountLoadingState extends AuthStates {}
class CreateAccountSuccessState extends AuthStates {}
class CreateAccountErrorState extends AuthStates {}

class LoginLoadingState extends AuthStates {}
class LoginSuccessState extends AuthStates {}
class LoginErrorState extends AuthStates {}

class GetUserLoadingState extends AuthStates {}
class GetUserSuccessState extends AuthStates {}
class GetUserErrorState extends AuthStates {}