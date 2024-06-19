import 'package:flutter/material.dart';
import 'package:messanger/packets/chat/domain/models/message/extentions/date.dart';
import 'package:messanger/packets/themes/src/extenshion/extenshion.dart';

import '../../domain/models/message/message_model.dart';
import 'painter.dart';

class RecievMessage extends StatelessWidget {
  final MessageModel message;
  const RecievMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
                color: context.color.recieveMessage),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            margin: const EdgeInsets.only(top: 20, left: 70),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (message.text != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        message.text!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: context.color.text),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        message.time,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: context.color.text),
                      )
                    ],
                  ),
                if (message.image != null)
                  Container(height: 160, color: Colors.amber)
              ],
            ),
          ),
        ),
        CustomPaint(painter: MyMessagePainter(context.color.recieveMessage)),
      ],
    );
  }
}
