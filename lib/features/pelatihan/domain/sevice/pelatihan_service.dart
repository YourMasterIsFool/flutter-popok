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

  Future<Either<List<PelatihanModel>, DioException?>?>
      getListPelatihanService() async {
    try {
      var response = await client.get('/pelatihan');

      if (response.statusCode == 200) {
        Iterable datas = response.data['data'];
        List<PelatihanModel> listPelatihan =
            datas.map((e) => PelatihanModel.fromJson(e)).toList();

        print(listPelatihan);
        return left(listPelatihan);
      }
    } catch (e) {
      if (e is DioException) {
        print(e);

        return right(e);
      }
    }
  }
}
