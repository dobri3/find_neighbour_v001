import 'dart:convert';

class User {
  final String id;
  final String name;
  final String surname;
  final String description;
  final String? photoUrl;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.description,
    this.photoUrl,
  });

  User copyWith({
    String? name,
    String? surname,
    String? description,
    String? photoUrl,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      description: description ?? this.description,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

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
