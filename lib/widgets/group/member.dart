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
  final VoidCallback? onRemove;
  final bool isOwner;

  const Member({
    required this.member,
    this.onMore,
    super.key, 
    this.onRemove, 
    this.isOwner = false,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      decoration: AppContainerStyles.profileCard,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: isMobile
          ? _MemberMobile(member: member, onMore: onMore, onRemove: onRemove, isOwner: isOwner)
          : _MemberDesktop(member: member, onMore: onMore, onRemove: onRemove, isOwner: isOwner),
    );
  }
}

class _MemberMobile extends StatelessWidget {
  final form.Form member;
  final VoidCallback? onMore;
  final VoidCallback? onRemove;
  final bool isOwner;

  const _MemberMobile({
    required this.member,
    this.onMore,
    this.onRemove,
    this.isOwner = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(radius: 26),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${member.parameters.name} ${member.parameters.surname}",
                    style: AppTextStyles.smallHeaderBold(context),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Участник • ${member.parameters.age} лет",
                    style: AppTextStyles.smallSecondary,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          member.parameters.description,
          style: AppTextStyles.whiteSmall(context),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onMore,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.textBase,
              foregroundColor: AppColors.baseBright,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Подробнее"),
          ),
        ),
        if (isOwner) ...[
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onRemove,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.redBase),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Исключить пользователя", style: TextStyle(color: AppColors.redBase)),
            ),
          ),
        ],
      ],
    );
  }
}


class _MemberDesktop extends StatelessWidget {
  final form.Form member;
  final VoidCallback? onMore;
  final VoidCallback? onRemove;
  final bool isOwner;

  const _MemberDesktop({
    required this.member,
    this.onMore,
    this.onRemove,
    this.isOwner = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  const CircleAvatar(radius: 30),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${member.parameters.name} ${member.parameters.surname}",
                        style: AppTextStyles.smallHeaderBold(context),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Участник • ${member.parameters.age} лет",
                        style: AppTextStyles.smallSecondary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onMore,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textBase,
                foregroundColor: AppColors.baseBright,
                minimumSize: const Size(160, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Подробнее"),
            ),
            if (isOwner) ...[
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: onRemove,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.redBase),
                  minimumSize: const Size(160, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Исключить пользователя", style: TextStyle(color: AppColors.redBase)),
              ),
            ]
          ],
        ),
        const SizedBox(height: 16),
        Text(
          member.parameters.description,
          style: AppTextStyles.whiteSmall(context),
        ),
      ],
    );
  }
}
