import 'package:find_neighbour_v001/api/api.dart';
import 'package:find_neighbour_v001/models/chat/messages.dart';
import 'package:find_neighbour_v001/widgets/chat_notification_controller.dart';
import 'package:flutter/material.dart';
  import 'package:flutter/foundation.dart';

class AppInitializer extends StatefulWidget {
  final Widget child;
  const AppInitializer({required this.child});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  @override
  void initState() {
    super.initState();

    ApiService.chatService.GettingMessageEventHTTP(
      (message) {
        ChatNotificationController.instance.showIfNeeded(message);
      },
      () {},
    );
  }



// @override
// void initState() {
//   super.initState();

//   ApiService.chatService.GettingMessageEventHTTP(
//     (message) {
//       ChatNotificationController.instance.showIfNeeded(message);
//     },
//     () {},
//   );

//   if (kDebugMode) {
//     Future.delayed(const Duration(seconds: 2), () {
//       print('MOCK NOTIFICATION FIRED');
//       ChatNotificationController.instance.showIfNeeded(
//         OutputMessage(
//           chatID: 'test_chat',
//           sender: ChatUser(
//             id: 'another_user',
//             name: 'Test User',
//             avatarUrl: '',
//           ),
//           content: 'Тестовое уведомление',
//           contentType: 'text',
//           createdAt: DateTime.now(),
//         ),
//       );
//     });
//   }
// }


  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
