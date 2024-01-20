import 'package:flutter/material.dart';
import 'package:messanger/const/extension.dart';

import 'sound/recorder.dart';

class CreateMessage extends StatefulWidget {
  const CreateMessage({super.key});

  @override
  State<CreateMessage> createState() => _CreateMessageState();
}

class _CreateMessageState extends State<CreateMessage> {
  final notifier = ValueNotifier<bool>(false);
  @override
  void initState() {
    notifier.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: Stack(
        children: [
          if (!notifier.value)
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: context.color.chartBottom),
              height: 42,
              width: 42,
              child: const Center(
                child: Icon(Icons.image),
              ),
            ),
          if (!notifier.value)
            Container(
              margin: const EdgeInsets.only(left: 52, right: 52),
              width: MediaQuery.of(context).size.width,
              height: 42,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: context.color.chartBottom),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Сообщение',
                  hintStyle: context.text.hintStyle,
                  contentPadding: const EdgeInsets.only(left: 12, bottom: 10),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
          Positioned(right: 0, child: SoundRecorder(notifier: notifier)),
        ],
      ),
    );
  }
}
