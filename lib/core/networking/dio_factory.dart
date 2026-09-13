import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/networking/api_constants.dart';

class DioFactory {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        queryParameters: {'api_key': ApiConstants.apiKey, 'language': 'en-US'},
      ),
    );
  }

  static Future<Response<dynamic>> getData(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    final response = await dio.get(endpoint, queryParameters: queryParameters);
    return response;
  }
}
