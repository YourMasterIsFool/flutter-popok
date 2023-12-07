import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pos_flutter/features/product/domain/models/product_model.dart';

abstract class ProductState extends Equatable {
  final ProductModel? product;
  final String? success;
  final DioException? error;

  const ProductState({this.product, this.success, this.error});

  @override
  List<Object?> get props => [this.product, this.success, this.error];
}

class InitialProductState extends ProductState {
  // final String success;
  const InitialProductState();
}

class SuccessCreateProduct extends ProductState {
  final String success;
  const SuccessCreateProduct(this.success);
}

class LoadingCreateProduct extends ProductState {
  const LoadingCreateProduct();
}

class SuccessGetListProduct extends ProductState {
  final List<ProductModel> products;
  const SuccessGetListProduct(this.products);
}

class LoadingGetListProduct extends ProductState {
  const LoadingGetListProduct();
}

class SuccessGetDetailProduct extends ProductState {
  final ProductModel product;
  const SuccessGetDetailProduct(this.product) : super(product: product);
}

class LoadingGetDetailProduct extends ProductState {
  const LoadingGetDetailProduct();
}
