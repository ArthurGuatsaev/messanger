import 'package:flutter/material.dart';
import 'package:messanger/const/extension.dart';

import '../../packets/chat/domain/models/user/user_model.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.user,
  });

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: user?.avatarColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          user!.avatarName,
          style: context.text.avatar.copyWith(color: context.color.bg),
        ),
      ),
    );
  }
}
