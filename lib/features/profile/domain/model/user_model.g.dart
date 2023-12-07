// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int?,
      email: json['email'] as String,
      role_id: json['role_id'] as int,
      role_name: json['role_name'] as String?,
      alamat: json['alamat'] as String?,
      phone_number: json['phone_number'] as String?,
      jenis_kelamin: json['jenis_kelamin'] as String?,
      name: json['name'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'phone_number': instance.phone_number,
      'alamat': instance.alamat,
      'jenis_kelamin': instance.jenis_kelamin,
      'role_id': instance.role_id,
      'password': instance.password,
    };
