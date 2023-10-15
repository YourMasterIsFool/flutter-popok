import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pos_flutter/config/client/client.dart';
import 'package:pos_flutter/features/auth/model/login_model.dart';
import 'package:pos_flutter/features/auth/model/signup_model.dart';

class AuthService {
  Future<Either<Map<String, dynamic>, DioException>?> loginService(
      LoginModel loginModel) async {
    try {
      var response = await client.post('/login', data: loginModel.toJson());

      // print(response.data['data']['token']);p
      return left(response.data['data']);
    } catch (e) {
      if (e is DioException) {
        return right(e);
      }
    }
  }

  Future<Either<Map<String, dynamic>, DioException>?> logoutService() async {
    try {
      var response = await client.post('/logout');

      // print(response.data['data']['token']);p

      print(response);
      return left(response.data);
    } catch (e) {
      if (e is DioException) {
        return right(e);
      }
    }
  }

  Future<Either<Map<String, dynamic>, DioException>?> registerService(
      SignupModel schema) async {
    try {
      var response = await client.post('/logout', data: schema.toJson());

      // print(response.data['data']['token']);p

      print(response);
      return left(response.data);
    } catch (e) {
      if (e is DioException) {
        return right(e);
      }
    }
  }
}
