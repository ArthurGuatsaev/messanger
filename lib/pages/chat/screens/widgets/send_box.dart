import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/packets/chat/domain/bloc/chat/chat_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:messanger/packets/themes/src/extenshion/extenshion.dart';

class SendMessageBox extends StatefulWidget {
  final Map<String, dynamic>? user;
  const SendMessageBox({
    super.key,
    required this.user,
  });

  @override
  State<SendMessageBox> createState() => _SendMessageBoxState();
}

class _SendMessageBoxState extends State<SendMessageBox> {
  late final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: context.color.bg,
        height: 90,
        padding:
            const EdgeInsets.only(bottom: 30, left: 12, right: 12, top: 12),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: context.color.searchBox,
                  borderRadius: BorderRadius.circular(12)),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.attach_file),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: context.color.searchBox,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.message,
                        hintStyle: context.text.searchBox
                            .copyWith(color: context.color.commentColor),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.zero),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              decoration: BoxDecoration(
                  color: context.color.searchBox,
                  borderRadius: BorderRadius.circular(12)),
              child: IconButton(
                  onPressed: () {
                    if (controller.text.isEmpty) {
                      return FocusScope.of(context).unfocus();
                    }
                    context.read<ChatBloc>().add(SentMessageEvent(
                        user: widget.user, text: controller.text));
                    controller.clear();
                    FocusScope.of(context).unfocus();
                  },
                  icon: const Icon(Icons.send)),
            ),
          ],
        ),
      ),
    );
  }
}
