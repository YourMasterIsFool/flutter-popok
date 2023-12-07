import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/features/lupa_password/domain/service/hint_question_service.dart';
import 'package:pos_flutter/features/lupa_password/presentation/bloc/lupa_password_state.dart';

class LupaPasswordBloc extends Cubit<LupaPasswordState> {
  LupaPasswordBloc() : super(const InitialHintQuestion());

  Future<void> getListQuestionBloc() async {
    emit(LoadingHintQuestion());
    var response = await HintQuestionService().get_list_question_service();
    response?.fold((l) {
      print("l to string" + l.toString());
      emit(SuccessGetHintQuestion(l));
    }, (r) {});
  }
}
