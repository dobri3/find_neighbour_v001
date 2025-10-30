class User {
  final String id;
  final String name;
  final String surname;
  final String description;

  User(
      {required this.id,
      required this.name,
      required this.surname,
      required this.description});

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name': name,
      'Surname': surname,
      'Description': description,
    };
  }
}
