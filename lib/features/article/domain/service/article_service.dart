import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pos_flutter/config/client/client.dart';
import 'package:pos_flutter/features/article/domain/model/article_model.dart';

class ArticleService {
  Future<Either<List<ArticleModel>, DioException?>?> getListArticle(
      {Map<String, dynamic>? params}) async {
    try {
      var response = await client.get('/article', queryParameters: params);
      if (response.statusCode == 200) {
        List<ArticleModel> articles = (response.data['data'] as Iterable)
            .map((e) => ArticleModel.fromJson(e))
            .toList();

        return left(articles);
      }
    } catch (e) {
      if (e is DioException) {
        print(e.response);
        return right(e);
      }
    }
  }

  Future<Either<List<ArticleModel>, DioException?>?> getTopArticle(
      {Map<String, dynamic>? params}) async {
    try {
      var response =
          await client.get('/article/top-article', queryParameters: params);
      if (response.statusCode == 200) {
        List<ArticleModel> articles = (response.data['data'] as Iterable)
            .map((e) => ArticleModel.fromJson(e))
            .toList();

        return left(articles);
      }
    } catch (e) {
      if (e is DioException) {
        print(e.response);
        return right(e);
      }
    }
  }

  Future<Either<ArticleModel, DioException>?> createArticleService(
      {required ArticleModel schema}) async {
    try {
      var response = await client.post('/article', data: schema.toJson());
      if (response.statusCode == 201) {
        ArticleModel articleModel =
            ArticleModel.fromJson(response.data['data']);

        return left(articleModel);
      }
    } catch (e) {
      if (e is DioException) {
        print(e.response.toString());
        return right(e);
      }
    }
  }

  Future<Either<ArticleModel, DioException>?> updateArticleService(
      {required ArticleModel schema, required int id}) async {
    try {
      var response =
          await client.patch('/article/${id}', data: schema.toJson());

      ArticleModel articleModel = ArticleModel.fromJson(response.data['data']);

      return left(articleModel);
    } catch (e) {
      if (e is DioException) {
        print('error update' + e.response.toString());
        return right(e);
      }
    }
  }

  Future<Either<String, DioException>?> deleteArticleService(
      {required int id}) async {
    try {
      var response = await client.delete('/article/${id}');

      return left("Success Delete Article");
    } catch (e) {
      if (e is DioException) {
        print(e.response.toString());
        return right(e);
      }
    }
  }

  Future<Either<ArticleModel, DioException>?> getDetailArticleService(
      {required int id}) async {
    try {
      var response = await client.get('/article/${id}');
      if (response.statusCode == 200) {
        return left(new ArticleModel.fromJson(response.data['data']));
      }
    } catch (e) {
      if (e is DioException) {
        print(e.response.toString());
        return right(e);
      }
    }
  }
}
