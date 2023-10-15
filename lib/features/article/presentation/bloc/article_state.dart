import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pos_flutter/features/article/domain/model/article_model.dart';

abstract class ArticleState extends Equatable {
  final String? success;
  final DioException? error;
  final ArticleModel? article;
  final List<ArticleModel>? articles;
  final List<ArticleModel>? topArticles;
  @override
  List<Object?> get props =>
      [this.success, this.error, this.article, this.articles, this.topArticles];

  const ArticleState(
      {this.success,
      this.error,
      this.article,
      this.articles,
      this.topArticles});
}

class InitialArticleState extends ArticleState {
  const InitialArticleState();
}

class LoadingGetArticleState extends ArticleState {
  const LoadingGetArticleState();
}

class SuccessGetListArticle extends ArticleState {
  final List<ArticleModel>? articles;

  SuccessGetListArticle(this.articles) : super(articles: articles);
}

class LoadingCreateArticleState extends ArticleState {
  const LoadingCreateArticleState();
}

class SuccessCreateArticle extends ArticleState {
  final String success;

  const SuccessCreateArticle(this.success);
}

class LoadingUpdateArticle extends ArticleState {
  const LoadingUpdateArticle();
}

class SuccessUpdateArticle extends ArticleState {
  final String success;

  const SuccessUpdateArticle(this.success);
}

class LoadingDetailArticle extends ArticleState {
  const LoadingDetailArticle();
}

class SuccessGetDetailArticle extends ArticleState {
  final ArticleModel article;

  const SuccessGetDetailArticle(this.article) : super(article: article);
}

class LoadingDeleteArticle extends ArticleState {
  const LoadingDeleteArticle();
}

class SuccessDeleteArticle extends ArticleState {
  final String success;

  const SuccessDeleteArticle(this.success);
}

class LoadingTopArticle extends ArticleState {
  const LoadingTopArticle();
}

class SuccessTopArticle extends ArticleState {
  final List<ArticleModel> articles;

  const SuccessTopArticle(this.articles) : super(topArticles: articles);
}
