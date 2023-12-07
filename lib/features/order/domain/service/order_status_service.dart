import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pos_flutter/config/client/client.dart';

import '../../models/order_status_model.dart';

class OrderStatusService {
  Future<Either<List<OrderStatusModel>, DioException>?>
      get_list_order_status_service() async {
    try {
      var response = await client.get('/order_status');
      print("oder status data" + response.data['data']);
      // List<OrderStatusModel> list = (response.data['data'] as Iterable)
      //     .map((e) => OrderStatusModel.fromJson(e))
      //     .toList();

      return left([]);
    } catch (e) {
      if (e is DioException) {
        print("error order status" + e.response.toString());
        return right(e);
      }
    }
  }
}
