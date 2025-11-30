class InputMessage {
  final String content;
  final String contentType;

  InputMessage({
    required this.content,
    required this.contentType,
  });

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'content_type': contentType,
    };
  }

  static InputMessage fromJson(Map<String, dynamic> json) {
    return InputMessage(
      content: json['content'] ?? '',
      contentType: json['content_type'] ?? '',
    );
  }
}

class OutputMessage {
  final String chatID;
  final ChatUser sender;
  final String content;
  final String contentType;
  final DateTime createdAt;

  OutputMessage({
    required this.chatID,
    required this.sender,
    required this.content,
    required this.contentType,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'chat_id': chatID,
      'sender': sender.toJson(),
      'content': content,
      'content_type': contentType,
      'created_at': createdAt,
    };
  }

  static OutputMessage fromJson(Map<String, dynamic> json) {
    return OutputMessage(
      chatID: json['chat_id'] ?? '',
      sender: ChatUser.fromJson(json['sender'] ?? {}),
      content: json['content'] ?? '',
      contentType: json['content_type'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
    );
  }
}

class ChatUser {
  final String id;
  final String name;
  final String avatarUrl;

  ChatUser({
    required this.id,
    required this.name,
    required this.avatarUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar_url': avatarUrl,
    };
  }

  static ChatUser fromJson(Map<String, dynamic> json) {
    return ChatUser(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
    );
  }
}
