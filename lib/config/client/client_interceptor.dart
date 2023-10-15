import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/commons/loading_overflay.dart';
import 'package:pos_flutter/config/secure_storage/secure_storage.dart';

class ClientInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // TODO: implement onError

    if (err.response?.statusCode == 401) {
      // navigate to the authentication screen
      await SecureStorage().deleteToken();

      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('/login', (route) => false);
      return handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: 'The user has been deleted or the session is expired',
        ),
      );
    }
    return handler.next(err);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // TODO: implement onRequest
    options.headers.addAll({"Accept": "application/json"});
    options.headers.addAll({"content-type": "application/json"});

    final token = await SecureStorage().getToken();
    if (token != null) {
      options.headers.addAll({"Authorization": "Bearer $token"});
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // TODO: implement onResponse

    final token = await SecureStorage().getToken();

    // if (token == null) {
    //   navigatorKey.currentState
    //       ?.pushNamedAndRemoveUntil('/logoot', (route) => false);
    // }
    super.onResponse(response, handler);
  }
}
