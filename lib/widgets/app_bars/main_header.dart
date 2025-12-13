import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/widgets/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:find_neighbour_v001/api/api.dart';
import 'package:find_neighbour_v001/models/user.dart';
import 'package:find_neighbour_v001/routing/app_router.dart';
import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';
import 'package:find_neighbour_v001/styles/app_button_styles.dart';
import 'package:find_neighbour_v001/models/notification.dart' as models;


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
    NotificationController.instance.subscribe();
    // ТЕСТ
      WidgetsBinding.instance.addPostFrameCallback((_) {
  Future.delayed(const Duration(seconds: 1), () {
    final testNotification = models.Notification(
      id: 'test1',
      title: 'Тест',
      body: 'Пользователь Иван отправил запрос на вступление в группу',
      isRead: false,
      createdAt: DateTime.now(),
    );
    final current = List<models.Notification>.from(NotificationController.instance.notifications.value);
    current.insert(0, testNotification);
    NotificationController.instance.notifications.value = current;
  });
});
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

List<Widget> _buildHeaderContent(
    BuildContext context,
    double logoFontSize,
    double avatarRadius,
    double spacing,
    bool isMobile,
) {
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
          onPressed: () async{
            var group = await ApiService.matcherService.getGroupByUserId(user!.id);
            context.router.push(GroupRoute(id: group.id));
          },
          icon: const Icon(Icons.group, color: AppColors.textBase),
        ),
      SizedBox(width: spacing),
      // if (!isMobile)
      //   GestureDetector(
      //     onTap: () {
      //       _showNotificationsPopup(context);
      //     },
      //     child: Text("Собщения", style: AppTextStyles.whiteSmall(context)),
      //   ),
      // if (isMobile)
      ValueListenableBuilder<List<models.Notification>>(
      valueListenable: NotificationController.instance.notifications,
      builder: (context, notifications, child) {
        final unread = notifications.where((n) => !n.isRead).length;

        return IconButton(
          onPressed: () {
            _showNotificationsPopup(context);
          },
          icon: Stack(
            children: [
              Icon(
                Icons.notifications_active,
                color: AppColors.textBase,
              ),
              if (unread > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: const Color.fromARGB(255, 128, 35, 35),
                    child: Text(
                      '$unread',
                      style: const TextStyle(fontSize: 8, color: AppColors.base1),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    ),

      SizedBox(width: spacing / 2),
      _AuthorizedUserSection(
        user: user!,
        avatarRadius: avatarRadius,
        isMobile: isMobile,
      ),
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
        elevation: MaterialStateProperty.all(0),
      ),
      child: Text(
        "Регистрация",
        style: AppTextStyles.buttonSmall(context).copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}


// void _showNotificationsPopup(BuildContext context) {
//   final notifications = NotificationController.instance.notifications.value;

//   final items = notifications.map((n) {
//     return PopupMenuItem(
//       value: n.id,
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 16,
//             backgroundImage: NetworkImage(n.avatarUrl ?? ''), // URL аватарки
//           ),
//       const SizedBox(width: 8),
//       Expanded(
//       child: Text(
//         "${n.title}: ${n.body}",
//         maxLines: 2,
//         overflow: TextOverflow.ellipsis,
//         style: TextStyle(color: AppColors.base1),
//       ),
//       )
//         ]
//       )
//     );
//   }).toList();


void _showNotificationsPopup(BuildContext context) {
  final notifications = NotificationController.instance.notifications.value;

  final items = notifications.map((n) {
    return PopupMenuItem(
      value: n.id,
      child: 
      Text(
        "${n.title}: ${n.body}",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: AppColors.base1),
      ),
    );
  }).toList();


  showMenu(
    context: context,
    position: const RelativeRect.fromLTRB(1000, 80, 16, 0),
    items: items,
    color: AppColors.accentBlue.withOpacity(0.85),
  ).then((selectedId) {
    if (selectedId != null) {
      final notification = notifications.firstWhere((n) => n.id == selectedId);
      NotificationController.instance.markAsRead(notification.id);

      context.router.push(GroupRoute(id: notification.id)); // тут нужно правильно groupId
    }
  });
}
