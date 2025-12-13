

import 'package:find_neighbour_v001/api/notification.dart';
import 'package:find_neighbour_v001/models/notification.dart' as models;
import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

class NotificationController {
  static final NotificationController instance = NotificationController._internal();
  NotificationController._internal();

  // Список всех уведомлений
  final ValueNotifier<List<models.Notification>> notifications = ValueNotifier([]);

  void subscribe() {
    NotificationService().GettingNotifications(
      (notification) {
        final current = List<models.Notification>.from(notifications.value);
        current.insert(0, notification); 
        notifications.value = current;
      },
      () {},
    );
  }

  int get unreadCount => notifications.value.where((n) => !n.isRead).length;

  void markAsRead(String id) {
    final current = List<models.Notification>.from(notifications.value);
    final idx = current.indexWhere((n) => n.id == id);
    if (idx != -1) current[idx].isRead = true;
    notifications.value = current;
    NotificationService().markNotificationAsRead([id]);
  }
}

