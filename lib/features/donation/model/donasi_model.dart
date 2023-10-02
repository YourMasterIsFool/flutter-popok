import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'donasi_model.g.dart';

@JsonSerializable()
class DonasiModel extends Equatable {
  DonasiModel(
      {this.id, required this.jumlah_donasi, required this.date_donasi});

  @JsonKey(includeToJson: false)
  final int? id;

  final double jumlah_donasi;
  final DateTime? date_donasi;

  @override
  // TODO: implement props
  List<Object?> get props => [this.jumlah_donasi, this.date_donasi, this.id];

  Map<String, dynamic> toJson() => _$DonasiModelToJson(this);

  factory DonasiModel.fromJson(Map<String, dynamic> json) =>
      _$DonasiModelFromJson(json);
}
