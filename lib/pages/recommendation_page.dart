import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/widgets/group_neighbours_widget.dart';
import 'package:flutter/material.dart';

import 'package:find_neighbour_v001/api/api.dart';
import 'package:find_neighbour_v001/models/matcher/group.dart';

import 'package:find_neighbour_v001/models/matcher/form.dart';
import 'package:find_neighbour_v001/models/user.dart';

@RoutePage()
class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key});

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  List<GroupWithScore> _groups = [];

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
      appBar: AppBar(
        backgroundColor: const Color(0xFF162632),
        elevation: 0,
        title: const Text(
          "Поиск соседей",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              for (var group in _groups)
                NeighborGroupCard(
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
