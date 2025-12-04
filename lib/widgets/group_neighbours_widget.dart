import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/api/api.dart';
import 'package:find_neighbour_v001/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:find_neighbour_v001/models/user.dart';
import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';

class NeighborGroupCard extends StatelessWidget {
  final String id;
  final String title;
  final String location;
  final int membersCount;
  final int totalSpots;
  final double progress;
  final int budget;
  final int age;
  final String housing;
  final int compatibility;
  final List<Member> members;

  const NeighborGroupCard({
    Key? key,
    required this.id,
    required this.title,
    required this.location,
    required this.membersCount,
    required this.totalSpots,
    required this.progress,
    required this.budget,
    required this.age,
    required this.housing,
    required this.compatibility,
    required this.members,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.45),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: AppColors.teal.withOpacity(0.06)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Pill(
                text: '$membersCount/$totalSpots • $title',
                color: AppColors.detailBlue,
                textColor: AppColors.white,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  location,
                  style: const TextStyle(
                    color: AppColors.textBase,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${totalSpots - membersCount} из $totalSpots мест',
                style: TextStyle(
                  color: AppColors.textBase,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Заполненность группы:",
            style: AppTextStyles.whiteSmall,
          ),
          const SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 6,
              backgroundColor: Colors.white12,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accentBlue),
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, c) {
              final itemWidth = (c.maxWidth - 3 * 12) / 4;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _InfoTile(
                    width: itemWidth,
                    label: 'Бюджет',
                    value: '$budget',
                  ),
                  _InfoTile(
                    width: itemWidth,
                    label: 'Возраст',
                    value: '$age лет',
                  ),
                  _InfoTile(
                    width: itemWidth,
                    label: 'Жильё',
                    value: housing,
                  ),
                  _InfoTile(
                    width: itemWidth,
                    label: 'Совместимость',
                    value: '$compatibility%',
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: members.map((m) => _MemberCard(member: m)).toList(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () => context.router.push(GroupRoute(id: id)),
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.baseBright,
                  foregroundColor: AppColors.textBase,
                  side: BorderSide(color: AppColors.teal.withOpacity(0.25)),
                  minimumSize: const Size(190, 60),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Подробнее'),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () async {
                  var session = await ApiService.authService.getSession();
                  await ApiService.matcherService
                      .sendJoinRequest(session.id, id);
                  print('sent');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(190, 60),
                  backgroundColor: AppColors.detailBlue,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Занять место', style: TextStyle(color: AppColors.white),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;

  const _Pill({
    Key? key,
    required this.text,
    required this.color,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final double width;

  const _InfoTile({
    Key? key,
    required this.label,
    required this.value,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.base1,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.teal.withOpacity(0.7)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: AppColors.textBase,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(label,
                style: TextStyle(color: AppColors.textBase, fontSize: 12)),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

class Member {
  final String name;
  final int age;
  final String profession;
  final int budget;
  final String avatarPath;

  const Member({
    required this.name,
    required this.age,
    required this.profession,
    required this.budget,
    required this.avatarPath,
  });
}

class _MemberCard extends StatelessWidget {
  final Member member;
  const _MemberCard({Key? key, required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.base1,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${member.name}',
                  style: TextStyle(color: AppColors.textBase, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${member.age} лет  ${member.profession}   ${member.budget} ₽',
                  style: const TextStyle(color: AppColors.textLight, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
