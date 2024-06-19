import 'package:flutter/material.dart';

import '../../../../packets/chat/domain/models/message/message_model.dart';
import '../../../../packets/chat/domain/models/user/user_model.dart';
import '../../../../packets/initialize/initialize.dart';
import 'chat_item.dart';

class UserChats extends StatelessWidget {
  const UserChats({
    super.key,
    required this.chats,
    required this.allUsr,
  });

  final Map<String, List<MessageModel>> chats;
  final Map<String, UserModel> allUsr;

  @override
  Widget build(BuildContext context) {
    final me = context
        .dependOnInheritedWidgetOfExactType<InheritedDependencies>()
        ?.dependencies
        .uR
        .me
        ?.id;
    return SliverList.builder(
      itemCount: allUsr.length,
      itemBuilder: (context, index) {
        final id = allUsr.keys.toList()[index];
        final user = allUsr[id];
        final lastMessage = chats[id]?.last;
        if (me == user!.id) return const SizedBox.shrink();
        return UserChatBox(user: user, message: lastMessage);
      },
    );
  }
}
