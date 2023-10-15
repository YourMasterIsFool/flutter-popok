import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
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

  OrderModel({
    this.customer_id,
    required this.quantity,
    required this.price,
    required this.product_id,
    this.id,
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
        this.id
      ];

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
