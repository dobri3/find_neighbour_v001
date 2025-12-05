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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();
  final TextEditingController _neighboursController = TextEditingController();
  final TextEditingController _roomCountController = TextEditingController();
  final TextEditingController _monthsController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();

  bool _isFormValid = false;
  bool _isModified = false;
  bool _isSaving = false;

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
      _address = _form.parameters.address;
      print(_address);
      print(_userLocation.toJson());
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
    _monthsController.dispose();
    _regionController.dispose();
    super.dispose();
  }

  bool _isStringValid(String value) {
    return value.trim().isNotEmpty && RegExp(r'^[а-яА-Яa-zA-Z\s]+$').hasMatch(value);
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
      _isNumberValid(_monthsController.text);

  bool modified = _nameController.text != _name ||
      _surnameController.text != _surname ||
      _descController.text != _user.description ||
      _moneyController.text != '' ||
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
  );
  await ApiService.userService.updateUser(user);

  matcher.Parameters parameters = matcher.Parameters(
    name: _nameController.text,
    surname: _surnameController.text,
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
    age: 0,
    smoking: false,
    alko: false,
    pet: false,
    sex: 'male',
    userType: 'student',
    description: _descController.text,
    address: _address ?? '',
  );

  if (widget.auth) {
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

  File file = File(image.path);

  // String? uploadedUrl = await ApiService.userService.uploadAvatar(_id, file);
  String? uploadedUrl = '';

  if (uploadedUrl == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Ошибка загрузки фотографии")),
    );
    return;
  }

  setState(() {
    _user = _user.copyWith(photoUrl: uploadedUrl);
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeHeader(),
      backgroundColor: AppColors.baseBright,
      // backgroundColor: AppColors.white,
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
                  child: AppTextStyles.logo,
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
                        const Text('Профиль', style: AppTextStyles.profileTitle),
                        const SizedBox(height: 27),
                        Row(
                          children: [
                            Expanded(
                              child: Row(spacing: 41, children: [
                                GestureDetector(
                                  onTap: _id == sessionUser.id ? _pickAvatar : null,
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundColor: AppColors.teal.withOpacity(0.1),
                                    backgroundImage: _user.photoUrl != null ? NetworkImage(_user.photoUrl!) : null,
                                    child: _user.photoUrl == null
                                        ? const Icon(Icons.camera_alt, color: AppColors.textBase, size: 32)
                                        : null,
                                  ),
                                ),
                                // CircleAvatar(
                                //     radius: 60,),
                                Text(
                                  "$_name $_surname",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.textBase,
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
                                      minimumSize: const Size(190, 60),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                    ),
                                    child: const Text(
                                      'Написать',
                                          style: TextStyle(fontSize: 12, color: AppColors.textBase),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildMainInfo(),
                        const SizedBox(height: 20),
                        _buildHomeInfo(),
                        const SizedBox(height: 20),
                        ElevatedButton(
                        onPressed: (_isFormValid && !_isSaving) ? _saveProfile : null,
                        style: (_isFormValid && !_isSaving)
                            ? AppButtonStyles.primaryLarge
                            : AppButtonStyles.primaryLarge.copyWith(
                                backgroundColor: MaterialStateProperty.all(AppColors.baseBright.withOpacity(0.5)),
                                foregroundColor: MaterialStateProperty.all(AppColors.textBase.withOpacity(0.5)),
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
                        "Бюджет ₽", _moneyController, "Введите бюджет в рублях"),
                  ),
                Expanded(
                    child: _buildInput("Количество соседей", _neighboursController,
                        "Введите количество соседей")),
              ],
            ),
            ),
            const SizedBox(height: 20),
            Row(
              spacing: 20,
              children: [
                Expanded(
                    child: _buildInput(
                        "Срок съема (мес.)", _monthsController, "Введите срок съема в месяцах")),
                Expanded(
                    child: _buildInput("Количество комнат", _roomCountController,
                        "Введите количество комнат")),
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
                          _userLocation =
                              matcher.Point(lat: point.latitude, lon: point.longitude);
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

  Widget _buildInput(String title, TextEditingController controller, String hint,
      {maxLines = 1, minLines = 1}) {
    bool isStringField =
        [ _nameController, _surnameController, _descController].contains(controller);
    bool isValid = isStringField
        ? _isStringValid(controller.text)
        : _isNumberValid(controller.text);

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
                decoration: AppContainerStyles.textInput(hint).copyWith(
                  errorText: isValid ? null : 'Некорректное значение',
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(controller.text,
                    style: AppTextStyles.inputLabel,
                    textAlign: TextAlign.start,
                    maxLines: maxLines),
              ),
      ],
    );
  }
}
