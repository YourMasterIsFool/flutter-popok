import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/features/order/domain/service/order_service.dart';
import 'package:pos_flutter/features/order/models/order_model.dart';
import 'package:pos_flutter/features/order/presentation/bloc/order_state.dart';

class OrderBloc extends Cubit<OrderState> {
  OrderBloc() : super(InitialOrderState());

  Future<void> createOrderBloc({required OrderModel schema}) async {
    emit(LoadingCreateOrder());
    var response = await OrderService().create_order_service(schema);

    response?.fold((l) {
      print(l);
      emit(SuccessCreateOrder('Berhasil create order', l));
    }, (r) {
      print(r);
    });
  }

  Future<void> getDetailOrderBloc({int? id}) async {
    emit(LoadingDetailOrder());
    var response = await OrderService().get_detail_order_service(id: id);

    response?.fold((l) {
      print(l.toString());
      emit(SuccessGetDetailOrder(l));
    }, (r) {
      print(r.toString());
    });
  }

  Future<void> getListOrderBloc({Map<String, dynamic>? params}) async {
    emit(LoadingGetListOrder());
    var response = await OrderService().get_list_order(params: params);

    response?.fold((l) {
      emit(SuccessGetListOrder(l));
    }, (r) {
      print(r.toString());
    });
  }

  Future<void> updateStatusOrder(
      {Map<String, dynamic>? data, required int id}) async {
    emit(LoadingUpdateOrderStatus());
    var response =
        await OrderService().update_status_order(id: id, schema: data);

    response?.fold((l) {
      getDetailOrderBloc(id: id);
      emit(SuccessUpdateOrderStatus(l));
    }, (r) {
      print(r.toString());
    });
  }
}
