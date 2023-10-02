// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donasi_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonasiModel _$DonasiModelFromJson(Map<String, dynamic> json) => DonasiModel(
      id: json['id'] as int?,
      jumlah_donasi: (json['jumlah_donasi'] as num).toDouble(),
      date_donasi: json['date_donasi'] == null
          ? null
          : DateTime.parse(json['date_donasi'] as String),
    );

Map<String, dynamic> _$DonasiModelToJson(DonasiModel instance) =>
    <String, dynamic>{
      'jumlah_donasi': instance.jumlah_donasi,
      'date_donasi': instance.date_donasi?.toIso8601String(),
    };
