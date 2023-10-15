// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      customer_id: json['customer_id'] as int?,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
      product_id: json['product_id'] as int,
      id: json['id'] as int?,
      alamat: json['alamat'] as String,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'product_id': instance.product_id,
      'price': instance.price,
      'alamat': instance.alamat,
    };
