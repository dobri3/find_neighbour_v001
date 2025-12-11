import 'package:dio/dio.dart';
import 'package:find_neighbour_v001/api/api.dart';
import 'package:find_neighbour_v001/models/notification.dart';
import 'dart:convert';

class NotificationService {
  static final Dio _dio = ApiService.dio;

  Future<List<Notification>> getNotifications() async {
    try {
      Response response = await _dio.get('/notifications');
      var data = response.data;
      print('data');
      print(data);

      if (data is List) {
        return await Future.wait(
          data.map(
            (e) async {
              Notification notification = Notification.fromJson(e);
              return notification;
            },
          ).toList(),
        );
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> markNotificationAsRead(List<String> ids) async {
    try {
      Response response = await _dio.put(
        '/notifications/read',
        data: {
          'ids': ids,
        },
      );
      print('data');
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> GettingNotifications(
    Function(Notification notification) onEvent,
    Function() onDone,
  ) async {
    final sse = await _dio.get(
      '/notifications/stream',
      options: Options(
        responseType: ResponseType.stream,
        receiveTimeout: Duration(hours: 3),
      ),
    );

    final stream = sse.data as ResponseBody;

    String buffer = "";
    await for (final chunk in stream.stream) {
      buffer += String.fromCharCodes(chunk);

      final messages = buffer.split("\n\n");

      buffer = messages.removeLast();

      for (final message in messages) {
        if (message.isEmpty) continue;

        String? event;
        String? data;

        final lines = message.split("\n");
        for (final line in lines) {
          if (line.startsWith('event:')) {
            event = line.substring(6).trim();
          } else if (line.startsWith('data:')) {
            data = line.substring(5).trim();
          }
        }

        if (data != null) {
          onEvent(Notification.fromJson(jsonDecode(data)));
        }
      }
    }

    onDone();
  }
}
