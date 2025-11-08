import 'package:dio/dio.dart';
import 'package:find_neighbour_v001/api/api.dart';
import 'package:find_neighbour_v001/models/user.dart';

class AuthService {
  static final Dio _dio = ApiService.dio;

  Future refreshToken() async {
    try {
      await _dio.head('/auth/refresh');
    } catch (e) {
      print(e);
    }
  }

  Future<String> googleAuthURL() async {
    try {
      final response = await _dio.get('/auth/google/login');
      return response.data['Url'] ?? 'url';
    } catch (e) {
      print(e);
      return '';
    }
  }

  Future googleAuthorize(String code, String state) async {
    try {
      final response = await _dio.get('/auth/google/callback',
          queryParameters: {'code': code, 'state': state});

      return response.data['access_token'];
    } catch (e) {
      print(e);
      return '';
    }
  }

  Future<User> getSession() async {
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
}
