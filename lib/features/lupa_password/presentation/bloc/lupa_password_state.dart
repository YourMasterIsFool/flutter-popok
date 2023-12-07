import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pos_flutter/features/lupa_password/model/hint_question_model.dart';

abstract class LupaPasswordState extends Equatable {
  final HintQuestionModel? hintQuestionModel;
  final DioException? error;

  const LupaPasswordState({this.hintQuestionModel, this.error});
  @override
  List<Object?> get props => [this.hintQuestionModel, this.error];
}

class InitialHintQuestion extends LupaPasswordState {
  const InitialHintQuestion();
}

class LoadingHintQuestion extends LupaPasswordState {
  const LoadingHintQuestion();
}

class SuccessGetHintQuestion extends LupaPasswordState {
  final List<HintQuestionModel> listQuestion;
  const SuccessGetHintQuestion(this.listQuestion);
}
