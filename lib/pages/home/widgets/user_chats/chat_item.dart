import 'package:flutter/material.dart';
import 'package:messanger/const/extension.dart';
import 'package:messanger/packets/chat/domain/models/message/extentions/date.dart';
import 'package:messanger/packets/chat/domain/models/message/message_model.dart';
import 'package:messanger/packets/navigation/router.dart';

import '../../../../packets/chat/domain/models/user/user_model.dart';
import '../../../widgets/user_avatar.dart';
import 'last_message/chat_last.dart';
import 'last_message/user_last.dart';

class UserChatBox extends StatelessWidget {
  const UserChatBox({
    super.key,
    required this.user,
    required this.message,
  });

  final UserModel? user;
  final MessageModel? message;

  Widget _buildLastMessage(BuildContext context) {
    if (message == null) return const SizedBox(height: 10);
    if (message?.text != null) {
      return UserLastMessage(message: message, user: user);
    } else {
      return ChatLastMessage(message: message, user: user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MyNavigatorManager.instance.pushChat(user!.toMap()),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: context.color.searchBox))),
        margin: const EdgeInsets.only(top: 10),
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: UserAvatar(user: user)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${user?.name} ${user?.lastName}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: context.color.textBodyLarge),
                  ),
                  _buildLastMessage(context),
                ],
              ),
            ),
            if (message != null)
              Text(message!.view,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: context.color.commentColor))
          ],
        ),
      ),
    );
  }
}
