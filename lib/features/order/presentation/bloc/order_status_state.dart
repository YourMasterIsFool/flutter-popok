import 'package:equatable/equatable.dart';
import 'package:pos_flutter/features/order/models/order_status_model.dart';

abstract class OrderStatusState extends Equatable {
  final List<OrderStatusModel>? listOrderStatus;

  const OrderStatusState({this.listOrderStatus});
  @override
  List<Object?> get props => [this.listOrderStatus];
}

class LoadingGetListOrderStatus extends OrderStatusState {
  const LoadingGetListOrderStatus();
}

class SuccessGetListOrderStatus extends OrderStatusState {
  final List<OrderStatusModel> listOrderStatus;
  const SuccessGetListOrderStatus(this.listOrderStatus);
}
