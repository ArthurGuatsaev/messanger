part of '../message.dart';

class ReceivedMessage extends StatelessWidget {
  final String message;
  const ReceivedMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi),
          child: CustomPaint(
            painter: MyMessagePainter(context.color.otherMessage),
          ),
        ),
        Flexible(
          child: Container(
            margin: const EdgeInsets.only(bottom: 0, right: 50, top: 10),
            decoration: BoxDecoration(
              color: context.color.otherMessage,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(19),
                topLeft: Radius.circular(19),
                bottomRight: Radius.circular(19),
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
      ],
    );
  }
}
