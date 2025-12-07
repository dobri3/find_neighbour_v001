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
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: AppContainerStyles.profileCard,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 60,
                      right: 60,
                      bottom: 60,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            '${_group.parameters.name}',
                            style: AppTextStyles.profileTitle(context),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              container("${_group.parameters.budget} ₽",
                                  "Средний бюджет"),
                              const SizedBox(width: 20),
                              container("${_group.members.length}",
                                  "Человек в группе"),
                              const SizedBox(width: 20),
                              container(
                                  "${_group.parameters.roommatesCount - _group.members.length}",
                                  "Нужно соседей"),
                              const SizedBox(width: 20),
                              container(
                                  "${_group.parameters.age} лет", "Возраст"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                _session != null &&
                        _session!.id == _group.ownerId &&
                        _requests != null &&
                        _requests!.length > 0
                    ? Column(
                        children: [
                           Text(
                            "Запросы",
                            style: AppTextStyles.sectionTitle(context),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              spacing: 20,
                              children: [
                                for (var request in _requests!)
                                  RequestCard(
                                    request: request,
                                    onAccept: () async {
                                      await ApiService.matcherService
                                          .acceptJoinRequest(
                                              _session!.id, request.id);
                                    },
                                    onReject: () async {
                                      await ApiService.matcherService
                                          .rejectJoinRequest(
                                              _session!.id, request.id);
                                    },
                                    onMore: () {
                                      context.router.push(
                                          UserProfileRoute(id: request.userId));
                                    },
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      )
                    : const SizedBox(),
                 Text(
                  "Информация",
                  style: AppTextStyles.sectionTitle(context),
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: 20,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: AppContainerStyles.profileCard,
                          margin: const EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Описание',
                                style: AppTextStyles.smallHeaderBold(context),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${_group.parameters.description}',
                                style: AppTextStyles.whiteSmall(context),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Расположение',
                                style: AppTextStyles.smallHeaderBold(context),
                              ),
                              const SizedBox(height: 10),
                              MapWidget(
                                width: double.infinity,
                                height: 500,
                                initialCenter: LatLng(55.755793, 37.617134),
                                initialZoom: 10,
                                isSelectable: false,
                                staticMarkerPoint: LatLng(
                                    _group.parameters.geo.lat,
                                    _group.parameters.geo.lon),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: AppContainerStyles.profileCard,
                          margin: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Text(
                                'Контакты',
                                style: AppTextStyles.smallHeaderBold(context),
                              ),
                              const SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'E-mail: email@email.com',
                                    style: AppTextStyles.whiteSmall(context),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Телефон: телефон владельца',
                                    style: AppTextStyles.whiteSmall(context),
                                  ),
                                  const SizedBox(height: 20),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        OutlinedButton(
                                          onPressed: () {},
                                          style: OutlinedButton.styleFrom(
                                              // .tealOutlinedButton(
                                                  fixedSize: const Size(200, 50),
                                                  side: BorderSide(
                                                  color: AppColors.teal.withOpacity(0.8), // Черная рамка
                                                  width: 1,
                                                ),
                                                backgroundColor: Colors.transparent,
                                                foregroundColor: AppColors.teal,
                                                // minimumSize: minSize,
                                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                  side: const BorderSide(color: AppColors.teal, width: 2),
                                                ),
                                                  ),
                                                
                                          child: Text(
                                            "Написать",
                                            style: AppTextStyles.whiteSmall(context),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        OutlinedButton(
                                          onPressed: _isJoinButtonSuccess || _isJoinButtonLoading
                                              ? null
                                              : () async {
                                                  setState(() {
                                                    _isJoinButtonLoading = true;
                                                  });

                                                  try {
                                                    var session = await ApiService.authService.getSession();

                                                    final ok = await ApiService.matcherService
                                                        .sendJoinRequest(session.id, _group.id);

                                                    setState(() {
                                                      _isJoinButtonLoading = false;
                                                      _isJoinButtonSuccess = true;
                                                    });

                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                        content: Text("Заявка успешно отправлена"),
                                                      ),
                                                    );
                                                  } catch (e) {
                                                    setState(() {
                                                      _isJoinButtonLoading = false;
                                                    });

                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                        content: Text("Ошибка при отправке запроса"),
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: _isJoinButtonLoading
                                                  ? const SizedBox(
                                                      width: 20,
                                                      height: 20,
                                                      child: CircularProgressIndicator(strokeWidth: 2),
                                                    )
                                                  : Text(
                                                      _isJoinButtonSuccess ? "Заявка отправлена" : "Занять место",
                                                      style: AppTextStyles.whiteSmall(context),
                                                    ),

                                          // onPressed: () async {
                                          //   var session = await ApiService
                                          //       .authService
                                          //       .getSession();
                                          //   await ApiService.matcherService
                                          //       .sendJoinRequest(
                                          //           session.id, _group.id);
                                          //   print('sent');
                                          // },
                                          // style:
                                          //     AppButtonStyles.tealFiledButton(
                                          //         const Size(200, 50)),
                                          // child: const Text(
                                          //   "Занять место",
                                          //   style: AppTextStyles.whiteSmall,
                                          // ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
                        )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget container(String title, String value) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        height: 100,
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
