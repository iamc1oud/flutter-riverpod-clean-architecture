import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class APIOptions {}

class ApiService implements APIOptions {
  Dio _dio = Dio();

  ApiService() {
    BaseOptions options = BaseOptions(
      baseUrl: 'http://10.0.2.2:3000', // Replace with your API base URL
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 30),
    );

    _dio = Dio(options);

    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? token = prefs.getString('token');
          
          if(token != null) {
            options.headers.addAll({"Authorization": "Bearer $token"});
          }

          print('Headers: ${options.headers}');
      return handler.next(options);
    }));

    // You can add interceptors for authentication, logging, etc.
  }

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.get(endpoint, queryParameters: queryParameters);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(String endpoint, {Map<String, dynamic>? body}) async {
    try {
      final response = await _dio.post(endpoint, data: body);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }
}

dynamic _handleError(dynamic error) {
  if (error is DioError) {
    String errorMessage = "An error occurred.";
    if (error.response != null) {
      errorMessage =
          "${error.response?.statusCode}: ${error.response?.statusMessage}";
    }
    throw Exception(errorMessage);
  }
  throw error;
}
