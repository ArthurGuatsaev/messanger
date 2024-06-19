import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/packets/chat/domain/models/user/user_model.dart';
import '../../../../packets/chat/domain/bloc/chat/chat_bloc.dart';
import '../../../../packets/chat/view/chat/message.dart';
import '../widgets/appbar_title.dart';
import '../widgets/send_box.dart';

class PhoneChat extends StatelessWidget {
  const PhoneChat({
    super.key,
    required this.user,
  });

  final Map<String, dynamic>? user;

  @override
  Widget build(BuildContext context) {
    final us = UserModel.fromMap(user!);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        leading: const SizedBox.shrink(),
        title: AppbarTitle(us: us),
      ),
      body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 12),
          child: Stack(
            children: [
              BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  final chats = state.chats[us.id];
                  if (chats?.isEmpty == true || chats == null) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('no message'),
                      ],
                    );
                  }
                  return CustomScrollView(
                    slivers: [
                      SliverList.builder(
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          final mess = chats[index];
                          return ChatMessage(
                              message: mess, mine: us.id != mess.author.id);
                        },
                      )
                    ],
                  );
                },
              ),
              SendMessageBox(user: user)
            ],
          )),
    );
  }
}
