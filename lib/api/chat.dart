import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:find_neighbour_v001/api/api.dart';
import 'package:find_neighbour_v001/models/chat/chat.dart';

import 'package:find_neighbour_v001/models/chat/messages.dart';

// import 'package:find_neighbour_v001/widgets/toast_notification.dart';
import 'dart:io';
import 'dart:html' as html;

import 'package:web_socket_channel/html.dart';

class ChatService {
  static final Dio _dio = ApiService.dio;

  Future<List<Chat>> getChatsByUserId() async {
    try {
      Response response = await _dio.get('/chat/list');
      var data = response.data;
      print('data');
      print(data);

      if (data is List) {
        return await Future.wait(
          data.map(
            (e) async {
              Chat chat = Chat.fromJson(e);
              return chat;
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

  Future<HtmlWebSocketChannel?> connectToChat(
    String? chatId,
    String? userId,
    String? groupId,
  ) async {
    try {
      String url = const String.fromEnvironment('WS_BASE_URL',
              defaultValue: 'ws://localhost:8080/api/v1') +
          "/chat/messages";
      int k = 0;
      if (chatId != null) {
        url += "?chat_id=$chatId";
        k++;
      }
      if (userId != null) {
        if (k == 0) {
          url += "?user_id=$userId";
        } else {
          url += "&user_id=$userId";
        }
        k++;
      }
      if (groupId != null) {
        if (k == 0) {
          url += "?group_id=$groupId";
        } else {
          url += "&group_id=$groupId";
        }
      }

      final wsUrl = Uri.parse(url);
      final webSocket = HtmlWebSocketChannel.connect(wsUrl);

      await webSocket.ready;

      return webSocket;
    } catch (e) {
      print(e);
      return null;
    }
  }
  //
  // void connectAndListenGlobal({required String userId}) async {
  //   final socket = await connectToChat(null, userId, null);
  //   if (socket == null) return;
  //
  //   socket.stream.listen((event) {
  //     if (event is! String) return;
  //
  //     print('WS EVENT RAW: $event');
  //
  //     final data = jsonDecode(event);
  //     final type = data['type'];
  //
  //     if (type == 'new_request') {
  //       AppNotifications().push("Новая заявка в вашу группу");
  //       NotificationState.instance.increment();
  //     }
  //
  //     if (type == 'new_message') {
  //       AppNotifications().push("Новое сообщение");
  //       NotificationState.instance.increment();
  //     }
  //   });
  // }

  Future<void> GettingMessageEvent(
    Function(OutputMessage message) onEvent,
    Function() onDone,
  ) async {
    try {
      print('GettingMessageEvent');
      final Response<ResponseBody> sse = await _dio.get<ResponseBody>(
        '/chat/messages/stream',
        options: Options(
          responseType: ResponseType.stream,
          sendTimeout: Duration(seconds: 10),
          receiveTimeout: Duration(hours: 3),
          headers: {
            'Accept': 'text/event-stream',
            'Connection': 'keep-alive',
            'Cache-control': 'no-cache',
            'X-Requested-With': 'XMLHttpRequest',
          },
        ),
      );

      final stream = sse.data as ResponseBody;
      print(stream);

      String buffer = "";
      await for (final chunk in stream.stream) {
        buffer += String.fromCharCodes(chunk);
        print(buffer);

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

          if (data != null && event != null && event.trim() == 'message') {
            onEvent(OutputMessage.fromJson(jsonDecode(data)));
          }
        }
      }

      onDone();
    } catch (e) {
      print(e);
      onDone();
    }
  }

  Future<void> GettingMessageEventHTTP(
    Function(OutputMessage message) onEvent,
    Function() onDone,
  ) async {
    html.EventSource? eventSource;

    try {
      print('GettingMessageEvent - connecting via browser EventSource...');

      // Полный URL с endpoint
      final url = 'http://localhost:8080/api/v1/chat/messages/stream';

      // Используем нативный браузерный EventSource
      eventSource = html.EventSource(url, withCredentials: true);

      // Обработка открытия соединения
      eventSource.onOpen.listen((event) {
        print('SSE Connected to $url');
      });

      // Обработка сообщений
      eventSource.onMessage.listen((html.MessageEvent event) {
        print('SSE Message received: ${event.data}');

        try {
          final jsonData = jsonDecode(event.data);
          final message = OutputMessage.fromJson(jsonData);
          onEvent(message);
        } catch (e) {
          print('Failed to decode message: $e\nData: ${event.data}');
        }
      });

      // Обработка событий с определенными именами (если сервер отправляет event: message)
      eventSource.addEventListener('message', (html.Event event) {
        final messageEvent = event as html.MessageEvent;
        print('SSE Event "message": ${messageEvent.data}');

        try {
          final jsonData = jsonDecode(messageEvent.data);
          final message = OutputMessage.fromJson(jsonData);
          onEvent(message);
        } catch (e) {
          print('Failed to decode message: $e\nData: ${messageEvent.data}');
        }
      });

      // Обработка ошибок
      eventSource.onError.listen((html.Event event) {
        print('SSE Error occurred');
        eventSource?.close();
        onDone();
      });
    } catch (e, stackTrace) {
      print('Error in GettingMessageEvent: $e');
      print('Stack trace: $stackTrace');
      eventSource?.close();
      onDone();
    }
  }
}
