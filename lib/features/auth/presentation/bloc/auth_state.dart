import 'package:equatable/equatable.dart';
import 'package:pos_flutter/features/auth/model/login_model.dart';
import 'package:pos_flutter/features/auth/model/signup_model.dart';

abstract class AuthState extends Equatable {
  final SignupModel? signupModel;
  final LoginModel? loginModel;
  final Map<String, dynamic>? error;

  const AuthState({this.signupModel, this.loginModel, this.error});
  @override
  List<Object?> get props => [this.signupModel, this.loginModel];
}

class ErrorLoginState extends AuthState {
  final Map<String, dynamic>? error;
  const ErrorLoginState({this.error}) : super(error: error);
}

class SuccessLoginState extends AuthState {
  const SuccessLoginState();
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
