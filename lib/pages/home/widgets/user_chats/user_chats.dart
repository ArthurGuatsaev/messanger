import 'package:flutter/material.dart';

import '../../../../packets/chat/domain/models/message_model.dart';
import '../../../../packets/chat/domain/models/user_model.dart';
import 'chat_item.dart';

class UserChats extends StatelessWidget {
  const UserChats({
    super.key,
    required this.chats,
    required this.chatUsers,
  });

  final Map<String, List<MessageModel>> chats;
  final Map<String, UserModel> chatUsers;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final id = chats.keys.toList()[index];
        final user = chatUsers[id];
        return UserChatBox(user: user);
      },
    );
  }
}