import 'package:messanger/packets/chat/domain/models/message/message_model.dart';

extension DateViews on MessageModel {
  String get view {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final init = DateTime(date.year, date.month, date.day);
    if (today == init) return 'Сегодня';
    if (today.difference(init).inDays < 2) return 'Вчера';
    final d = date.day.toString().length < 2 ? '0${date.day}' : '${date.day}';
    final m =
        date.month.toString().length < 2 ? '0${date.month}' : '${date.month}';
    return '$d.$m.${date.year}';
  }

  Map<String, List> get dayNumber {
    final m = date.month;
    final result = <String, List>{};
    for (var i = 0; i <= 31; i++) {
      final key = date.add(Duration(days: i));
      if (key.month == m) {
        result[dayId(key)] = [];
      }
    }
    return result;
  }

  String dayId(DateTime date) {
    final d = date.day.toString().length < 2 ? '0${date.day}' : '${date.day}';
    final m =
        date.month.toString().length < 2 ? '0${date.month}' : '${date.month}';
    return '$d-$m-${date.year}';
  }

  String get time {
    final h =
        date.hour.toString().length < 2 ? '0${date.hour}' : '${date.hour}';
    final m = date.minute.toString().length < 2
        ? '0${date.minute}'
        : '${date.minute}';
    return '$h:$m';
  }
}
