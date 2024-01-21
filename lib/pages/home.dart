import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/const/extension.dart';
import 'package:messanger/pages/chat.dart';

import '../message/domain/bloc/mess_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: SafeArea(
          child: CustomScrollView(slivers: [
            _Title(),
            _Search(),
            _List(),
          ]),
        ),
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessBloc, MessState>(
      builder: (context, state) {
        final users = state.chats.keys.toList();
        return SliverList.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final message =
                  state.chats[user]!.isEmpty ? null : state.chats[user]!.last;
              return GestureDetector(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ChatPage())),
                child: Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      top: index == 0
                          ? BorderSide(color: context.color.chartBottom)
                          : BorderSide.none,
                      bottom: BorderSide(color: context.color.chartDate),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor: context.color.avatarBC,
                          child: Center(
                              child: Text(user.abrv.toUpperCase(),
                                  style: context.text.avatarStyle)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            message != null ? message.name : user.naming,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Row(
                            children: [
                              Text(
                                message == null || message.mine ? 'Вы:' : '',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                message == null || message.mine
                                    ? ''
                                    : message.message,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          )
                        ],
                      ),
                      const Spacer(),
                      Text('2 min ago', style: context.text.chartDate)
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}

class _Search extends StatelessWidget {
  const _Search({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 42,
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: context.color.chartBottom),
        child: Row(
          children: [
            Icon(Icons.search_outlined, color: context.color.hint),
            const SizedBox(width: 4),
            Expanded(
              child: TextField(
                showCursor: false,
                decoration: InputDecoration(
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'Поиск',
                    contentPadding: const EdgeInsets.only(top: 10),
                    hintStyle: context.text.hintStyle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Text('Чаты', style: Theme.of(context).textTheme.headlineLarge),
    );
  }
}
