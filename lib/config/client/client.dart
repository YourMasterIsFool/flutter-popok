import 'package:dio/dio.dart';
import 'package:pos_flutter/config/client/client_interceptor.dart';

BaseOptions baseOptions = BaseOptions(baseUrl: 'http://192.168.0.103:8000/api');
final client = Dio(baseOptions)..interceptors.add(ClientInterceptor());
