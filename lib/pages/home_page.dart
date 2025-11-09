import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/models/neighbour_model.dart';
import 'package:find_neighbour_v001/routing/app_router.dart';
import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';
import 'package:find_neighbour_v001/styles/app_button_styles.dart';
import 'package:find_neighbour_v001/styles/app_container_styles.dart';
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
          child: Column(
            children: [
              HomeHeader(),
              Container(
                height: 530,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: AppColors.blueGradient),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Найди идеального\nсоседа",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.mediumHeading
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        "Сервис для поиска людей с похожими привычками и интересами\nдля совместной аренды",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyLarge,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      AppButtonStyles.primaryButtonWithShadow(
                                onPressed: () {
                                context.router.push(const AuthRoute());
                                    },
                                text: "Войти",
                                    )
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 48),
                height: 700,
                decoration: AppContainerStyles.sectionBorder,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Прямо сейчас в поиске",
                      style: AppTextStyles.largeHeadingWhite
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
                    ),

                    
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}




class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: AppColors.midnight,
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Row(
        children: [
          AppRichTextStyles.logoText(),
          const Spacer(),
          const Text("Как это работает", style: AppTextStyles.whiteSmall),
          const SizedBox(width: 32),
          const Text("Новости", style: AppTextStyles.whiteSmall),
          const SizedBox(width: 32),
          ElevatedButton(
            onPressed: () => context.router.push(const AuthRoute()),
            style: AppButtonStyles.primaryMedium,
            child: const Text("Войти", style: AppTextStyles.buttonMedium),
          )
        ],
      ),
    );
  }
}
