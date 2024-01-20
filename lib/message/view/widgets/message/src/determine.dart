part of '../message.dart';

class ReadyMessage extends StatelessWidget {
  final bool mine;
  final String mes;
  final bool isDate;
  final String date;
  const ReadyMessage({
    super.key,
    required this.mine,
    required this.mes,
    required this.date,
    required this.isDate,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isDate) DateWidget(date: date),
        if (mine) SentMessage(message: mes),
        if (!mine) ReceivedMessage(message: mes),
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
