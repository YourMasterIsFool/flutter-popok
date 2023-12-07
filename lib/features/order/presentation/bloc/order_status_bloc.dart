import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/features/order/domain/service/order_status_service.dart';
import 'package:pos_flutter/features/order/presentation/bloc/order_status_state.dart';

class OrderStatusBloc extends Cubit<OrderStatusState> {
  OrderStatusBloc() : super(LoadingGetListOrderStatus());

  Future<void> getListOrderStatusBloc() async {
    print('initial get list status order');
    emit(LoadingGetListOrderStatus());
    var response = await OrderStatusService().get_list_order_status_service();

    response?.fold((l) {
      print("l to string" + l.toList().toString());
      // emit(SuccessGetListOrderStatus(l));
    }, (r) {
      print(r.response.toString());
    });
  }
}
