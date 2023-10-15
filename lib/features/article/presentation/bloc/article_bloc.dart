import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/features/article/domain/model/article_model.dart';
import 'package:pos_flutter/features/article/domain/service/article_service.dart';
import 'package:pos_flutter/features/article/presentation/bloc/article_state.dart';

class ArticleBloc extends Cubit<ArticleState> {
  final ArticleService _articleService = new ArticleService();
  ArticleBloc() : super(const InitialArticleState());

  Future<void> getListArticleBloc({Map<String, dynamic>? params}) async {
    emit(LoadingGetArticleState());
    var response = await _articleService.getListArticle(params: params);

    response?.fold((l) {
      emit(SuccessGetListArticle(l));
    }, (r) {});
  }

  Future<void> getListTopArticle({Map<String, dynamic>? params}) async {
    emit(LoadingTopArticle());
    var response = await _articleService.getTopArticle(params: params);

    response?.fold((l) {
      emit(SuccessTopArticle(l));
    }, (r) {});
  }

  Future<void> createArticleBloc({required ArticleModel schema}) async {
    emit(LoadingCreateArticleState());
    var response = await _articleService.createArticleService(schema: schema);

    print(schema.toJson());
    response?.fold((l) async {
      getListArticleBloc();
      emit(SuccessCreateArticle("Berhasil mebuat article"));
    }, (r) {});
  }

  Future<void> detailArticleBloc({required int id}) async {
    emit(LoadingDetailArticle());
    var response = await _articleService.getDetailArticleService(id: id);

    response?.fold((l) async {
      emit(SuccessGetDetailArticle(l));
    }, (r) {});
  }

  Future<void> deleteArticleBloc({required int id}) async {
    emit(LoadingDeleteArticle());
    var response = await _articleService.deleteArticleService(id: id);

    response?.fold((l) async {
      emit(LoadingDeleteArticle());
    }, (r) {});
  }

  Future<void> updateArticleBloc(
      {required int id, required ArticleModel schema}) async {
    emit(LoadingUpdateArticle());
    var response =
        await _articleService.updateArticleService(id: id, schema: schema);

    response?.fold((l) async {
      getListArticleBloc();
      emit(SuccessUpdateArticle("Berhasil Update artikel"));
    }, (r) {
      print('error update ' + r.toString());
    });
  }
}
