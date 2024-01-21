import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/const/extension.dart';

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
        final mes = state.chats[state.current] ?? [];
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
                      child: Text('AG'.toUpperCase(),
                          style: context.text.avatarStyle)),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Greg Petrov',
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
                          return ReadyMessage(
                            mine: m.mine,
                            mes: m.message,
                            isDate: isD,
                            date: m.date.chartD,
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

// final list = [
//   MessageModel(
//       message:
//           'hello my first normal messanger with dart languiges and flutter framework worker',
//       date: DateTime(2023, 1, 1, 10, 0),
//       mine: true),
//   MessageModel(message: '2', date: DateTime(2023, 1, 1, 10, 0), mine: false),
//   MessageModel(message: '2', date: DateTime(2023, 1, 1, 10, 0), mine: false),
//   MessageModel(message: '3', date: DateTime(2023, 2, 1, 10, 0), mine: true),
//   MessageModel(message: '4', date: DateTime(2023, 2, 1, 10, 0), mine: true),
//   MessageModel(message: '5', date: DateTime(2024, 1, 18, 10, 0), mine: false),
//   MessageModel(message: '5', date: DateTime(2024, 1, 19, 10, 0), mine: false),
// ];
