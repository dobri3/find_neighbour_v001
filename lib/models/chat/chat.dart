import 'package:find_neighbour_v001/models/user.dart';

class Chat {
  final String id;
  final String name;
  final String avatarUrl;
  final List<User> members;

  Chat({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.members,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar_url': avatarUrl,
      'members': members.map((e) => e.toJson()).toList(),
    };
  }

  static Chat fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      members: List<User>.from(
        json['members'].map((x) => User.fromJson(x)),
      ),
    );
  }
}
