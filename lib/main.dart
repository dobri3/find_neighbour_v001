// import 'package:find_neighbour_v001/pages/auth_page.dart';
import 'package:find_neighbour_v001/pages/home_page.dart';
import 'package:find_neighbour_v001/pages/user_profile_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Inter",
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: UserProfilePage(),
    );
  }
}
