import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/config/secure_storage/secure_storage.dart';
// import 'package:pos_flutter/config/secure_storage/secure_storage.dart';
import 'package:pos_flutter/features/auth/domain/service/auth_service.dart';
import 'package:pos_flutter/features/auth/model/login_model.dart';
import 'package:pos_flutter/features/auth/model/signup_model.dart';
import 'package:pos_flutter/features/auth/presentation/bloc/auth_state.dart';
import 'package:pos_flutter/features/profile/domain/service/user_service.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthService authService = new AuthService();

  AuthBloc() : super(const InitalAuthState());

  Future<void> loginBloc(LoginModel loginModel) async {
    var response = await authService.loginService(loginModel);

    response?.fold((l) async {
      String token = l['token'];

      var saving_token = await SecureStorage().setToken(token);
      var get_token = await SecureStorage().getToken();

      // print('token' + token);
      // print('get tokena' + get_token.toString());
      if (get_token!.isNotEmpty) {
        var userDetail = await UserService().get_current_user_service();

        userDetail?.fold((l) async {
          print("role name" + l.role_name! ?? '');
          await SecureStorage().setRole(l.role_name ?? '');
        }, (r) {});
        navigatorKey.currentState
            ?.pushNamedAndRemoveUntil('/', (route) => false);
      }
    }, (r) => null);
  }

  Future<void> logoutHandler() async {
    var response = await authService.logoutService();

    response?.fold((l) async {
      print("lstring" + l.toString());
      await SecureStorage().deleteToken();
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('/login', (route) => false);
      // var saving_token = await SecureStorage().dele(token);
      // var get_token = await SecureStorage().getToken();

      // // print('token' + token);
      // // print('get tokena' + get_token.toString());
      // if (get_token!.isNotEmpty) {
      //   navigatorKey.currentState
      //       ?.pushNamedAndRemoveUntil('/', (route) => false);
      // }
    }, (r) => null);
  }

  Future<void> registerHandler(SignupModel schema) async {
    emit(LoadingRegsterState());
    var response = await authService.registerService(schema);

    response?.fold((l) async {
      emit(SuccessRegisterState());
    }, (r) => null);
  }
}
