import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pos_flutter/config/client/client.dart';
import 'package:pos_flutter/features/product/domain/models/product_model.dart';

class ProductService {
  Future<Either<ProductModel, DioException>?> createProduct(
      ProductModel schema) async {
    try {
      var response = await client.post('/product', data: schema.toJson());
      print(response.toString());

      return left(new ProductModel.fromJson(response.data['data']));
    } catch (e) {
      if (e is DioException) {
        print(e.response);
        return right(e);
      }
    }
  }

  Future<Either<List<ProductModel>, DioException>?>
      getListProductService() async {
    try {
      var response = await client.get(
        '/product',
      );
      print(response.toString());

      if (response.statusCode == 200) {
        List<ProductModel> list = (response.data['data'] as Iterable)
            .map((e) => ProductModel.fromJson(e))
            .toList();
        return left(list);
      }
    } catch (e) {
      if (e is DioException) {
        print(e.response);
        return right(e);
      }
    }
  }

  Future<Either<ProductModel, DioException>?> getProductDetailService(
      int id) async {
    try {
      var response = await client.get(
        '/product/${id}',
      );
      print('product detail' + response.toString());

      if (response.statusCode == 200) {
        return left(new ProductModel.fromJson(response.data['data']));
      }
    } catch (e) {
      if (e is DioException) {
        print(e.response);
        return right(e);
      }
    }
  }
}
