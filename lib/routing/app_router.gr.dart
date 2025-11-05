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
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          UserProfileRoute.name,
          args: UserProfileRouteArgs(id: id, key: key),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<UserProfileRouteArgs>(
        orElse: () => UserProfileRouteArgs(id: pathParams.getString('id')),
      );
      return UserProfilePage(id: args.id, key: args.key);
    },
  );
}

class UserProfileRouteArgs {
  const UserProfileRouteArgs({required this.id, this.key});

  final String id;

  final Key? key;

  @override
  String toString() {
    return 'UserProfileRouteArgs{id: $id, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserProfileRouteArgs) return false;
    return id == other.id && key == other.key;
  }

  @override
  int get hashCode => id.hashCode ^ key.hashCode;
}
