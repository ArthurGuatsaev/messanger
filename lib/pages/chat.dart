import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/const/extension.dart';

import '../auth/domain/cubit/auth_cubit.dart';
import '../message/domain/bloc/mess_bloc.dart';
import '../message/view/widgets/message/message.dart';
import '../message/view/widgets/message/src/create_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final ScrollController _controller = ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final position = _controller.position.maxScrollExtent;
      _controller.jumpTo(position);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessBloc, MessState>(
      builder: (context, state) {
        final mes = state.curList.messages;
        final userName = state.correspondentName(state.current);
        return Scaffold(
          appBar: AppBar(
            leading: Row(
              children: [
                const SizedBox(width: 10),
                GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.navigate_before, size: 35)),
                CircleAvatar(
                  radius: 28,
                  backgroundColor: context.color.avatarBC,
                  child: Center(
                      child: Text(userName.abrv.toUpperCase(),
                          style: context.text.avatarStyle)),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userName,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'В сети:',
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
              ],
            ),
            leadingWidth: 300,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: CustomScrollView(
                    reverse: true,
                    anchor: 0,
                    controller: _controller,
                    slivers: [
                      SliverList.builder(
                        itemCount: mes.length,
                        itemBuilder: (context, index) {
                          final messages = mes.reversed.toList();
                          final m = messages[index];
                          final isD = index == 0 ||
                              messages[index - 1].date.chartD != m.date.chartD;
                          return BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, auth) {
                              final mine = auth.user.name == m.name;
                              return ReadyMessage(
                                mine: mine,
                                mes: m.message,
                                isDate: isD,
                                date: m.date.chartD,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CreateMessage(),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
