import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pos_flutter/features/order/models/order_status_model.dart';
import 'package:pos_flutter/features/product/domain/models/product_model.dart';
import 'package:pos_flutter/features/profile/domain/model/user_model.dart';
part 'order_model.g.dart';

@JsonSerializable()
class OrderModel extends Equatable {
  @JsonKey(includeToJson: false)
  final int? id;

  @JsonKey(includeToJson: false)
  final int? customer_id;
  final int quantity;
  final int product_id;
  final double price;
  final String alamat;
  final String? longitude;
  final String? latitude;
  final OrderStatusModel? status;

  @JsonKey(includeFromJson: true, includeToJson: false)
  final UserModel? customer;
  @JsonKey(includeToJson: false, includeFromJson: true)
  final ProductModel? product;

  @JsonKey(includeToJson: false)
  final DateTime? created_at;

  OrderModel({
    this.customer_id,
    required this.quantity,
    required this.price,
    required this.product_id,
    this.customer,
    this.id,
    this.status,
    this.product,
    this.latitude,
    this.created_at,
    this.longitude,
    required this.alamat,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        this.customer_id,
        this.quantity,
        this.price,
        this.alamat,
        this.customer_id,
        this.latitude,
        this.longitude,
        this.created_at,
        this.product,
        this.id,
        this.status,
      ];

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
