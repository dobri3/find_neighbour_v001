class Parameters {
  final String name;
  final String surname;
  final Point geo;
  final List<String> photos;
  final int budget;
  final int roomCount;
  final int roommatesCount;
  final int months;
  final int age;

  final bool smoking;
  final bool alko;
  final bool pet;

  final String sex;
  final String userType;
  final String description;
  final String address;

  Parameters({
    required this.name,
    required this.surname,
    required this.geo,
    required this.photos,
    required this.budget,
    required this.roomCount,
    required this.roommatesCount,
    required this.months,
    required this.age,
    required this.smoking,
    required this.alko,
    required this.pet,
    required this.sex,
    required this.userType,
    required this.description,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'geo': geo.toJson(),
      'photos': photos,
      'budget': budget,
      'room_count': roomCount,
      'roommates_count': roommatesCount,
      'months': months,
      'age': age,
      'smoking': smoking,
      'alko': alko,
      'pet': pet,
      'sex': sex,
      'user_type': userType,
      'description': description,
      'address': address,
    };
  }

  static Parameters fromJson(Map<String, dynamic> json) {
    return Parameters(
      name: json['name'] ?? '',
      surname: json['surname'] ?? '',
      geo: Point.fromJson(json['geo'] ?? {}),
      photos: json['photos'] ?? [],
      budget: json['budget'] ?? 0,
      roomCount: json['room_count'] ?? 0,
      roommatesCount: json['roommates_count'] ?? 0,
      months: json['months'] ?? 0,
      age: json['age'] ?? 0,
      smoking: json['smoking'] ?? false,
      alko: json['alko'] ?? false,
      pet: json['pet'] ?? false,
      sex: json['sex'] ?? '',
      userType: json['user_type'] ?? '',
      description: json['description'] ?? '',
      address: json['address'] ?? '',
    );
  }
}

class Point {
  final double lat;
  final double lon;

  Point({required this.lat, required this.lon});

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lon': lon,
    };
  }

  static Point fromJson(Map<String, dynamic> json) {
    return Point(
      lat: json['lat'] ?? 0,
      lon: json['lon'] ?? 0,
    );
  }
}
