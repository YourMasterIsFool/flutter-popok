import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'pelatihan_model.g.dart';

@JsonSerializable()
class PelatihanModel extends Equatable {
  PelatihanModel(
      {this.id,
      required this.judul_pelatihan,
      required this.deskripsi,
      required this.lokasi_pelatihan,
      required this.tanggal_pelatihan});

  @JsonKey(includeToJson: false)
  final int? id;

  final String judul_pelatihan;
  final DateTime? tanggal_pelatihan;
  final String lokasi_pelatihan;
  final String deskripsi;

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.judul_pelatihan,
        this.tanggal_pelatihan,
        this.lokasi_pelatihan,
        this.deskripsi
      ];

  Map<String, dynamic> toJson() => _$PelatihanModelToJson(this);

  factory PelatihanModel.fromJson(Map<String, dynamic> json) =>
      _$PelatihanModelFromJson(json);
}
