import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/const/extension.dart';
import '../../../../packets/chat/domain/bloc/chat/chat_bloc.dart';
import '../../widgets/search_box/search_box.dart';
import '../../widgets/user_chats/user_chats.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          final chatUsers = state.chatUsers;
          return SafeArea(
            minimum: const EdgeInsets.only(left: 12, right: 12, top: 20),
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(child: SizedBox(height: 100)),
                    UserChats(chats: chats, chatUsers: chatUsers)
                  ],
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(AppLocalizations.of(context)!.chats,
                          style: context.text.title
                              .copyWith(color: context.color.textTitleLarge)),
                    ),
                    const SizedBox(height: 8),
                    SearchBox(allUsers: allUsers),
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
