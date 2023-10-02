import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/config/secure_storage/secure_storage.dart';
// import 'package:pos_flutter/config/secure_storage/secure_storage.dart';
import 'package:pos_flutter/features/auth/domain/service/auth_service.dart';
import 'package:pos_flutter/features/auth/model/login_model.dart';
import 'package:pos_flutter/features/auth/presentation/bloc/auth_state.dart';

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
        navigatorKey.currentState
            ?.pushNamedAndRemoveUntil('/', (route) => false);
      }
    }, (r) => null);
  }
}
