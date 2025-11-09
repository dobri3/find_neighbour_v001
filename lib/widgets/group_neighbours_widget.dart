import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/routing/app_router.dart';
import 'package:flutter/material.dart';

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
    super.key,
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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$membersCount/$totalSpots • $title",
                style: const TextStyle(
                  color: Color(0xFF62E1C5),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                location,
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              color: const Color(0xFF62E1C5),
              backgroundColor: Colors.white12,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 8,
            children: [
              _InfoTile(label: "Бюджет", value: "$budget ₽"),
              _InfoTile(label: "Возраст", value: "$age лет"),
              _InfoTile(label: "Жильё", value: housing),
              _InfoTile(label: "Совместимость", value: "$compatibility%"),
            ],
          ),
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: members
                .map((m) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          // CircleAvatar(
                          //   radius: 20,
                          //   backgroundImage: AssetImage(m.avatarPath),
                          // ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "${m.name}, ${m.age} лет — ${m.profession}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Text(
                            "${m.budget} ₽",
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () => context.router.push(GroupRoute(id: id)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white30),
                ),
                child: const Text("Подробнее"),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF62E1C5),
                  foregroundColor: Colors.black,
                ),
                child: const Text("Занять место"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(color: Colors.white54, fontSize: 13)),
          const SizedBox(height: 2),
          Text(value,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600)),
        ],
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

  Member({
    required this.name,
    required this.age,
    required this.profession,
    required this.budget,
    required this.avatarPath,
  });
}
