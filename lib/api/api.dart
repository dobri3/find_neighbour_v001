import 'package:dio/dio.dart';
import 'package:find_neighbour_v001/models/user.dart';

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
      extra: {
        'withCredentials': true,
      },
    ),
  );

  static Future refreshToken() async {
    try {
      await _dio.head('/auth/refresh');
    } catch (e) {
      print(e);
    }
  }

  static Future<String> googleAuthURL() async {
    try {
      final response = await _dio.get('/auth/google/login');
      return response.data['Url'] ?? 'url';
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Future googleAuthorize(String code, String state) async {
    try {
      final response = await _dio.get('/auth/google/callback',
          queryParameters: {'code': code, 'state': state});

      return response.data['access_token'];
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Future<User> getSession() async {
    try {
      final response = await _dio.get('/user/session');
      return User(
          id: response.data['ID'],
          name: response.data['Name'],
          surname: response.data['Surname'],
          description: response.data['Description']);
    } catch (e) {
      print(e);
      return User(id: '', name: '', surname: '', description: '');
    }
  }

  static Future<User> getUserById(String id) async {
    try {
      Response response = await dio.get('/user/$id');
      return User(
          id: response.data['ID'],
          name: response.data['Name'],
          surname: response.data['Surname'],
          description: response.data['Description']);
    } catch (e) {
      print(e);
      return User(id: '', name: '', surname: '', description: '');
    }
  }

  static Future<String> updateUser(User user) async {
    try {
      final response = await _dio.put('/user/${user.id}', data: user.toJson());
      return response.data['ID'];
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Dio get dio => _dio;
}
