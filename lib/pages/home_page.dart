import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/models/neighbour_model.dart';
import 'package:find_neighbour_v001/routing/app_router.dart';
import 'package:find_neighbour_v001/utils/play_animation_widget.dart';
import 'package:find_neighbour_v001/widgets/neighbour_introductory_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: const Color(0xFF131718),
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                        child: Text(
                          "ИщуСоседа",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   width: 500,
                      // ),
                      const Text(
                        "Как это работает",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Inter",
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      // const Text(
                      //   "Новости",
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontFamily: "Inter",
                      //     fontSize: 15
                      //   ),
                      // ),
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        margin: const EdgeInsets.all(25),
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                            color: const Color(0xFF6A999E),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {
                            context.router.push(const AuthRoute());

                            //                     Navigator.of(context).push(
                            // MaterialPageRoute(
                            //   builder: (context) => const AuthPage(),
                            // ),
                            // );
                          },
                          child: const Text("Войти",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Inter",
                                  fontSize: 15)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 530,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                      Color(0xFF133B5A),
                      Color(0xFF32658D),
                      Color(0xFF32658D),
                      Color(0xFF133B5A),
                    ])),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ShaderMask(
                      //   shaderCallback: (bounds) {
                      //     return LinearGradient(
                      //       colors: [
                      //         Color(0xFFE7E9EC),
                      //         Color(0xFF6A999E),
                      //       ],
                      //       begin: Alignment.centerLeft,
                      //       end: Alignment.centerRight
                      //     ).createShader(bounds);
                      //   },
                      // child:
                      const Text(
                        "Найди идеального\nсоседа",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 165, 237, 245),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Сервис для поиска людей с похожими привычками и интересами\nдля совместной аренды",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.all(25),
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 20,
                                spreadRadius: 2,
                                offset: const Offset(0, 0),
                              ),
                            ],
                            color: const Color(0xFF6A999E),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {
                            context.router.push(const AuthRoute());

                            //                       Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => const AuthPage(),
                            //   ),
                            // );
                          },
                          child: const Text("Войти",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Inter",
                                  fontSize: 17)),
                        ),
                      ),
                      //   Container(
                      //     decoration: BoxDecoration(
                      //       border: Border.all(
                      //         color: const Color(0xFF6A999E)
                      //       ),
                      //       borderRadius: BorderRadius.circular(10),
                      //       color: const Color(0xFF131718)
                      //     ),
                      //     width: 500,
                      //     child: const TextField(
                      //       decoration: InputDecoration(
                      //         border: InputBorder.none,
                      //         prefixIcon: Icon(Icons.search, color:Colors.grey),
                      //         hintStyle: TextStyle(color: Colors.grey, fontSize: 16, fontFamily: "Inter"),
                      //         hintText: "Найти соседа"
                      //       ),
                      // ),
                      //   ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 700,
                decoration: const BoxDecoration(
                    border: BorderDirectional(
                        bottom: BorderSide(
                  color: Color.fromARGB(255, 165, 237, 245),
                ))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Прямо сейчас в поиске",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 48,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    SafeArea(
                      child: SizedBox(
                        height: 450,
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse,
                            },
                          ),
                          child: ListView.separated(
                              separatorBuilder: (_, index) =>
                                  const SizedBox(width: 15),
                              scrollDirection: Axis.horizontal,
                              itemCount: neighbourModels.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {},
                                    child: PlayAnimatonWidget(
                                      delay: 1.2,
                                      child: NeighbourIntroductoryWidget(
                                        neighbourModel: neighbourModels[index],
                                      ),
                                    ));
                              }),
                        ),
                      ),
                      // ],
                      //   ),
                      // ),
                    ),

                    // SafeArea(
                    //             child: ListView.separated(
                    //               separatorBuilder: (_, index) => const SizedBox(height: 15),
                    // scrollDirection: Axis.vertical,
                    // itemCount: 1,
                    // child: NeighbourIntroductoryWidget(neighbourModel: neighbourModels[position])
                    // children: [
                    //   // const SizedBox(height: 20,),
                    //                 SizedBox(height: 220, width: 600,
                    //                 child: ListView.builder(
                    //                   scrollDirection: Axis.horizontal,
                    //                   itemCount: 1,
                    //                   itemBuilder: ((context, position) {
                    //                     return NeighbourIntroductoryWidget(neighbourModel: neighbourModels[position]);
                    //                   }
                    //                   ),
                    //                 ),
                    //                 ),
                    // ],
                    //     ),
                    //   ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

