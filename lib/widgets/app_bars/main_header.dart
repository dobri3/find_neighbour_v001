import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:find_neighbour_v001/api/api.dart';
import 'package:find_neighbour_v001/models/user.dart';
import 'package:find_neighbour_v001/routing/app_router.dart';
import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';
import 'package:find_neighbour_v001/styles/app_button_styles.dart';

class HomeHeader extends StatefulWidget implements PreferredSizeWidget {
  const HomeHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  User? user;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final u = await ApiService.authService.getSession();
    if (!mounted) return;
    setState(() {
      user = u;
      loading = false;
    });
  }

  bool get isAuthorized => user != null && user!.id.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.midnight,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1280),
          width: double.infinity,
          height: widget.preferredSize.height,
          child: Row(
            children: [
              GestureDetector(
                onTap: () => context.router.push(const RecommendationRoute()),
                child: AppRichTextStyles.logoText(),
              ),
              const Spacer(),
              if (isAuthorized) ...[
                GestureDetector(
                  onTap: () {
                    context.router.push(ChatRoute());
                  },
                  child:
                      const Text("Сообщения", style: AppTextStyles.whiteSmall),
                ),
                const SizedBox(width: 32),
                GestureDetector(
                  onTap: () async {
                    var group = await ApiService.matcherService
                        .getGroupByUserId(user!.id);

                    context.router.push(GroupRoute(id: group.id));
                  },
                  child: const Text("Группы", style: AppTextStyles.whiteSmall),
                ),
                const SizedBox(width: 40),
                IconButton(
                  onPressed: () =>
                      context.router.push(const RecommendationRoute()),
                  icon:
                      const Icon(Icons.notifications_none, color: Colors.white),
                ),
                const SizedBox(width: 28),
              ],
              if (!isAuthorized)
                _UnauthorizedButton()
              else
                _AuthorizedUserSection(user: user!),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthorizedUserSection extends StatelessWidget {
  final User user;

  const _AuthorizedUserSection({required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(
        UserProfileRoute(id: user.id, auth: false),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage("asset/images/smart_guy.jpg"),
          ),
          const SizedBox(width: 10),
          Text(
            "${user.name} ${user.surname}",
            style: AppTextStyles.whiteSmall,
          ),
        ],
      ),
    );
  }
}

class _UnauthorizedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.router.push(const AuthRoute()),
      style: AppButtonStyles.primaryMedium,
      child: const Text(
        "Регистрация",
        style: AppTextStyles.buttonSmall,
      ),
    );
  }
}
