// import 'package:find_neighbour_v001/pages/auth_page.dart';
import 'package:find_neighbour_v001/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:find_neighbour_v001/api/api.dart';
import 'package:find_neighbour_v001/api/interceptor.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'package:auto_route/auto_route.dart';

final appRouter = AppRouter();

void main() {
  usePathUrlStrategy();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ApiService.dio.interceptors.add(RefreshTokenInterceptor(
      dio: ApiService.dio,
      refreshTokenCallback: ApiService.authService.refreshToken,
    ));
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Inter",
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      routerConfig: appRouter.config(
        navigatorObservers: () => [
          AutoRouterObserver(),
        ],
      ),
    );
  }
}
