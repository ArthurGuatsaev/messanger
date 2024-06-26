import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../packets/chat/domain/bloc/chat/chat_bloc.dart';
import '../../widgets/search_box/search_box.dart';
import '../../widgets/user_chats/user_chats.dart';

class PhoneHome extends StatelessWidget {
  const PhoneHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          final chats = state.chats;
          final allUsers = state.allUsers;
          return SafeArea(
            minimum: const EdgeInsets.only(top: 40, right: 12, left: 12),
            child: Stack(
              children: [
                RefreshIndicator.adaptive(
                  onRefresh: () {
                    context.read<ChatBloc>().add(SetAllUsers(refresh: true));
                    return Future.sync(() => 3);
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(child: SearchBox(allUsers: allUsers)),
                      UserChats(chats: chats, allUsr: allUsers),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
