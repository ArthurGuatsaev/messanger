import 'package:flutter/material.dart';
import 'package:messanger/const/extension.dart';

import '../../../../packets/chat/domain/models/user_model.dart';

class UserChatBox extends StatelessWidget {
  const UserChatBox({
    super.key,
    required this.user,
  });

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
      margin: const EdgeInsets.only(top: 10),
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: CircleAvatar(backgroundColor: user?.avatarColor)),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${user?.name} ${user?.lastName}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: context.color.textBodyLarge),
                ),
                Row(
                  children: [
                    Text(
                      'You',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: context.color.textBodySmall),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'message to do //',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: context.color.commentColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text('data to do //',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: context.color.commentColor))
        ],
      ),
    );
  }
}
