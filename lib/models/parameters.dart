class Parameters {
  final String name;
  final String surname;
  final Point geo;
  final List<String> photos;
  final int budget;
  final int roomCount;
  final int roommatesCount;
  final int age;
  final bool smoking;
  final bool alko;
  final bool pet;
  final String sex;
  final String userType;
  final String description;

  Parameters({
    required this.name,
    required this.surname,
    required this.geo,
    required this.photos,
    required this.budget,
    required this.roomCount,
    required this.roommatesCount,
    required this.age,
    required this.smoking,
    required this.alko,
    required this.pet,
    required this.sex,
    required this.userType,
    required this.description,
  });

  factory Parameters.fromJson(Map<String, dynamic> json) {
    return Parameters(
      name: json['name'] ?? '',
      surname: json['surname'] ?? '',
      geo: Point.fromJson(json['geo'] ?? {}),
      photos: List<String>.from(json['photos'] ?? []),
      budget: json['budget'] ?? 0,
      roomCount: json['roomCount'] ?? 0,
      roommatesCount: json['roommatesCount'] ?? 0,
      age: json['age'] ?? 0,
      smoking: json['smoking'] ?? false,
      alko: json['alko'] ?? false,
      pet: json['pet'] ?? false,
      sex: json['sex'] ?? 'unspecified',
      userType: json['userType'] ?? 'unspecified',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'geo': geo.toJson(),
      'photos': photos,
      'budget': budget,
      'roomCount': roomCount,
      'roommatesCount': roommatesCount,
      'age': age,
      'smoking': smoking,
      'alko': alko,
      'pet': pet,
      'sex': sex,
      'userType': userType,
      'description': description,
    };
  }

  static Parameters empty() {
    return Parameters(
      name: '',
      surname: '',
      geo: Point(lat: 0.0, lon: 0.0),
      photos: [],
      budget: 0,
      roomCount: 0,
      roommatesCount: 0,
      age: 0,
      smoking: false,
      alko: false,
      pet: false,
      sex: 'unspecified',
      userType: 'unspecified',
      description: '',
    );
  }
}

class Point {
  final double lat;
  final double lon;

  Point({required this.lat, required this.lon});

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      lat: (json['lat'] ?? 0.0).toDouble(),
      lon: (json['lon'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lon': lon,
    };
  }
}

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
}

class Group {
  final String id;
  final String ownerId;
  final Parameters parameters;
  final int maxUsers;
  final DateTime createdAt;
  final DateTime updatedAt;

  Group({
    required this.id,
    required this.ownerId,
    required this.parameters,
    required this.maxUsers,
    required this.createdAt,
    required this.updatedAt,
  });
}

class GroupWithScore {
  final Group group;
  final double score;

  GroupWithScore({
    required this.group,
    required this.score,
  });
}