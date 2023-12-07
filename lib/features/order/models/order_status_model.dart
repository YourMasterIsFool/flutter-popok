import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_status_model.g.dart';

@JsonSerializable()
class OrderStatusModel extends Equatable {
  @JsonKey(includeToJson: false)
  final int? id;
  final int code;
  final String status;

  OrderStatusModel({required this.code, required this.status, this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [this.code, this.status, this.id];

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStatusModelToJson(this);
}
