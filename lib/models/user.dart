import 'dart:convert';

class User {
  final String id;
  final String name;
  final String surname;
  final String description;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name': name,
      'Surname': surname,
      'Description': description,
    };
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['ID'] ?? '',
      name: json['Name'] ?? '',
      surname: json['Surname'] ?? '',
      description: json['Description'] ?? '',
    );
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  static User fromJsonString(String jsonString) {
    return User.fromJson(jsonDecode(jsonString));
  }
}
