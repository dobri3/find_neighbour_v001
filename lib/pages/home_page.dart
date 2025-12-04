import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/models/neighbour_model.dart';
import 'package:find_neighbour_v001/routing/app_router.dart';
import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';
import 'package:find_neighbour_v001/styles/app_button_styles.dart';
import 'package:find_neighbour_v001/styles/app_container_styles.dart';
import 'package:find_neighbour_v001/utils/play_animation_widget.dart';
import 'package:find_neighbour_v001/widgets/criteria_card_widget.dart';
import 'package:find_neighbour_v001/widgets/neighbour_introductory_widget.dart';
import 'package:flutter/material.dart';
import 'package:find_neighbour_v001/widgets/app_bars/main_header.dart'
    as home_header;

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: home_header.HomeHeader(),
      body: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 530,
              width: double.infinity,
              decoration: const BoxDecoration(gradient: AppColors.blueGradient),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const GradientText(
                      "Найди идеального\nсоседа",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.mediumHeading,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFE7E9EC),
                          Color(0xFF6A999E),
                        ],
                      ),
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
                      height: 50,
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
                height: 2, width: double.infinity, color: Colors.tealAccent),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 48),
              height: 710,
              decoration: AppContainerStyles.sectionBorder,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Прямо сейчас в поиске",
                      style: AppTextStyles.largeHeadingWhite),
                  const SizedBox(
                    height: 80,
                  ),
                  SafeArea(
                    child: Container(
                      constraints:
                          BoxConstraints(maxHeight: 470, minHeight: 450),
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
            Container(
              height: 700,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF32658D), Color(0xFF122330)],
                    begin: AlignmentGeometry.topCenter,
                    end: AlignmentGeometry.bottomCenter),
              ),
              child: Padding(
                padding: const EdgeInsets.all(48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Быстрый старт',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.largeHeadingWhite,
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 92, right: 92, bottom: 24),
                      child: Column(
                        children: List.generate(_steps.length, (index) {
                          final step = _steps[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 55,
                                  backgroundColor: AppColors.teal,
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 36,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GradientText(
                                          step['title']!,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w600),
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFFF8F9FA),
                                              Color(0xFF6A999E),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 4,
                                        width: double.infinity,
                                        color: AppColors.teal,
                                      ),
                                      const SizedBox(height: 8),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          step['description']!,
                                          style: const TextStyle(
                                              fontFamily: "Inter",
                                              color: Colors.white70,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 2,
              width: double.infinity,
              color: Colors.tealAccent,
            ),
            Container(
              height: 570,
              width: double.infinity,
              color: AppColors.midnight,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Критерии поиска",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.largeHeadingWhite,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CriteriaCard(
                          icon: Icons.attach_money,
                          title: "Бюджет",
                          subtitle:
                              "Подберем соседа под ваши возможности оплачивать жильё",
                        ),
                        const SizedBox(width: 60),
                        CriteriaCard(
                          icon: Icons.add_location_alt_outlined,
                          title: "Геопозиция",
                          subtitle:
                              "Найдём соседей, которые хотели бы жить в том же районе",
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CriteriaCard(
                          icon: Icons.people_alt_rounded,
                          title: "Количество соседей",
                          subtitle:
                              "Найдём ровно столько человек, сколько вы сами указали",
                        ),
                        const SizedBox(width: 60),
                        CriteriaCard(
                          icon: Icons.apartment_rounded,
                          title: "Квартира",
                          subtitle:
                              "Выбирайте количество комнат по вашему желанию",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 2,
              width: double.infinity,
              color: Colors.tealAccent,
            ),
            Container(
              height: 550,
              width: double.infinity,
              decoration: const BoxDecoration(gradient: AppColors.blueGradient),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const GradientText(
                      "Готовы найти своего\nсоседа?",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.mediumHeading,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFE7E9EC),
                          Color(0xFF6A999E),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Присоединяйтесь к тем, кто уже нашел \nидеальное соседство",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyLarge,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 60,
                      child: AppButtonStyles.primaryButtonWithShadow(
                        onPressed: _scrollToTop,
                        text: "Начать поиск",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 2,
              width: double.infinity,
              color: Colors.tealAccent,
            ),
          ],
        ),
      ),
    );
  }

  final List<Map<String, String>> _steps = const [
    {
      'title': 'Создайте профиль',
      'description':
          'Как можно подробнее расскажите о себе и своих предпочтениях, чтобы мы смогли \nподобрать наиболее подходящего для вас соседа'
    },
    {
      'title': 'Ищите соседей',
      'description':
          'Ищите будущих соседей по фильтрам. Алгоритмы сами отсортируют для тебя список \nобъявлений и найдёт самые лучшие'
    },
    {
      'title': 'Общайтесь и встречайтесь',
      'description':
          'Вам осталось лишь обсудить детали совместного быта. Знакомьтесь с новыми людьми и \nоговаривайте условия совместной аренды'
    },
  ];
}
