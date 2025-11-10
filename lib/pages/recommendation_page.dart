import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/api/api.dart';
import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:flutter/material.dart' hide Form;
import 'package:find_neighbour_v001/widgets/group_neighbours_widget.dart';
import 'package:flutter/material.dart';

import 'package:find_neighbour_v001/api/api.dart';
import 'package:find_neighbour_v001/models/matcher/group.dart';

import 'package:find_neighbour_v001/models/matcher/form.dart';
import 'package:find_neighbour_v001/models/user.dart';
import 'package:find_neighbour_v001/routing/app_router.dart';

import 'package:find_neighbour_v001/pages/group_page.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';

@RoutePage()
class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key});

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  List<GroupWithScore> _groups = [];
  bool loading = true;
  List<NeighborGroupCard> cards = [];

  @override
  void initState() {
    super.initState();
    _loadRecommendation();
  }

  void _loadRecommendation() async {
    User session = await ApiService.authService.getSession();
    List<GroupWithScore> recommendation =
        await ApiService.matcherService.findGroups(session.id);

    setState(() {
      _groups = recommendation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1922),
      appBar: MainAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 96),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var group in _groups)
                NeighborGroupCard(
                  id: group.group.id,
                  title: group.group.parameters.name,
                  location: "",
                  membersCount: 0,
                  totalSpots: group.group.maxUsers,
                  progress: 0,
                  budget: group.group.parameters.budget,
                  age: group.group.parameters.age,
                  housing: "${group.group.parameters.roomCount}-к кв",
                  compatibility: (group.score * 100).round(),
                  members: [
                    for (var member in group.group.members)
                      Member(
                        name: member.parameters.name,
                        age: member.parameters.age,
                        profession: member.parameters.userType,
                        budget: member.parameters.budget,
                        avatarPath: "",
                      ),
                  ],
                ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: AppColors.blueDark,
      padding: const EdgeInsets.symmetric(horizontal: 72),
      child: Row(
        children: [
          AppRichTextStyles.logoText(),
          const Spacer(),
          const Text("Поиск", style: AppTextStyles.whiteSmall),
          const SizedBox(width: 32),
          const Text("Сообщения", style: AppTextStyles.whiteSmall),
          const SizedBox(width: 32),
          const Text("Заявки", style: AppTextStyles.whiteSmall),
          const SizedBox(width: 32),
          const Text("Мой профиль", style: AppTextStyles.whiteSmall),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(75);
}
