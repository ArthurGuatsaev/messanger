import 'dart:math';

import 'package:flutter/material.dart';
import 'package:messanger/const/extension.dart';
import 'package:messanger/packets/chat/domain/models/message/extentions/date.dart';

import '../../domain/models/message/message_model.dart';
import 'painter.dart';

class SentMessage extends StatelessWidget {
  final MessageModel message;
  const SentMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi),
          child:
              CustomPaint(painter: MyMessagePainter(context.color.sentMessage)),
        ),
        Flexible(
          child: Container(
            constraints: BoxConstraints.loose(const Size(double.infinity, 300)),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
                color: context.color.sentMessage),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            margin: const EdgeInsets.only(top: 20, right: 70),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (message.image != null)
                  Container(height: 160, color: Colors.amber),
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
