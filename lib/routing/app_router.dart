import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/pages/auth_page.dart';
import 'package:find_neighbour_v001/pages/home_page.dart';
import 'package:find_neighbour_v001/pages/root_page.dart';

part 'app_router.gr.dart';


@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// Основной, корневой маршрут
        AutoRoute(
          page: RootRoute.page,
          initial: true,
          children: [
            /// Вложенные маршруты
            AutoRoute(page: HomeRoute.page, initial: true),
            AutoRoute(page: AuthRoute.page),
            // AutoRoute(page: Profile Route.page),
          ],
        ),
      ];
}