import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static initDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
        connectTimeout: 30*1000 , /// 30 Second
      receiveTimeout:30*1000 , /// 30 Second
      ),
    );
  }

  static Future<Response?> getNetworkData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    return await dio?.get(url, queryParameters: query);
  }
}
