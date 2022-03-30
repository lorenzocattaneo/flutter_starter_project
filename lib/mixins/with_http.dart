import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_project/data/http.dart';

class WithHttp {
  late Dio dio;

  Future<T?> httpRequest<T>(Reader read, Future<T> Function(Dio) req,
      {Function(DioError)? onDioError,
      Function(Error)? onError,
      Function(Exception)? onException}) async {
    dio = read(httpProvider);
    try {
      T val = await req(dio);
      return val;
    } on DioError catch (e) {
      print(e.toString());
      if (onDioError != null) onDioError(e);
    } on Exception catch (e) {
      print(e.toString());
      if (onException != null) onException(e);
    } on Error catch (e) {
      print(e.toString());
      if (onError != null) onError(e);
    }
  }
}
