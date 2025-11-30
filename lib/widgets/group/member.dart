import 'package:find_neighbour_v001/models/matcher/form.dart';
import 'package:flutter/material.dart';
import 'package:find_neighbour_v001/models/matcher/parameters.dart' as matcher;
import 'package:find_neighbour_v001/models/matcher/form.dart' as form;
import 'package:find_neighbour_v001/styles/app_container_styles.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';
import 'package:find_neighbour_v001/styles/app_colors.dart';

class Member extends StatelessWidget {
  final form.Form member;
  final VoidCallback? onMore;

  const Member({required this.member, this.onMore});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppContainerStyles.profileCard,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${member.parameters.name} ${member.parameters.surname}",
                            style: AppTextStyles.smallHeaderBold,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Участник - ${member.parameters.age} лет",
                            style: AppTextStyles.smallSecondary,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: onMore,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.teal,
                    side: BorderSide(color: AppColors.teal.withOpacity(0.25)),
                    minimumSize: const Size(190, 60),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Подробнее',
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              member.parameters.description,
              style: AppTextStyles.whiteSmall,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
