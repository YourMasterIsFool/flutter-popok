import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hint_question_model.g.dart';

@JsonSerializable()
class HintQuestionModel extends Equatable {
  final int code;
  final int? id;
  final String question;

  HintQuestionModel({
    required this.code,
    this.id,
    required this.question,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [this.code, this.question, this.id];

  Map<String, dynamic> toJson() => _$HintQuestionModelToJson(this);
  factory HintQuestionModel.fromJson(Map<String, dynamic> json) =>
      _$HintQuestionModelFromJson(json);
}
