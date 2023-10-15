import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pos_flutter/config/client/client_interceptor.dart';

BaseOptions baseOptions =
    BaseOptions(baseUrl: '${dotenv.env["BASE_URL_API"]}/api');
final client = Dio(baseOptions)..interceptors.add(ClientInterceptor());
