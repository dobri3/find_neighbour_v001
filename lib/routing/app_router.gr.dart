// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AuthGoogleCallbackPage]
class AuthGoogleCallbackRoute
    extends PageRouteInfo<AuthGoogleCallbackRouteArgs> {
  AuthGoogleCallbackRoute({
    String? code,
    String? state,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AuthGoogleCallbackRoute.name,
          args: AuthGoogleCallbackRouteArgs(code: code, state: state, key: key),
          rawQueryParams: {'code': code, 'state': state},
          initialChildren: children,
        );

  static const String name = 'AuthGoogleCallbackRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<AuthGoogleCallbackRouteArgs>(
        orElse: () => AuthGoogleCallbackRouteArgs(
          code: queryParams.optString('code'),
          state: queryParams.optString('state'),
        ),
      );
      return AuthGoogleCallbackPage(
        code: args.code,
        state: args.state,
        key: args.key,
      );
    },
  );
}

class AuthGoogleCallbackRouteArgs {
  const AuthGoogleCallbackRouteArgs({this.code, this.state, this.key});

  final String? code;

  final String? state;

  final Key? key;

  @override
  String toString() {
    return 'AuthGoogleCallbackRouteArgs{code: $code, state: $state, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AuthGoogleCallbackRouteArgs) return false;
    return code == other.code && state == other.state && key == other.key;
  }

  @override
  int get hashCode => code.hashCode ^ state.hashCode ^ key.hashCode;
}

/// generated route for
/// [AuthPage]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthPage();
    },
  );
}

/// generated route for
/// [AuthYandexCallbackPage]
class AuthYandexCallbackRoute
    extends PageRouteInfo<AuthYandexCallbackRouteArgs> {
  AuthYandexCallbackRoute({
    String? code,
    String? state,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AuthYandexCallbackRoute.name,
          args: AuthYandexCallbackRouteArgs(code: code, state: state, key: key),
          rawQueryParams: {'code': code, 'state': state},
          initialChildren: children,
        );

  static const String name = 'AuthYandexCallbackRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<AuthYandexCallbackRouteArgs>(
        orElse: () => AuthYandexCallbackRouteArgs(
          code: queryParams.optString('code'),
          state: queryParams.optString('state'),
        ),
      );
      return AuthYandexCallbackPage(
        code: args.code,
        state: args.state,
        key: args.key,
      );
    },
  );
}

class AuthYandexCallbackRouteArgs {
  const AuthYandexCallbackRouteArgs({this.code, this.state, this.key});

  final String? code;

  final String? state;

  final Key? key;

  @override
  String toString() {
    return 'AuthYandexCallbackRouteArgs{code: $code, state: $state, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AuthYandexCallbackRouteArgs) return false;
    return code == other.code && state == other.state && key == other.key;
  }

  @override
  int get hashCode => code.hashCode ^ state.hashCode ^ key.hashCode;
}

/// generated route for
/// [ChatPage]
class ChatRoute extends PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    Key? key,
    String? userId,
    String? groupId,
    String? chatId,
    List<PageRouteInfo>? children,
  }) : super(
          ChatRoute.name,
          args: ChatRouteArgs(
            key: key,
            userId: userId,
            groupId: groupId,
            chatId: chatId,
          ),
          rawQueryParams: {
            'user_id': userId,
            'group_id': groupId,
            'chat_id': chatId,
          },
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<ChatRouteArgs>(
        orElse: () => ChatRouteArgs(
          userId: queryParams.optString('user_id'),
          groupId: queryParams.optString('group_id'),
          chatId: queryParams.optString('chat_id'),
        ),
      );
      return ChatPage(
        key: args.key,
        userId: args.userId,
        groupId: args.groupId,
        chatId: args.chatId,
      );
    },
  );
}

class ChatRouteArgs {
  const ChatRouteArgs({this.key, this.userId, this.groupId, this.chatId});

  final Key? key;

  final String? userId;

  final String? groupId;

  final String? chatId;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, userId: $userId, groupId: $groupId, chatId: $chatId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChatRouteArgs) return false;
    return key == other.key &&
        userId == other.userId &&
        groupId == other.groupId &&
        chatId == other.chatId;
  }

  @override
  int get hashCode =>
      key.hashCode ^ userId.hashCode ^ groupId.hashCode ^ chatId.hashCode;
}

/// generated route for
/// [GroupPage]
class GroupRoute extends PageRouteInfo<GroupRouteArgs> {
  GroupRoute({required String id, Key? key, List<PageRouteInfo>? children})
      : super(
          GroupRoute.name,
          args: GroupRouteArgs(id: id, key: key),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'GroupRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<GroupRouteArgs>(
        orElse: () => GroupRouteArgs(id: pathParams.getString('id')),
      );
      return GroupPage(id: args.id, key: args.key);
    },
  );
}

class GroupRouteArgs {
  const GroupRouteArgs({required this.id, this.key});

  final String id;

  final Key? key;

  @override
  String toString() {
    return 'GroupRouteArgs{id: $id, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GroupRouteArgs) return false;
    return id == other.id && key == other.key;
  }

  @override
  int get hashCode => id.hashCode ^ key.hashCode;
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [RecommendationPage]
class RecommendationRoute extends PageRouteInfo<void> {
  const RecommendationRoute({List<PageRouteInfo>? children})
      : super(RecommendationRoute.name, initialChildren: children);

  static const String name = 'RecommendationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RecommendationPage();
    },
  );
}

/// generated route for
/// [RootPage]
class RootRoute extends PageRouteInfo<void> {
  const RootRoute({List<PageRouteInfo>? children})
      : super(RootRoute.name, initialChildren: children);

  static const String name = 'RootRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RootPage();
    },
  );
}

/// generated route for
/// [UserProfilePage]
class UserProfileRoute extends PageRouteInfo<UserProfileRouteArgs> {
  UserProfileRoute({
    required String id,
    bool auth = false,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          UserProfileRoute.name,
          args: UserProfileRouteArgs(id: id, auth: auth, key: key),
          rawPathParams: {'id': id},
          rawQueryParams: {'auth': auth},
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final queryParams = data.queryParams;
      final args = data.argsAs<UserProfileRouteArgs>(
        orElse: () => UserProfileRouteArgs(
          id: pathParams.getString('id'),
          auth: queryParams.getBool('auth', false),
        ),
      );
      return UserProfilePage(id: args.id, auth: args.auth, key: args.key);
    },
  );
}

class UserProfileRouteArgs {
  const UserProfileRouteArgs({required this.id, this.auth = false, this.key});

  final String id;

  final bool auth;

  final Key? key;

  @override
  String toString() {
    return 'UserProfileRouteArgs{id: $id, auth: $auth, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserProfileRouteArgs) return false;
    return id == other.id && auth == other.auth && key == other.key;
  }

  @override
  int get hashCode => id.hashCode ^ auth.hashCode ^ key.hashCode;
}
