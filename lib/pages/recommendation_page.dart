

//   @override
//   Widget build(BuildContext context) {
//     final groups = [
//       NeighborGroupCard(
//         title: "Есть 2 места",
//         location: "г. Москва, м. Аэропорт",
//         membersCount: 2,
//         totalSpots: 4,
//         progress: 0.5,
//         budget: 32000,
//         age: 28,
//         housing: "4-x кв",
//         compatibility: 94,
//         members: [
//           Member(
//             name: "Артем Васильев",
//             age: 28,
//             profession: "IT-специалист",
//             budget: 32000,
//             avatarPath: "asset/images/smart_guy.jpg",
//           ),
//           Member(
//             name: "Мария Семенова",
//             age: 26,
//             profession: "Дизайнер",
//             budget: 31000,
//             avatarPath: "asset/images/smart_guy.jpg",
//           ),
//         ],
//       ),
//       NeighborGroupCard(
//         title: "Есть 1 место",
//         location: "г. Москва, м. Динамо",
//         membersCount: 3,
//         totalSpots: 4,
//         progress: 0.75,
//         budget: 35000,
//         age: 30,
//         housing: "3-x кв",
//         compatibility: 87,
//         members: [
//           Member(
//             name: "Иван Петров",
//             age: 31,
//             profession: "Маркетолог",
//             budget: 34000,
//             avatarPath: "asset/images/smart_guy.jpg",
//           ),
//           Member(
//             name: "Анастасия Л.",
//             age: 27,
//             profession: "UX-дизайнер",
//             budget: 36000,
//             avatarPath: "asset/images/smart_guy.jpg",
//           ),
//           Member(
//             name: "Михаил С.",
//             age: 29,
//             profession: "Разработчик",
//             budget: 35000,
//             avatarPath: "asset/images/smart_guy.jpg",
//           ),
//         ],
//       ),
//     ];




import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/api/api.dart';
import 'package:find_neighbour_v001/models/parameters.dart';
import 'package:flutter/material.dart' hide Form;
import 'package:find_neighbour_v001/widgets/group_neighbours_widget.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';

@RoutePage()
class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key});

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  bool loading = true;
  List<NeighborGroupCard> cards = [];

  @override
  void initState() {
    super.initState();
    loadGroups();
  }

  Future<void> loadGroups() async {
    final session = await ApiService.getSession();
    if (session == null || session.id.isEmpty) {
      setState(() => loading = false);
      return;
    }

    final groupsWithScore = await ApiService.findGroups(session.id);

    List<NeighborGroupCard> uiCards = [];

    for (final gws in groupsWithScore) {
      final group = gws.group;

      final membersForms = await ApiService.listGroupMembers(group.id);

      final members = membersForms.map((f) {
        return Member(
          name: f.parameters.name,
          age: f.parameters.age,
          profession: f.parameters.userType,
          budget: f.parameters.budget,
          avatarPath: f.parameters.photos.isNotEmpty
              ? f.parameters.photos.first
              : "asset/images/default_user.png",
        );
      }).toList();

      final card = NeighborGroupCard(
        title: "Есть ${group.maxUsers - members.length} места",
        location: "г. Москва", 
        membersCount: members.length,
        totalSpots: group.maxUsers,
        progress: members.isEmpty ? 0 : members.length / group.maxUsers,
        budget: _avgBudget(membersForms),
        age: _avgAge(membersForms),
        housing: "${group.parameters.roomCount}-к квартира",
        compatibility: (gws.score * 100).toInt(),
        members: members,
      );

      uiCards.add(card);
    }

    setState(() {
      cards = uiCards;
      loading = false;
    });
  }

  int _avgBudget(List<Form> list) {
    if (list.isEmpty) return 0;
    final sum = list.fold(0, (acc, v) => acc + v.parameters.budget);
    return (sum ~/ list.length);
  }

  int _avgAge(List<Form> list) {
    if (list.isEmpty) return 0;
    final sum = list.fold(0, (acc, v) => acc + v.parameters.age);
    return (sum ~/ list.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1922),
      appBar: AppBar(
        backgroundColor: const Color(0xFF162632),
        elevation: 0,
        title: AppRichTextStyles.logoText(),
        toolbarHeight: 75,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    for (var card in cards) card,
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
    );
  }
}
