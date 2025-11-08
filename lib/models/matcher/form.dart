import 'package:find_neighbour_v001/models/matcher/parameters.dart';

class Form {
  final String id;
  final String userId;
  final Parameters parameters;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;

  Form({
    required this.id,
    required this.userId,
    required this.parameters,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'parameters': parameters.toJson(),
      'active': active,
      'created_at': createdAt,
      'updated_t': updatedAt,
    };
  }

  static Form fromJson(Map<String, dynamic> json) {
    return Form(
      id: json['id'],
      userId: json['user_id'],
      parameters: Parameters.fromJson(json['parameters']),
      active: json['active'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
