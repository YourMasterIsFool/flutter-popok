import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pos_flutter/config/client/client.dart';
import 'package:pos_flutter/features/order/models/order_model.dart';

class OrderService {
  Future<Either<OrderModel, DioException>?> create_order_service(
      OrderModel schema) async {
    try {
      var response = await client.post('/order', data: schema.toJson());

      return left(new OrderModel.fromJson(response.data['data']));
    } catch (e) {
      if (e is DioException) {
        print(e.response.toString());
        return right(e);
      }
    }
  }

  Future<Either<OrderModel, DioException?>?> get_detail_order_service(
      {int? id}) async {
    try {
      var response = await client.get('/order/${id}');

      print(response.data.toString());
      return left(OrderModel.fromJson(response.data['data']));
    } catch (e) {
      if (e is DioException) {
        print(e.response.toString());
        return right(e);
      }
    }
  }

  Future<Either<List<OrderModel>, DioException?>?> get_list_order(
      {Map<String, dynamic>? params}) async {
    try {
      var response = await client.get('/order');

      List<OrderModel> orders = (response.data['data'] as Iterable)
          .map((e) => new OrderModel.fromJson(e))
          .toList();

      return left(orders);
    } catch (e) {
      if (e is DioException) {
        return right(e);
      }
    }
  }

  Future<Either<String, DioException?>?> update_status_order({
    Map<String, dynamic>? schema,
    int? id,
  }) async {
    try {
      var response =
          await client.put('/order/update-status/${id}', data: schema);

      return left("Berhasil Update Data");
    } catch (e) {
      if (e is DioException) {
        return right(e);
      }
    }
  }
}
