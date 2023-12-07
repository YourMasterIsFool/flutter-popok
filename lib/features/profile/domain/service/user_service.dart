import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pos_flutter/config/client/client.dart';
import 'package:pos_flutter/features/profile/domain/model/user_model.dart';

class UserService {
  Future<Either<UserModel, DioException>?> get_current_user_service() async {
    try {
      var response = await client.get('/current_user');

      if (response.statusCode == 200) {
        var data = response.data['data'];
        print('userrrr' + data.toString());
        return left(UserModel.fromJson(data));
      }
    } catch (e) {
      print(e);
      if (e is DioException) {
        return right(e);
      }
    }
  }

  Future<Either<UserModel, DioException>?> registerNewUserService(
      UserModel schema) async {
    try {
      var response = await client.post('/register', data: schema.toJson());

      if (response.statusCode == 200) {
        var data = response.data['data'];
        print('userrrr' + data.toString());
        return left(UserModel.fromJson(data));
      }
    } catch (e) {
      print(e);
      if (e is DioException) {
        print(e.response.toString());
        return right(e);
      }
    }
  }

  Future<Either<UserModel, DioException>?> update_user_service(
      Map<String, dynamic> schema) async {
    try {
      var response = await client.patch('/update_user', data: schema);

      if (response.statusCode == 200) {
        var data = response.data['data'];

        return left(UserModel.fromJson(data));
      }
    } catch (e) {
      print(e);
      if (e is DioException) {
        return right(e);
      }
    }
  }

  Future<Either<List<UserModel>, DioException?>?> getListKurir(
      {Map<String, dynamic>? params}) async {
    try {
      var response = await client.get('/user-list', queryParameters: params);
      if (response.statusCode == 200) {
        List<UserModel> listUser = (response.data['data'] as Iterable)
            .map((e) => new UserModel.fromJson(e))
            .toList();

        return left(listUser);
      }
    } catch (e) {
      if (e is DioException) {
        print(e.toString());
        return right(e);
      }
    }
  }

  Future<Either<UserModel, DioException?>?> get_user_admin() async {
    try {
      var response = await client.get("/user/get_user_admin");

      return left(UserModel.fromJson(response.data['data']));
    } catch (e) {
      if (e is DioException) {
        return right(e);
      }
    }
  }
}
