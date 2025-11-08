import 'package:find_neighbour_v001/models/matcher/parameters.dart';
import 'package:find_neighbour_v001/models/matcher/form.dart';

class Group {
  final String id;
  final String ownerId;
  final Parameters parameters;
  final int maxUsers;
  final DateTime createdAt;
  final DateTime updatedAt;
  List<Form> members;

  Group({
    required this.id,
    required this.ownerId,
    required this.parameters,
    required this.maxUsers,
    required this.createdAt,
    required this.updatedAt,
    this.members = const [],
  });

  void setMembers(List<Form> members) {
    this.members = members;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner_id': ownerId,
      'parameters': parameters.toJson(),
      'max_users': maxUsers,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  static Group fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'] ?? '',
      ownerId: json['owner_id'] ?? '',
      parameters: Parameters.fromJson(json['parameters']),
      maxUsers: json['max_users'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class GroupWithScore {
  final Group group;
  final double score;

  GroupWithScore({required this.group, required this.score});

  Map<String, dynamic> toJson() {
    return {
      'group': group.toJson(),
      'score': score,
    };
  }

  static GroupWithScore fromJson(Map<String, dynamic> json) {
    return GroupWithScore(
      group: Group.fromJson(json['group']),
      score: json['score'],
    );
  }
}
