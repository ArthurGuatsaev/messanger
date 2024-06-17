import 'package:flutter/material.dart';
import 'package:messanger/const/extension.dart';
import 'package:messanger/packets/chat/domain/models/message/message_model.dart';
import 'package:messanger/packets/chat/domain/models/user/user_model.dart';

class UserLastMessage extends StatelessWidget {
  const UserLastMessage({
    super.key,
    required this.message,
    required this.user,
  });

  final MessageModel? message;
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (message?.author.id != user?.id)
          Text('You:',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: context.color.textBodySmall)),
        const SizedBox(width: 10),
        Text(message!.text!,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: context.color.commentColor)),
      ],
    );
  }
}
