// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupModel _$SignupModelFromJson(Map<String, dynamic> json) => SignupModel(
      email: json['email'] as String,
      alamat: json['alamat'] as String?,
      jenis_kelamin: json['jenis_kelamin'] as String?,
      phone_number: json['phone_number'] as String?,
      name: json['name'] as String,
      question_id: json['question_id'] as int,
      question_answer: json['question_answer'] as String,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$SignupModelToJson(SignupModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'alamat': instance.alamat,
      'jenis_kelamin': instance.jenis_kelamin,
      'phone_number': instance.phone_number,
      'password': instance.password,
      'question_id': instance.question_id,
      'question_answer': instance.question_answer,
    };
