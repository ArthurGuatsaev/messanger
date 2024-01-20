part of '../message.dart';

class SentMessage extends StatelessWidget {
  final String message;
  const SentMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            margin: const EdgeInsets.only(bottom: 0, left: 50),
            decoration: BoxDecoration(
              color: context.color.myMessage,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(19),
                topRight: Radius.circular(19),
                bottomLeft: Radius.circular(19),
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 50, bottom: 20),
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 5,
                  child: Text(
                    '14:31',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ),
        CustomPaint(painter: MyMessagePainter(context.color.myMessage)),
      ],
    );
  }
}
