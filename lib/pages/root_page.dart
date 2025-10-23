import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/routing/app_router.dart';
import 'package:flutter/cupertino.dart';

@RoutePage()
class RootPage extends StatelessWidget {
  const RootPage({super.key});


  @override
  Widget build(BuildContext context) {
    return const AutoTabsScaffold(
      routes: [
         HomeRoute(),
         AuthRoute(),
        UserProfileRoute(),
        DraftStylesRoute(),
      ],
    );
  }
}