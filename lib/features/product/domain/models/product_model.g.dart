// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      product_title: json['product_title'] as String,
      product_description: json['product_description'] as String,
      product_price: (json['product_price'] as num).toDouble(),
      id: json['id'] as int?,
      file_path: json['file_path'] as String?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'product_title': instance.product_title,
      'product_description': instance.product_description,
      'product_price': instance.product_price,
      'file_path': instance.file_path,
    };
