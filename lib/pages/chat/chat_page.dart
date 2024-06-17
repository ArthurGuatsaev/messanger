import 'package:flutter/material.dart';

import 'screens/phone/phone_chats.dart';

class ChatPage extends StatelessWidget {
  final Map<String, dynamic>? user;
  const ChatPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrraints) {
      return switch (constrraints.maxWidth) {
        < 450 => PhoneChat(user: user),
        _ => PhoneChat(user: user),
      };
    });
  }
}
