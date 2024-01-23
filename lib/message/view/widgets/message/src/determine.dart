part of '../message.dart';

class ReadyMessage extends StatefulWidget {
  final bool mine;
  final String mes;
  final bool isDate;
  final String date;
  final String? audio;
  const ReadyMessage({
    super.key,
    required this.mine,
    required this.mes,
    required this.date,
    required this.isDate,
    this.audio,
  });

  @override
  State<ReadyMessage> createState() => _ReadyMessageState();
}

class _ReadyMessageState extends State<ReadyMessage> {
  final FlutterSoundPlayer myPlayer = FlutterSoundPlayer();
  @override
  Widget build(BuildContext context) {
    if (widget.audio != null) {
      return Column(
        children: [
          if (widget.isDate) DateWidget(date: widget.date),
          PlayerMessage(
            mine: widget.mine,
            myPlayer: myPlayer,
            audio: widget.audio!,
          ),
        ],
      );
    }
    return Column(
      children: [
        if (widget.isDate) DateWidget(date: widget.date),
        if (widget.mine) SentMessage(message: widget.mes),
        if (!widget.mine) ReceivedMessage(message: widget.mes),
      ],
    );
  }
}

class DateWidget extends StatelessWidget {
  final String date;
  const DateWidget({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: context.color.chartDate)),
        Text(date, style: context.text.chartDate),
        Expanded(child: Divider(color: context.color.chartDate)),
      ],
    );
  }
}
