class AuthStates {}

class AuthInitialState extends AuthStates {}

class CreateAccountLoadingState extends AuthStates {}
class CreateAccountSuccessState extends AuthStates {}
class CreateAccountErrorState extends AuthStates {}

class LoginLoadingState extends AuthStates {}
class LoginSuccessState extends AuthStates {}
class LoginErrorState extends AuthStates {}

class InsertCodeLoadingState extends AuthStates {}
class InsertCodeSuccessState extends AuthStates {}
class InsertCodeErrorState extends AuthStates {
  String error;
  InsertCodeErrorState(this.error);
}

class LogoutLoadingState extends AuthStates {}
class LogoutSuccessState extends AuthStates {}
class LogoutErrorState extends AuthStates {}

class ForgetPasswordLoadingState extends AuthStates {}
class ForgetPasswordSuccessState extends AuthStates {}
class ForgetPasswordErrorState extends AuthStates {}

class GetUserLoadingState extends AuthStates {}
class GetUserSuccessState extends AuthStates {}
class GetUserErrorState extends AuthStates {}

class LoginWithGoogleLoadingState extends AuthStates {}
class LoginWithGoogleSuccessState extends AuthStates {}
class LoginWithGoogleErrorState extends AuthStates {}

class GetGoogleInfoState extends AuthStates {}
class GetAddressInfoState extends AuthStates {}

class EnableGoogleAuthLoadingState extends AuthStates {}
class EnableGoogleAuthSuccessState extends AuthStates {}
class EnableGoogleAuthErrorState extends AuthStates {}