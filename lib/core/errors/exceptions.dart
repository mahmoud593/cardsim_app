import 'package:games_app/features/auth/data/models/error_model.dart';
import 'package:games_app/features/auth/data/models/google_auth_error.dart';

import '../network/error_message_model.dart';

class ServerExceptions implements Exception {
  final ErrorMessageModel errorMessageModel;

  const ServerExceptions({required this.errorMessageModel});
}

class RegisterExceptions implements Exception {
  final ErrorModel errorModel;

  const RegisterExceptions({required this.errorModel});
}

class GoogleAuthExceptions implements Exception {
  final GoogleAuthError googleAuthError;

  const GoogleAuthExceptions({required this.googleAuthError});
}
