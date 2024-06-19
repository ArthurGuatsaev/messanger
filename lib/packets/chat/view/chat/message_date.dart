import 'package:flutter/material.dart';
import 'package:messanger/const/extension.dart';
import 'package:messanger/packets/chat/domain/models/message/extentions/date.dart';

import '../../domain/models/message/message_model.dart';

class ChatMessageDate extends StatelessWidget {
  const ChatMessageDate({
    super.key,
    required this.message,
  });

  final MessageModel? message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: context.color.commentColor)),
        const SizedBox(width: 20),
        Center(
            child: Text(
          message!.view,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: context.color.commentColor),
        )),
        const SizedBox(width: 20),
        Expanded(child: Divider(color: context.color.commentColor)),
      ],
    );
  }
}
