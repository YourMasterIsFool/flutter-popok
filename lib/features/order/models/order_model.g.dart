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
      customer: json['customer'] == null
          ? null
          : UserModel.fromJson(json['customer'] as Map<String, dynamic>),
      id: json['id'] as int?,
      status: json['status'] == null
          ? null
          : OrderStatusModel.fromJson(json['status'] as Map<String, dynamic>),
      product: json['product'] == null
          ? null
          : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      latitude: json['latitude'] as String?,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      longitude: json['longitude'] as String?,
      alamat: json['alamat'] as String,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'product_id': instance.product_id,
      'price': instance.price,
      'alamat': instance.alamat,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'status': instance.status,
    };
