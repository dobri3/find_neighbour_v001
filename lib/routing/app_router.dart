import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/pages/auth_page.dart';
import 'package:find_neighbour_v001/pages/auth_yandex_callback_page.dart';
import 'package:find_neighbour_v001/pages/home_page.dart';
import 'package:find_neighbour_v001/pages/recommendation_page.dart';
import 'package:find_neighbour_v001/pages/root_page.dart';
import 'package:find_neighbour_v001/pages/user_profile_page.dart';
import 'package:find_neighbour_v001/pages/auth_google_callback_page.dart';
import 'package:flutter/material.dart';
import 'package:find_neighbour_v001/pages/group_page.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: "/",
          page: HomeRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: AuthRoute.page,
          path: '/auth',
        ),
        AutoRoute(
          page: UserProfileRoute.page,
          path: '/profile/:id',
        ),
        AutoRoute(
          page: AuthGoogleCallbackRoute.page,
          path: '/auth/google/callback',
        ),
        AutoRoute(
          page: RecommendationRoute.page,
          path: '/recommendation',
        ),
        AutoRoute(
          page: GroupRoute.page,
          path: '/group/:id',
        ),
        AutoRoute(
          page: AuthYandexCallbackRoute.page,
          path: '/auth/yandex/callback',
        ),
      ];
}
