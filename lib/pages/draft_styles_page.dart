import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/styles/app_textstyles.dart';
import 'package:flutter/material.dart';

// это страница на которой можно увидеть как выглядит каждый из текстстилей

@RoutePage()
class DraftStylesPage extends StatelessWidget {
  const DraftStylesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            SizedBox(height: 10,),
            Text(
              "Хэадинг Лардж", style: AppTextStyles.headingLarge,
            ),
            SizedBox(height: 10,),
            Text(
              "Хэадинг Лардж Болд", style: AppTextStyles.headingLargeBold,
            ),
            SizedBox(height: 10,),
            Text(
              "Хэадинг медиум", style: AppTextStyles.headingMedium,
            ),
            SizedBox(height: 10,),
            Text(
              "Хэадинг смол", style: AppTextStyles.headingSmall,
            ),
            SizedBox(height: 10,),
            Text(
              "Боди Лардж", style: AppTextStyles.bodyLarge,
            ),
            SizedBox(height: 10,),
            Text(
              "Боди медиум", style: AppTextStyles.bodyMedium,
            ),
            SizedBox(height: 10,),
            Text(
              "Боди смол", style: AppTextStyles.bodySmall,
            ),
            SizedBox(height: 10,),
            Text(
              "Хэадинг смол", style: AppTextStyles.secondaryLarge,
            ),
            SizedBox(height: 10,),
            Text(
              "Секондари медиум", style: AppTextStyles.secondaryMedium,
            ),
            SizedBox(height: 10,),
            Text(
              "Лейбл медиум", style: AppTextStyles.labelMedium,
            ),
            SizedBox(height: 10,),
            Text(
              "Баттон праймари", style: AppTextStyles.buttonPrimary,
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}