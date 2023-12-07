import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Equatable {
  final String product_title;

  @JsonKey(includeToJson: false, includeFromJson: true)
  final int? id;

  final String product_description;
  final double product_price;
  final int? stok;
  // @JsonKey(includeToJson: false, includeFromJson: false)
  // final File? product_file;

  final String? file_path;

  ProductModel(
      {required this.product_title,
      required this.product_description,
      required this.product_price,
      this.id,
      this.file_path,
      this.stok});

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.product_title,
        this.product_description,
        this.product_price,
        this.id,
        this.file_path,
        this.stok
      ];

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
