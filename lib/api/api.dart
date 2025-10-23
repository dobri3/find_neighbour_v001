import 'package:dio/dio.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:8080/api/v1',
      sendTimeout: const Duration(seconds: 15),
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Origin': 'http://localhost:8888',
      },
    ),
  );

  static Future refreshToken() async {
    try {
      await _dio.get('/auth/refresh');
    } catch (e) {
      print(e);
    }
  }

  static Future<String> googleAuthURL() async {
    try {
      final response = await _dio.get('/auth/google/login');
      return response.data['Url'] ?? '';
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Future googleAuthorize(String code, String state) async {
    try {
      final response = await _dio.post('/auth/google/authorize',
          queryParameters: {'code': code, 'state': code});

      return response.data['access_token'];
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Dio get dio => _dio;
}
