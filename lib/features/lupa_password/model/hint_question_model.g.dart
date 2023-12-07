// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hint_question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HintQuestionModel _$HintQuestionModelFromJson(Map<String, dynamic> json) =>
    HintQuestionModel(
      code: json['code'] as int,
      id: json['id'] as int?,
      question: json['question'] as String,
    );

Map<String, dynamic> _$HintQuestionModelToJson(HintQuestionModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'id': instance.id,
      'question': instance.question,
    };
