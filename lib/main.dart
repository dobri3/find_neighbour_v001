// import 'package:find_neighbour_v001/pages/auth_page.dart';
import 'package:find_neighbour_v001/routing/app_router.dart';
import 'package:flutter/material.dart';

final appRouter = AppRouter();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Inter",
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),

      routerConfig: appRouter.config(),
    );
  }
}
