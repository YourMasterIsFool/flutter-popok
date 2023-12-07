// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderStatusModel _$OrderStatusModelFromJson(Map<String, dynamic> json) =>
    OrderStatusModel(
      code: json['code'] as int,
      status: json['status'] as String,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$OrderStatusModelToJson(OrderStatusModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
    };
