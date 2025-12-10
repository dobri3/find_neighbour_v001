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
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Scaffold(
      appBar: home_header.HomeHeader(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: Column(
            children: [
              Container(
                height: isMobile ? 350 : 500,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.color1,
                      AppColors.color1,
                      AppColors.base1
                    ],
                    stops: [0.0, 0.78, 0.78],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 8,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Найди идеального\nсоседа",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.mediumHeading(context),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "Сервис для поиска людей с похожими привычками и интересами\nдля совместной аренды",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyLarge(context),
                      ),
                      const SizedBox(height: 50),
                      AppButtonStyles.primaryButtonWithShadow(
                        context: context,
                        onPressed: () {
                          context.router.push(const AuthRoute());
                        },
                        text: "Войти",
                      )
                    ],
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -0.5),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 48,
                    vertical: 20,
                  ),
                  decoration: const BoxDecoration(color: AppColors.base1),
                  child: isMobile
                      ? Column(
                          children: [
                            _LeftNeighbourBlock(),
                            const SizedBox(height: 1),
                            _NeighbourList(),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(flex: 2, child: _LeftNeighbourBlock()),
                            Expanded(flex: 3, child: _NeighbourList()),
                          ],
                        ),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -1),
                child: Container(
                  width: double.infinity,
                  color: AppColors.color1,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 48,
                    vertical: 80,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Быстрый старт',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.mediumHeading(context),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 0 : 92,
                        ),
                        child: Column(
                          children: List.generate(_steps.length, (index) {
                            final step = _steps[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: isMobile ? 35 : 55,
                                    backgroundColor: AppColors.textBase,
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        color: AppColors.color1,
                                        fontSize: isMobile ? 16 : 36,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          step['title']!,
                                          style: TextStyle(
                                            color: AppColors.textBase,
                                            fontSize: isMobile ? 16 : 24,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          height: 4,
                                          width: double.infinity,
                                          color: AppColors.textBase,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          step['description']!,
                                          style: TextStyle(
                                            color: AppColors.textBase,
                                            fontSize: isMobile ? 12 : 14,
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
              Transform.translate(
                offset: const Offset(0, -1.5),
                child: Container(
                  width: double.infinity,
                  color: AppColors.base1,
                  padding:
                      const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        "Критерии поиска",
                        style: AppTextStyles.mediumHeading(context),
                      ),
                      const SizedBox(height: 50),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1280),
                        child: Wrap(
                          spacing: 60,
                          runSpacing: 40,
                          alignment: WrapAlignment.center,
                          children: const [
                            CriteriaCard(
                              icon: Icons.attach_money,
                              title: "Бюджет",
                              subtitle:
                                  "Подберем соседа под ваши возможности оплачивать жильё",
                            ),
                            CriteriaCard(
                              icon: Icons.add_location_alt_outlined,
                              title: "Геопозиция",
                              subtitle:
                                  "Найдём соседей, которые хотели бы жить в том же районе",
                            ),
                            CriteriaCard(
                              icon: Icons.people_alt_rounded,
                              title: "Количество соседей",
                              subtitle:
                                  "Найдём ровно столько человек, сколько вы сами указали",
                            ),
                            CriteriaCard(
                              icon: Icons.apartment_rounded,
                              title: "Квартира",
                              subtitle:
                                  "Выбирайте количество комнат по вашему желанию",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -2),
                child: Container(
                  width: double.infinity,
                  color: AppColors.color1,
                  padding: const EdgeInsets.symmetric(vertical: 120),
                  child: Column(
                    children: [
                      Text(
                        "Готовы найти своего\nсоседа?",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.mediumHeading(context),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "Присоединяйтесь к тем, кто уже нашел \nидеальное соседство",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyLarge(context),
                      ),
                      const SizedBox(height: 50),
                      AppButtonStyles.primaryButtonWithShadow(
                        context: context,
                        onPressed: _scrollToTop,
                        text: "Начать поиск",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
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

class _LeftNeighbourBlock extends StatelessWidget {
  const _LeftNeighbourBlock();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Прямо сейчас в поиске",
              style: AppTextStyles.mediumHeading(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            Text(
              "Зарегистрируйся сейчас",
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge(context).copyWith(
                decoration: TextDecoration.underline,
                decorationColor: AppColors.textBase,
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _NeighbourList extends StatelessWidget {
  const _NeighbourList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 470,
          minHeight: 450,
        ),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: neighbourModels.length,
            separatorBuilder: (_, __) => const SizedBox(width: 15),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: PlayAnimatonWidget(
                  delay: 1.2,
                  child: NeighbourIntroductoryWidget(
                    neighbourModel: neighbourModels[index],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
