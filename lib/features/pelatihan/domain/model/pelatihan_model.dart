import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pos_flutter/features/pelatihan/domain/model/pelatihan_member.dart';
part 'pelatihan_model.g.dart';

@JsonSerializable()
class PelatihanModel extends Equatable {
  PelatihanModel(
      {this.id,
      this.is_member,
      required this.judul_pelatihan,
      required this.deskripsi,
      this.members,
      required this.lokasi_pelatihan,
      required this.tanggal_pelatihan});

  @JsonKey(includeToJson: false)
  final int? id;

  final String judul_pelatihan;
  final DateTime? tanggal_pelatihan;
  final String lokasi_pelatihan;
  final String deskripsi;

  @JsonKey(includeToJson: false, includeFromJson: true)
  final PelatihanMember? is_member;

  @JsonKey(includeFromJson: true, includeToJson: false)
  final List<PelatihanMember>? members;

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.judul_pelatihan,
        this.members,
        this.tanggal_pelatihan,
        this.lokasi_pelatihan,
        this.deskripsi,
        this.is_member
      ];

  Map<String, dynamic> toJson() => _$PelatihanModelToJson(this);

  factory PelatihanModel.fromJson(Map<String, dynamic> json) =>
      _$PelatihanModelFromJson(json);
}
