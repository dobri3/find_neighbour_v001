import 'package:dio/dio.dart';
import 'package:find_neighbour_v001/api/api.dart';
import 'package:find_neighbour_v001/models/chat/chat.dart';

import 'dart:io';

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
      String url =
          // const String.fromEnvironment('WS_BASE_URL') + "/chat/messages";
          "ws://localhost:8080/api/v1/chat/messages";
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
}
