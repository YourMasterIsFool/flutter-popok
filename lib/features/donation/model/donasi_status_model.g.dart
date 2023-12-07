// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donasi_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonasiStatusModel _$DonasiStatusModelFromJson(Map<String, dynamic> json) =>
    DonasiStatusModel(
      code: json['code'] as int,
      status: json['status'] as String,
    );

Map<String, dynamic> _$DonasiStatusModelToJson(DonasiStatusModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
    };
