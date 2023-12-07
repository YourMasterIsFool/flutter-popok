import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pos_flutter/config/client/client.dart';
import 'package:pos_flutter/features/auth/model/login_model.dart';
import 'package:pos_flutter/features/auth/model/signup_model.dart';
import 'package:pos_flutter/features/profile/domain/model/user_model.dart';

class AuthService {
  Future<Either<Map<String, dynamic>, DioException>?> loginService(
      LoginModel loginModel) async {
    try {
      var response = await client.post('/login', data: loginModel.toJson());

      // print(response.data['data']['token']);p
      return left(response.data['data'] ?? {});
    } catch (e) {
      if (e is DioException) {
        print("error" + e.toString());
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
      var response = await client.post('/register', data: schema.toJson());

      // print(response.data['data']['token']);p

      print(response);
      return left(response.data);
    } catch (e) {
      if (e is DioException) {
        return right(e);
      }
    }
  }

  Future<Either<Map<String, dynamic>, DioException>?> checkEmailIsExits(
      String email) async {
    try {
      var response = await client.post('/check-email', data: {'email': email});

      return left(response.data['data']);
    } catch (e) {
      if (e is DioException) {
        return right(e);
      }
    }
  }

  Future<Either<String, DioException>?> checkHintPasswordIsCorrect(
      {required String email, required String question_answer}) async {
    try {
      var response = await client.post('/hint-password',
          data: {'email': email, 'question_answer': question_answer});

      return left('check berhasil');
    } catch (e) {
      if (e is DioException) {
        return right(e);
      }
    }
  }

  Future<Either<String, DioException>?> changePassword(
      {required String email, required String new_password}) async {
    try {
      var response = await client.post('/change-password',
          data: {'email': email, 'new_password': new_password});

      print(response.data['data']);
      return left(response.data['data'].toString());
    } catch (e) {
      if (e is DioException) {
        return right(e);
      }
    }
  }
}
