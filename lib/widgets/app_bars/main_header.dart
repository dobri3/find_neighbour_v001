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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 750;

    final horizontalPadding = isMobile ? 16.0 : 60.0;
    final logoFontSize = isMobile ? 24.0 : 30.0;
    final avatarRadius = isMobile ? 16.0 : 20.0;
    final spacing = isMobile ? 8.0 : 32.0;

    return Material(
      child: Container(
        color: AppColors.baseBright,
        width: double.infinity,
        // constraints: const BoxConstraints(maxWidth: 1280),
        height: widget.preferredSize.height,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15,),
                Row(
                    children: _buildHeaderContent(context, logoFontSize, avatarRadius, spacing, isMobile),
                  ),
            Container(
              height: 1,
              color: AppColors.teal.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildHeaderContent(BuildContext context, double logoFontSize, double avatarRadius, double spacing, bool isMobile) {
    final List<Widget> widgets = [
      GestureDetector(
        onTap: () => context.router.push(const RecommendationRoute()),
        child: AppTextStyles.logo(context),
      ),
      Spacer(),
    ];

    if (isAuthorized) {
      widgets.addAll([
        if (!isMobile)
          GestureDetector(
            onTap: () => context.router.push(ChatRoute()),
            child: Text("Сообщения", style: AppTextStyles.whiteSmall(context)),
          ),
        if (isMobile)
          IconButton(
            onPressed: () => context.router.push(ChatRoute()),
            icon: const Icon(Icons.message, color: AppColors.textBase),
          ),
        SizedBox(width: spacing),
        if (!isMobile)
          GestureDetector(
            onTap: () async {
              var group = await ApiService.matcherService.getGroupByUserId(user!.id);
              context.router.push(GroupRoute(id: group.id));
            },
            child: Text("Группы", style: AppTextStyles.whiteSmall(context)),
          ),
        if (isMobile)
        IconButton(
            onPressed: () async {
                var group = await ApiService.matcherService.getGroupByUserId(user!.id);
                context.router.push(GroupRoute(id: group.id));
              },
            icon: const Icon(Icons.group, color: AppColors.textBase),
          ),
        SizedBox(width: spacing),
          IconButton(
            onPressed: () => context.router.push(const RecommendationRoute()),
            icon: const Icon(Icons.notifications_none, color: AppColors.textBase),
          ),
        SizedBox(width: spacing / 2),
        _AuthorizedUserSection(user: user!, avatarRadius: avatarRadius, isMobile: isMobile,),
      ]);
    } else {
      widgets.add(_UnauthorizedButton());
    }

    return widgets;
  }
}

class _AuthorizedUserSection extends StatelessWidget {
  final User user;
  final double avatarRadius;
  final bool isMobile;

  const _AuthorizedUserSection({required this.user, this.avatarRadius = 20, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(UserProfileRoute(id: user.id, auth: false)),
      child: Row(
        children: [
          CircleAvatar(
            radius: avatarRadius,
            backgroundImage: const AssetImage("asset/images/smart_guy.jpg"),
          ),
          const SizedBox(width: 8),
          if (!isMobile)
          Text("${user.name} ${user.surname}", style: AppTextStyles.whiteSmall(context)),
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
      style: AppButtonStyles.primaryMedium.copyWith(
        elevation: MaterialStateProperty.all(0), // убираем тень
      ),
      child: Text(
        "Регистрация",
        style: AppTextStyles.buttonSmall(context).copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
