import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pos_flutter/config/client/client.dart';
import 'package:pos_flutter/features/lupa_password/model/hint_question_model.dart';

class HintQuestionService {
  Future<Either<List<HintQuestionModel>, DioException?>?>
      get_list_question_service() async {
    try {
      var response = await client.get('/hint_question');

      print('hint service question' +
          (response.data['data'] as Iterable)
              .map((e) => HintQuestionModel.fromJson(e))
              .toList()
              .toString());

      // List<HintQuestionModel> list = ;

      List<HintQuestionModel> questions = (response.data['data'] as Iterable)
          .map((e) => HintQuestionModel.fromJson(e))
          .toList();

      // print('listttt' + list.toString());
      return left(questions);
    } catch (e) {
      if (e is DioException) {
        print(e.response.toString());
        return right(e);
      }
    }
  }
}
