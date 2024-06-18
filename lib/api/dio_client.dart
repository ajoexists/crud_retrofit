import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient({String? baseUrl})
      : _dio = Dio(BaseOptions(baseUrl: baseUrl ?? "https://dummy.restapiexample.com/api/v1")) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        options.headers['Authorization'] = 'Bearer your_token';
        print('Request: ${options.method} ${options.path}');
        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        print('Response: ${response.statusCode} ${response.data}');
        return handler.next(response);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) {
        print('Error: ${error.response?.statusCode} ${error.message}');
        return handler.next(error);
      },
    ));
  }

  Dio get dio => _dio;
}
