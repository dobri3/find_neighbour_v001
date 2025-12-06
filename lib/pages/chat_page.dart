import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'package:find_neighbour_v001/widgets/app_bars/main_header.dart';
import 'package:find_neighbour_v001/styles/app_container_styles.dart';

import 'package:find_neighbour_v001/styles/app_colors.dart';

import 'package:find_neighbour_v001/models/chat/chat.dart';
import 'package:find_neighbour_v001/api/api.dart';

import 'package:find_neighbour_v001/models/chat/messages.dart';
import 'package:find_neighbour_v001/models/user.dart';
import 'dart:convert';
import 'package:web_socket_channel/html.dart';
import 'package:intl/intl.dart';

@RoutePage()
class ChatPage extends StatefulWidget {
  final String? userId;
  final String? groupId;
  final String? chatId;

  ChatPage({
    super.key,
    @QueryParam('user_id') this.userId,
    @QueryParam('group_id') this.groupId,
    @QueryParam('chat_id') this.chatId,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String? _selectedChatId;
  List<OutputMessage> _messages = [];
  User? _session;
  ChatDetail? chat;
  List<Chat> _chats = [];
  HtmlWebSocketChannel? _webSocket;

  final _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool get _isScrollNearBottom {
    if (!_scrollController.hasClients) return false;

    final position = _scrollController.position;
    return position.pixels <= position.minScrollExtent + 100;
  }

  void _scrollToBottomIfNeeded() {
    if (!_isScrollNearBottom) {
      _scrollToBottom();
    }
  }

  void _loadChatData() async {
    List<Chat> chats = await ApiService.chatService.getChatsByUserId();
    print(chats);
    User? session = await ApiService.authService.getSession();

    if (widget.userId != null || widget.groupId != null) {
      _webSocket = await ApiService.chatService.connectToChat(
        widget.chatId,
        widget.userId,
        widget.groupId,
      );

      if (_webSocket != null) {
        _webSocket!.stream.listen((event) {
          print(event);
          setState(() {
            chat = ChatDetail(
              id: "",
              userName: "",
              avatarUrl: "",
              compatibility: 0,
              isOnline: false,
            );
            _messages.add(OutputMessage.fromJson(jsonDecode(event)));
            _scrollToBottom();
          });
        });
      }
    }

    setState(() {
      _chats = chats;
      _session = session;
    });
  }

  void _sendMessage() async {
    if (_textController.text.isNotEmpty) {
      _webSocket?.sink.add(
        jsonEncode(
          InputMessage(
            content: _textController.text,
            contentType: 'text',
          ),
        ),
      );
      _textController.clear();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;

    _scrollController
        .animateTo(
      position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    )
        .then((_) {
      if (_scrollController.hasClients) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent);
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    _loadChatData();
  }

  @override
  void dispose() async {
    await _webSocket?.sink.close();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeHeader(),
      backgroundColor: AppColors.baseBright,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 1100,
          ),
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 20,
          ),
          width: double.infinity,
          height: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: AppContainerStyles.profileCard,
                  child: _buildChatList(context),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 5,
                child: Container(
                  decoration: AppContainerStyles.profileCard,
                  child: _buildChatDetail(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatList(BuildContext context) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              '💬 Сообщения',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textBase, // Белый текст для темного фона
              ),
            ),
            SizedBox(height: 20),
            TextField(
              style: TextStyle(color: AppColors.textBase),
              decoration: AppContainerStyles.textInput(context, 'Найти диалог'),
            ),
          ],
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: ListView.builder(
            itemCount: _chats.length,
            itemBuilder: (context, index) {
              final chat = _chats[index];
              final isSelected = _selectedChatId == chat.id;

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.teal.withOpacity(0.25)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected ? Border.all(color: AppColors.teal) : null,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(chat.avatarUrl),
                  ),
                  title: Text(
                    chat.name,
                    style: TextStyle(
                      color: AppColors.textBase,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    "", // chat.lastMessage,
                    style: TextStyle(
                      color: AppColors.textBase.withOpacity(0.8),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "", // chat.time,
                        style: TextStyle(
                          color: AppColors.textBase.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                      // if (chat.unreadCount > 0) ...[
                      //   SizedBox(height: 4),
                      //   Container(
                      //     padding:
                      //         EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      //     decoration: BoxDecoration(
                      //       color: AppColors.teal,
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     child: Text(
                      //       chat.unreadCount.toString(),
                      //       style: TextStyle(
                      //         color: Colors.black,
                      //         fontSize: 10,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ),
                      // ],
                    ],
                  ),
                  onTap: () {
                    _onChatSelected(context, chat.id);
                  },
                ),
              );
            },
          ),
        ),
      ),
    ]);
  }

  void _onChatSelected(BuildContext context, String chatId) async {
    await _webSocket?.sink.close();
    _webSocket = await ApiService.chatService.connectToChat(
      chatId,
      null,
      null,
    );

    if (_webSocket != null) {
      _webSocket!.stream.listen((event) {
        print(event);
        setState(() {
          _messages.add(OutputMessage.fromJson(jsonDecode(event)));
        });
      });
    }
    setState(() {
      _selectedChatId = chatId;
      // chat = _getChatById(chatId);
    });
  }

  Widget _buildChatDetail(BuildContext context) {
    return Container(
      child: chat == null
          ? null
          : Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: AppColors.textBase,),
                    onPressed: () => {
                      setState(() {
                        _selectedChatId = null;
                        chat = null;
                      }),
                    },
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(chat!.avatarUrl),
                        radius: 18,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chat!.userName,
                              style: TextStyle(
                                color: AppColors.textBase,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                // Container(
                                //   width: 8,
                                //   height: 8,
                                //   decoration: BoxDecoration(
                                //     color: Colors.green,
                                //     shape: BoxShape.circle,
                                //   ),
                                // ),
                                // SizedBox(width: 6),
                                // Text(
                                //   'Онлайн - ${chat!.compatibility}% совместимость',
                                //   style: TextStyle(
                                //     color: Colors.grey[400],
                                //     fontSize: 12,
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // actions: [
                //   IconButton(
                //     icon: Icon(Icons.more_vert, color: Colors.white),
                //     onPressed: () {
                //       print('more');
                //     },
                //   ),
                // ],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView(
                      controller: _scrollController,
                      padding: EdgeInsets.all(16),
                      children: _messages.map((message) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _buildMessageBubble(
                            message: message.content,
                            isMe: message.sender.id == _session!.id,
                            time: formatDate(message.createdAt.toLocal()),
                            showStatus: true,
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  // Поле ввода сообщения
                  Container(
                    padding: EdgeInsets.all(16),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.baseLight,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 16),
                                Expanded(
                                  child: TextField(
                                    controller: _textController,
                                    textInputAction: TextInputAction.send,
                                    onSubmitted: (value) => _sendMessage(),
                                    decoration: InputDecoration(
                                      hintText: 'Напишите сообщение...',
                                      hintStyle:
                                          TextStyle(color: AppColors.textBase.withOpacity(0.8),),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(color: AppColors.textBase),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () => _sendMessage(),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xFF3A8DFF),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.send, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildMessageBubble({
    required String message,
    required bool isMe,
    required String time,
    bool showStatus = false,
  }) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isMe) ...[
          CircleAvatar(
            backgroundImage: NetworkImage('https://via.placeholder.com/40'),
            radius: 16,
          ),
          SizedBox(width: 8),
        ],
        Flexible(
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isMe ? AppColors.textBase : Color(0xFF2A3B47),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: isMe ? Radius.circular(16) : Radius.circular(4),
                    bottomRight:
                        isMe ? Radius.circular(4) : Radius.circular(16),
                  ),
                ),
                child: Text(
                  message,
                  style: TextStyle(
                    color: AppColors.textBase,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment:
                    isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      color: AppColors.textBase.withOpacity(0.8),
                      fontSize: 11,
                    ),
                  ),
                  if (showStatus && isMe) ...[
                    SizedBox(width: 4),
                    Icon(Icons.done_all, color: AppColors.textBase, size: 14),
                  ],
                ],
              ),
            ],
          ),
        ),
        if (isMe) ...[
          SizedBox(width: 8),
          CircleAvatar(
            backgroundImage: NetworkImage('https://via.placeholder.com/40'),
            radius: 16,
          ),
        ],
      ],
    );
  }

  Widget _buildInfoMessage(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.textBase.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.textBase.withOpacity(0.8),
          fontSize: 12,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}

class ChatDetail {
  final String id;
  final String userName;
  final String avatarUrl;
  final int compatibility;
  final bool isOnline;

  ChatDetail({
    required this.id,
    required this.userName,
    required this.avatarUrl,
    required this.compatibility,
    required this.isOnline,
  });
}

String formatDate(DateTime date) {
  return DateFormat('HH:mm').format(date);
}
