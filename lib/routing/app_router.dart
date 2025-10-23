import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/pages/auth_page.dart';
import 'package:find_neighbour_v001/pages/draft_styles_page.dart';
import 'package:find_neighbour_v001/pages/home_page.dart';
import 'package:find_neighbour_v001/pages/root_page.dart';
import 'package:find_neighbour_v001/pages/user_profile_page.dart';

part 'app_router.gr.dart';


@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        // / Основной, корневой маршрут
        AutoRoute(
          path: "/root",
          page: RootRoute.page,
          initial: true,
          children: [
            // / Вложенные маршруты
            AutoRoute(page: HomeRoute.page, initial: true, path: 'home-page',),  
            AutoRoute(page: AuthRoute.page, path: 'auth-page',),
            AutoRoute(page: UserProfileRoute.page, path: 'user-prifile-page',),
            AutoRoute(page: DraftStylesRoute.page, path: 'draft-styles-page',),
            // AutoRoute(page: Profile Route.page),
          ],
        ),
        
      ];
}