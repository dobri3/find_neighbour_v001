import 'package:dio/dio.dart';
import 'package:find_neighbour_v001/api/api.dart';
import 'package:find_neighbour_v001/models/user.dart';
import 'package:find_neighbour_v001/storage/session.dart';

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
      await _dio.get('/auth/google/callback',
          queryParameters: {'code': code, 'state': state});
    } catch (e) {
      throw e;
    }
  }

  Future<String> yandexAuthURL() async {
    try {
      final response = await _dio.get('/auth/yandex/login');
      return response.data['Url'] ?? 'url';
    } catch (e) {
      print(e);
      return '';
    }
  }

  Future yandexAuthorize(String code, String state) async {
    try {
      await _dio.get('/auth/yandex/callback',
          queryParameters: {'code': code, 'state': state});
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<User> getSession() async {
    try {
      User? user = await TemporaryStorage.getValue('user');

      if (user != null) {
        return user;
      }

      final response = await _dio.get('/user/session');
      user = User.fromJson(response.data);
      print(response.data);

      await TemporaryStorage.saveValue('user', user);

      return user;
    } catch (e) {
      print(e);
      return User(id: '', name: '', surname: '', description: '');
    }
  }

  Future logout() async {
    try {
      await _dio.get('/auth/logout');
    } catch (e) {}
  }
}
