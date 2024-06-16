import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../packets/themes/src/colors/color_constant.dart';

import '../packets/themes/src/text/text_constant.dart';

extension BuildContextExt on BuildContext {
  $MyThemeColor get color => Theme.of(this).extension<$MyThemeColor>()!;
  $MyThemeText get text => Theme.of(this).extension<$MyThemeText>()!;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}

extension DateString on DateTime {
  String get view {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final init = DateTime(year, month, day);
    if (today == init) return 'Сегодня';
    if (today.difference(init).inDays < 2) return 'Вчера';
    final d = day.toString().length < 2 ? '0$day' : '$day';
    final m = month.toString().length < 2 ? '0$month' : '$month';
    return '$d.$m.$year';
  }

  String get dayId {
    final d = day.toString().length < 2 ? '0$day' : '$day';
    final m = month.toString().length < 2 ? '0$month' : '$month';
    return '$d-$m-$year';
  }

  Map<String, List> get dayNumber {
    final m = month;
    final result = <String, List>{};
    for (var i = 0; i <= 31; i++) {
      final key = add(Duration(days: i));
      if (key.month == m) {
        result[key.dayId] = [];
      }
    }
    return result;
  }
}

extension SubScriptionVerify on Duration {
  bool get subDuration {
    final durationWithSubscribe = kDebugMode ? inMinutes : inDays;
    return kDebugMode ? durationWithSubscribe <= 3 : durationWithSubscribe <= 7;
  }
}
