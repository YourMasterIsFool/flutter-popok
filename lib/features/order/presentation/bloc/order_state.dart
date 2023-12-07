import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pos_flutter/features/order/models/order_model.dart';

abstract class OrderState extends Equatable {
  final DioException? error;
  final OrderModel? order;
  final String? success;

  const OrderState({this.error, this.order, this.success});
  @override
  List<Object?> get props => [this.error, this.order, this.success];
}

class InitialOrderState extends OrderState {
  const InitialOrderState();
}

class LoadingCreateOrder extends OrderState {
  const LoadingCreateOrder();
}

class SuccessCreateOrder extends OrderState {
  final String success;
  final OrderModel order;
  const SuccessCreateOrder(this.success, this.order)
      : super(success: success, order: order);
}

class LoadingDetailOrder extends OrderState {
  const LoadingDetailOrder();
}

class SuccessGetDetailOrder extends OrderState {
  // final String success;
  final OrderModel order;
  const SuccessGetDetailOrder(this.order) : super(order: order);
}

class LoadingGetListOrder extends OrderState {
  const LoadingGetListOrder();
}

class SuccessGetListOrder extends OrderState {
  final List<OrderModel> orders;

  const SuccessGetListOrder(this.orders);
}

class LoadingUpdateOrderStatus extends OrderState {
  const LoadingUpdateOrderStatus();
}

class SuccessUpdateOrderStatus extends OrderState {
  final String success;

  const SuccessUpdateOrderStatus(this.success);
}
