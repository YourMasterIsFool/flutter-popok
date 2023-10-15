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
      name: json['name'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'role_id': instance.role_id,
      'password': instance.password,
    };
