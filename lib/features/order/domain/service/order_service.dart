import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pos_flutter/config/client/client.dart';
import 'package:pos_flutter/features/order/models/order_model.dart';

class OrderService {
  Future<Either<OrderModel, DioException>?> create_order_service(
      OrderModel schema) async {
    try {
      var response = await client.post('/order', data: schema.toJson());

      if (response.statusCode == 200)
        return left(OrderModel.fromJson(response.data['data']));
    } catch (e) {
      if (e is DioException) {
        return right(e);
      }
    }
  }
}
