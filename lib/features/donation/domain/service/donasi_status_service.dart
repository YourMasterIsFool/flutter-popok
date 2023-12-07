import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pos_flutter/config/client/client.dart';
import 'package:pos_flutter/features/donation/model/donasi_status_model.dart';

class DonasiStatusService {
  Future<Either<List<DonasiStatusModel>, DioException>?>
      getListDonasiStatusService({Map<String, dynamic>? params}) async {
    try {
      var response =
          await client.get('/donasi_status', queryParameters: params);

      print("donasi status " + response.data['data'].toString());
      var datas = response.data['data'] as Iterable;
      List<DonasiStatusModel> listStatus =
          datas.map((e) => DonasiStatusModel.fromJson(e)).toList();

      return left(listStatus);
    } catch (e) {
      if (e is DioException) {
        print(e.toString());

        return right(e);
      }
    }
  }
}
