import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/api/api.dart';
import 'package:find_neighbour_v001/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:find_neighbour_v001/models/user.dart';
import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';

class NeighborGroupCard extends StatefulWidget {
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
  State<NeighborGroupCard> createState() => _NeighborGroupCardState();
}

class _NeighborGroupCardState extends State<NeighborGroupCard> {
  bool isSending = false;

  @override
  void didUpdateWidget(covariant NeighborGroupCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.membersCount != oldWidget.membersCount ||
        widget.totalSpots != oldWidget.totalSpots ||
        widget.progress != oldWidget.progress) {
      setState(() => isSending = false);
    }
  }

@override
Widget build(BuildContext context) {
  final isMobile = MediaQuery.of(context).size.width < 700;

  return ConstrainedBox(
    constraints: const BoxConstraints(
      maxHeight: 350, 
      minHeight: 250, 
    ),
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.teal.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Pill(
                text: '${widget.membersCount}/${widget.totalSpots} • ${widget.title}',
                color: AppColors.detailBlue,
                textColor: AppColors.white,
              ),
              const SizedBox(width: 12),
              Text(
                widget.location,
                style: const TextStyle(
                  color: AppColors.textBase,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${widget.totalSpots - widget.membersCount} из ${widget.totalSpots} мест',
                style: const TextStyle(color: AppColors.textBase, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text("Заполненность группы:", style: AppTextStyles.whiteSmall(context)),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: widget.progress.clamp(0.0, 1.0),
              minHeight: 6,
              backgroundColor: Colors.white12,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accentBlue),
            ),
          ),
          const SizedBox(height: 16),
          // Инфо-блоки
          LayoutBuilder(
            builder: (context, c) {
              final isMobile = c.maxWidth < 500;
              final columns = isMobile ? 2 : 4;
              final itemWidth = (c.maxWidth - (columns - 1) * 12) / columns;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _InfoTile(width: itemWidth, label: 'Бюджет', value: '${widget.budget}'),
                  _InfoTile(width: itemWidth, label: 'Возраст', value: '${widget.age} лет'),
                  _InfoTile(width: itemWidth, label: 'Жильё', value: widget.housing),
                  _InfoTile(width: itemWidth, label: 'Совместимость', value: '${widget.compatibility}%'),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          
          Expanded(
            child: SingleChildScrollView(
              child: (!isMobile) ? Column(
                children: widget.members.take(3).map((m) => _MemberCard(member: m)).toList(),
              ) : const SizedBox(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () => context.router.push(GroupRoute(id: widget.id)),
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.baseBright,
                  foregroundColor: AppColors.textBase,
                  side: BorderSide(color: AppColors.teal.withOpacity(0.25)),
                  minimumSize: Size(isMobile ? 140 : 190, isMobile ? 48 : 60),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Подробнее'),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(isMobile ? 140 : 190, isMobile ? 48 : 60),
                  backgroundColor: AppColors.detailBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: isSending ? null : () async {
                  setState(() => isSending = true);
                  try {
                    var session = await ApiService.authService.getSession();
                    await ApiService.matcherService.sendJoinRequest(session.id, widget.id);
                    print('sent');
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Ошибка отправки запроса: $e")),
                    );
                    setState(() => isSending = false);
                  }
                },
                child: isSending
                    ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Занять место', style: TextStyle(color: AppColors.white)),
              ),
            ],
          ),
        ],
      ),
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
    final isMobile = MediaQuery.of(context).size.width < 600;

    return SizedBox(
      width: width,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 8: 14, vertical: isMobile ? 6 : 12),
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
        border: Border.all(color: AppColors.teal.withOpacity(0.7)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
          ),
          const SizedBox(width: 12),
          Column(
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
        ],
      ),
    );
  }
}