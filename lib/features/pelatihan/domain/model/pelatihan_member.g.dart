// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pelatihan_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PelatihanMember _$PelatihanMemberFromJson(Map<String, dynamic> json) =>
    PelatihanMember(
      id: json['id'] as int?,
      pelatihan_id: json['pelatihan_id'] as int,
      customer_id: json['customer_id'] as int,
      customer: json['customer'] == null
          ? null
          : UserModel.fromJson(json['customer'] as Map<String, dynamic>),
      acc: json['acc'] as int?,
    );

Map<String, dynamic> _$PelatihanMemberToJson(PelatihanMember instance) =>
    <String, dynamic>{
      'pelatihan_id': instance.pelatihan_id,
      'customer_id': instance.customer_id,
      'acc': instance.acc,
      'customer': instance.customer,
    };
