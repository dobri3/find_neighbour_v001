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
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onMore;

  const RequestCard({
    super.key,
    required this.request,
    required this.onMore,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

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
                  backgroundImage: request.user?.photoUrl != null
                      ? NetworkImage(request.user!.photoUrl!)
                      : null,
                ),
                const SizedBox(width: 20),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${request.user?.name ?? ''} ${request.user?.surname ?? ''}",
                        style: AppTextStyles.smallHeaderBold(context),
                      ),
                    ],
                  ),
                ),

                if (!isMobile) ...[
                  const SizedBox(width: 10),
                  _ActionButtons(
                    onMore: onMore,
                    onAccept: onAccept,
                    onReject: onReject,
                  ),
                ],
              ],
            ),

            const SizedBox(height: 20),
            Text(
              request.user?.description ?? "",
              style: AppTextStyles.whiteSmall(context),
            ),

            if (isMobile) ...[
              const SizedBox(height: 20),
              _MobileActionButtons(
                onMore: onMore,
                onAccept: onAccept,
                onReject: onReject,
              ),
            ],
          ],
        ),
      ),
    );
  }
}



class _ActionButtons extends StatelessWidget {
  final VoidCallback onMore;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const _ActionButtons({
    required this.onMore,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _smallButton(
          label: "Подробнее",
          onTap: onMore,
          background: AppColors.baseBright,
          textColor: AppColors.textBase,

        ),
        const SizedBox(width: 10),

        _smallButton(
          label: "Принять",
          onTap: onAccept,
          background: const Color.fromARGB(255, 27, 134, 41),
          textColor: Colors.white,
        ),
        const SizedBox(width: 10),

        _smallButton(
          label: "Отклонить",
          onTap: onReject,
          background: AppColors.redBase,
          textColor: Colors.white,
        ),
      ],
    );
  }

  Widget _smallButton({
    required String label,
    required VoidCallback onTap,
    required Color background,
    required Color textColor,
  }) {
    return SizedBox(
      width: 100,
      height: 50,
      // width: 110,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: textColor,
          minimumSize: const Size(110, 40),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(label, style: const TextStyle(fontSize: 12)),
      ),
    );
  }
}

class _MobileActionButtons extends StatelessWidget {
  final VoidCallback onMore;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const _MobileActionButtons({
    required this.onMore,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _bigButton(
          label: "Подробнее",
          onTap: onMore,
          background: AppColors.baseBright,
          textColor: AppColors.textBase,

        ),
        const SizedBox(height: 10),

        _bigButton(
          label: "Принять",
          onTap: onAccept,
          background: const Color.fromARGB(255, 27, 134, 41),
          textColor: Colors.white,
        ),
        const SizedBox(height: 10),

        _bigButton(
          label: "Отклонить",
          onTap: onReject,
          background: AppColors.redBase,
          textColor: Colors.white,
        ),
      ],
    );
  }

  Widget _bigButton({
    required String label,
    required VoidCallback onTap,
    required Color background,
    required Color textColor,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: textColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(label, style: const TextStyle(fontSize: 14)),
      ),
    );
  }
}



// import 'package:find_neighbour_v001/models/matcher/form.dart';
// import 'package:flutter/material.dart';
// import 'package:find_neighbour_v001/models/matcher/parameters.dart' as matcher;
// import 'package:find_neighbour_v001/models/matcher/form.dart' as form;
// import 'package:find_neighbour_v001/styles/app_container_styles.dart';
// import 'package:find_neighbour_v001/styles/app_text_styles.dart';
// import 'package:find_neighbour_v001/models/matcher/request.dart';
// import 'package:find_neighbour_v001/styles/app_colors.dart';

// class RequestCard extends StatelessWidget {
//   final Request request;
//   final VoidCallback? onAccept;
//   final VoidCallback? onReject;
//   final VoidCallback? onMore;

//   const RequestCard({
//     required this.request,
//     this.onAccept,
//     this.onReject,
//     this.onMore,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: AppContainerStyles.profileCard,
//       width: double.infinity,
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CircleAvatar(
//                   radius: 30,
//                 ),
//                 const SizedBox(width: 20),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "${request.user!.name} ${request.user!.surname}",
//                         style: AppTextStyles.smallHeaderBold(context),
//                         textAlign: TextAlign.left,
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Row(
//                   children: [
//                     SizedBox(
//                       width: 100,
//                       child: ElevatedButton(
//                         onPressed: onMore,
//                         style: OutlinedButton.styleFrom(
//                           foregroundColor: AppColors.baseBright,
//                           backgroundColor: AppColors.textBase,
//                           side: BorderSide(
//                               color: AppColors.teal.withOpacity(0.25)),
//                           minimumSize: const Size(190, 60),
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 12),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: const Text(
//                           'Подробнее',
//                           style: TextStyle(fontSize: 12, color: AppColors.white),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     SizedBox(
//                       width: 100,
//                       child: ElevatedButton(
//                         onPressed: onAccept,
//                         style: ElevatedButton.styleFrom(
//                           minimumSize: const Size(190, 60),
//                           backgroundColor: AppColors.detailBlue,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 18, vertical: 12),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: const Text(
//                           'Принять',
//                           style: TextStyle(fontSize: 13),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     SizedBox(
//                       width: 100,
//                       child: ElevatedButton(
//                         onPressed: onReject,
//                         style: ElevatedButton.styleFrom(
//                           minimumSize: const Size(190, 60),
//                           backgroundColor: const Color(0xFFEF4444),
//                           foregroundColor: Colors.black,
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 18, vertical: 13),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: const Text(
//                           'Отклонить',
//                           style: TextStyle(fontSize: 12),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Text(
//               "${request.user!.description}",
//               style: AppTextStyles.whiteSmall(context),
//               textAlign: TextAlign.left,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
