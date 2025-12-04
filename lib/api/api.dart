import 'package:dio/dio.dart';
import 'package:find_neighbour_v001/models/user.dart';
import 'package:find_neighbour_v001/api/auth.dart';
import 'package:find_neighbour_v001/api/user.dart';
import 'package:find_neighbour_v001/api/matcher.dart';
import 'package:find_neighbour_v001/api/chat.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: const String.fromEnvironment('BASE_URL',
          defaultValue: 'http://localhost:8080/api/v1'),
      sendTimeout: const Duration(seconds: 15),
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Origin': const String.fromEnvironment('ORIGIN',
            defaultValue: 'http://localhost:8888'),
      },
      extra: {
        'withCredentials': true,
      },
    ),
  );

  static final AuthService _authService = AuthService();
  static final UserService _userService = UserService();
  static final MatcherService _matcherService = MatcherService();
  static final ChatService _chatService = ChatService();

  static Dio get dio => _dio;

  static AuthService get authService => _authService;
  static UserService get userService => _userService;
  static MatcherService get matcherService => _matcherService;
  static ChatService get chatService => _chatService;
}
