import 'package:dio/dio.dart';
import 'package:find_neighbour_v001/api/api.dart';

import 'package:find_neighbour_v001/models/matcher/parameters.dart';
import 'package:find_neighbour_v001/models/matcher/group.dart';
import 'package:find_neighbour_v001/models/matcher/form.dart';
import 'package:find_neighbour_v001/models/matcher/request.dart';

import 'dart:convert';

class MatcherService {
  static final Dio _dio = ApiService.dio;

  Future createForm(String userId, Parameters parameters) async {
    try {
      var formData = FormData.fromMap({
        "data": json.encode({
          'user_id': userId,
          "parameters": parameters.toJson(),
        }),
      });

      await _dio.post(
        '/matcher/form',
        data: formData,
        options: Options(
            contentType: 'multipart/form-data',
            headers: {'Content-Type': 'multipart/form-data'}),
      );
    } catch (e) {
      print(e);
    }
  }

  Future updateForm(String userId, Parameters parameters) async {
    try {
      var formData = FormData.fromMap({
        "data": json.encode({
          'user_id': userId,
          "parameters": parameters.toJson(),
        }),
      });

      await _dio.put('/matcher/form',
          data: formData,
          options: Options(
              contentType: 'multipart/form-data',
              headers: {'Content-Type': 'multipart/form-data'}));
    } catch (e) {
      print(e);
    }
  }

  Future<Group> getGroup(String groupId) async {
    try {
      Response response = await _dio.get('/matcher/group/$groupId');
      return Group.fromJson(response.data);
    } catch (e) {
      print(e);
      return Group(
        id: '',
        ownerId: '',
        parameters: Parameters(
          name: '',
          surname: '',
          geo: Point(lat: 0, lon: 0),
          photos: [],
          budget: 0,
          roomCount: 0,
          roommatesCount: 0,
          months: 0,
          age: 0,
          smoking: false,
          alko: false,
          pet: false,
          sex: '',
          userType: '',
          description: '',
          address: '',
        ),
        maxUsers: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }
  }

  Future<Group> getGroupByUserId(String userId) async {
    try {
      Response response = await _dio.get('/matcher/group/user/$userId');
      return Group.fromJson(response.data);
    } catch (e) {
      print(e);
      return Group(
        id: '',
        ownerId: '',
        parameters: Parameters(
          name: '',
          surname: '',
          geo: Point(lat: 0, lon: 0),
          photos: [],
          budget: 0,
          roomCount: 0,
          roommatesCount: 0,
          months: 0,
          age: 0,
          smoking: false,
          alko: false,
          pet: false,
          sex: '',
          userType: '',
          description: '',
          address: '',
        ),
        maxUsers: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }
  }

  Future<List<Form>> getListGroupMembers(String groupId) async {
    try {
      Response response = await _dio.get('/matcher/group/members/$groupId');
      final data = response.data["forms"];

      if (data is List) {
        return data
            .map(
              (e) => Form.fromJson(e),
            )
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<GroupWithScore>> findGroups(String userId) async {
    try {
      Response response = await _dio.get('/matcher/find/$userId');
      print(response.data);

      final data = response.data['groups_with_score'];

      if (data is List) {
        return await Future.wait(
          data.map(
            (e) async {
              GroupWithScore group = GroupWithScore.fromJson(e);
              group.group.setMembers(await getListGroupMembers(group.group.id));
              return group;
            },
          ).toList(),
        );
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }




  Future<String> sendJoinRequest(String userId, String groupId) async {
    try {
      Response respone = await _dio.post('/matcher/group/send',
          data: {'user_id': userId, 'group_id': groupId});
      return respone.data['requrest_id'];
    } catch (e) {
      print(e);
      return '';
    }
  }

  Future acceptJoinRequest(String ownerId, String requestId) async {
    try {
      await _dio.post('/matcher/group/accept',
          data: {'owner_id': ownerId, 'request_id': requestId});
    } catch (e) {
      print(e);
    }
  }

  Future rejectJoinRequest(String ownerId, String requestId) async {
    try {
      await _dio.post('/matcher/group/reject',
          data: {'owner_id': ownerId, 'request_id': requestId});
    } catch (e) {
      print(e);
    }
  }

  Future<Form> getFormByUser(String userId) async {
    try {
      Response response = await _dio.get('/matcher/form/$userId');
      return Form.fromJson(response.data);
    } catch (e) {
      print(e);
      throw e;
      // return Form(
      //   id: '',
      //   userId: '',
      //   parameters: Parameters(
      //     name: '',
      //     surname: '',
      //     geo: Point(lat: 0, lon: 0),
      //     photos: [],
      //     budget: 0,
      //     roomCount: 0,
      //     roommatesCount: 0,
      //     months: 0,
      //     age: 0,
      //     smoking: false,
      //     alko: false,
      //     pet: false,
      //     sex: '',
      //     userType: '',
      //     description: '',
      //     address: '',
      //   ),
      //   active: false,
      //   createdAt: DateTime.now(),
      //   updatedAt: DateTime.now(),
      // );
    }
  }

  Future<List<Request>> getListRequests(String groupId) async {
    try {
      Response response = await _dio.get('/matcher/group/$groupId/requests');
      final data = response.data;

      if (data is List) {
        return await Future.wait(
          data.map(
            (e) async {
              Request request = Request.fromJson(e);
              request.setUser(
                  await ApiService.userService.getUserById(request.userId));
              return request;
            },
          ).toList(),
        );
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future leaveGroup(String id) async {
    try {
      await _dio.post('/matcher/group/user');
    } catch (e) {
      throw e;
    }
  }

  // Future kickMember(String memberId) async {
  //   try {
  //     await _dio.post('matcher/group/kick/$memberId');
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  Future<void> kickMember(String groupId, String userId) async {
    try{await _dio.post('/matcher/group/user/kick', data: {
    'group_id': groupId,
    'user_id': userId,
  });
  }
  catch (e) {
      throw e;
    }
  
}


}
