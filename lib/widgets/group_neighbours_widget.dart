// import 'package:flutter/material.dart';

// class NeighborGroupCard extends StatelessWidget {
//   final String title;
//   final String location;
//   final int membersCount;
//   final int totalSpots;
//   final double progress;
//   final int budget;
//   final int age;
//   final String housing;
//   final int compatibility;
//   final List<Member> members;

//   const NeighborGroupCard({
//     super.key,
//     required this.title,
//     required this.location,
//     required this.membersCount,
//     required this.totalSpots,
//     required this.progress,
//     required this.budget,
//     required this.age,
//     required this.housing,
//     required this.compatibility,
//     required this.members,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//       decoration: BoxDecoration(
//         color: const Color(0xFF1E1E1E),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.4),
//             blurRadius: 12,
//             offset: const Offset(0, 6),
//           )
//         ],
//       ),
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "$membersCount/$totalSpots • $title",
//                 style: const TextStyle(
//                   color: Color(0xFF62E1C5),
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//               Text(
//                 location,
//                 style: const TextStyle(color: Colors.white70),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),

//           ClipRRect(
//             borderRadius: BorderRadius.circular(6),
//             child: LinearProgressIndicator(
//               value: progress,
//               minHeight: 6,
//               color: const Color(0xFF62E1C5),
//               backgroundColor: Colors.white12,
//             ),
//           ),
//           const SizedBox(height: 20),

//           Wrap(
//             alignment: WrapAlignment.spaceBetween,
//             runSpacing: 8,
//             children: [
//               _InfoTile(label: "Бюджет", value: "$budget ₽"),
//               _InfoTile(label: "Возраст", value: "$age лет"),
//               _InfoTile(label: "Жильё", value: housing),
//               _InfoTile(label: "Совместимость", value: "$compatibility%"),
//             ],
//           ),
//           const SizedBox(height: 24),

//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: members
//                 .map((m) => Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 6),
//                       child: Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 20,
//                             backgroundImage: AssetImage(m.avatarPath),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Text(
//                               "${m.name}, ${m.age} лет — ${m.profession}",
//                               style: const TextStyle(color: Colors.white),
//                             ),
//                           ),
//                           Text(
//                             "${m.budget} ₽",
//                             style: const TextStyle(color: Colors.white70),
//                           ),
//                         ],
//                       ),
//                     ))
//                 .toList(),
//           ),
//           const SizedBox(height: 24),

//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               OutlinedButton(
//                 onPressed: () {},
//                 style: OutlinedButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   side: const BorderSide(color: Colors.white30),
//                 ),
//                 child: const Text("Подробнее"),
//               ),
//               const SizedBox(width: 12),
//               ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF62E1C5),
//                   foregroundColor: Colors.black,
//                 ),
//                 child: const Text("Занять место"),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _InfoTile extends StatelessWidget {
//   final String label;
//   final String value;

//   const _InfoTile({required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 120,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label,
//               style: const TextStyle(color: Colors.white54, fontSize: 13)),
//           const SizedBox(height: 2),
//           Text(value,
//               style: const TextStyle(
//                   color: Colors.white, fontWeight: FontWeight.w600)),
//         ],
//       ),
//     );
//   }
// }

// class Member {
//   final String name;
//   final int age;
//   final String profession;
//   final int budget;
//   final String avatarPath;

//   Member({
//     required this.name,
//     required this.age,
//     required this.profession,
//     required this.budget,
//     required this.avatarPath,
//   });
// }





import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class NeighborGroupCard extends StatelessWidget {
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
        color: AppColors.midnight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.45),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: AppColors.white.withOpacity(0.06)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Pill(
                text: '$membersCount/$totalSpots • $title',
                color: AppColors.teal,
                textColor: AppColors.black,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  location,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${totalSpots - membersCount} из $totalSpots мест',
                style: TextStyle(
                  color: AppColors.white.withOpacity(0.45),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          const Text("Заполненность группы:",
          style: AppTextStyles.whiteSmall,),

          const SizedBox(height: 10,),

          // Прогресс
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 6,
              backgroundColor: Colors.white12,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.teal),
            ),
          ),
          const SizedBox(height: 16),

          LayoutBuilder(
            builder: (context, c) {
              final itemWidth =
                  (c.maxWidth - 3 * 12) / 4;
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

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: members
                .map((m) => _MemberCard(member: m))  
                .toList(),
          ),

          const SizedBox(height: 16),

          // Кнопки справа
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () {},
                style: 
                OutlinedButton.styleFrom(
                  foregroundColor: AppColors.teal,
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(190, 60),
                  backgroundColor: AppColors.teal,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                ),
                child: const Text('Занять место'),
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
          color: const Color(0xFF20252B),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.06)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: AppColors.teal,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(label,
                style: const TextStyle(color: Colors.white54, fontSize: 12)),
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
        color: const Color(0xFF1D2228),          
        borderRadius: BorderRadius.circular(14), 
        border: Border.all(color: Colors.white12),
      ),

      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(member.avatarPath),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text(
              '${member.name}',
              style: const TextStyle(color: Colors.white, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${member.age} лет  ${member.profession}   ${member.budget} ₽',
              style: const TextStyle(color: Colors.white54, fontSize: 14),
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
