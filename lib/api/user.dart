import 'package:find_neighbour_v001/models/user.dart';
import 'package:find_neighbour_v001/api/api.dart';
import 'package:dio/dio.dart';

class UserService {
  static final Dio _dio = ApiService.dio;

  Future<User> getUserById(String id) async {
    try {
      Response response = await _dio.get('/user/$id');
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

  Future<String> updateUser(User user) async {
    try {
      final response = await _dio.put('/user', data: user.toJson());
      return response.data['ID'];
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Dio get dio => _dio;
}
