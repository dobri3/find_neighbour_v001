// import 'package:find_neighbour_v001/styles/app_colors.dart';
// import 'package:find_neighbour_v001/styles/app_text_styles.dart';
// import 'package:flutter/material.dart';

// class AppNotificationService {
//   static final AppNotificationService _instance = AppNotificationService._();
//   factory AppNotificationService() => _instance;
//   AppNotificationService._();

//   OverlayEntry? _entry;

//   void show(
//     BuildContext context, {
//     required String message,
//     Duration duration = const Duration(seconds: 3),
//   }) {
//     _entry?.remove();

//     _entry = OverlayEntry(
//       builder: (context) => _NotificationWidget(message: message),
//     );

//     Overlay.of(context, rootOverlay: true).insert(_entry!);

//     Future.delayed(duration, () {
//       _entry?.remove();
//       _entry = null;
//     });
//   }
// }


// class _NotificationWidget extends StatelessWidget {
//   final String message;

//   const _NotificationWidget({required this.message});

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: 24,
//       left: 16,
//       right: 16,
//       child: Material(
//         color: Colors.transparent,
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//           decoration: BoxDecoration(
//             color: AppColors.textBase,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.25),
//                 blurRadius: 10,
//               ),
//             ],
//           ),
//           child: Text(
//             message,
//             style: AppTextStyles.whiteSmall(context)
//                 .copyWith(color: Colors.white),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';

import 'package:find_neighbour_v001/api/api.dart';
import 'package:find_neighbour_v001/api/chat.dart';
import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppNotificationService {
  static final AppNotificationService _instance = AppNotificationService._();
  factory AppNotificationService() => _instance;
  AppNotificationService._();

  OverlayEntry? _entry;

  void show(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _entry?.remove();
    _entry = null;

    final overlay = Overlay.of(context);
    if (overlay == null) return;

    _entry = OverlayEntry(
      builder: (context) {
        return _NotificationWidget(
          message: message,
          onDismissed: hide,
        );
      },
    );

    overlay.insert(_entry!);

    Future.delayed(duration, hide);
  }

  void hide() {
    _entry?.remove();
    _entry = null;
  }
}

class _NotificationWidget extends StatefulWidget {
  final String message;
  final VoidCallback onDismissed;

  const _NotificationWidget({
    required this.message,
    required this.onDismissed,
  });

  @override
  State<_NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<_NotificationWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _offset = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Positioned(
      left: 16,
      right: 16,
      bottom: bottomInset + 16,
      child: SlideTransition(
        position: _offset,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.textBase,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(0.25),
                ),
              ],
            ),
            child: Text(
              widget.message,
              style: AppTextStyles.whiteSmall(context),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}


class AppNotifications {
  static final AppNotifications _instance = AppNotifications._();
  factory AppNotifications() => _instance;
  AppNotifications._();

  final _controller = StreamController<String>.broadcast();

  Stream<String> get stream => _controller.stream;

  void push(String message) {
    _controller.add(message);
  }

  void dispose() {
    _controller.close();
  }
}


class AppShell extends StatefulWidget {
  final Widget child;
  const AppShell({required this.child});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late final StreamSubscription<String> _sub;

  @override
  void initState() async{
    super.initState();

  final currentUser = await ApiService.authService.getSession();
  ChatService().connectAndListenGlobal(userId: currentUser.id);

    _sub = AppNotifications().stream.listen((message) {
      AppNotificationService().show(
        context,
        message: message,
      );
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class NotificationState {
  static final NotificationState instance = NotificationState._();
  NotificationState._();

  final ValueNotifier<int> counter = ValueNotifier<int>(0);

  void increment() {
    counter.value++;
  }

  void reset() {
    counter.value = 0;
  }
}

