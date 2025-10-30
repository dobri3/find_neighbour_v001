import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/pages/auth_page.dart';
import 'package:find_neighbour_v001/pages/home_page.dart';
import 'package:find_neighbour_v001/pages/recommendation_page.dart';
import 'package:find_neighbour_v001/pages/root_page.dart';

part 'app_router.gr.dart';

// Большая проблема с зависимостями от библиотек (или еще чем то)
// Карточку группы соседей и страницу рекомендаций еще нужно допилить

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
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
        RecommendationRoute(
          page: RecommendationRoute.page,
          path: '/recommendation',
        ),
      ];
}
