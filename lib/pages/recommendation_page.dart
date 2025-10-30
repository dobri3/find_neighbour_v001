
import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/widgets/group_neighbours_widget.dart';
import 'package:flutter/material.dart';


@RoutePage()
class RecommendationPage extends StatelessWidget {
  const RecommendationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = [
      NeighborGroupCard(
        title: "Есть 2 места",
        location: "г. Москва, м. Аэропорт",
        membersCount: 2,
        totalSpots: 4,
        progress: 0.5,
        budget: 32000,
        age: 28,
        housing: "4-к кв",
        compatibility: 94,
        members: [
          Member(
            name: "Артем Васильев",
            age: 28,
            profession: "IT-специалист",
            budget: 32000,
            avatarPath: "asset/images/smart_guy.jpg",
          ),
          Member(
            name: "Мария Семенова",
            age: 26,
            profession: "Дизайнер",
            budget: 31000,
            avatarPath: "asset/images/smart_guy.jpg",
          ),
        ],
      ),
      NeighborGroupCard(
        title: "Есть 1 место",
        location: "г. Москва, м. Динамо",
        membersCount: 3,
        totalSpots: 4,
        progress: 0.75,
        budget: 35000,
        age: 30,
        housing: "3-к кв",
        compatibility: 87,
        members: [
          Member(
            name: "Иван Петров",
            age: 31,
            profession: "Маркетолог",
            budget: 34000,
            avatarPath: "asset/images/smart_guy.jpg",
          ),
          Member(
            name: "Анастасия Л.",
            age: 27,
            profession: "UX-дизайнер",
            budget: 36000,
            avatarPath: "asset/images/smart_guy.jpg",
          ),
          Member(
            name: "Михаил С.",
            age: 29,
            profession: "Разработчик",
            budget: 35000,
            avatarPath: "asset/images/smart_guy.jpg",
          ),
        ],
      ),
    ];

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
              for (var group in groups) group,
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
