import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pos_flutter/features/auth/model/login_model.dart';
import 'package:pos_flutter/features/auth/model/signup_model.dart';

abstract class AuthState extends Equatable {
  final SignupModel? signupModel;
  final LoginModel? loginModel;
  final DioException? error;

  const AuthState({this.signupModel, this.loginModel, this.error});
  @override
  List<Object?> get props => [this.signupModel, this.loginModel];
}

class ErrorLoginState extends AuthState {
  final DioException error;
  const ErrorLoginState(this.error) : super(error: error);
}

class SuccessLoginState extends AuthState {
  const SuccessLoginState();
}

class LoadingLoginState extends AuthState {
  const LoadingLoginState();
}

class InitalAuthState extends AuthState {
  const InitalAuthState();
}

class SuccessRegisterState extends AuthState {
  const SuccessRegisterState();
}

class LoadingRegsterState extends AuthState {
  const LoadingRegsterState();
}

class ErrorRegister extends AuthState {
  final String errorMessage;

  const ErrorRegister(this.errorMessage);
}

class LoadingForgotEmailState extends AuthState {
  const LoadingForgotEmailState();
}

class SuccesssForgotEmailState extends AuthState {
  final String email;

  const SuccesssForgotEmailState(this.email);
}

class ErrorForgotEmailState extends AuthState {
  final DioException error;

  const ErrorForgotEmailState(this.error);
}

class LoadingHintPassword extends AuthState {
  const LoadingHintPassword();
}

class SuccessHintPassword extends AuthState {
  final String email;

  const SuccessHintPassword(this.email);
}

class ErorrHintPassword extends AuthState {
  final DioException error;

  const ErorrHintPassword(this.error);
}

class LoadingChageNewPassword extends AuthState {
  const LoadingChageNewPassword();
}

class SuccessChangeNewPassword extends AuthState {
  final String successMessage;

  const SuccessChangeNewPassword(this.successMessage);
}

class ErorrChangeNewPassword extends AuthState {
  final DioException error;

  const ErorrChangeNewPassword(this.error);
}
