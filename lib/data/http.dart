import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_project/authentication_provider.dart';
import 'package:flutter_starter_project/main.dart';

final httpProvider = Provider<Dio>((ref) {
  final baseUrl = ref.watch(baseUrlProvider);
  var dio = Dio(BaseOptions(connectTimeout: 10000, baseUrl: baseUrl));

  final authProvider = ref.watch(authenticationProvider.notifier);
  if (authProvider.isAuthenticated()) {
    dio.options.headers
        .addAll({"Authorization": "Bearer ${authProvider.state}"});
  }

  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }
  return dio;
});
