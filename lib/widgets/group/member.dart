import 'package:find_neighbour_v001/models/matcher/form.dart';
import 'package:flutter/material.dart';
import 'package:find_neighbour_v001/models/matcher/parameters.dart' as matcher;
import 'package:find_neighbour_v001/models/matcher/form.dart' as form;
import 'package:find_neighbour_v001/styles/app_container_styles.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';

class Member extends StatelessWidget {
  final form.Form member;

  const Member({required this.member});

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
