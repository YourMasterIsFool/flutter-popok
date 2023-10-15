// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donasi_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonasiModel _$DonasiModelFromJson(Map<String, dynamic> json) => DonasiModel(
      id: json['id'] as int?,
      status_id: json['status_id'] as int?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      status_donasi: json['status_donasi'] as String?,
      alamat_donasi: json['alamat_donasi'] as String?,
      jumlah_donasi: (json['jumlah_donasi'] as num).toDouble(),
      date_donasi: json['date_donasi'] == null
          ? null
          : DateTime.parse(json['date_donasi'] as String),
    );

Map<String, dynamic> _$DonasiModelToJson(DonasiModel instance) =>
    <String, dynamic>{
      'alamat_donasi': instance.alamat_donasi,
      'jumlah_donasi': instance.jumlah_donasi,
      'date_donasi': instance.date_donasi?.toIso8601String(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
