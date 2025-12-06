import 'package:find_neighbour_v001/models/matcher/form.dart';
import 'package:flutter/material.dart';
import 'package:find_neighbour_v001/models/matcher/parameters.dart' as matcher;
import 'package:find_neighbour_v001/models/matcher/form.dart' as form;
import 'package:find_neighbour_v001/styles/app_container_styles.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';
import 'package:find_neighbour_v001/models/matcher/request.dart';
import 'package:find_neighbour_v001/styles/app_colors.dart';

class RequestCard extends StatelessWidget {
  final Request request;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final VoidCallback? onMore;

  const RequestCard({
    required this.request,
    this.onAccept,
    this.onReject,
    this.onMore,
  });

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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${request.user!.name} ${request.user!.surname}",
                        style: AppTextStyles.smallHeaderBold(context),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                // Кнопки справа
                Row(
                  children: [
                    // Кнопка "Подробнее"
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: onMore,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.baseBright,
                          backgroundColor: AppColors.textBase,
                          side: BorderSide(
                              color: AppColors.teal.withOpacity(0.25)),
                          minimumSize: const Size(190, 60),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Подробнее',
                          style: TextStyle(fontSize: 12, color: AppColors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Кнопка "Принять"
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: onAccept,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(190, 60),
                          backgroundColor: AppColors.detailBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Принять',
                          style: TextStyle(fontSize: 13),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Кнопка "Отклонить"
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: onReject,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(190, 60),
                          backgroundColor: const Color(0xFFEF4444),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Отклонить',
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "${request.user!.description}",
              style: AppTextStyles.whiteSmall(context),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
