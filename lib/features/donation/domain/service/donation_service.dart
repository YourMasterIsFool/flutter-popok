import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pos_flutter/config/client/client.dart';
import 'package:pos_flutter/features/auth/model/login_model.dart';
import 'package:pos_flutter/features/donation/model/donasi_model.dart';

class DonationService {
  Future<Either<Map<String, dynamic>, DioException>?> createDonasiService(
      DonasiModel donasiModel) async {
    try {
      print('to json' + donasiModel.toJson().toString());
      var response = await client.post('/donasi', data: donasiModel.toJson());
      if (response.statusCode == 201) {
        return left(response.data['data']);
      }
    } catch (e) {
      if (e is DioException) {
        print(e.response);
        return right(e);
      }
    }
  }

  Future<Either<List<DonasiModel>, DioException?>?> getListDonasiService({
    Map<String, dynamic>? params,
  }) async {
    try {
      var response = await client.get('/donasi', queryParameters: params);

      if (response.statusCode == 200) {
        Iterable datas = response.data['data'];
        List<DonasiModel> listDonasi =
            datas.map((e) => DonasiModel.fromJson(e)).toList();

        print(listDonasi);
        return left(listDonasi);
      }
    } catch (e) {
      if (e is DioException) {
        print(e.response);

        return right(e);
      }
    }
  }

  Future<Either<DonasiModel, DioException?>?> getDetailDonasiService(
      int? id) async {
    try {
      var response = await client.get('/donasi/${id}');

      if (response.statusCode == 200) {
        return left(DonasiModel.fromJson(response.data['data']));
      }
    } catch (e) {
      if (e is DioException) {
        print(e);

        return right(e);
      }
    }
  }

  Future<Either<DonasiModel, DioException?>?> updateDonasiService(
      int? id, DonasiModel schema) async {
    try {
      var response = await client.patch('/donasi/${id}', data: schema.toJson());

      print(response.data['data']);
      if (response.statusCode == 200) {
        return left(DonasiModel.fromJson(response.data['data']));
      }
    } catch (e) {
      if (e is DioException) {
        print(e.response);

        return right(e);
      }
    }
  }

  Future<Either<String, DioException?>?> updateStatusDonasi(
      int id, int status) async {
    try {
      var response = await client
          .patch('/donasi/${id}/update-status', data: {'status': status});

      print(response.data['data']);
      if (response.statusCode == 200) {
        return left("Success update statu");
      }
    } catch (e) {
      if (e is DioException) {
        print(e.response);

        return right(e);
      }
    }
  }

  Future<Either<String, DioException?>?> delete_donasi_service(
      {int? id}) async {
    try {
      var response = await client.delete('/donasi/${id}');

      return left("Berhasil menghapus donasi");
    } catch (e) {
      if (e is DioException) {
        return right(e);
      }
    }
  }
}
