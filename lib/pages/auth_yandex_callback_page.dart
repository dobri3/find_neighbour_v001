import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/api/api.dart';

import 'package:find_neighbour_v001/routing/app_router.dart';

@RoutePage()
class AuthYandexCallbackPage extends StatelessWidget {
  final String? code;
  final String? state;

  const AuthYandexCallbackPage({
    @QueryParam('code') this.code,
    @QueryParam('state') this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiService.yandexAuthorize(code ?? '', state ?? '').then(
      (value) => ApiService.getSession().then((value) {
        context.router.push(UserProfileRoute(id: value.id));
      }),
    );
    return const Scaffold();
  }
}