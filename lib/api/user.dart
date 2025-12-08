import 'package:find_neighbour_v001/models/user.dart';
import 'package:find_neighbour_v001/api/api.dart';
import 'package:dio/dio.dart';
import 'package:find_neighbour_v001/storage/session.dart';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

class UserService {
  static final Dio _dio = ApiService.dio;

  Future<User> getUserById(String id) async {
    try {
      Response response = await _dio.get('/user/$id');
      return User.fromJson(response.data);
    } catch (e) {
      print(e);
      return User(id: '', name: '', surname: '', description: '');
    }
  }

  Future<String> updateUser(User user, XFile? avatar) async {
    try {
      print(avatar!.path.split('/').last);
      print(avatar.mimeType);
      var formData = FormData.fromMap({
        "data": user.toJsonForServerString(),
        "avatar": avatar == null
            ? null
            : MultipartFile.fromBytes(
                await avatar.readAsBytes(),
                filename: avatar.path.split('/').last,
                contentType: MediaType.parse(
                  avatar.mimeType!,
                ),
              ),
      });

      final response = await _dio.put(
        '/user',
        data: formData,
        options: Options(
            contentType: 'multipart/form-data',
            headers: {'Content-Type': 'multipart/form-data'}),
      );

      await TemporaryStorage.clear();

      return response.data['Id'];
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Dio get dio => _dio;
}
