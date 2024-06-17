import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/const/extension.dart';
import 'package:messanger/packets/chat/domain/bloc/chat/chat_bloc.dart';

class ChatPage extends StatelessWidget {
  final Map<String, dynamic>? user;
  const ChatPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          const CustomScrollView(
            slivers: [],
          ),
          SendMessageBox(user: user)
        ],
      )),
    );
  }
}

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
    return Padding(
      padding: const EdgeInsets.only(bottom: 50, left: 12, right: 12),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 42,
          child: Row(
            children: [
              Container(
                color: context.color.searchBox,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.note),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  color: context.color.searchBox,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(controller: controller),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                color: context.color.searchBox,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () {
                        if (controller.text.isEmpty) return;
                        context.read<ChatBloc>().add(SentMessageEvent(
                            user: widget.user, text: controller.text));
                        controller.clear();
                        FocusScope.of(context).unfocus();
                      },
                      icon: const Icon(Icons.send)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
