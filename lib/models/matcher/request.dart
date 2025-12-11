import 'package:find_neighbour_v001/models/matcher/parameters.dart';

import 'package:find_neighbour_v001/models/user.dart';

class Request {
  final String id;
  final String groupId;
  final String userId;
  User? user;
  final DateTime createdAt;

  Request({
    required this.id,
    required this.groupId,
    required this.userId,
    required this.createdAt,
  });

  void setUser(User user) {
    this.user = user;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': groupId,
      'user_id': userId,
      'user': user?.toJson(),
      'created_at': createdAt,
    };
  }

  static Request fromJson(Map<String, dynamic> json) {
  final req = Request(
    id: json['id'] ?? '',
    groupId: json['group_id'] ?? '',
    userId: json['user_id'] ?? '',
    createdAt: DateTime.parse(json['created_at'] ?? ''),
  );

  if (json['user'] != null) {
    req.user = User.fromJson(json['user']);
  }

  Request nullRequest = Request(
    id: '',
    groupId: '',
    userId: '',
    createdAt: DateTime.now(),
  );

  return req;
}

  // static Request fromJson(Map<String, dynamic> json) {
  //   return Request(
  //     id: json['id'] ?? '',
  //     groupId: json['group_id'] ?? '',
  //     userId: json['user_id'] ?? '',
  //     createdAt: DateTime.parse(json['created_at'] ?? ''),
  //   );
  // }
}


