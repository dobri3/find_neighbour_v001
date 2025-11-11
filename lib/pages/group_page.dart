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
    ),
    maxUsers: 0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  @override
  void initState() {
    super.initState();
    _loadGroupData();
  }

  void _loadGroupData() async {
    Group group = await ApiService.matcherService.getGroup(widget.id);

    setState(() {
      _group = group;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeHeader(),
      backgroundColor: const Color(0xFF1C2B38),
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
                  child: AppRichTextStyles.logoText(),
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
                            style: AppTextStyles.profileTitle,
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
                const Text(
                  "Информация",
                  style: AppTextStyles.sectionTitle,
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
                                style: AppTextStyles.smallHeaderBold,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${_group.parameters.description}',
                                style: AppTextStyles.whiteSmall,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Расположение',
                                style: AppTextStyles.smallHeaderBold,
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
                                style: AppTextStyles.smallHeaderBold,
                              ),
                              const SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'E-mail: email@email.com',
                                    style: AppTextStyles.whiteSmall,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Телефон: телефон владельца',
                                    style: AppTextStyles.whiteSmall,
                                  ),
                                  const SizedBox(height: 20),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        OutlinedButton(
                                          onPressed: () {},
                                          style: AppButtonStyles
                                              .tealOutlinedButton(
                                                  const Size(200, 50)),
                                          child: const Text(
                                            "Написать",
                                            style: AppTextStyles.whiteSmall,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        OutlinedButton(
                                          onPressed: () {},
                                          style:
                                              AppButtonStyles.tealFiledButton(
                                                  const Size(200, 50)),
                                          child: const Text(
                                            "Занять место",
                                            style: AppTextStyles.whiteSmall,
                                          ),
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
                const Text(
                  "Участники",
                  style: AppTextStyles.sectionTitle,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    spacing: 20,
                    children: [
                      for (var member in _group.members) Member(member: member)
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
                style: AppTextStyles.sectionTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                value,
                style: AppTextStyles.whiteSmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
