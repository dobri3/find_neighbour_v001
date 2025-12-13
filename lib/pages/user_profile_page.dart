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

import 'package:find_neighbour_v001/widgets/app_bars/main_header.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:io';

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
  String? _address;
  String _name = '';
  String _surname = '';
  String _id = '';
  ImageProvider? _avatar;
  bool _auth = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();
  final TextEditingController _neighboursController = TextEditingController();
  final TextEditingController _roomCountController = TextEditingController();
  final TextEditingController _monthsController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final List<TextEditingController> _contactsControllers = [
    TextEditingController(),
  ];

  bool _isFormValid = false;
  bool _isModified = false;
  bool _isSaving = false;
  int _age = 0;

  XFile? _localAvatar;

  void _addContactField() {
    setState(() {
      _contactsControllers.add(TextEditingController());
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();

    _nameController.addListener(_validateForm);
    _surnameController.addListener(_validateForm);
    _descController.addListener(_validateForm);
    _moneyController.addListener(_validateForm);
    _neighboursController.addListener(_validateForm);
    _roomCountController.addListener(_validateForm);
    _monthsController.addListener(_validateForm);
    _ageController.addListener(_validateForm);
  }

  void _loadUserData() async {
    final user = await ApiService.userService.getUserById(widget.id);
    sessionUser = await ApiService.authService.getSession();
    form.Form _form;
    try {
      _form = await ApiService.matcherService.getFormByUser(widget.id);
    } catch (e) {
      if (widget.id == sessionUser.id) {
        _auth = true;
      }
      _form = form.Form(
        id: '',
        userId: widget.id,
        parameters: matcher.Parameters(
          name: '',
          surname: '',
          geo: matcher.Point(lat: 55.755793, lon: 37.617134),
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
        active: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }

    setState(() {

      _user = user;
      _id = user.id;
      _name = user.name;
      _surname = user.surname;
      _age = _form.parameters.age;

      _userLocation = _form.parameters.geo;
      _address = _form.parameters.address;
    });

    _nameController.text = _user.name;
    _surnameController.text = _user.surname;
    _descController.text = _user.description;
    _ageController.text = _form.parameters.age.toString();

    _moneyController.text = _form.parameters.budget.toString();
    _neighboursController.text = _form.parameters.roommatesCount.toString();
    _roomCountController.text = _form.parameters.roomCount.toString();
    _monthsController.text = _form.parameters.months.toString();
    _regionController.text = _form.parameters.geo.toString();
    bool first = true;

    for (final c in user.contacts ?? []) {
      if (first) {
        first = false;
      } else {
        _addContactField();
      }
      _contactsControllers.last.text = c;
    }
  }

  @override
  void dispose() {
    _ageController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _descController.dispose();
    _moneyController.dispose();
    _neighboursController.dispose();
    _roomCountController.dispose();
    _monthsController.dispose();
    _regionController.dispose();
    for (final c in _contactsControllers) {
      c.dispose();
    }
    super.dispose();
  }

  bool _isStringValid(String value) {
    return value.trim().isNotEmpty &&
        RegExp(r'^[а-яА-Яa-zA-Z\s]+$').hasMatch(value);
  }

  bool _isNumberValid(String value) {
    if (value.isEmpty) return false;
    int? number = int.tryParse(value);
    return number != null && number > 0;
  }

  void _validateForm() {
    bool stringFieldsValid = _isStringValid(_nameController.text) &&
        _isStringValid(_surnameController.text) &&
        _isStringValid(_descController.text);

    bool numberFieldsValid = _isNumberValid(_moneyController.text) &&
        _isNumberValid(_neighboursController.text) &&
        _isNumberValid(_roomCountController.text) &&
        _isNumberValid(_monthsController.text) &&
        _isNumberValid(_ageController.text);

    bool modified = _nameController.text != _name ||
        _surnameController.text != _surname ||
        _descController.text != _user.description ||
        _moneyController.text != '' ||
        _ageController.text != _age.toString() ||
        _neighboursController.text != '' ||
        _roomCountController.text != '' ||
        _monthsController.text != '';

    setState(() {
      _isModified = modified;
      _isFormValid = stringFieldsValid && numberFieldsValid && _isModified;

      if (_isSaving && _isModified) {
        _isSaving = false;
      }
    });
  }

  void _saveProfile() async {
    if (!_isFormValid || _isSaving) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, исправьте ошибки в форме')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    User user = User(
      id: _id,
      name: _nameController.text,
      surname: _surnameController.text,
      description: _descController.text,
      contacts: _contactsControllers.map((e) => e.text).toList(),
    );
    await ApiService.userService.updateUser(user, _localAvatar);

    matcher.Parameters parameters = matcher.Parameters(
      name: _nameController.text,
      surname: _surnameController.text,
      age: int.parse(_ageController.text),
      geo: _userLocation,
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
      // age: 0,
      smoking: false,
      alko: false,
      pet: false,
      sex: 'male',
      userType: 'student',
      description: _descController.text,
      address: _address ?? '',
    );

    if (_auth) {
      await ApiService.matcherService.createForm(
        _id,
        parameters,
      );
      context.router.push(RecommendationRoute());
    } else {
      await ApiService.matcherService.updateForm(_id, parameters);
    }

    setState(() {
      _isModified = false;
      _validateForm();
    });
  }

  Future<void> _pickAvatar() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    setState(() {
      _avatar = NetworkImage(image.path);
    });

    // загрузка на сервер
    // final url = await ApiService.userService.uploadAvatar(_id, file);
    // if (url != null) {
    //   setState(() {
    //     _avatar = NetworkImage(url);
    //   });
    // }

    String? uploadedUrl = '';

    if (uploadedUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ошибка загрузки фотографии")),
      );
      return;
    }

    setState(() {
      _localAvatar = image;
      _user = _user.copyWith(photoUrl: uploadedUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: HomeHeader(),
      backgroundColor: AppColors.baseBright,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 846,
            ),
            child: Column(
              children: [
                if (!isMobile)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 42,
                      bottom: 42,
                    ),
                    child: AppTextStyles.logo(context),
                  ),
                if (!isMobile)
                  const SizedBox(
                    height: 20,
                  ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: AppContainerStyles.profileCard,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 20 : 60,
                      vertical: isMobile ? 32 : 60,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text('Профиль',
                              style: AppTextStyles.profileTitle(context)),
                          const SizedBox(height: 27),
                          Row(
                            children: [
                              Expanded(
                                child: Row(spacing: 41, children: [
                                  GestureDetector(
                                      onTap: (_user.id.isNotEmpty &&
                                              _user.id == sessionUser.id)
                                          ? _pickAvatar
                                          : null,
                                      child: CircleAvatar(
                                        radius: 60,
                                        backgroundColor:
                                            AppColors.teal.withOpacity(0.1),
                                        backgroundImage: _avatar ??
                                            (_user.photoUrl != null
                                                ? NetworkImage(_user.photoUrl!)
                                                : null),
                                        child: _avatar == null &&
                                                _user.photoUrl == null
                                            ? const Icon(Icons.camera_alt,
                                                size: 32)
                                            : null,
                                      )),
                                  Expanded(
                                    child: Text(
                                      "$_name $_surname",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.profileName(context)
                                          .copyWith(
                                        fontSize:
                                            MediaQuery.of(context).size.width <
                                                    600
                                                ? 16
                                                : 20,
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                              const SizedBox(width: 20),
                              _id != sessionUser.id
                                  ? ElevatedButton(
                                      onPressed: () => context.router
                                          .push(ChatRoute(userId: _id)),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: AppColors.textBase,
                                        backgroundColor: AppColors.baseBright,
                                        side: BorderSide(
                                            color: AppColors.teal
                                                .withOpacity(0.25)),
                                        minimumSize: Size(
                                          MediaQuery.of(context).size.width <
                                                  600
                                              ? 140
                                              : 190,
                                          48,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text(
                                        'Написать',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.textBase),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _buildMainInfo(),
                          const SizedBox(height: 20),
                          _buildAdditionalInfo(),
                          const SizedBox(height: 20),
                          _buildHomeInfo(),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: (_isFormValid && !_isSaving)
                                ? _saveProfile
                                : null,
                            style: (_isFormValid && !_isSaving)
                                ? AppButtonStyles.primaryLarge
                                : AppButtonStyles.primaryLarge.copyWith(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.baseBright.withOpacity(0.5)),
                                    foregroundColor: MaterialStateProperty.all(
                                        AppColors.textBase.withOpacity(0.5)),
                                  ),
                            child: const Text("Сохранить"),
                          )
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
            Text(
              "Основная информация",
              style: AppTextStyles.smallHeaderBold(context),
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
                validate: false, minLines: 3, maxLines: 5),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalInfo() {
    return Container(
      decoration: AppContainerStyles.sectionContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Дополнительная информация",
              style: AppTextStyles.smallHeaderBold(context),
            ),
            const SizedBox(height: 20),
            Row(
              spacing: 20,
              children: [
                Expanded(
                  child: _buildInput(
                    "Возраст",
                    _ageController,
                    "Введите возраст",
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildInput(
                              "Контакты",
                              _contactsControllers[0],
                              "Введите контакт",
                              validate: false,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: _addContactField,
                            icon: const Icon(Icons.add),
                            tooltip: 'Добавить контакт',
                            color: AppColors.accentBlue,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (_contactsControllers.length > 1) ...[
              const SizedBox(height: 16),
              Column(
                children: List.generate(
                  _contactsControllers.length - 1,
                  (index) {
                    final controller = _contactsControllers[index + 1];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildInput(
                        "Контакт ${index + 2}",
                        controller,
                        "Введите контакт",
                        validate: false,
                      ),
                    );
                  },
                ),
              ),
            ],
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
            Text(
              "Параметры жилья",
              style: AppTextStyles.smallHeaderBold(context),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                spacing: 20,
                children: [
                  Expanded(
                    child: _buildInput("Бюджет ₽", _moneyController,
                        "Введите бюджет в рублях"),
                  ),
                  Expanded(
                      child: _buildInput("Количество соседей",
                          _neighboursController, "Введите количество соседей")),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              spacing: 20,
              children: [
                Expanded(
                    child: _buildInput("Срок съема (мес.)", _monthsController,
                        "Введите срок съема в месяцах")),
                Expanded(
                    child: _buildInput("Количество комнат",
                        _roomCountController, "Введите количество комнат")),
              ],
            ),
            const SizedBox(height: 20),
            widget.id == sessionUser.id
                ? MapWidget(
                    width: double.infinity,
                    height: 500,
                    isSelectable: true,
                    onPointSelected: (point, address) {
                      if (point != null) {
                        setState(() {
                          _userLocation = matcher.Point(
                              lat: point.latitude, lon: point.longitude);
                          _address = address;
                          _validateForm();
                        });
                      }
                    },
                    initialCenter: LatLng(_userLocation.lat, _userLocation.lon),
                    initialAddress: _address,
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
                    initialAddress: _address,
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(
    String title,
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
    int minLines = 1,
    bool validate = true,
  }) {
    bool isStringField = [_nameController, _surnameController, _descController]
        .contains(controller);
    bool isValid = true;

    if (validate) {
      bool isStringField = [
        _nameController,
        _surnameController,
        _descController
      ].contains(controller);

      isValid = isStringField
          ? _isStringValid(controller.text)
          : _isNumberValid(controller.text);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.smallSecondary),
        const SizedBox(height: 10),
        sessionUser.id == widget.id
            ? TextField(
                style: TextStyle(color: AppColors.textBase),
                controller: controller,
                maxLines: maxLines,
                minLines: minLines,
                cursorColor: AppColors.textBase,
                decoration:
                    AppContainerStyles.textInput(context, hint).copyWith(
                  errorText: isValid ? null : 'Некорректное значение',
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(controller.text,
                    style: AppTextStyles.inputLabel(context),
                    textAlign: TextAlign.start,
                    maxLines: maxLines),
              ),
      ],
    );
  }
}
