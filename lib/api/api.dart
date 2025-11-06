import 'package:dio/dio.dart';
import 'package:find_neighbour_v001/models/parameters.dart';
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

  static Future<String> yandexAuthURL() async {
    try {
      final response = await _dio.get('/auth/yandex/login');
      return response.data['Url'] ?? '';
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Future<String> yandexAuthorize(String code, String state) async {
    try {
      final response = await _dio.post('/auth/yandex/authorize',
          queryParameters: {'code': code, 'state': state});

      return response.data['access_token'];
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Future<String> logout() async {
    try {
      final response = await _dio.delete('/auth/logout');
      return response.data['message'] ?? '';
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Future<String> createUser(User user) async {
    try {
      final response = await _dio.post('/user', data: user.toJson());
      return response.data['ID'];
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Future<User> getUser(String uid) async {
    try {
      final response = await _dio.get('/user/$uid');
      return User(
        id: response.data['ID'] ?? '',
        name: response.data['Name'] ?? '',
        surname: response.data['Surname'] ?? '',
        description: response.data['Description'] ?? '',
      );
    } catch (e) {
      print(e);
      return User(id: '', name: '', surname: '', description: '');
    }
  }

  static Future<List<User>> getUsers(String ids) async {
    try {
      final response = await _dio.get('/users', queryParameters: {'ids': ids});
      return (response.data as List).map((userJson) => User(
        id: userJson['ID'] ?? '',
        name: userJson['Name'] ?? '',
        surname: userJson['Surname'] ?? '',
        description: userJson['Description'] ?? '',
      )).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<String> deleteUser(String uid) async {
    try {
      final response = await _dio.delete('/user/$uid');
      return response.data['message'] ?? '';
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Future<String> createForm(String userId, Parameters parameters) async {
    try {
      final response = await _dio.post('/matcher/form', data: {
        'user_id': userId,
        'parameters': parameters.toJson(),
      });
      return response.data['ID'];
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Future<Form> getFormByUser(String uid) async {
    try {
      final response = await _dio.get('/matcher/form/$uid');
      return Form(
        id: response.data['ID'] ?? '',
        userId: response.data['UserID'] ?? '',
        parameters: Parameters.fromJson(response.data['Parameters'] ?? {}),
        active: response.data['Active'] ?? false,
        createdAt: DateTime.parse(response.data['Created_at'] ?? '2023-01-01'),
        updatedAt: DateTime.parse(response.data['Updated_at'] ?? '2023-01-01'),
      );
    } catch (e) {
      print(e);
      return Form(
        id: '',
        userId: '',
        parameters: Parameters.empty(),
        active: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }
  }

  static Future<String> updateForm(String userId, Parameters parameters) async {
    try {
      final response = await _dio.put('/matcher/form', data: {
        'user_id': userId,
        'parameters': parameters.toJson(),
      });
      return response.data['ID'];
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Future<String> deleteForm(String uid) async {
    try {
      final response = await _dio.delete('/matcher/form/$uid');
      return response.data['message'] ?? '';
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Future<Group> getGroup(String gid) async {
    try {
      final response = await _dio.get('/matcher/group/$gid');
      return Group(
        id: response.data['ID'] ?? '',
        ownerId: response.data['OwnerID'] ?? '',
        parameters: Parameters.fromJson(response.data['Parameters'] ?? {}),
        maxUsers: response.data['MaxUsers'] ?? 0,
        createdAt: DateTime.parse(response.data['Created_at'] ?? '2023-01-01'),
        updatedAt: DateTime.parse(response.data['Updated_at'] ?? '2023-01-01'),
      );
    } catch (e) {
      print(e);
      return Group(
        id: '',
        ownerId: '',
        parameters: Parameters.empty(),
        maxUsers: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }
  }

  static Future<String> deleteGroup(String oid) async {
    try {
      final response = await _dio.delete('/matcher/group/$oid');
      return response.data['message'] ?? '';
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Future<List<Form>> listGroupMembers(String gid) async {
    try {
      final response = await _dio.get('/matcher/group/$gid/members');
      return (response.data as List).map((formJson) => Form(
        id: formJson['ID'] ?? '',
        userId: formJson['UserID'] ?? '',
        parameters: Parameters.fromJson(formJson['Parameters'] ?? {}),
        active: formJson['Active'] ?? false,
        createdAt: DateTime.parse(formJson['Created_at'] ?? '2023-01-01'),
        updatedAt: DateTime.parse(formJson['Updated_at'] ?? '2023-01-01'),
      )).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<GroupWithScore>> findGroups(String uid) async {
    try {
      final response = await _dio.get('/matcher/find/$uid');
      return (response.data as List).map((groupJson) => GroupWithScore(
        group: Group(
          id: groupJson['Group']['ID'] ?? '',
          ownerId: groupJson['Group']['OwnerID'] ?? '',
          parameters: Parameters.fromJson(groupJson['Group']['Parameters'] ?? {}),
          maxUsers: groupJson['Group']['MaxUsers'] ?? 0,
          createdAt: DateTime.parse(groupJson['Group']['Created_at'] ?? '2023-01-01'),
          updatedAt: DateTime.parse(groupJson['Group']['Updated_at'] ?? '2023-01-01'),
        ),
        score: (groupJson['Score'] ?? 0.0).toDouble(),
      )).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<String> sendJoinRequest(String userId, String groupId) async {
    try {
      final response = await _dio.post('/matcher/group/send', data: {
        'user_id': userId,
        'group_id': groupId,
      });
      return response.data['request_id'];
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Future<String> acceptJoinRequest(String ownerId, String requestId) async {
    try {
      final response = await _dio.post('/matcher/group/accept', data: {
        'owner_id': ownerId,
        'request_id': requestId,
      });
      return response.data['message'] ?? '';
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Future<String> rejectJoinRequest(String ownerId, String requestId) async {
    try {
      final response = await _dio.post('/matcher/group/reject', data: {
        'owner_id': ownerId,
        'request_id': requestId,
      });
      return response.data['message'] ?? '';
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Dio get dio => _dio;
}
