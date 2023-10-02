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

  Future<Either<List<DonasiModel>, DioException?>?>
      getListDonasiService() async {
    try {
      var response = await client.get('/donasi');

      if (response.statusCode == 200) {
        Iterable datas = response.data['data'];
        List<DonasiModel> listDonasi =
            datas.map((e) => DonasiModel.fromJson(e)).toList();

        print(listDonasi);
        return left(listDonasi);
      }
    } catch (e) {
      if (e is DioException) {
        print(e);

        return right(e);
      }
    }
  }
}
