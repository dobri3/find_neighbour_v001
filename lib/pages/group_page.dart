// import 'package:find_neighbour_v001/styles/app_button_styles.dart';
// import 'package:find_neighbour_v001/styles/app_colors.dart';
// import 'package:find_neighbour_v001/styles/app_container_styles.dart';
// import 'package:find_neighbour_v001/styles/app_text_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:find_neighbour_v001/routing/app_router.dart';
// import 'package:auto_route/auto_route.dart';
// import 'package:find_neighbour_v001/api/api.dart';
// import 'package:find_neighbour_v001/models/user.dart';

// import 'package:find_neighbour_v001/models/matcher/group.dart';
// import 'package:find_neighbour_v001/models/matcher/form.dart' as form;
// import 'package:find_neighbour_v001/models/matcher/parameters.dart' as matcher;

// import 'package:find_neighbour_v001/widgets/group/member.dart';
// import 'package:find_neighbour_v001/widgets/map.dart';
// import 'package:latlong2/latlong.dart';

// import 'package:find_neighbour_v001/widgets/app_bars/main_header.dart';

// import 'package:find_neighbour_v001/widgets/group/request.dart';
// import 'package:find_neighbour_v001/models/matcher/request.dart';

// @RoutePage()
// class GroupPage extends StatefulWidget {
//   final String id;

//   const GroupPage({
//     @PathParam('id') required this.id,
//     super.key,
//   });

//   @override
//   State<GroupPage> createState() => _GroupPageState();
// }

// class _GroupPageState extends State<GroupPage> {
  
//   bool _isJoinButtonLoading = false;
// bool _isJoinButtonSuccess = false;

// Future<void> _sendJoinRequest() async {
//   setState(() {
//     _isJoinButtonLoading = true;
//   });

//   try {
//     final session = await ApiService.authService.getSession();

//     await ApiService.matcherService.sendJoinRequest(
//       session.id,
//       _group.id,
//     );

//     setState(() {
//       _isJoinButtonSuccess = true;
//     });
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Ошибка отправки заявки: $e'),
//       ),
//     );
//   } finally {
//     setState(() {
//       _isJoinButtonLoading = false;
//     });
//   }
// }

//   Group _group = Group(
//     id: '',
//     ownerId: '',
//     parameters: matcher.Parameters(
//       name: '',
//       surname: '',
//       geo: matcher.Point(lat: 0, lon: 0),
//       photos: [],
//       budget: 0,
//       roomCount: 0,
//       roommatesCount: 0,
//       months: 0,
//       age: 0,
//       smoking: false,
//       alko: false,
//       pet: false,
//       sex: '',
//       userType: '',
//       description: '',
//       address: '',
//     ),
//     maxUsers: 0,
//     createdAt: DateTime.now(),
//     updatedAt: DateTime.now(),
//   );
//   User? _session;
//   List<Request>? _requests;

//   @override
//   void initState() {
//     super.initState();
//     _loadGroupData();
//   }

//   void _loadGroupData() async {
//     Group group = await ApiService.matcherService.getGroup(widget.id);
//     group.setMembers(
//         await ApiService.matcherService.getListGroupMembers(widget.id));
//     User session = await ApiService.authService.getSession();
//     var requests = null;
//     if (session.id == group.ownerId) {
//       requests = await ApiService.matcherService.getListRequests(widget.id);
//       print(requests);
//     }

//     setState(() {
//       _group = group;
//       _session = session;
//       _requests = requests;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;

//     final isMobile = width < 750;
//     final isTablet = width >= 750 && width < 1000;
//     final isDesktop = width >= 1000;

//     // decoration: BoxDecoration(
//     //                 color: AppColors.white,
//     //                 borderRadius: BorderRadius.circular(16),
//     //                 border: Border.all(color: AppColors.teal.withOpacity(0.06)),
//     //               ),

//     return Scaffold(
//       appBar: HomeHeader(),
//       backgroundColor: AppColors.baseBright,
//       body: SingleChildScrollView(
//         child: Center(
//           child: Container(
//             constraints: const BoxConstraints(
//               maxWidth: 1100,
//             ),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     top: 42,
//                     bottom: 42,
//                   ),
//                   child: AppTextStyles.logo(context),
//                 ),
//                 Container(
//                       constraints: const BoxConstraints(maxWidth: 1100),
//                       padding: EdgeInsets.symmetric(
//                         horizontal: isMobile ? 16 : 32,
//                       ),
//                     child: Center(
//                       child: Column(
//                         children: [
//                 Container(
//                   constraints: const BoxConstraints(maxWidth: 1100 ),
//                   width: double.infinity,
//                   padding: EdgeInsets.symmetric(
//                     horizontal: isMobile ? 16 : 32,
//                     vertical: 24,
//                   ),
//                   decoration: BoxDecoration(
//                     color: AppColors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(
//                       color: AppColors.teal.withOpacity(0.06),
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       Text(
//                         _group.parameters.name,
//                         style: AppTextStyles.profileTitle(context),
//                       ),

//                       const SizedBox(height: 20),

//                       isMobile
//                           ? Column(
//                               children: [
//                                 _StatRowMobile(group: _group),
//                                 const SizedBox(height: 12),
//                               ],
//                             )
//                           : Row(
//                               children: [
//                                 container("${_group.parameters.budget} ₽", "Средний бюджет"),
//                                 const SizedBox(width: 20),
//                                 container("${_group.members.length}", "Человек в группе"),
//                                 const SizedBox(width: 20),
//                                 container(
//                                   "${_group.parameters.roommatesCount - _group.members.length}",
//                                   "Нужно соседей",
//                                 ),
//                                 const SizedBox(width: 20),
//                                 container("${_group.parameters.age} лет", "Возраст"),
//                               ],
//                             ),

//                       if (_session != null &&
//                           _session!.id == _group.ownerId &&
//                           _requests != null &&
//                           _requests!.isNotEmpty) ...[
//                         const SizedBox(height: 24),
//                         Text(
//                           "Запросы",
//                           style: AppTextStyles.sectionTitle(context),
//                         ),
//                         const SizedBox(height: 20),
//                         Column(
//                           spacing: 20,
//                           children: [
//                             for (var request in _requests!)
//                               RequestCard(
//                                 request: request,
//                                 onAccept: () async {
//                                   await ApiService.matcherService
//                                       .acceptJoinRequest(_session!.id, request.id);
//                                 },
//                                 onReject: () async {
//                                   await ApiService.matcherService
//                                       .rejectJoinRequest(_session!.id, request.id);
//                                 },
//                                 onMore: () {
//                                   context.router.push(
//                                     UserProfileRoute(id: request.userId),
//                                   );
//                                 },
//                               ),
//                           ],
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20,),
//                  Text(
//                   "Информация",
//                   style: AppTextStyles.sectionTitle(context),
//                 ),
//                 const SizedBox(height: 20,),
//                 isMobile
//                   ? Column(
//                       children: [
//                         _InfoCard(group: _group),
//                         const SizedBox(height: 20),
//                         _ContactsCard(
//           isJoinLoading: _isJoinButtonLoading,
//           isJoinSuccess: _isJoinButtonSuccess,
//           onWrite: () {},
//           onJoin: _sendJoinRequest,
//           ),
//                       ],
//                     )
//                   : Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(flex: 3, child: _InfoCard(group: _group)),
//                         const SizedBox(width: 20),
//                         Expanded(flex: 2, child: _ContactsCard(
//           isJoinLoading: _isJoinButtonLoading,
//           isJoinSuccess: _isJoinButtonSuccess,
//           onWrite: () {},
//           onJoin: _sendJoinRequest,
//           )),
//                       ],
//                     ),
//                 const SizedBox(height: 20),
//                 Text(
//                   "Участники",
//                   style: AppTextStyles.sectionTitle(context),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(top: 20),
//                   child: Column(
//                     spacing: 20,
//                     children: [
//                       for (var member in _group.members)
//                         Member(
//                           member: member,
//                           onMore: () {
//                             context.router
//                                 .push(UserProfileRoute(id: member.userId));
//                           },
//                         )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//               ],
//           )
//         )
//       )
//       )
//     );
//   }

//   Widget container(String title, String value) {
//     return Expanded(
//       child: Container(
//         alignment: Alignment.center,
//         height: 110,
//         width: 120,
//         decoration: AppContainerStyles.sectionContainer,
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             children: [
//               Text(
//                 title,
//                 style: AppTextStyles.sectionTitle(context),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 value,
//                 style: AppTextStyles.whiteSmall(context),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _InfoCard extends StatelessWidget {
//   final Group group;

//   const _InfoCard({
//     super.key,
//     required this.group,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = MediaQuery.of(context).size.width < 650;

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: AppContainerStyles.profileCard,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Описание',
//             style: AppTextStyles.smallHeaderBold(context),
//           ),
//           const SizedBox(height: 12),
//           Text(
//             group.parameters.description.isEmpty
//                 ? 'Описание отсутствует'
//                 : group.parameters.description,
//             style: AppTextStyles.whiteSmall(context),
//           ),
//           const SizedBox(height: 24),
//           Text(
//             'Расположение',
//             style: AppTextStyles.smallHeaderBold(context),
//           ),
//           const SizedBox(height: 12),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: MapWidget(
//               width: double.infinity,
//               height: isMobile ? 240 : 400,
//               initialCenter: LatLng(
//                 group.parameters.geo.lat,
//                 group.parameters.geo.lon,
//               ),
//               initialZoom: 10,
//               isSelectable: false,
//               staticMarkerPoint: LatLng(
//                 group.parameters.geo.lat,
//                 group.parameters.geo.lon,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// class _ContactsCard extends StatelessWidget {
//   final bool isJoinLoading;
//   final bool isJoinSuccess;
//   final VoidCallback onWrite;
//   final Future<void> Function() onJoin;

//   const _ContactsCard({
//     super.key,
//     required this.isJoinLoading,
//     required this.isJoinSuccess,
//     required this.onWrite,
//     required this.onJoin,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = MediaQuery.of(context).size.width < 600;

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: AppContainerStyles.profileCard,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Контакты',
//             style: AppTextStyles.smallHeaderBold(context),
//           ),
//           const SizedBox(height: 12),
//           Text(
//             'E-mail: email@email.com',
//             style: AppTextStyles.whiteSmall(context),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Телефон: телефон владельца',
//             style: AppTextStyles.whiteSmall(context),
//           ),
//           const SizedBox(height: 24),
//           Column(
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 child: OutlinedButton(
//                   onPressed: onWrite,
//                   style: OutlinedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     side: BorderSide(
//                       color: AppColors.teal.withOpacity(0.8),
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: Text(
//                     'Написать',
//                     style: AppTextStyles.whiteSmall(context),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               SizedBox(
//                 width: double.infinity,
                
//                 child: OutlinedButton(
//                   onPressed:
//                       isJoinLoading || isJoinSuccess ? null : onJoin,
//                   style:OutlinedButton.styleFrom(
//                    fixedSize: const Size(200, 50),
//                   backgroundColor: Colors.transparent,
//                   foregroundColor: AppColors.textBase,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: isJoinLoading
//                       ? const SizedBox(
//                           width: 20,
//                           height: 20,
//                           child: CircularProgressIndicator(strokeWidth: 2),
//                         )
//                       : Text(
//                           isJoinSuccess
//                               ? 'Заявка отправлена'
//                               : 'Занять место',
//                           style: AppTextStyles.whiteSmall(context),
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _StatRowMobile extends StatelessWidget {
//   final Group group;

//   const _StatRowMobile({
//     required this.group,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       spacing: 12,
//       runSpacing: 12,
//       children: [
//         _StatItem(
//           title: "${group.parameters.budget} ₽",
//           subtitle: "Средний бюджет",
//         ),
//         _StatItem(
//           title: "${group.members.length}",
//           subtitle: "В группе",
//         ),
//         _StatItem(
//           title:
//               "${group.parameters.roommatesCount - group.members.length}",
//           subtitle: "Нужно соседей",
//         ),
//         _StatItem(
//           title: "${group.parameters.age} лет",
//           subtitle: "Возраст",
//         ),
//       ],
//     );
//   }
// }

// class _StatItem extends StatelessWidget {
//   final String title;
//   final String subtitle;

//   const _StatItem({
//     required this.title,
//     required this.subtitle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;

//     return SizedBox(
//       width: (width - 48) / 2, 
//       child: Container(
//         height: 100,
//         decoration: AppContainerStyles.sectionContainer,
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               title,
//               style: AppTextStyles.sectionTitle(context),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               subtitle,
//               style: AppTextStyles.whiteSmall(context),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

















import 'package:find_neighbour_v001/styles/app_button_styles.dart';
import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:find_neighbour_v001/styles/app_container_styles.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:find_neighbour_v001/routing/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/api/api.dart';
import 'package:find_neighbour_v001/models/user.dart';

import 'package:find_neighbour_v001/models/matcher/group.dart';
import 'package:find_neighbour_v001/models/matcher/form.dart' as form;
import 'package:find_neighbour_v001/models/matcher/parameters.dart' as matcher;

import 'package:find_neighbour_v001/widgets/group/member.dart';
import 'package:find_neighbour_v001/widgets/map.dart';
import 'package:latlong2/latlong.dart';

import 'package:find_neighbour_v001/widgets/app_bars/main_header.dart';

import 'package:find_neighbour_v001/widgets/group/request.dart';
import 'package:find_neighbour_v001/models/matcher/request.dart';

@RoutePage()
class GroupPage extends StatefulWidget {
  final String id;

  const GroupPage({
    @PathParam('id') required this.id,
    super.key,
  });

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {

  
  
  bool _isJoinButtonLoading = false;
bool _isJoinButtonSuccess = false;

Future<void> _sendJoinRequest() async {
  setState(() {
    _isJoinButtonLoading = true;
  });

  try {
    final session = await ApiService.authService.getSession();

    await ApiService.matcherService.sendJoinRequest(
      session.id,
      _group.id,
    );

    setState(() {
      _isJoinButtonSuccess = true;
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ошибка отправки заявки: $e'),
      ),
    );
  } finally {
    setState(() {
      _isJoinButtonLoading = false;
    });
  }


}

  Group _group = Group(
    id: '',
    ownerId: '',
    parameters: matcher.Parameters(
      name: '',
      surname: '',
      geo: matcher.Point(lat: 0, lon: 0),
      photos: [],
      budget: 0,
      roomCount: 0,
      roommatesCount: 0,
      months: 0,
      age: 0,
      smoking: false,
      alko: false,
      pet: false,
      sex: '',
      userType: '',
      description: '',
      address: '',
    ),
    maxUsers: 0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  User? _session;
  List<Request>? _requests;

  @override
  void initState() {
    super.initState();
    _loadGroupData();
  }

  void _loadGroupData() async {
    Group group = await ApiService.matcherService.getGroup(widget.id);
    group.setMembers(
        await ApiService.matcherService.getListGroupMembers(widget.id));
    User session = await ApiService.authService.getSession();
    var requests = null;
    if (session.id == group.ownerId) {
      requests = await ApiService.matcherService.getListRequests(widget.id);
      print(requests);
    }

    setState(() {
      _group = group;
      _session = session;
      _requests = requests;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final isMobile = width < 750;
    final isTablet = width >= 750 && width < 1000;
    final isDesktop = width >= 1000;

    return Scaffold(
      appBar: HomeHeader(),
      backgroundColor: AppColors.baseBright,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 1100,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 42,
                    bottom: 42,
                  ),
                  child: AppTextStyles.logo(context),
                ),
                Container(
                      constraints: const BoxConstraints(maxWidth: 1100),
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 16 : 32,
                      ),
                    child: Center(
                      child: Column(
                        children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 1100 ),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 32,
                    vertical: 24,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.teal.withOpacity(0.06),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _group.parameters.name,
                        style: AppTextStyles.profileTitle(context),
                      ),

                      const SizedBox(height: 20),

                      _StatRowResponsive (group: _group,
                      
                    ),

                const SizedBox(height: 20,),
                 Text(
                  "Информация",
                  style: AppTextStyles.sectionTitle(context),
                ),
                const SizedBox(height: 20,),
                isMobile
                  ? Column(
                      children: [
                        _InfoCard(group: _group),
                        const SizedBox(height: 20),
                        _ContactsCard(
          isJoinLoading: _isJoinButtonLoading,
          isJoinSuccess: _isJoinButtonSuccess,
          onWrite: () {},
          onJoin: _sendJoinRequest, isMember: _group.members.any((m) => m.userId == _session!.id),
          ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: _InfoCard(group: _group)),
                        const SizedBox(width: 20),
                        Expanded(flex: 2, child: _ContactsCard(
          isJoinLoading: _isJoinButtonLoading,
          isJoinSuccess: _isJoinButtonSuccess,
          onWrite: () {},
          onJoin: _sendJoinRequest, isMember: _group.members.any((m) => m.userId == _session!.id),
          )),
                      ],
                    ),
                const SizedBox(height: 20),
                Text(
                  "Участники",
                  style: AppTextStyles.sectionTitle(context),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    spacing: 20,
                    children: [
                      for (var member in _group.members)
                          Member(
                            member: member,
                            onMore: () { 
                              context.router
                                 .push(UserProfileRoute(id: member.userId));
                             },
                            isOwner: _session!.id == _group.ownerId,
                            onRemove: () async {
                              await ApiService.matcherService.kickMember(_group.id); 
                            },
                          )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
                        ],
                    ),
                    ),
          )
              ]
      )
        )
      )
      )
    );
  }



  Widget container(String title, String value, bool isMobile) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
      height: isMobile ? 80 : 110,
      width: isMobile ? 90 : 120,  
        decoration: AppContainerStyles.sectionContainer,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                title,
                style: AppTextStyles.sectionTitle(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                value,
                style: AppTextStyles.whiteSmall(context),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final Group group;

  const _InfoCard({
    super.key,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 650;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppContainerStyles.profileCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Описание',
            style: AppTextStyles.smallHeaderBold(context),
          ),
          const SizedBox(height: 12),
          Text(
            group.parameters.description.isEmpty
                ? 'Описание отсутствует'
                : group.parameters.description,
            style: AppTextStyles.whiteSmall(context),
          ),
          const SizedBox(height: 24),
          Text(
            'Расположение',
            style: AppTextStyles.smallHeaderBold(context),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: MapWidget(
              width: double.infinity,
              height: isMobile ? 240 : 400,
              initialCenter: LatLng(
                group.parameters.geo.lat,
                group.parameters.geo.lon,
              ),
              initialZoom: 10,
              isSelectable: false,
              staticMarkerPoint: LatLng(
                group.parameters.geo.lat,
                group.parameters.geo.lon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactsCard extends StatelessWidget {
  final bool isJoinLoading;
  final bool isJoinSuccess;
  final bool isMember; // новый флаг: уже в группе
  final VoidCallback onWrite;
  final Future<void> Function() onJoin;
  final Future<void> Function()? onLeave; // колбек для выхода из группы

  const _ContactsCard({
    super.key,
    required this.isJoinLoading,
    required this.isJoinSuccess,
    required this.isMember,
    required this.onWrite,
    required this.onJoin,
    this.onLeave,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppContainerStyles.profileCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Контакты', style: AppTextStyles.smallHeaderBold(context)),
          const SizedBox(height: 12),
          Text('E-mail: email@email.com', style: AppTextStyles.whiteSmall(context)),
          const SizedBox(height: 8),
          Text('Телефон: телефон владельца', style: AppTextStyles.whiteSmall(context)),
          const SizedBox(height: 24),
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: onWrite,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: AppColors.teal.withOpacity(0.8)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text('Написать', style: AppTextStyles.whiteSmall(context)),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: isJoinLoading
                      ? null
                      : isMember
                          ? onLeave
                          : onJoin,
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(200, 50),
                    backgroundColor: Colors.transparent,
                    foregroundColor: AppColors.textBase,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: isJoinLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          isMember ? 'Выйти из группы' : (isJoinSuccess ? 'Заявка отправлена' : 'Занять место'),
                          style: AppTextStyles.whiteSmall(context),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class _StatRowResponsive extends StatelessWidget {
  final Group group;

  const _StatRowResponsive({required this.group});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final maxWidth = constraints.maxWidth;
      final isMobile = maxWidth < 750;
      final isTablet = maxWidth >= 750 && maxWidth < 900;

      int itemsPerRow = (isMobile || isTablet) ? 2 : 4;
      double itemWidth = (maxWidth - (16 * (itemsPerRow - 1))) / itemsPerRow;

      return Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          _StatItem(title: "${group.parameters.budget} ₽", subtitle: "Средний бюджет", width: itemWidth),
          _StatItem(title: "${group.members.length}", subtitle: "В группе", width: itemWidth),
          _StatItem(title: "${group.parameters.roommatesCount - group.members.length}", subtitle: "Нужно соседей", width: itemWidth),
          _StatItem(title: "${group.parameters.age} лет", subtitle: "Возраст", width: itemWidth),
        ],
      );
    });
  }
}

class _StatItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final double width;

  const _StatItem({required this.title, required this.subtitle, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 100,
      decoration: AppContainerStyles.sectionContainer,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: AppTextStyles.sectionTitle(context), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text(subtitle, style: AppTextStyles.whiteSmall(context), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
