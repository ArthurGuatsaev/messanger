import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/packets/chat/domain/models/user/user_model.dart';

import '../../../../packets/chat/domain/bloc/chat/chat_bloc.dart';
import '../widgets/send_box.dart';

class PhoneChat extends StatelessWidget {
  const PhoneChat({
    super.key,
    required this.user,
  });

  final Map<String, dynamic>? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              final chats = state.chats[UserModel.fromMap(user!).id];
              return CustomScrollView(
                slivers: [
                  SliverList.builder(
                    itemCount: chats?.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 50,
                        color: Colors.red,
                      );
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
