// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthGoogleCallbackRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<AuthGoogleCallbackRouteArgs>(
          orElse: () => AuthGoogleCallbackRouteArgs(
                code: queryParams.optString('code'),
                state: queryParams.optString('state'),
              ));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AuthGoogleCallbackPage(
          code: args.code,
          state: args.state,
          key: args.key,
        ),
      );
    },
    AuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    RootRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RootPage(),
      );
    },
    UserProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<UserProfileRouteArgs>(
          orElse: () => UserProfileRouteArgs(id: pathParams.getString('id')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserProfilePage(
          id: args.id,
          key: args.key,
        ),
      );
    },
  };
}

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
          args: AuthGoogleCallbackRouteArgs(
            code: code,
            state: state,
            key: key,
          ),
          rawQueryParams: {
            'code': code,
            'state': state,
          },
          initialChildren: children,
        );

  static const String name = 'AuthGoogleCallbackRoute';

  static const PageInfo<AuthGoogleCallbackRouteArgs> page =
      PageInfo<AuthGoogleCallbackRouteArgs>(name);
}

class AuthGoogleCallbackRouteArgs {
  const AuthGoogleCallbackRouteArgs({
    this.code,
    this.state,
    this.key,
  });

  final String? code;

  final String? state;

  final Key? key;

  @override
  String toString() {
    return 'AuthGoogleCallbackRouteArgs{code: $code, state: $state, key: $key}';
  }
}

/// generated route for
/// [AuthPage]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RootPage]
class RootRoute extends PageRouteInfo<void> {
  const RootRoute({List<PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
          args: UserProfileRouteArgs(
            id: id,
            key: key,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static const PageInfo<UserProfileRouteArgs> page =
      PageInfo<UserProfileRouteArgs>(name);
}

class UserProfileRouteArgs {
  const UserProfileRouteArgs({
    required this.id,
    this.key,
  });

  final String id;

  final Key? key;

  @override
  String toString() {
    return 'UserProfileRouteArgs{id: $id, key: $key}';
  }
}
