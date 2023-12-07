import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pos_flutter/config/client/client.dart';
import 'package:pos_flutter/features/auth/model/login_model.dart';
import 'package:pos_flutter/features/donation/model/donasi_model.dart';
import 'package:pos_flutter/features/pelatihan/domain/model/pelatihan_model.dart';

class PelatihanService {
  Future<Either<Map<String, dynamic>, DioException>?> createPelatihanService(
      PelatihanModel schema) async {
    try {
      print('to json' + schema.toJson().toString());
      var response = await client.post('/pelatihan', data: schema.toJson());
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

  Future<Either<String, DioException>?> requestJoinPelatihan(int id) async {
    try {
      // print('to json' + schema.toJson().toString());
      var response = await client
          .post('/pelatihan/request-join', data: {'pelatihan_id': id});
      return left("Berhasil request join ke pelatihan");
    } catch (e) {
      if (e is DioException) {
        print(e.response);
        return right(e);
      }
    }
  }

  Future<Either<PelatihanModel, DioException>?> detailPelatihanService(
      int id) async {
    try {
      // print('to json' + schema.toJson().toString());
      var response = await client.get('/pelatihan/${id}');
      print('detail pelatihan' + response.data['data'].toString());
      return left(PelatihanModel.fromJson(response.data['data']));
    } catch (e) {
      if (e is DioException) {
        print(e.response);
        return right(e);
      }
    }
  }

  Future<Either<String, DioException>?> updateStatusMemberPelatihan({
    required int id,
    required int acc,
  }) async {
    try {
      // print('to json' + schema.toJson().toString());
      var response = await client
          .put('/pelatihan/update-status-member/${id}', data: {'acc': acc});
      print('detail pelatihan' + response.data['data'].toString());
      return left("Berhasil update status member");
    } catch (e) {
      if (e is DioException) {
        print(e.response);
        return right(e);
      }
    }
  }

  Future<Either<List<PelatihanModel>, DioException?>?> getListPelatihanService(
      {Map<String, dynamic>? params}) async {
    try {
      var response = await client.get('/pelatihan', queryParameters: params);

      print('pelatihan service get' + response.toString());

      Iterable datas = response.data['data'];
      List<PelatihanModel> listPelatihan =
          datas.map((e) => PelatihanModel.fromJson(e)).toList();

      return left(listPelatihan);
    } catch (e) {
      if (e is DioException) {
        print(e);

        return right(e);
      }
    }
  }
}
