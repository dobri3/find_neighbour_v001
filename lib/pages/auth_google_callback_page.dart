import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/api/api.dart';

import 'package:find_neighbour_v001/routing/app_router.dart';

@RoutePage()
class AuthGoogleCallbackPage extends StatelessWidget {
  final String? code;
  final String? state;

  const AuthGoogleCallbackPage({
    @QueryParam('code') this.code,
    @QueryParam('state') this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiService.authService.googleAuthorize(code ?? '', state ?? '').then(
          (value) => ApiService.authService.getSession().then((value) {
            context.router.push(UserProfileRoute(id: value.id, auth: true));
          }),
        );
    return const Scaffold();
  }
}
