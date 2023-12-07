import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'donasi_model.g.dart';

@JsonSerializable()
class DonasiModel extends Equatable {
  DonasiModel(
      {this.id,
      this.status_id,
      this.longitude,
      this.latitude,
      this.status_donasi,
      this.alamat_donasi,
      required this.jumlah_donasi,
      required this.date_donasi});

  @JsonKey(includeToJson: false)
  final int? id;
  final String? alamat_donasi;

  @JsonKey(includeToJson: false)
  final int? status_id;

  @JsonKey(includeToJson: false)
  final String? status_donasi;

  final double jumlah_donasi;

  final DateTime? date_donasi;

  final String? latitude;
  final String? longitude;

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.jumlah_donasi,
        this.date_donasi,
        this.id,
        this.alamat_donasi,
        this.latitude,
        this.longitude,
        // this.date_donasi,
        this.status_donasi,
        this.id
      ];

  Map<String, dynamic> toJson() => _$DonasiModelToJson(this);

  factory DonasiModel.fromJson(Map<String, dynamic> json) =>
      _$DonasiModelFromJson(json);
}
