import 'package:find_neighbour_v001/styles/app_button_styles.dart';
import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:find_neighbour_v001/styles/app_container_styles.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/api/api.dart';
import 'package:find_neighbour_v001/models/user.dart';

@RoutePage()
class UserProfilePage extends StatefulWidget {
  final String id;

  const UserProfilePage({@PathParam('id') required this.id, super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String _name = '';
  String _surname = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();
  final TextEditingController _neighboursController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    User user = await ApiService.getUserById(widget.id);

    setState(() {
      _name = user.name;
      _surname = user.surname;
    });

    _nameController.text = user.name;
    _surnameController.text = user.surname;
    _descController.text = user.description;

    _moneyController.text = "20000";
    _neighboursController.text = "2";
    _regionController.text = "м. Войковская";
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _descController.dispose();
    _moneyController.dispose();
    _neighboursController.dispose();
    _regionController.dispose();
    super.dispose();
  }

  // @override
  // void _saveProfile() {
  //   print("save");
  // }

  Future<void> _saveProfile() async {
  User updatedUser = User(
    id: widget.id,
    name: _nameController.text,
    surname: _surnameController.text,
    description: _descController.text,
  );

  final result = await ApiService.updateUser(updatedUser);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Профиль сохранён ✅ ID: $result"),
      duration: Duration(seconds: 2),
    ),
  );
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
                              ClipOval(
                                child: Image.network(
                                  "data:image/jpeg;base64,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",
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
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
              style: AppTextStyles.sectionTitle,
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                spacing: 20,
                children: [
                  Expanded(
                    child: _buildInput("Имя", _nameController),
                  ),
                  Expanded(
                    child: _buildInput("Фамилия", _surnameController),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildInput("О себе", _descController, minLines: 3, maxLines: 5),
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
              style: AppTextStyles.sectionTitle,
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                spacing: 20,
                children: [
                  Expanded(
                    child: _buildInput("Бюджет", _moneyController),
                  ),
                  Expanded(
                    child: _buildInput(
                        "Количество соседей", _neighboursController),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildInput("Предпочитаемый район", _regionController),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String title, TextEditingController controller,
      {maxLines = 1, minLines = 1}) {
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: AppTextStyles.inputLabel,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            maxLines: maxLines,
            minLines: minLines,
            cursorColor: AppColors.teal,
            decoration: AppContainerStyles.textInput,
          ),
        ],
      ),
    );
  }
}
