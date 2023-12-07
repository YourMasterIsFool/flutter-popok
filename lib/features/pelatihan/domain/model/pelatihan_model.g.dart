// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pelatihan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PelatihanModel _$PelatihanModelFromJson(Map<String, dynamic> json) =>
    PelatihanModel(
      id: json['id'] as int?,
      is_member: json['is_member'] == null
          ? null
          : PelatihanMember.fromJson(json['is_member'] as Map<String, dynamic>),
      judul_pelatihan: json['judul_pelatihan'] as String,
      deskripsi: json['deskripsi'] as String,
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => PelatihanMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      lokasi_pelatihan: json['lokasi_pelatihan'] as String,
      tanggal_pelatihan: json['tanggal_pelatihan'] == null
          ? null
          : DateTime.parse(json['tanggal_pelatihan'] as String),
    );

Map<String, dynamic> _$PelatihanModelToJson(PelatihanModel instance) =>
    <String, dynamic>{
      'judul_pelatihan': instance.judul_pelatihan,
      'tanggal_pelatihan': instance.tanggal_pelatihan?.toIso8601String(),
      'lokasi_pelatihan': instance.lokasi_pelatihan,
      'deskripsi': instance.deskripsi,
    };
