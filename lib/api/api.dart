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
          queryParameters: {'code': code, 'state': state});

      return response.data['access_token'];
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Future<bool> logout() async {
    try {
      await _dio.delete('/auth/logout');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
}

static Future<String> yandexAuthURL() async {
    try {
      final response = await _dio.get('/auth/yandex/login');
      return response.data['Url'] ?? '';
    } catch (e) {
      print(e);
      return '';
    }
}

static Future yandexAuthorize(String code, String state) async {
    try {
      final response = await _dio.get(
        '/auth/yandex/callback',
        queryParameters: {'code': code, 'state': state},
      );
      return response.data['access_token'];
    } catch (e) {
      print(e);
      return '';
    }
}

static Future getSession() async {
    try {
      final response = await _dio.get('/user/session');
      return response.data['id'] ?? '';
    } catch (e) {
      print(e);
      return false;
    }
}


  static Future createUser() async {
    try {
      final response = await _dio.get('/user');
      return response.data['id'] ?? '';
    } catch (e) {
      print(e);
      return false;
    }
}


  static Dio get dio => _dio;
}









class User {
  final String id;
  final String name;
  final String surname;
  final List<String> contacts;
  final String description;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.contacts,
    required this.description,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['json'] ?? '',
      name: json['name'] ?? '',
      surname: json['surname'] ?? '',
      contacts: List<String>.from(json['contacts'] ?? []),
      description: json['description'] ?? '',
    );
  }
}