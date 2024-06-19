import 'package:flutter/material.dart';
import '/packets/chat/domain/models/message/message_model.dart';

import 'reciev.dart';
import 'sent.dart';

class ChatMessage extends StatelessWidget {
  final MessageModel? message;
  final bool mine;
  const ChatMessage({super.key, required this.mine, required this.message});

  @override
  Widget build(BuildContext context) {
    if (message == null) return const SizedBox.shrink();
    return switch (mine) {
      true => SentMessage(message: message!),
      false => RecievMessage(message: message!),
    };
  }
}
