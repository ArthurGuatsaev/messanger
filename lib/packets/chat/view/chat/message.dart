import 'package:flutter/material.dart';
import 'package:messanger/const/extension.dart';
import 'package:messanger/packets/chat/domain/models/message/extentions/date.dart';
import '/packets/chat/domain/models/message/message_model.dart';

import 'message_date.dart';
import 'reciev.dart';
import 'sent.dart';

class ChatMessage extends StatelessWidget {
  final MessageModel? message;
  final bool mine;
  final DateTime? lastDate;
  const ChatMessage(
      {super.key, required this.mine, required this.message, this.lastDate});

  @override
  Widget build(BuildContext context) {
    if (message == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (message?.date.day != lastDate?.day)
            ChatMessageDate(message: message),
          switch (mine) {
            true => SentMessage(message: message!),
            false => RecievMessage(message: message!),
          },
        ],
      ),
    );
  }
}
