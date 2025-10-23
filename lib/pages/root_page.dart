// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';

// @RoutePage()
// class RootPage extends StatelessWidget {
//   const RootPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();


    
//   }
// }

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
      ],
      // bottomNavigationBuilder: (_, tabsRouter) {
      //   return BottomNavigationBar(
      //     currentIndex: tabsRouter.activeIndex,
      //     onTap: tabsRouter.setActiveIndex,
      //     items: const [
      //       BottomNavigationBarItem(
      //         label: 'Все книги',
      //         icon: Icon(Icons.book),
      //       ),
      //       BottomNavigationBarItem(
      //         label: 'Мои книги',
      //         icon: Icon(Icons.book_online),
      //       ),
      //       BottomNavigationBarItem(
      //         label: 'Профиль',
      //         icon: Icon(Icons.verified_user),
      //       ),
      //     ],
      //   );
      // },
    );
  }
}