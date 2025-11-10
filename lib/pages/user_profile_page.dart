import 'package:find_neighbour_v001/styles/app_button_styles.dart';
import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:find_neighbour_v001/styles/app_container_styles.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/api/api.dart';
import 'package:find_neighbour_v001/models/user.dart';

import 'package:find_neighbour_v001/models/matcher/parameters.dart' as matcher;
import 'package:find_neighbour_v001/models/matcher/form.dart' as form;

import 'package:find_neighbour_v001/widgets/map.dart';
import 'package:latlong2/latlong.dart';
import 'package:find_neighbour_v001/routing/app_router.dart';

@RoutePage()
class UserProfilePage extends StatefulWidget {
  final String id;
  final bool auth;

  const UserProfilePage({
    @PathParam('id') required this.id,
    @QueryParam('auth') this.auth = false,
    super.key,
  });

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  User _user = User(id: '', name: '', surname: '', description: '');
  User sessionUser = User(id: '', name: '', surname: '', description: '');
  matcher.Point _userLocation = matcher.Point(lat: 55.755793, lon: 37.617134);
  String _name = '';
  String _surname = '';
  String _id = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();
  final TextEditingController _neighboursController = TextEditingController();
  final TextEditingController _roomCountController = TextEditingController();
  final TextEditingController _monthsController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    User _user = await ApiService.userService.getUserById(widget.id);
    sessionUser = await ApiService.authService.getSession();
    form.Form _form = await ApiService.matcherService.getFormByUser(widget.id);

    setState(() {
      _id = _user.id;
      _name = _user.name;
      _surname = _user.surname;

      _userLocation = _form.parameters.geo;
    });

    _nameController.text = _user.name;
    _surnameController.text = _user.surname;
    _descController.text = _user.description;

    _moneyController.text = _form.parameters.budget.toString();
    _neighboursController.text = _form.parameters.roommatesCount.toString();
    _roomCountController.text = _form.parameters.roomCount.toString();
    _monthsController.text = _form.parameters.months.toString();
    _regionController.text = _form.parameters.geo.toString();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _descController.dispose();
    _moneyController.dispose();
    _neighboursController.dispose();
    _roomCountController.dispose();
    _regionController.dispose();
    super.dispose();
  }

  void _saveProfile() async {
    User user = User(
      id: _id,
      name: _nameController.text,
      surname: _surnameController.text,
      description: _descController.text,
    );
    await ApiService.userService.updateUser(user);
    matcher.Parameters parameters = matcher.Parameters(
      name: _nameController.text,
      surname: _surnameController.text,
      geo: matcher.Point(lat: 0, lon: 0),
      photos: [],
      budget:
          _moneyController.text.isEmpty ? 0 : int.parse(_moneyController.text),
      roomCount: _roomCountController.text.isEmpty
          ? 0
          : int.parse(_roomCountController.text),
      roommatesCount: _neighboursController.text.isEmpty
          ? 0
          : int.parse(_neighboursController.text),
      months: _monthsController.text.isEmpty
          ? 0
          : int.parse(_monthsController.text),
      age: 0,
      smoking: false,
      alko: false,
      pet: false,
      sex: 'male',
      userType: 'student',
      description: _descController.text,
    );

    if (widget.auth) {
      await ApiService.matcherService.createForm(
        _id,
        parameters,
      );
      context.router.push(RecommendationRoute());
    } else {
      await ApiService.matcherService.updateForm(
        _id,
        parameters,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2B38),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 846,
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
                          const Text(
                            'Профиль',
                            style: AppTextStyles.profileTitle,
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 27,
                              bottom: 27,
                            ),
                            child: Row(spacing: 41, children: [
                              CircleAvatar(
                                radius: 60,
                              ),
                              Text(
                                "$_name $_surname",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                            ]),
                          ),
                          _buildMainInfo(),
                          const SizedBox(height: 20),
                          _buildHomeInfo(),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _saveProfile,
                            style: AppButtonStyles.primaryLarge,
                            child: const Text("Сохранить"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainInfo() {
    return Container(
      decoration: AppContainerStyles.sectionContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Основная информация",
              style: AppTextStyles.smallHeaderBold,
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                spacing: 20,
                children: [
                  Expanded(
                    child: _buildInput("Имя", _nameController, "Введите имя"),
                  ),
                  Expanded(
                    child: _buildInput(
                        "Фамилия", _surnameController, "Введите фамилию"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildInput("О себе", _descController, "Расскажите о себе",
                minLines: 3, maxLines: 5),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeInfo() {
    return Container(
      decoration: AppContainerStyles.sectionContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Параметры жилья",
              style: AppTextStyles.smallHeaderBold,
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                spacing: 20,
                children: [
                  Expanded(
                    child: _buildInput(
                        "Бюджет", _moneyController, "Введите бюджет в рублях"),
                  ),
                  Expanded(
                    child: _buildInput("Количество соседей",
                        _neighboursController, "Введите количество соседей"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                spacing: 20,
                children: [
                  Expanded(
                    child: _buildInput("Срок съема", _monthsController,
                        "Введите срок съема в месяцах"),
                  ),
                  Expanded(
                    child: _buildInput("Количество комнат",
                        _roomCountController, "Введите количество комнат"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            widget.id == sessionUser.id
                ? MapWidget(
                    width: double.infinity,
                    height: 500,
                    onPointSelected: (point, address) {
                      if (point != null) {
                        _userLocation = matcher.Point(
                            lat: point.latitude, lon: point.longitude);
                      }
                    },
                    initialCenter: LatLng(55.755793, 37.617134),
                    initialMarkerPoint:
                        LatLng(_userLocation.lat, _userLocation.lon),
                    initialZoom: 10,
                  )
                : MapWidget(
                    width: double.infinity,
                    height: 500,
                    initialCenter: LatLng(_userLocation.lat, _userLocation.lon),
                    initialZoom: 10,
                    isSelectable: false,
                    staticMarkerPoint:
                        LatLng(_userLocation.lat, _userLocation.lon),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(
      String title, TextEditingController controller, String hint,
      {maxLines = 1, minLines = 1}) {
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: AppTextStyles.smallSecondary,
            ),
          ),
          const SizedBox(height: 10),
          sessionUser.id == widget.id
              ? TextField(
                  controller: controller,
                  maxLines: maxLines,
                  minLines: minLines,
                  cursorColor: AppColors.teal,
                  decoration: AppContainerStyles.textInput(hint),
                )
              : Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      controller.text,
                      style: AppTextStyles.inputLabel,
                      textAlign: TextAlign.start,
                      maxLines: maxLines,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
