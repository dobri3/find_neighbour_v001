import 'package:find_neighbour_v001/api/notification.dart';
import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:find_neighbour_v001/models/chat/messages.dart';

class ChatNotificationController {
  ChatNotificationController._();
  static final instance = ChatNotificationController._();

  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  String? activeChatId;

  String? currentUserId;

  void showIfNeeded(OutputMessage message) {
    if (message.sender.id == currentUserId) return;

    if (message.chatID == activeChatId) return;

    final messenger = messengerKey.currentState;
    if (messenger == null) return;

    messenger.clearSnackBars();

    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        backgroundColor: AppColors.accentBlue.withOpacity(0.85),
        margin: const EdgeInsets.only(
          bottom: 24,
          left: 24,
          right: 24,
        ),
        content: Row(
          children: [
            const Icon(Icons.message, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: 
              // Text(
              //   style: TextStyle(color: AppColors.base1),
              //   message.content,
              //   maxLines: 2,
              //   overflow: TextOverflow.ellipsis,
              // ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.sender.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      message.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}

