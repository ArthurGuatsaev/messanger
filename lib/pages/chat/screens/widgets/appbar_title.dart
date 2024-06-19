import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:messanger/packets/themes/src/extenshion/extenshion.dart';
import '../../../../packets/chat/domain/models/user/user_model.dart';
import '../../../widgets/user_avatar.dart';

class AppbarTitle extends StatelessWidget {
  const AppbarTitle({
    super.key,
    required this.us,
  });

  final UserModel us;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.navigate_before, size: 40)),
        UserAvatar(user: us),
        const SizedBox(width: 10),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${us.name} ${us.lastName}',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: context.color.textBodyLarge),
              ),
              Text(
                AppLocalizations.of(context)!.online,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: context.color.commentColor),
              )
            ])
      ],
    );
  }
}
