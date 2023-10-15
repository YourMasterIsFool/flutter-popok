import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/features/product/domain/models/product_model.dart';
import 'package:pos_flutter/features/product/domain/service/product_service.dart';
import 'package:pos_flutter/features/product/presentation/bloc/product_state.dart';

class ProductBloc extends Cubit<ProductState> {
  ProductBloc() : super(const InitialProductState());
  final productService = ProductService();

  Future<void> createProductBloc(ProductModel schema) async {
    emit(LoadingCreateProduct());
    var response = await productService.createProduct(schema);

    response?.fold((l) {
      emit(SuccessCreateProduct("success create product"));
      print("test");
    }, (r) => print(r));
  }

  Future<void> getProductListBloc() async {
    emit(LoadingGetListProduct());
    var response = await productService.getListProductService();

    response?.fold((l) {
      emit(SuccessGetListProduct(l));
      print("test");
    }, (r) => print(r));
  }

  Future<void> getProductDetail(int id) async {
    emit(LoadingGetDetailProduct());
    var response = await productService.getProductDetailService(id);

    response?.fold((l) {
      emit(SuccessGetDetailProduct(l));
      print("test");
    }, (r) => print(r));
  }
}
