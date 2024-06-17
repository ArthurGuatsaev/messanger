import 'package:flutter/material.dart';
import 'package:messanger/const/extension.dart';

import '../../../../packets/chat/domain/models/user_model.dart';
import '../../../../packets/navigation/router.dart';

class SearchUsers extends StatelessWidget {
  const SearchUsers({
    super.key,
    required this.allUsers,
  });

  final Map<String, UserModel> allUsers;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allUsers.length,
      itemBuilder: (context, index) {
        final user = allUsers.values.toList()[index];
        return Container(
          color: context.color.searchBox,
          height: 50,
          margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
          child: ListTile(
            onTap: () => MyNavigatorManager.instance.pushChat(user.toMap()),
            leading: CircleAvatar(backgroundColor: user.avatarColor),
            title: Text('${user.name} ${user.lastName}'),
            trailing: const Icon(Icons.touch_app_rounded),
          ),
        );
      },
    );
  }
}
