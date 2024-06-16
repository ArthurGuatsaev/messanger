import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../packets/chat/domain/bloc/chat/chat_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          final chats = state.chats;
          final allUsers = state.allUsers;
          return SafeArea(
            child: Stack(
              children: [
                ConstrainedBox(
                  constraints:
                      BoxConstraints.loose(const Size(double.infinity, 300)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          height: 60,
                          padding: const EdgeInsets.all(8),
                          child: TextField(
                            onChanged: (value) {},
                          )),
                      Expanded(
                          child: ListView.builder(
                        itemCount: allUsers.length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Colors.amber,
                            height: 50,
                            margin: const EdgeInsets.only(top: 10),
                          );
                        },
                      )),
                    ],
                  ),
                ),
                CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                        child: SizedBox(
                      height: 100,
                    )),
                    SliverList.builder(
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(top: 10),
                          color: Colors.blue,
                          height: 100,
                          child: const Text(''),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
