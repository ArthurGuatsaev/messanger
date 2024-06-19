import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:messanger/packets/themes/src/extenshion/extenshion.dart';
import '../../../../packets/chat/domain/models/user/user_model.dart';
import 'search_textfield.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.allUsers,
  });

  final Map<String, UserModel> allUsers;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(AppLocalizations.of(context)!.chats,
                style: context.text.title
                    .copyWith(color: context.color.textTitleLarge))),
        const SizedBox(height: 8),
        const SearchTextField(),
        // if (allUsers.isNotEmpty) SearchUsers(allUsers: allUsers),
      ],
    );
  }
}
