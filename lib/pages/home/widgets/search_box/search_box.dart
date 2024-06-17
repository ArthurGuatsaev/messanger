import 'package:flutter/material.dart';
import '../../../../packets/chat/domain/models/user_model.dart';
import 'search_textfield.dart';
import 'search_users.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.allUsers,
  });

  final Map<String, UserModel> allUsers;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.loose(const Size(double.infinity, 300)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SearchTextField(),
          Expanded(child: SearchUsers(allUsers: allUsers)),
        ],
      ),
    );
  }
}
