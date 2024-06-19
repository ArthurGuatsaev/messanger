import 'package:flutter/material.dart';
import 'package:messanger/const/extension.dart';
import 'package:messanger/pages/widgets/user_avatar.dart';

import '../../../../packets/chat/domain/models/user/user_model.dart';
import '../../../../packets/initialize/initialize.dart';
import '../../../../packets/navigation/router.dart';

class SearchUsers extends StatelessWidget {
  const SearchUsers({
    super.key,
    required this.allUsers,
  });

  final Map<String, UserModel> allUsers;

  @override
  Widget build(BuildContext context) {
    final me = context
        .dependOnInheritedWidgetOfExactType<InheritedDependencies>()
        ?.dependencies
        .aR
        .user;
    return ConstrainedBox(
      constraints: BoxConstraints.loose(const Size(double.infinity, 200)),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: allUsers.length,
        itemBuilder: (context, index) {
          final user = allUsers.values.toList()[index];
          if (user.id == me!.id) return const SizedBox.shrink();
          return Container(
            color: context.color.searchBox,
            height: 60,
            margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
            child: ListTile(
              onTap: () => MyNavigatorManager.instance.pushChat(user.toMap()),
              leading: UserAvatar(user: user),
              title: Text('${user.name} ${user.lastName}'),
              trailing: const Icon(Icons.touch_app_rounded),
            ),
          );
        },
      ),
    );
  }
}
